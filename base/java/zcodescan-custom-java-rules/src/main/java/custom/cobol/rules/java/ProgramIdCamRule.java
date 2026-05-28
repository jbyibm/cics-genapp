/*
 * IBM Confidential
 *
 * OCO Source Materials
 *
 * Copyright IBM Corp. 2026 All rights reserved.
 *
 * The source code for this program is not published or otherwise divested of its trade secrets, irrespective of what
 * has been deposited with the U.S. Copyright Office.
 */

package custom.cobol.rules.java;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.ibm.etools.cobol.application.model.cobol.ASTNode;
import com.ibm.etools.cobol.application.model.cobol.IdentificationDivision;
import com.ibm.etools.cobol.application.model.cobol.Program;
import com.ibm.zcodescan.api.IZCodeScanIssue;
import com.ibm.zcodescan.api.IZCodeScanLocation;
import com.ibm.zcodescan.api.IZCodeScanTextRange;
import com.ibm.zcodescan.api.ZCodeScanFactory;
import com.ibm.zcodescan.cobol.api.AbstractCOBOLVisitor;
import com.ibm.zcodescan.cobol.api.COBOLVisitorAdapter;
import com.ibm.zcodescan.cobol.api.IZCodeScanCobolRule;

public class ProgramIdCamRule implements IZCodeScanCobolRule {
    private static final String LENGTH_PARAM = "length"; //$NON-NLS-1$

    @Override
    public List<IZCodeScanIssue> scan(final String uri, final String source, final ASTNode astNode,
            final Map<String, String> parameters) {

        final List<IZCodeScanIssue> issues = new ArrayList<>();
        final ASTNode baseNode = astNode;
        final COBOLVisitorAdapter adapter = new COBOLVisitorAdapter();
        adapter.accept(baseNode, new AbstractCOBOLVisitor() {
            @Override
            public void unimplementedVisitor(final String value) {
                // DO NOTHING
            }

            @Override
            public boolean visit(final Program program) {
                final IZCodeScanTextRange textRange = checkProgramId(program, source,
                        (int) Double.parseDouble(parameters.get(LENGTH_PARAM)));
                if (textRange != null) {
                    final ZCodeScanFactory factory = ZCodeScanFactory.getInstance();
                    final IZCodeScanIssue issue = factory.createIssue();
                    final IZCodeScanLocation primaryLocation = factory.createLocation();
                    issue.setPrimaryLocation(primaryLocation);
                    primaryLocation.setTextRange(textRange);
                    issues.add(issue);
                }
                return true;
            }

        });
        return issues;
    }

    public static IZCodeScanTextRange checkProgramId(final Program program, final String source, final int maxLength) {
        final IdentificationDivision identificationDivision = program.getIdentificationDivision();
        final String programId = identificationDivision.getProgramId();
        if (programId.length() > maxLength) {
            final IZCodeScanTextRange textRange = ZCodeScanFactory.getInstance().createTextRange();
            textRange.setStartLine(identificationDivision.getBeginLine());
            textRange.setEndLine(identificationDivision.getEndLine());
            textRange.setStartColumn(identificationDivision.getBeginColumn());
            textRange.setEndColumn(identificationDivision.getEndColumn());
            textRange.setStartOffset(source.indexOf(programId));
            textRange.setEndOffset(source.indexOf(programId) + programId.length());
            return textRange;
        }
        return null;
    }

}
