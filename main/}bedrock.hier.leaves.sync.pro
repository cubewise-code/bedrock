601,100
602,"}bedrock.hier.leaves.sync"
562,"SUBSET"
586,"}Dimensions"
585,"}Dimensions"
564,
565,"v2Ro>?=^[<xzbf5>egIxAPyK?1p;]2H[@>;urjCnA4W19Bd[v9tMDub2+[Qwo}JR;yS1]>[kEqt>rAn@mv^i;@dTCYQ:Jy1bOV6=smDMzlqQof\Gi^K1j8vPu?9kj\@k!kGBS;G=JXYfmoIn7==XF[EB]zk1]TT31GpaHis@\6=Y=iH]aiMv0v:26?d`qLc5S\d21D"
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
560,5
pLogOutput
pStrictErrorHandling
pDim
pHier
pDelim
561,5
1
1
2
2
2
590,5
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pHier,""
pDelim,"&"
637,5
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"REQUIRED: Dimension, accepts wildcards (all dimensions = *)"
pHier,"OPTIONAL: Hierarchy, accepts wildcards (all hierarchies = *)"
pDelim,"OPTIONAL: Delimiter character (default value if blank = '&')"
577,1
vDimHier
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
572,162
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.leaves.sync', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
	    'pDim', '', 'pHier', '', 'pDelim', '&'
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
# In certain circumstances the Leaves hierarchy can become *out of sync* with the same named hierarchy and other alternate hierarchies
# and *not contain all leaf elements*. Should this happen this process will heal such dimensions and restore the synced state where
# the Leaves hierarchy contains the collection of all leaf elements from all hiearchies of a dimension.  
# For the set of dimensions and hierarchies defined by the pDim & pHier parameters this process checks that all leaf elements from each
# hierarchy also exists in the Leaves hierarchy of the specified dimension(s).
#
# If the leaf element does not exist in the Leaves hierarchy then the element is inserted into Leaves.
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
cTempSub          = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cTempSubDim       = cThisProcName |'_Dim_'| cTimeStamp |'_'| cRandomInt;
cUserName         = TM1User();
cMsgErrorLevel    = 'ERROR';
cMsgInfoLevel     = 'INFO';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%.';
cAll              = '*';
cDimDimensions    = '}Dimensions';
cCharAny          = '?';
cStringAny        = '*';
cHierLeaves       = 'Leaves';
cSubMissing       = 'Missing';

### LogOutput parameters
IF( pLogoutput >= 1 );
  LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters
nErrors = 0;
nDims = 0;
nDimsChanged = 0;
nElems = 0;
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

### Handle All dimensions or a dimension list, including all available hierarchies
If ( TRIM( pDim ) @= cAll );
  sMDX1 = Expand( '{TM1SUBSETALL([%cDimDimensions%])}' );
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
      sMDX = Expand( '{TM1FILTERBYPATTERN( {TM1SUBSETALL([%cDimDimensions%])}, "%sSearchDim%" )}' );
    Else;
      sMDX = Expand( '%sMDX% + {TM1FILTERBYPATTERN( {TM1SUBSETALL([%cDimDimensions%])}, "%sSearchDim%" )}' );
    EndIf;
    ### Consume dimension and delimiter
    sDimTokenizer = TRIM( DELET( sDimTokenizer, 1, nPos + LONG( pDelim ) - 1 ) );
  End;
  sMDX1 = Expand( '{%sMDX%}' );
EndIf;

### Handle All hierarchies or a hierarchy list
### We will filter hierarchies in this step from base set created previously
If ( TRIM( pHier ) @= cAll );
  sMDX = sMDX1;
