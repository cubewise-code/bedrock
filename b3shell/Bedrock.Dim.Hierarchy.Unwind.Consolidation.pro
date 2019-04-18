﻿601,100
602,"Bedrock.Dim.Hierarchy.Unwind.Consolidation"
562,"NULL"
586,"}Cubes"
585,"}Cubes"
564,
565,"g31G\<BaKIpt;at0NQi0>>Q]zx:[@Pk83<rkJCp_0sySi\CaotaYCIy8K1@e?2WSISFR:<LaUyU`stQsEr2]TMO\PBGvR7sUusFUL\nwi=5ASOUZF<nL;[h3`sTj?Fqc9icI3KFVF1hnWNI5IQnSuyh4YlYagqN8eyX2p3dsIKrnz?Q>d@q]:PPJFy8oWFs4J\pU3b?V"
559,1
928,0
593,
594,
595,
597,
598,
596,
800,
801,
566,0
567,","
588,"."
589,
568,""""
570,
571,All
569,0
592,0
599,1000
560,4
pDimension
pConsol
pRecursive
pDebug
561,4
2
2
1
1
590,4
pDimension,""
pConsol,""
pRecursive,0
pDebug,0
637,4
pDimension,"Target Dimension"
pConsol,"Target Consolidation"
pRecursive,"Boolean: 1 = True (break from node down not just direct children)"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,65

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4.

# This process will remove all children from a specific target consolidation in the target dimension
# If recursive will also unwind all consolidations that are children of the target regardless of depth

# Note:
# - If consolidations are also used in unrelated hierarchies and recursive is selected this will result in
#   orphan consolidations in the other hierarchies
##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName     = GetProcessName();
cUserName         = TM1User();
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile        = GetProcessErrorFileDirectory | cThisProcName | '.' | cTimeStamp | '.' | cRandomInt ;
cSubset           = cThisProcName | '_' |cTimeStamp | '_' | cRandomInt ;
#cHierAttr        = 'Bedrock.Descendant';
#cAttrVal         = 'Descendant';

### Validate pConsol
If( pConsol @= '' );
  pConsol = '*';
EndIf;
  

### Initialise Debug ###
If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';
  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension : ' | pDimension );
  AsciiOutput( sDebugFile, '            pConsol    : ' | pConsol );
  AsciiOutput( sDebugFile, '            pRecursive : ' | NumberToString( pRecursive ) );
EndIf;

nRet = EXECUTEPROCESS('}bedrock.hier.unwind',
  'pLogOutput', pDebug,
  'pDim', pDimension,
  'pHier', '',
  'pConsol', pConsol,
  'pRecursive', pRecursive
  );
  
IF(nRet <> 0);
    sMessage = 'the process incurred at least 1 major error and consequently aborted. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% aborted. Check tm1server.log for details.' );
    ProcessError;
EndIf;
573,10

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 



574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,10

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 



576,CubeAction=1511DataAction=1503CubeLogChanges=0
930,0
638,1
804,0
1217,1
900,
901,
902,
938,0
937,
936,
935,
934,
932,0
933,0
903,
906,
929,
907,
908,
904,0
905,0
909,0
911,
912,
913,
914,
915,
916,
917,0
918,0
919,0
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
