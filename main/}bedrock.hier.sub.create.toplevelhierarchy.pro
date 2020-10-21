601,100
602,"}bedrock.hier.sub.create.toplevelhierarchy"
562,"NULL"
586,
585,
564,
565,"wjL>a=cy7hb^qcdFv?JLLeSaC:aD7tX@mJEVNx;wDzpmHmFl[jgu\oZvaBzLDu]XGnoWlo<mpDNJ]v9MrJJfSx_3rjxLHJeMT@`_QFi[PJ2qJlSlyF\VEc]4_JR90_cE^IN@TRMgsY]9iPqeGj[^7kLkQsq;U:yqOFprlModVP5lieMh6@Q\^so@<Of:HEbt9TS3[9:9"
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
pSub
pConvertToStatic
pAlias
pTemp
561,8
1
1
2
2
2
1
2
1
590,8
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pHier,""
pSub,""
pConvertToStatic,1
pAlias,""
pTemp,1
637,8
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"REQUIRED: Dimension name"
pHier,"OPTIONAL: Hierarchy name (default if blank = same named hierarchy)"
pSub,"REQUIRED: Subset name"
pConvertToStatic,"OPTIONAL: Boolean: 1 = Convert to Static Subset"
pAlias,"OPTIONAL: Set Alias for Subset"
pTemp,"OPTIONAL: Use temporary objects? (Boolean 1=True)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,180
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.sub.create.toplevelhierarchy', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pDim', '', 'pHier', '', 'pSub', '',
    	'pConvertToStatic', 1, 'pAlias', '', 'pTemp', 1
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

# This process will Create a Top Level Hierarchy by N-Level Elements
# that is a subset of all "top node" elements ( Consolidated elements that have no parents )

#EndRegion @DOC

##Global Variables
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
cLogInfo            = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%, pSub:%pSub%, pConvertToStatic:%pConvertToStatic%, pAlias:%pAlias%, pTemp:%pTemp%.'; 
cAttributeDim       = '}ElementAttributes_' | pDim;


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

If( DnLev( pDim|':'|sHier ) <= 1 );
  # Create by MDX would return empty set and fail so need to abort here
  nErrors = 1;
  sMessage = 'Cannot continue, dimension hierarchy is flat: ' | pDim|':'|sHier;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIF;


# Validate subset
If( Trim( pSub ) @= '' );
  pSub = 'Top Level Hierarchies';
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

### MDX for creating subset ###

sMDX = '{EXCEPT( {FILTER( {TM1SUBSETALL( [' | pDim|':'|sHier | '] )}, MemberToStr( [' |
       pDim|':'|sHier | '].CurrentMember.Parent ) = "" )},' |
       '{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | pDim|':'|sHier | '] )},0 )} )}';


### Create Subset ###

If( nErrors = 0 );

  # For a dynamic subset, the original subset MUST be destroyed first or the MDX will fail
  If( pConvertToStatic = 0 );
    If( HierarchySubsetExists( pDim, sHier, pSub ) = 1 );
      HierarchySubsetDestroy( pDim, sHier, pSub );
    EndIf;
    SubsetCreateByMDX( pSub, sMDX, pDim, pTemp );

  # For a static subset the subset does not need to be destroyed but its elements need to be deleted first
  Else;
    If( HierarchySubsetExists( pDim, sHier, pSub ) = 1 );
      HierarchySubsetDeleteAllElements( pDim, sHier, pSub );
    Else;
      HierarchySubsetCreate( pDim, sHier, pSub, pTemp );
    EndIf;

    # Create a temporary MDX subset for processing
    sSubsetMDX = cThisProcName |'.' | NumberToString( Int( Rand() * 100000 ) );
    # It is unlikely that the subset already exists due to the random number in the subset name
    # However, it the SubsetDestroy is included in case the same random number is generated
    If( HierarchySubsetExists( pDim, sHier, sSubsetMDX ) = 1 );
      HierarchySubsetDestroy( pDim, sHier, sSubsetMDX );
    EndIf;
    SubsetCreateByMDX( sSubsetMDX, sMDX, pDim, pTemp );

    # Transfer the elements from the MDX subset to the static subset
    nSubsetSize = HierarchySubsetGetSize( pDim, sHier,sSubsetMDX );
    nSubsetIndex = 0;
    While( nSubsetIndex < nSubsetSize );
      nSubsetIndex = nSubsetIndex + 1;
      sTemp = HierarchySubsetElementGetIndex (pDim, sHier, sSubsetMDX, '', nSubsetIndex);
      sElement = HierarchySubsetGetElementName( pDim, sHier, sSubsetMDX, nSubsetIndex );
      HierarchySubsetElementInsert( pDim, sHier, pSub, sElement, nSubsetIndex );
    End;
  EndIf;

EndIf;

### Set Alias ##
IF(pAlias @<> '' );
  If( nErrors = 0 );
    HierarchySubsetAliasSet( pDim, pHier, pSub, pAlias );
  EndIf;
ENDIF;

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
