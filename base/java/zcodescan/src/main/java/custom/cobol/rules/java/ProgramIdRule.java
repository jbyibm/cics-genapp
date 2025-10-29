package custom.cobol.rules.java;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ibm.zcodescan.api.IZCodeScanIssue;
import com.ibm.zcodescan.api.IZCodeScanLocation;
import com.ibm.zcodescan.api.IZCodeScanRule;
import com.ibm.zcodescan.api.IZCodeScanTextRange;
import com.ibm.zcodescan.api.ZCodeScanFactory;

public class ProgramIdRule implements IZCodeScanRule {

	private static final String LENGTH_PARAM = "length";
	private static final String PROGRAM_ID = "PROGRAM-ID";

	private static final String SOURCE = """
			IDENTIFICATION DIVISION.
			PROGRAM-ID. HELLOO.
			AUTHOR. PROGRAMMER.
			ENVIRONMENT DIVISION.
			DATA DIVISION.
			PROCEDURE DIVISION.
			MAINLINE.
			DISPLAY 'Hello World!'.
			STOP RUN.
			""";

	public static void main(String[] args) {
		Map<String, String> parameters = new HashMap<>();
		parameters.put(LENGTH_PARAM, "4"); //$NON-NLS-1$
		List<IZCodeScanIssue> issues = new ProgramIdRule().scan("hello.cbl", SOURCE, parameters); //$NON-NLS-1$
		System.out.println(issues.size());
	}
 
	@Override
	public List<IZCodeScanIssue> scan(String uri, String source, Map<String, String> parameters) {
		if (parameters.get(LENGTH_PARAM) == null) {
			return Collections.emptyList();
		}
		IZCodeScanTextRange textRange = findProgramIdLine(source,
				(int) Double.parseDouble(parameters.get(LENGTH_PARAM)));
		if (textRange == null) {
			return Collections.emptyList();
		}
		List<IZCodeScanIssue> issues = new ArrayList<>();
		ZCodeScanFactory factory = ZCodeScanFactory.getInstance();
		IZCodeScanIssue issue = factory.createIssue();
		IZCodeScanLocation primaryLocation = factory.createLocation();
		issue.setPrimaryLocation(primaryLocation);
		primaryLocation.setTextRange(textRange);
		issues.add(issue);
		return issues;
	}

	public static IZCodeScanTextRange findProgramIdLine(String source, int maxLength) {
		String[] lines = source.split("\n"); //$NON-NLS-1$
		for (int i = 0; i < lines.length; i++) {
			if (lines[i].contains(PROGRAM_ID)) {
				String line = lines[i];
				int index = line.indexOf(PROGRAM_ID);
				if (index != -1) {
					String after = line.substring(index + PROGRAM_ID.length() + 1).trim();
					String programId = after.split("[\\s.]+")[0]; //$NON-NLS-1$
					if (programId.length() > maxLength) {
						IZCodeScanTextRange textRange = ZCodeScanFactory.getInstance().createTextRange();
						textRange.setStartLine(i + 1);
						textRange.setEndLine(i + 1);
						textRange.setStartColumn(line.indexOf(PROGRAM_ID));
						textRange.setEndColumn(line.indexOf(programId) + programId.length());
						textRange.setStartOffset(source.indexOf(programId));
						textRange.setEndOffset(source.indexOf(programId) + programId.length());
						return textRange;
					} else {
						return null;
					}
				}
			}
		}
		return null;
	}
}
