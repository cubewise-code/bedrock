601,100
602,"}bedrock.hier.sub.create.consolidation.all"
562,"NULL"
586,
585,
564,
565,"fNmt=caCO=GcQaFo::y0ZLy_uQj6^<n=R>`z]\]LpoXhpl@9MDwkdTeY9?qxhtlQo[i2=O_T08qOh=EpIC]_rhn>]jMBY`;1NZX`GBm>P@A@vnq6yIZ\wTs9AykgHQ<X^_5n;[e;TEkPTE6t1L@\xf16]miwP91Yxl?llapJ2t^zNEx7NmdeuLYRoT=WT<1543zUmjU5"
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
560,10
pLogOutput
pDim
pHier
pSub
pConsol
pAddToSubset
pExclusions
pDelim
pAlias
pTemp
561,10
1
2
2
2
2
1
2
2
2
1
590,10
pLogOutput,0
pDim,""
pHier,""
pSub,""
pConsol,""
pAddToSubset,0
pExclusions,""
pDelim,"&"
pAlias,""
pTemp,1
637,10
pLogOutput,"Optional: write parameters and action summary to server message log (Boolean True = 1)"
pDim,"Required: Dimension name"
pHier,"Optional: Hierarchy name (default if blank = same named hierarchy)"
pSub,"Required: Subset name"
pConsol,"Optional: Consolidated Element  (Blank Equals All)"
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
572,75

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This process will create a static subset in a Hierarchy of target Dimension that consists of
# all descendants of a specified consolidated element, including consolidated elements.

# Note:
# - pExclusions: If pExclusions is specified then the elements (separated by a delimiter) will be
#   excluded from the subset. Wildcards characters `*` and `?` are accepted.
# - pAddToSubset : If the specified subset already exists then this parameter will control whether
#   elements will be added to the existing subset (value 1) or a new subset will be created
#   (value 0).

# Caution: Number of consolidated levels that are processed is limited to maximum of 99.
#EndRegion @DOC

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###

cThisProcName = GetProcessName();
cUserName         = TM1User();
cMsgErrorLevel    = 'ERROR';
cMsgErrorShell = Expand('Executing process %cThisProcName% has failed.');
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%, pSub:%pSub%, pConsol:%pConsol%, pAddToSubset:%pAddToSubset%, pExclusions:%pExclusions%, pDelim:%pDelim%, pAlias:%pAlias%, pTemp:%pTemp%.' ;

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

nErrors = 0;

## Validate pTemp
IF( pTemp <> 0 & pTemp <> 1 );
    nErrors = 1;
    sMessage = 'Wrong parameter pTemp value (only 0 or 1 accepted).';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

nReturnCode = ExecuteProcess('}bedrock.hier.sub.create',
                              'pLogOutput', pLogOutput,
                              'pDim', pDim,
                              'pHier',pHier,
                              'pSub', pSub,
                              'pConsol', pConsol,
                              'pAttr', '',
                              'pAttrValue', '',
                              'pLevelFrom', 0,
                              'pLevelTo', 99,
                              'pExclusions', pExclusions,
                              'pDelim', pDelim,
                              'pAddToSubset', pAddToSubset,
                              'pAlias', pAlias,
                              'pTemp', pTemp
                            );
                            
IF ( nReturnCode <> ProcessExitNormal() );
  sMessage = cMsgErrorShell;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  ProcessError();
ENDIF;


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