Else;
  sHierTokenizer = TRIM( pHier );
  If( sHierTokenizer @= '' );
    # we need only same named hierarchies - that means to exclude elements that have : in their names
    sMDX = Expand( '{FILTER( %sMDX1%, INSTR([%cDimDimensions%].CurrentMember.Name, '':'' ) = 0 )}' );
  Else;
    sMDX = '';
    ### Loop and tokenize hierarchy list
    While ( sHierTokenizer @<> '' );
      nPos = SCAN( pDelim, sHierTokenizer );
      If ( nPos = 0 );
        nPos = LONG( sHierTokenizer ) + 1;
      EndIf;
      sSearchHier = TRIM( SUBST( sHierTokenizer, 1, nPos - 1 ) );
      If( sMDX @= '' );
        sMDX = Expand( '{TM1FILTERBYPATTERN( %sMDX1%, "*:%sSearchHier%" )}' );
      Else;
        sMDX = Expand( '%sMDX% + {TM1FILTERBYPATTERN( %sMDX1%, "*:%sSearchHier%" )}' );
      EndIf;
      ### Consume hierarchy and delimiter
      sHierTokenizer = TRIM( DELET( sHierTokenizer, 1, nPos + LONG( pDelim ) - 1 ) );
    End;
    sMDX = Expand( '{%sMDX%}' );
  EndIf;
EndIf;

sMDXF = Expand( '{ORDER( %sMDX%, [%cDimDimensions%].CurrentMember.Name, ASC )}' );

### Create dimension:hierarchy subset
If ( SubsetExists( cDimDimensions, cTempSub ) = 0 );
    SubsetCreatebyMDX( cTempSub, sMDXF, cDimDimensions, 1 );
Else;
    SubsetMDXSet( cDimDimensions, cTempSub, sMDXF );
EndIf;

DatasourceNameForServer = cDimDimensions;
DatasourceNameForClient = cDimDimensions;
DataSourceType = 'SUBSET';
DatasourceDimensionSubset = cTempSub;
573,47
#****Begin: Generated Statements***
#****End: Generated Statements****

nDelimHier = SCAN( ':', vDimHier );
If ( nDelimHier <> 0 );
  sDim = SUBST( vDimHier, 1, nDelimHier - 1);
  sHier = SUBST( vDimHier, nDelimHier + 1, LONG( vDimHier ) - nDelimHier );
Else;
  sDim = vDimHier;
  sHier = vDimHier;
EndIf;

If ( sHier @= cHierLeaves );
  ItemSkip;
EndIf;

# Summary information printout
If ( sDimPrev @<> sDim );
  If ( sDimPrev @<> '' & nElems <> 0 );
    sElems = NumberToString( nElems );
    If ( pLogOutput <> 0 );
      LogOutput( cMsgInfoLevel, Expand( 'Added [%sElems%] elements into [%cHierLeaves%] hierarchy of [%sDimPrev%] dimension.' ) );
    EndIf;
    nDimsChanged = nDimsChanged + 1;
  EndIf;
  nDims = nDims + 1;
  nElems = 0;
  sDimPrev = sDim;
EndIf;

nElem = 1;
nMaxElem = ElementCount( sDim, sHier );
While ( nElem <= nMaxElem );
  sElem = ElementName( sDim, sHier, nElem );
  If ( ElementLevel( sDim, sHier, sElem ) = 0 & HierarchyExists( sDim, cHierLeaves ) <> 0 );
    If ( ElementIndex( sDim, cHierLeaves, sElem ) = 0 );
      sType = ElementType( sDim, sHier, sElem );
      HierarchyElementInsert( sDim, cHierLeaves, '', sElem, sType );
      nElems = nElems + 1;
      If ( pLogOutput > 1 );
        LogOutput( cMsgInfoLevel, Expand( 'Adding element [%sElem%] of [%sType%] type into [%cHierLeaves%], element was found in hierarchy [%sHier%].' ) );
      EndIf;
    EndIf;
  EndIf;
  nElem = nElem + 1;
End;

574,2
#****Begin: Generated Statements***
#****End: Generated Statements****
575,38
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
  sDimsChanged = NumberToString( nDimsChanged );
  If ( nDimsChanged <> 0 );
    sProcessAction = Expand( 'Modified [%sDimsChanged%] dimensions out of [%sDims%] matching.' );
  Else;
    sProcessAction = Expand( 'Scanned [%sDims%] dimensions, all are ok.' );
  EndIf;
Else;
  sProcessAction = 'No dimensions/hierarchies are matching supplied parameters. Nothing modified.';
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
