601,100
602,"}bedrock.hier.leaves.orphan.check"
562,"SUBSET"
586,"}Dimensions"
585,"}Dimensions"
564,
565,"tqJ^r_HVFBuaH@V54yeAz@MqdhMhstA<SzEPKHXQcppzQo[]XN\jYUcDVue102sIOwKV7=:okED?fSFXxB3?>ooXeZdSSO\f>eL04n1VET7WWdkFQ_Rfk6vw_R2Gy3PAOqVYZtH?i0c@cvZ<@Wui=i42d7]`k^jbIXIW?O=2<5HBuRMGJYs`JcEi9Rp9mdqN?AVH;yLRtqJ^r_HVFBuaH@V54yeAt@MqdhMhstA<WzEPKHXQcppzQOZ]XN\jYUcDV5`802cNOwKF5=:okED7fSEXxB3?>ooXeZdXSO\f>eL@9n1VET7WWd{HS_Rfk6vw_R2GYDPAOQPYYtH?i0c0fvZLBWu99i42d7]`k^jbIX9S?O==<5HBuQMGJYs`JCNi9Rp9mD|~9AVH;yLR"
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
571,All
569,0
592,0
599,1000
560,8
pLogOutput
pStrictErrorHandling
pDim
pHier
pTgtSubLeaves
pIncludeNoParentElems
pTgtSubNoParents
pDelim
561,8
1
1
2
2
2
1
2
2
590,8
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pHier,"*"
pTgtSubLeaves,"Bedrock - Orphan Elements - Leaves"
pIncludeNoParentElems,0
pTgtSubNoParents,"Bedrock - No Parents"
pDelim,"&"
637,8
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"REQUIRED: Dimension, accepts wildcards (if = *, then all the dimensions)"
pHier,"OPTIONAL: Hierarchy, accepts wildcards (all hierarchies except default and Leaves deleted if = *)"
pTgtSubLeaves,"OPTIONAL: Name of target subset to store orphans in Leaves hierarchy"
pIncludeNoParentElems,"OPTIONAL: Include elements that have no parent in any of matching hierarchies"
pTgtSubNoParents,"OPTIONAL: Name of target subset to store elements that have no parent in any of matching hierarchies"
pDelim,"OPTIONAL: Delimiter character (default value if blank = '&')"
577,1
vDim
578,1
2
579,1
1
580,1
0
581,1
0
582,1
VarType=32ColType=827
603,0
572,153
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.leaves.orphan.check', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pDim', '', 'pHier', '*',
    	'pTgtSubLeaves', 'Bedrock - Orphan Elements - Leaves',
    	'pIncludeNoParentElems', 0,
    	'pTgtSubNoParents', 'Bedrock - No Parents',
    	'pDelim', '&' 
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
# This process checks all leaf elements (in the Leaves hierarchy) of the specified dimension(s).
# Within the Leaves hierarchy for each element *all hierarchies* are scanned for the existance of the leaf element.
# If the leaf element does not exist in all hierarchies except for Leaves then the element is classified as an orphan and added to the 
# "Orphan Leaf Elements" subset.
# Additionally when running with pIncludeNoParentElems parameter set, elements that have no parent will be stored in No Parents subset
# of matching hierarchy (except `Leaves`) within Leaves. The subset name might be accomodated and will be suffixed by dash and name of the matching hierarchy.
#
# Use case: 
# 1. Primarily intended to identify dimensions with maintenance issues during development/prototyping.
# 2. Can also be used for trouble-shooting in productive instances.
#
#EndRegion @DOC

### Global Variables

StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants
cThisProcName     = GetProcessName();
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cTempSub1          = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cTempSub2         = cTempSub1 | '_2';
cTempSubDim       = cThisProcName |'_Dim_'| cTimeStamp |'_'| cRandomInt;
cUserName         = TM1User();
cMsgErrorLevel    = 'ERROR';
cMsgInfoLevel     = 'INFO';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pDim:%pDim%.';
cAll              = '*';
cDimDimensions    = '}Dimensions';
cHierLeaves       = 'Leaves';
cSubMissing       = 'Bedrock - Orphan Elements - Leaves';
cSubNoParents     = 'Bedrock - No Parents - %sHier%';

### LogOutput parameters
IF( pLogoutput = 1 );
  LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters
