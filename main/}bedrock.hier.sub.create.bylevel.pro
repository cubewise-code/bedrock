601,100
602,"}bedrock.hier.sub.create.bylevel"
562,"NULL"
586,
585,
564,
565,"dHIua?_mqep1za7votaIgfT6AwVFfpsdh`NQg84UfL6\0GY2t^_QR2dIX7CJKp8nfWU:uVcnIdSSxteRp_I=bD<b?gl[2?GvY5>veJyef_JK?h8QPH?^9c=?IqIrzYHiPI7yfmOp8E:V]IFPP:kt@_sI`43LgWNgqC7PLg;Qzrwr`sfiR:jmf?TIuuiyS>5a7uY[3zW;"
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
589,","
568,""""
570,
571,
569,0
592,0
599,1000
560,8
pLogOutput
pStrictErrorHandling
pDim
pHier
pSort
pConvertStatic
pAlias
pTemp
561,8
1
1
2
2
1
1
2
1
590,8
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pHier,""
pSort,0
pConvertStatic,1
pAlias,""
pTemp,1
637,8
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"REQUIRED: Dimension name"
pHier,"OPTIONAL: Hierarchy name (default if blank = same named hierarchy)"
pSort,"OPTIONAL: Sort the Subset"
pConvertStatic,"OPTIONAL: Convert the Subset to Static"
pAlias,"OPTIONAL: Set Alias for Subset"
pTemp,"OPTIONAL: Use temporary objects? (Boolean 1=True)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,178
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.sub.create.bylevel', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pDim', '', 'pHier', '',
    	'pSort', 0, 'pConvertStatic', 1,
    	'pAlias', '', 'pTemp', 1
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
# This process creates static subsets named "All level <nn>" for the specified consolidation
# levels in a Hierarchy of a Dimension.

# Note:
# Option to sort subset is available only for sorting per element principal names.

# Caution: Target hierarchy cannot be `Leaves`.
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
cLogInfo            = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%, pSort:%pSort%, pConvertStatic:%pConvertStatic%, pAlias:%pAlias%, pTemp:%pTemp%.'; 
cAttributeDim       = '}ElementAttributes_' | pDim;
cSubs               = '' ;

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

IF(HierarchyExists(pDim, sHier ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dimension Hierarchy: ' | pDim |':'|sHier;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate Alias
IF(pAlias @<> '' );

  sDimAttr = '}ElementAttributes_' | pDim;
  IF(
  DimensionExists( sDimAttr ) = 0 );
    sMessage = 'No attributes exist for the dimension: ' | pDim;
    pAlias = '';
  EndIf;

  IF(DIMIX( sDimAttr, pAlias ) = 0 );
    sMessage = 'The Alias: ' | pAlias | ' does not exist in the dimension: ' | pDim;
    pAlias = '';
  EndIf;

  IF(DTYPE( sDimAttr, pAlias ) @<> 'AA' );
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

### Build Subset ###

If( nErrors = 0 );
  nLevel = 0;
  nLevelMax = DnLev( pDim|':'|sHier ) - 1;
  While( nLevel <= nLevelMax );
    # Loop through the levels of the dimension.
    sLevel = NumberToString( nLevel );
    sSubset = 'All Level ' | Fill( '0', 2 - Long( sLevel ) ) | sLevel;
    cSubs = cSubs | ' ' | sSubset | ','  ;
    If( HierarchySubsetExists( pDim, sHier, sSubset ) = 1 );
      # Need to destroy the subset because the subset may change from an MDX subset to a Static Subset.
      HierarchySubsetDestroy( pDim, sHier, sSubset );
    EndIf;

    # Generate MDX
    sMDX = '{ TM1FILTERBYLEVEL( { TM1SUBSETALL( [' | pDim|':'|sHier | '] ) }, ' | sLevel | ' ) }';
    If( pSort = 1 );
      sMDX = '{ TM1SORT( ' | sMDX | ', ASC ) }';
    EndIf;

    ## Build Subset for the level.
    If( pConvertStatic = 1 );
      # Convert the subset to a static subset
      sSubsetMDX = '}' | cThisProcName | '.' | NumberToString( Int( Rand() * 100000 ) );
      If( HierarchySubsetExists( pDim, pHier, sSubsetMDX ) = 1 );
        HierarchySubsetDestroy( pDim, sHier, sSubsetMDX );
      EndIF;
      SubsetCreatebyMDX( sSubsetMDX, sMDX, pDim, pTemp );
      nSubsetSize = HierarchySubsetGetSize( pDim, sHier, sSubsetMDX );
      nSubsetIndex = 0;
      HierarchySubsetCreate( pDim, sHier, sSubset, pTemp );
      While( nSubsetIndex < nSubsetSize );
        nSubsetIndex = nSubsetIndex + 1;
        sTemp =    HierarchySubsetElementGetIndex (pDim, sHier, sSubsetMDX, '', nSubsetIndex);
        sElement = HierarchySubsetGetElementName( pDim, sHier, sSubsetMDX, nSubsetIndex );
        HierarchySubsetElementInsert( pDim, sHier, sSubset, sElement, nSubsetIndex );
      End;
    Else;
      SubsetCreatebyMDX( sSubset, sMDX, pDim, pTemp );
    EndIf;

    ### Assign Alias to subset
    IF(pAlias @<> '' );
      If( nErrors = 0 );
        HierarchySubsetAliasSet( pDim, pHier, sSubset, pAlias );
      EndIf;
    ENDIF;
    nLevel = nLevel + 1;
  End;
EndIf;




### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,27

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
    If( pStrictErrorHandling = 1 ); 
        ProcessQuit; 
    EndIf;
Else;
    sProcessAction = Expand( 'Process:%cThisProcName% successfully created subset(s) %cSubs% from dimension %pDim%.' );
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
