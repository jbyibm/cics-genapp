# AAP - Creating and Using a Custom Non-Root Execution Environment

## Objective

Create a custom Execution Environment (EE) to:

* test non-root runtime behavior
* reproduce `pip install` permission issues
* use a local image in AAP without a registry
* verify the actual runner UID/GID

---

# 1. Install Prerequisites

## Install pip

```bash
dnf install -y python3-pip
```

## Install ansible-builder

```bash
python3 -m pip install ansible-builder
```

## Verify installation

```bash
ansible-builder --version
```

---

# 2. Create the Execution Environment

## Create a working directory

```bash
mkdir ~/custom
cd ~/custom
```

## Create the execution-environment.yml file

Minimal example:

```yaml
version: 3

additional_build_steps:
  append_final:
    - RUN useradd -u 1001 -g 0 -m runneruser || true
    - RUN mkdir -p /runner && chown -R 1001:0 /runner /home/runneruser
```

```bash
RUN useradd -u 980 -g 0 -m runneruser || true
RUN mkdir -p /runner && chown -R 980:0 /runner /home/runneruser
RUN rm -rf /output
LABEL ansible-execution-environment=true
USER 980
ENTRYPOINT ["/opt/builder/bin/entrypoint", "dumb-init"]
CMD ["bash"]
```
---

# 3. Generate the build context

```bash
ansible-builder create
```

The build context is created in:

```text
./context
```

---

# 4. Add USER 1001 manually

IMPORTANT:
Do NOT add `USER 1001` directly inside `append_final`
because ansible-builder still appends additional instructions afterward.

Append it manually at the end of the Containerfile:

```bash
echo 'USER 1001' >> context/Containerfile
```

---

# 5. Build the image

```bash
podman build -f context/Containerfile -t localhost/nonroot-ee:1.0 context
```

---

# 6. Verify the image locally

## Check runtime user

```bash
podman run --rm localhost/nonroot-ee:1.0 id
```

Expected result:

```text
uid=1001(runneruser) gid=0(root) groups=0(root)
```

---

# 7. Import the image for the awx user

AAP usually runs jobs as the `awx` user.

## Export the image

```bash
podman save localhost/nonroot-ee:1.0 -o /tmp/nonroot-ee.tar
chmod 644 /tmp/nonroot-ee.tar
```

## Import the image as awx

```bash
sudo -u awx podman load -i /tmp/nonroot-ee.tar
```

## Verify

```bash
sudo -u awx podman images | grep nonroot
```

---

# 8. Configure the Execution Environment in AAP

## Navigate to

```text
Administration -> Execution Environments
```

## Create a new EE

### Name

```text
nonroot-ee
```

### Image

```text
localhost/nonroot-ee:1.0
```

### Pull Policy

IMPORTANT:

```text
Never pull container before running
```

Otherwise AAP will attempt an HTTPS pull against:

```text
https://localhost/v2/
```

which causes TLS/certificate errors.

---

# 9. Configure the Job Template

## Navigate to

```text
Resources -> Templates
```

## Edit the Job Template

### Execution Environment

Select:

```text
nonroot-ee
```

---

# 10. Verify runtime UID/GID inside the playbook

Add this block at the beginning of the playbook:

```yaml
- name: Debug runtime user
  shell: |
    echo "=== ID ==="
    id

    echo "=== WHOAMI ==="
    whoami

    echo "=== CMDLINE ==="
    cat /proc/1/cmdline | tr '\0' ' '

    echo "=== STATUS ==="
    cat /proc/self/status | egrep 'Uid|Gid'

    echo "=== HOME ==="
    echo $HOME
  delegate_to: localhost
  register: runtime_debug

- debug:
    var: runtime_debug.stdout_lines
```

---

# 11. Expected output

## Non-root runtime

```text
uid=1001(runneruser)
Uid:    1001   1001   1001   1001
HOME=/home/runneruser
```

## Root runtime

```text
uid=0(root)
Uid:    0   0   0   0
HOME=/root
```

---

# 12. Important Notes

## The `-u root` argument in ansible-playbook

Example:

```text
ansible-playbook -u root
```

does NOT necessarily mean the container itself runs as root.

The real runtime identity is determined by:

```bash
id
cat /proc/self/status
```

inside the EE container.

---

# 13. Common Issue

If AAP still runs the EE as root even with `USER 1001`,
AAP or the container runtime may be overriding the container user at launch time.

Typical symptoms:

```text
uid=0(root)
HOME=/root
```

even though:

```bash
podman run --rm localhost/nonroot-ee:1.0 id
```

returns:

```text
uid=1001(runneruser)
```

This behavior is common with:

* hardened AAP environments
* OpenShift/Kubernetes security policies
* custom container runtime settings
* container groups
* execution node runtime overrides

```
```