nErrors = 0;
nDims = 0;
nDimsWithOrphans = 0;
nDimsWithoutParents = 0;
nElems = 0;
nElemsMissing = 0;
nElemsMissingParent = 0;
sDimPrev = '';

If( Scan( '*', pDim ) = 0 & Scan( '?', pDim ) = 0 & Scan( pDelim, pDim ) = 0 & Scan( ':', pDim ) > 0 & pHier @= '' );
  # A hierarchy has been passed as dimension. Handle the input error by splitting dim:hier into dimension & hierarchy
  pHier = SubSt( pDim, Scan( ':', pDim ) + 1, Long( pDim ) );
  pDim = SubSt( pDim, 1, Scan( ':', pDim ) - 1 );
EndIf;

### Validate delimiter
If( Trim( pDelim ) @= '' );
  pDelim = '&';
EndIf;

If( Trim( pTgtSubLeaves ) @= '' );
  pTgtSubLeaves = cSubMissing;
EndIf;

If( Trim( pTgtSubNoParents ) @= '' );
  pTgtSubNoParents = cSubNoParents;
Else;
  pTgtSubNoParents = pTgtSubNoParents | ' - %sHier%';
EndIf;

### Validate dimension
If( Trim( pDim ) @= '' );
  nErrors = 1;
  sMessage = 'No dimension specified.';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### If errors occurred terminate process with a major error status ###
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

### Handle All dimensions or a dimension list
### We will exclude hierarchies in this step and will filter them in connection with subsets in later steps
If ( TRIM( pDim ) @= cAll );
  sMDX = Expand( '{FILTER(TM1SUBSETALL([%cDimDimensions%]), INSTR([%cDimDimensions%].CurrentMember.Name, '':'' ) = 0 )}' );
Else;
  sDimTokenizer = TRIM( pDim );
  sMDX = '';
  ### Loop and tokenize dimension list
  While ( sDimTokenizer @<> '' );
    nPos = SCAN( pDelim, sDimTokenizer );
    If ( nPos = 0 );
      nPos = LONG( sDimTokenizer ) + 1;
    EndIf;
    sSearchDim = TRIM( SUBST( sDimTokenizer, 1, nPos - 1 ) );
    If( sMDX @= '' );
      sMDX = Expand( '{TM1FILTERBYPATTERN({FILTER(TM1SUBSETALL([%cDimDimensions%]), INSTR([%cDimDimensions%].CurrentMember.Name, '':'' ) = 0 )}, "%sSearchDim%")}' );
    Else;
      sMDX = Expand( '%sMDX% + {TM1FILTERBYPATTERN({FILTER(TM1SUBSETALL([%cDimDimensions%]), INSTR([%cDimDimensions%].CurrentMember.Name, '':'' ) = 0 )}, "%sSearchDim%")}' );
    EndIf;
    ### Consume dimension and delimiter
    sDimTokenizer = TRIM( DELET( sDimTokenizer, 1, nPos + LONG( pDelim ) - 1 ) );
  End;
  sMDX = Expand( '{%sMDX%}' );
EndIf;

### Create dimensions subset
If ( SubsetExists( cDimDimensions, cTempSub1 ) = 0 );
  SubsetCreate( cDimDimensions, cTempSub1, 1 );
EndIf;
SubsetMDXSet( cDimDimensions, cTempSub1, sMDX );
SubsetMDXSet( cDimDimensions, cTempSub1, '' );

### Create hierachies working subset
If ( SubsetExists( cDimDimensions, cTempSub2 ) = 0 );
  SubsetCreate( cDimDimensions, cTempSub2, 1 );
EndIf;

DatasourceNameForServer = cDimDimensions;
DatasourceNameForClient = cDimDimensions;
DataSourceType = 'SUBSET';
DatasourceDimensionSubset = cTempSub1;
573,106
#****Begin: Generated Statements***
#****End: Generated Statements****

# Skip processing if there is no Leaves hierarchy defined for the dimension or we are processing Leaves
If ( HierarchyExists( vDim, cHierLeaves ) = 0 );
  ItemSkip;
EndIf;

