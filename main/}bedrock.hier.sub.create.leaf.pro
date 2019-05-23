601,100
602,"}bedrock.hier.sub.create.leaf"
562,"NULL"
586,
585,
564,
565,"g0M8A@DaM@2yZi5G57S3>Qi6]Ay]T@9b<J^e4WE<9BQR9L<FOh_reCj1V7XxSQfht4Get=X[ie;[WeH?13mPnLmW;kuj:yz2LnI4J]bS^Rkv:6N0i;rwdsxDd2QA?nhK`6czE`OZ>G2VCyEV;Gn?zV;GFp?<9PY_0Ga4yDq<>imAIeIFQ=MJjI:@7fqR78\EKlFkx@H0"
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
571,
569,0
592,0
599,1000
560,9
pLogOutput
pDim
pHier
pSub
pAddToSubset
pExclusions
pDelim
pAlias
pTemp
561,9
1
2
2
2
1
2
2
2
1
590,9
pLogOutput,0
pDim,""
pHier,""
pSub,""
pAddToSubset,0
pExclusions,""
pDelim,"&"
pAlias,""
pTemp,1
637,9
pLogOutput,"Optional: write parameters and action summary to server message log (Boolean True = 1)"
pDim,"Required: Dimension name"
pHier,"Optional: Hierarchy name (default if blank = same named hierarchy)"
pSub,"Required: Subset name"
pAddToSubset,"Optional: Add to Subset if it Already Exists (0=No 1=Yes)"
pExclusions,"Optional: Elements to Exclude From Subset (Separated by Delimiter, Accepts Wild card)"
pDelim,"Optional: Delimiter character"
pAlias,"Optional: Set Alias for Subset"
pTemp,"Optional: Use temporary objects? (Boolean 1=True)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,72
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.sub.create.leaf', 'pLogOutput', pLogOutput,
    	'pDim', '', 'pHier', '', 'pSub', '',
    	'pAddToSubset', 0, 'pExclusions', '',
    	'pDelim', '&', 'pAlias', '', 'pTemp', 1
	);
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This process will create a static subset in Hierarchy of a Dimension that consists of all leaf
# elements.

# Note:
# This process uses modification parameters to determine what to include in the subset:
# - pExclusions: If pExclusions is specified then the elements (separated by a delimiter) will be
#                excluded from the subset. Wildcards characters `*` and `?` are accepted.
# - pAddToSubset: If the specified subset already exists then this parameter will control whether elements will
#                 be added to the existing subset (value 1) or a new subset will be created (value 0).
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;
nErrors = 0;

### Constants ###
cThisProcName       = GetProcessName();
cUserName           = TM1User();
cTimeStamp          = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt          = NumberToString( INT( RAND( ) * 1000 ));
cTempSub            = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cMsgErrorLevel      = 'ERROR';
cMsgErrorContent    = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo            = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%, pSub:%pSub%, pExclusions:%pExclusions%, pDelim:%pDelim%, pAddToSubset:%pAddToSubset%, pAlias:%pAlias%, pTemp:%pTemp%.';
cAttributeDim       = '}ElementAttributes_' | pDim;


## LogOutput parameters
IF ( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

nErrors = 0;

## Validate pTemp
IF( pTemp <> 0 & pTemp <> 1 );
    nErrors = 1;
    sMessage = 'Wrong parameter pTemp value (only 0 or 1 accepted).';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

nReturncode = 
ExecuteProcess( '}bedrock.hier.sub.create', 'pLogOutput', pLogOutput,
    'pDim', pDim, 'pHier',pHier, 'pSub', pSub,
    'pLevelFrom', 0, 'pLevelTo', 0,
    'pExclusions', pExclusions, 'pAddToSubset', pAddToSubset,
    'pDelim', pDelim, 'pAlias', pAlias, 'pTemp', pTemp
);

### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,24

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

### Return code & final error message handling
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
Else;
    sProcessAction = Expand( 'Process:%cThisProcName% successfully created subset %pSub% from dimension %pDim%.' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogoutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );   
    EndIf;
EndIf;

### End Epilog ###
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
918,1
919,0
920,0
921,""
922,""
923,0
924,""
925,""
926,""
927,""
