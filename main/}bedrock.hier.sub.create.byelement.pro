601,100
602,"}bedrock.hier.sub.create.byelement"
562,"NULL"
586,
585,
564,
565,"gxMapt;a9FLDI3YdqZ38riudEG9@j<:roYM4K;\U0=Dvqzl\8K7ePW;GWNTl>?uvehqKzP63OtfDBc3LJ^oh8KwTsJK5DH^dIhLaM;RrHtCQ:8TCUh2]aMiXjyFes]ZSJD=b?<8T5fr\mo\_j9eaatbxZ8wuJ:R]DM^rK1sdNe?[J`k6QtrKaBT\IDc4kghQgdAw<>pr"
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
pEle
pDelim
pAddToSubset
pAlias
pTemp
561,9
1
2
2
2
2
2
1
2
1
590,9
pLogOutput,0
pDim,""
pHier,""
pSub,""
pEle,""
pDelim,"&"
pAddToSubset,0
pAlias,""
pTemp,1
637,9
pLogOutput,"Optional: write parameters and action summary to server message log (Boolean True = 1)"
pDim,"Required: Dimension name"
pHier,"Optional: Hierarchy name (default if blank = same named hierarchy)"
pSub,"Required: Subset name"
pEle,"Required: Elements Separated by Delimiter"
pDelim,"Optional: Delimiter character"
pAddToSubset,"Optional: Add to Subset if it Already Exists (0=No 1=Yes)"
pAlias,"Optional: Set Alias for Subset"
pTemp,"Optional: Use temporary objects? (Boolean 1=True)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,199

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This process will create a static subset in a Hierarchy of target Dimension based on a list of
# supplied elements.

# Note:
# - pAddToSubset: If the specified subset already exists then this parameter will control whether elements will
#                 be added to the existing subset (value 1) or a new subset will be created (value 0).
# Caution: Process doesn't accept wildcards in element names.
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName       = GetProcessName();
cUserName           = TM1User();
cTimeStamp          = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt          = NumberToString( INT( RAND( ) * 1000 ));
cTempSub            = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cMsgErrorLevel      = 'ERROR';
cMsgErrorContent    = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo            = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%, pSub:%pSub%, pEle:%pEle%, pDelim:%pDelim%, pAddToSubset:%pAddToSubset%, pAlias:%pAlias%, pTemp:%pTemp%.'; 
cAttributeDim       = '}ElementAttributes_' | pDim;

## LogOutput parameters
IF ( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;


### Validate Parameters ###

nErrors = 0;

If( Scan( ':', pDim ) > 0 & pHier @= '' );
    # A hierarchy has been passed as dimension. Handle the input error by splitting dim:hier into dimension & hierarchy
    pHier       = SubSt( pDim, Scan( ':', pDim ) + 1, Long( pDim ) );
    pDim        = SubSt( pDim, 1, Scan( ':', pDim ) - 1 );
EndIf;

# Validate dimension

If( Trim( pDim ) @= '' );
  nErrors = 1;
  sMessage = 'No dimension specified';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;
If( DimensionExists( pDim ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dimension: ' | pDim;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate Hierarchy

IF(pHier @= 'Leaves' );
  nErrors = 1;
  sMessage = 'Invalid  Hierarchy: ' | pDim |':'|pHier;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

If( Trim( pHier ) @= '' );
  sHier = pDim;
Else;
  sHier = pHier;
EndIf;

IF(HierarchyExists(pDim, pHier ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dimension Hierarchy: ' | pDim |':'|pHier;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate subset
If( Trim( pSub ) @= '' );
  nErrors = 1;
  sMessage = 'No subset specified';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate elements
If( Trim( pEle ) @= '' );
  nErrors = 1;
  sMessage = 'No elements specified';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate delimiter
If( pDelim @= '' );
  pDelim = '&';
EndIf;

# Validate add to subset
If( pAddToSubset <> 0 & pAddToSubset <> 1 );
  nErrors = 1;
  sMessage = 'Invalid value for pAddToSubset: ' | NumberToString( pAddToSubset ) | '. Valid values are 0 and 1';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate Alias
sDimAttr = '}ElementAttributes_' | pDim;
IF(pAlias @<> '' );
  IF(DimensionExists( sDimAttr ) = 0 );
    sMessage = 'No attributes exist for the dimension: ' | pDim;
    pAlias = '';
  EndIf;

  IF(DIMIX( sDimAttr, pAlias ) = 0 );
    sMessage = 'The Alias: ' | pAlias | ' does not exist in the dimension: ' | pDim;
    pAlias = '';
  EndIf;

  IF(
  DTYPE( sDimAttr, pAlias ) @<> 'AA' );
    sMessage = 'The Alias: ' | pAlias | ' is not an Alias in the dimension: ' | sDimAttr;
    pAlias = '';
  EndIf;
ENDIF;

## Validate pTemp
IF( pTemp <> 0 & pTemp <> 1 );
    nErrors = 1;
    sMessage = 'Wrong parameter pTemp value (only 0 or 1 accepted).';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Prepare subset ###
If( HierarchySubsetExists( pDim, pHier, pSub ) = 1 );
  If( pAddtoSubset <> 1 );
    HierarchySubsetDeleteAllElements( pDim, pHier, pSub );
    nSubsetSize = 0;
  Else;
    nSubsetSize = HierarchySubsetGetSize( pDim, pHier, pSub );
  EndIf;
Else;
  If( nErrors = 0 );
    HierarchySubsetCreate( pDim, pHier, pSub, pTemp );
  EndIf;
  nSubsetSize = 0;
EndIf;

### Assign Alias to subset
IF(pAlias @<> '' );
  HierarchySubsetAliasSet( pDim, pHier, pSub, pAlias );
ENDIF;

### Insert elements ###

nSubsetIndex = 1;
sElements = pEle;
nDelimIndex = 1;

# Split filter into seperate dimensions
While( nDelimIndex <> 0 & Long( sElements ) > 0 );

  nDelimIndex = Scan( pDelim, sElements );
  If( nDelimIndex <> 0 );
    sElement = Trim( SubSt( sElements, 1, nDelimIndex - 1 ) );
    sElements = Trim( SubSt( sElements, nDelimIndex + Long( pDelim ), Long( sElements ) ) );
  Else;
    sElement = Trim( sElements );
  EndIf;

  If( ElementIndex( pDim, pHier, sElement ) <> 0 );
    If( nErrors = 0 );
       IF(ElementLevel( pDim, pHier, sElement) > 0);
         ExecuteProcess('}bedrock.hier.sub.create',
                         'pDim', pDim,
                         'pHier',pHier,
                         'pSub', pSub,
                         'pConsol', sElement,
                         'pExclusions', '',
                         'pDelim', pDelim,
                         'pAddToSubset', 1,
                         'pAlias', '',
                         'pTemp', pTemp
                        );

      ELSE;
        HierarchySubsetElementInsert( pDim, pHIer, pSub, sElement, nSubsetIndex );
      ENDIF;
    EndIf;
    nSubsetIndex = nSubsetIndex + 1;
  EndIf;
End;


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