# Summary information printout
If ( sDimPrev @<> vDim );
  If ( sDimPrev @<> '' & nElemsMissing <> 0 );
    sElemsMissing = NumberToString( nElemsMissing );
    If ( pLogOutput <> 0 );
      LogOutput( cMsgInfoLevel, Expand( 'Dimension [%sDimPrev%] is missing [%sElemsMissing%] elements from [%cHierLeaves%] hierarchy in all of matching hierarchies [%pHier%]. List of elements is available in subset [%pTgtSub%] of [%cHierLeaves%] hierarchy.' ) );
    EndIf;
    nDimsWithOrphans = nDimsWithOrphans + 1;
  EndIf;
  If ( sDimPrev @<> '' & nElemsMissingParent <> 0 );
    sElemsMissingParent = NumberToString( nElemsMissingParent );
    If ( pLogOutput <> 0 );
      LogOutput( cMsgInfoLevel, Expand( 'Dimension [%sDimPrev%] contains [%sElemsMissingParent%] elements that are missing parent in matching hierarchies [%pHier%].' ) );
    EndIf;
    nDimsWithoutParents = nDimsWithoutParents + 1;
  EndIf;
  nDims = nDims + 1;
  nElemsMissing = 0;
  nElemsMissingParent = 0;
  sDimPrev = vDim;
EndIf;

If( pHier @= '' );
  sHier = vDim;
Else;
  sHier = pHier;
EndIf;

If( sHier @= cAll );
  sMDX = Expand( '{FILTER(TM1SUBSETALL([%cDimDimensions%]), [%cDimDimensions%].CurrentMember.Name = ''%vDim%'' OR INSTR([%cDimDimensions%].CurrentMember.Name, ''%vDim%:'' ) = 1 )}' );
  SubsetMDXSet( cDimDimensions, cTempSub2, sMDX );
  # Exclude Leaves from the count
  nMaxHier = SubsetGetSize( cDimDimensions, cTempSub2 ) - 1;
Else;
  sMDX = Expand( '{TM1FILTERBYPATTERN({TM1SUBSETALL([%cDimDimensions%])}, ''%vDim%:%sHier%'')}' );
  SubsetMDXSet( cDimDimensions, cTempSub2, sMDX );
  nMaxHier = SubsetGetSize( cDimDimensions, cTempSub2 );
EndIf;  

If ( nMaxHier <> 0 );
  nElem = 1;
  nMaxElem = ElementCount( vDim, cHierLeaves );
  While ( nElem <= nMaxElem );
    sElem = ElementName( vDim, cHierLeaves, nElem );
    nElems = 0;
    nHier = 1;
    While ( nHier <= nMaxHier );
      sDimHier = SubsetGetElementName( cDimDimensions, cTempSub2, nHier );
      nDelimHier = SCAN( ':', sDimHier );
      If ( nDelimHier <> 0 );
        sDim = SUBST( sDimHier, 1, nDelimHier - 1);
        sHier = SUBST( sDimHier, nDelimHier + 1, LONG( sDimHier ) - nDelimHier );
      Else;
        sDim = sDimHier;
        sHier = sDimHier;
      EndIf;
      If ( sHier @<> cHierLeaves );
        If ( pIncludeNoParentElems <> 0 );
          If(ElementIndex( sDim, sHier, sElem ) <> 0 & ElementParentCount( sDim, sHier, sElem ) = 0 & ElementLevel(sDim, sHier, sElem) = 0);
            sTgtSubNoParents = Expand(pTgtSubNoParents);
            If ( HierarchySubsetExists( sDim, cHierLeaves, sTgtSubNoParents ) = 0 );
              HierarchySubsetCreate( sDim, cHierLeaves, sTgtSubNoParents );
            ElseIf ( nElemsMissingParent = 0 );
              HierarchySubsetDeleteAllElements( sDim, cHierLeaves, sTgtSubNoParents );
            EndIf;
            If ( HierarchySubsetElementExists( sDim, cHierLeaves, sTgtSubNoParents, sElem ) = 0 );
              HierarchySubsetElementInsert( sDim, cHierLeaves, sTgtSubNoParents, sElem, 0 );
            EndIf;
            If ( pLogOutput > 1 );
              LogOutput( cMsgInfoLevel, Expand( 'Element [%sElem%] is missing parent in [%sHier%] of dimension [%vDim%].' ) );
            EndIf;
            nElemsMissingParent = nElemsMissingParent + 1;
          EndIf;
        EndIf;
        If ( ElementIndex( sDim, sHier, sElem ) = 0 );
          nElems = nElems + 1;
        EndIf;
      EndIf;
      nHier = nHier + 1;
    End;
    # We have scanned all hierarchies and if number of elements missing equals number of hierarchies (excl. Leaves) then the element is orphan in Leaves
    If ( nElems = nMaxHier );
      If ( HierarchySubsetExists( sDim, cHierLeaves, pTgtSubLeaves ) = 0 );
        HierarchySubsetCreate( sDim, cHierLeaves, pTgtSubLeaves );
      ElseIf ( nElemsMissing = 0 );
        HierarchySubsetDeleteAllElements( sDim, cHierLeaves, pTgtSubLeaves );
      EndIf;
      If ( HierarchySubsetElementExists( sDim, cHierLeaves, pTgtSubLeaves, sElem ) = 0 );
        HierarchySubsetElementInsert( sDim, cHierLeaves, pTgtSubLeaves, sElem, 0 );
      EndIf;
      If ( pLogOutput > 1 );
        LogOutput( cMsgInfoLevel, Expand( 'Element [%sElem%] is missing in all matching hierarchies [%pHier%] of dimension [%vDim%] except [%cHierLeaves%].' ) );
      EndIf;
      nElemsMissing = nElemsMissing + 1;
    EndIf;
    nElem = nElem + 1;
  End;
