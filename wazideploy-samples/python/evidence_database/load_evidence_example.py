#!/usr/bin/env python3
#*******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corp. 2025. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
#*******************************************************************************

"""
Complete example of loading evidence files using configuration
"""

import sys
import argparse
import logging
from pathlib import Path
from db2_evidence_loader_ibm import DB2EvidenceLoaderIBM
from db2_evidence_loader_jdbc import DB2EvidenceLoaderJDBC
from db2_config import load_config

# Setup logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


def load_evidence(evidence_file: str, config_file: str='config.yaml'):
    """
    Load an evidence YAML file into DB2
    
    Args:
        evidence_file: Path to YAML evidence file
        config_file: Path to configuration file
        
    Returns:
        deploy_id or None on failure
    """
    # Validate files exist
    if not Path(evidence_file).exists():
        logger.error(f"Evidence file not found: {evidence_file}")
        return None

    if not Path(config_file).exists():
        logger.error(f"Configuration file not found: {config_file}")
        return None

    loader = None
    try:
        # Load configuration to determine driver
        config = load_config(config_file)
        driver = config.driver

        logger.info(f"Using driver: {driver}")
        logger.info(f"Loading evidence: {evidence_file}")

        # Create appropriate loader based on configuration
        if driver == 'ibm_db':
            loader = DB2EvidenceLoaderIBM(config_file=config_file)
        elif driver == 'jdbc':
            loader = DB2EvidenceLoaderJDBC(config_file=config_file)
        else:
            logger.error(f"Unknown driver: {driver}")
            return None

        # Load evidence file
        deploy_id = loader.load_evidence_file(evidence_file)

        logger.info(f"✓ Evidence loaded successfully (Deploy ID: {deploy_id})")
        return deploy_id

    except FileNotFoundError as e:
        logger.error(f"File not found: {e}")
        return None

    except Exception as e:
        logger.error(f"Error loading evidence: {e}", exc_info=True)
        return None

    finally:
        if loader:
            loader.close()
            logger.info("Database connection closed")


def main():
    """Main function with argument parsing"""
    parser = argparse.ArgumentParser(
        description='Load YAML evidence files into DB2',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Load using default config.yaml
  python load_evidence.py evidence.yml
  
  # Load using custom configuration
  python load_evidence.py evidence.yml --config config_prod.yaml
  
  # Enable debug logging
  python load_evidence.py evidence.yml --debug
  
  # Multiple evidence files
  python load_evidence.py evidence1.yml evidence2.yml evidence3.yml
        """
    )

    parser.add_argument(
        'evidence_files',
        nargs='+',
        help='YAML evidence file(s) to load'
    )

    parser.add_argument(
        '-c', '--config',
        default='config.yaml',
        help='Configuration file (default: config.yaml)'
    )

    parser.add_argument(
        '-d', '--debug',
        action='store_true',
        help='Enable debug logging'
    )

    parser.add_argument(
        '-q', '--quiet',
        action='store_true',
        help='Quiet mode (only errors)'
    )

    args = parser.parse_args()

    # Adjust logging level
    if args.debug:
        logging.getLogger().setLevel(logging.DEBUG)
    elif args.quiet:
        logging.getLogger().setLevel(logging.ERROR)

    # Process each evidence file
    results = []
    for evidence_file in args.evidence_files:
        logger.info(f"\n{'='*60}")
        logger.info(f"Processing: {evidence_file}")
        logger.info(f"{'='*60}")

        deploy_id = load_evidence(evidence_file, args.config)
        results.append({
            'file': evidence_file,
            'deploy_id': deploy_id,
            'success': deploy_id is not None
        })

    # Print summary
    print(f"\n{'='*60}")
    print("SUMMARY")
    print(f"{'='*60}")

    success_count = sum(1 for r in results if r['success'])
    total_count = len(results)

    for result in results:
        status = "✓" if result['success'] else "✗"
        deploy_info = f"(Deploy ID: {result['deploy_id']})" if result['success'] else "(FAILED)"
        print(f"{status} {result['file']} {deploy_info}")

    print(f"\nLoaded {success_count}/{total_count} evidence files")
    print(f"{'='*60}\n")

    # Exit code: 0 if all successful, 1 otherwise
    sys.exit(0 if success_count == total_count else 1)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\nInterrupted by user")
        sys.exit(1)
    except Exception as e:
        logger.error(f"Unexpected error: {e}", exc_info=True)
        sys.exit(1)