EndIf;
574,2
#****Begin: Generated Statements***
#****End: Generated Statements****
575,57
#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

### If errors occurred terminate process with a major error status ###
If( nErrors <> 0 );
    sMessage = 'the process incurred at least 1 major error and consequently aborted. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% aborted. Check tm1server.log for details.' );
    If( pStrictErrorHandling = 1 ); 
        ProcessQuit; 
    EndIf;
EndIf;

### Return Code
If ( nDims <> 0 );
  sDims = NumberToString( nDims );
  ### Regular function - Leaves orphans
  If ( nDimsWithOrphans = 0 & nElemsMissing <> 0 );
    nDimsWithOrphans = 1;
    If ( pLogOutput <> 0 );
      sElemsMissing = NumberToString( nElemsMissing );
      LogOutput( cMsgInfoLevel, Expand( 'Dimension [%sDimPrev%] is missing [%sElemsMissing%] elements from [%cHierLeaves%] hierarchy in all of matching hierarchies [%pHier%]. List of elements is available in subset [%pTgtSub%] of [%cHierLeaves%] hierarchy.' ) );
    EndIf;
  EndIf;
  sDimsWithOrphans = NumberToString( nDimsWithOrphans );
  If ( nDimsWithOrphans <> 0 );
    sProcessAction = Expand( 'There are orphan elements in [%sDimsWithOrphans%] dimensions out of [%sDims%] matching.' );
  Else;
    sProcessAction = Expand( 'Scanned [%sDims%] dimensions, all are OK and contain no Leaves orphans.' );
  EndIf;
  ### Optional function - elements missing parents
  If ( nDimsWithoutParents = 0 & nElemsMissingParent <> 0 );
    nDimsWithoutParents = 1;
    If ( pLogOutput <> 0 );
      sElemsMissingParents = NumberToString( nElemsMissingParent );
      LogOutput( cMsgInfoLevel, Expand( 'Dimension [%sDimPrev%] contains [%sElemsMissingParents%] elements that are missing parent in matching hierarchies [%pHier%].' ) );
    EndIf;
  EndIf;
  sDimsWithoutParents = NumberToString( nDimsWithoutParents );
  If ( nDimsWithoutParents <> 0 );
    sProcessAction = Expand( '%sProcessAction% There are elements having no parent in [%sDimsWithoutParents%] dimensions out of [%sDims%] matching.' );
  Else;
    sProcessAction = Expand( '%sProcessAction% All scanned dimensions are OK and contain no elements without parents.' );
  EndIf;
Else;
  sProcessAction = 'No dimensions/hierarchies are matching supplied parameters.';
EndIf;
sProcessReturnCode  = Expand( '%sProcessReturnCode% %sProcessAction%' );
nProcessReturnCode  = 1;
If( pLogoutput <> 0 );
    LogOutput( cMsgInfoLevel, Expand( sProcessAction ) );   
EndIf;
576,
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
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
