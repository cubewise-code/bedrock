601,100
602,"}bedrock.hier.leaves.sync"
562,"SUBSET"
586,"}Dimensions"
585,"}Dimensions"
564,
565,"tY<TvN]\dKGAx9l7s9I[yr>;f@R:3Ad[@^MZPH`P0B5daAO5aohnk9?a\)[QyL~:nQpR1]@gJTyt:sQ9feSH7<][8GX1K<6jkpN6mOLPtU?eXml\GnTJqArJKrLdbJqIr%{Jbw]9^OU{90a`ig;0=6OtnAODdFaL@X2w2ZIii67x6iIa94<U;z`H=WNyvoAB3ax>8ODj"
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
560,6
pLogOutput
pStrictErrorHandling
pDim
pHier
pDelim
pReverse
561,6
1
1
2
2
2
1
590,6
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pHier,""
pDelim,"&"
pReverse,0
637,6
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"REQUIRED: Dimension, accepts wildcards (all dimensions = *)"
pHier,"OPTIONAL: Hierarchy, accepts wildcards (all hierarchies = *)"
pDelim,"OPTIONAL: Delimiter character (default value if blank = '&')"
pReverse,"OPTIONAL: If true then also add any elements from the Leaves hierarchy not existing in the specified hierarchies to those hierarchies (under a consolidation bucket 'ORPHAN LEAVES')"
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
572,170
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.leaves.sync', 'pLogOutput', pLogOutput, 'pStrictErrorHandling', pStrictErrorHandling,
	    'pDim', '', 'pHier', '', 'pDelim', '&', 'pReverse', 0
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
cRollupOrphan     = 'ORPHAN LEAVES';

### LogOutput parameters
IF( pLogoutput >= 1 );
  LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters
sDimPrev          = '';
nErrors           = 0;
nDims             = 0;
nDimsChanged      = 0;
nElems            = 0;
nLeaves           = 0;

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

### Validate reverse sync option
If( pReverse <> 1 );
  pReverse = 0;
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
      sMDX = Expand( '{TM1FILTERBYPATTERN( {TM1SUBSETALL([%cDimDimensions%])}, "%sSearchDim%*" )}' );
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
    # if pHier blank then we need only same named hierarchies - that means to exclude elements that have : in their names
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

sMDX = Expand(' {EXCEPT( %sMDX%, {TM1FILTERBYPATTERN( {TM1SUBSETALL([%cDimDimensions%])}, "*:Leaves" )} )}');
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

### END PROLOG
573,84

#****Begin: Generated Statements***
#****End: Generated Statements****

# Get dimension & hierarchy from vDimHier
nDelimHier  = SCAN( ':', vDimHier );
If ( nDelimHier <> 0 );
    sDim    = SUBST( vDimHier, 1, nDelimHier - 1);
    sHier   = SUBST( vDimHier, nDelimHier + 1, LONG( vDimHier ) - nDelimHier );
Else;
    sDim    = vDimHier;
    sHier   = vDimHier;
EndIf;

If ( sHier  @= cHierLeaves );
    ItemSkip;
EndIf;

# Set check counters
If( sDim @<> sDimPrev );
    nDims   = nDims + 1;
EndIf;
nElems      = 0;
nLeaves     = 0;

# Add leaves which exist in hierarchy but (somehow) don't exist in Leaves hierarchy to Leaves
nElem = 1;
nMaxElem = ElementCount( sDim, sHier );
While ( nElem <= nMaxElem );
    sElem = ElementName( sDim, sHier, nElem );
    sType = ElementType( sDim, sHier, sElem );
    If ( ElementLevel( sDim, sHier, sElem ) = 0 & HierarchyExists( sDim, cHierLeaves ) = 1 );
        If ( ElementIndex( sDim, cHierLeaves, sElem ) = 0 & ( sType @= 'N' % sType @= 'S' ) );
            HierarchyElementInsert( sDim, cHierLeaves, '', sElem, sType );
            nElems = nElems + 1;
            If ( pLogOutput <> 0 );
                LogOutput( cMsgInfoLevel, Expand( 'Adding element [%sElem%] of [%sType%] type into [%cHierLeaves%], element was found in hierarchy [%sHier%].' ) );
            EndIf;
        EndIf;
    EndIf;
    nElem = nElem + 1;
End;

# Add leaves not existing in hierarchy to the 'ORPHAN LEAVES' consolidation
If( pReverse = 1 & HierarchyExists( sDim, cHierLeaves ) = 1 );
    nLeaf = 1;
    nMaxLeaves = ElementCount( sDim, cHierLeaves );
    While ( nLeaf <= nMaxLeaves );
        sLeaf = ElementName( sDim, cHierLeaves, nLeaf );
        sType = ElementType( sDim, cHierLeaves, sLeaf );
        If ( ElementIndex( sDim, sHier, sLeaf ) = 0 );
            HierarchyElementInsert( sDim, sHier, '', cRollupOrphan, 'C' );
            HierarchyElementInsert( sDim, sHier, '', sLeaf, sType );
            If( sType @= 'N' );
                HierarchyElementComponentAdd( sDim, sHier, cRollupOrphan, sLeaf, 1 );
            EndIf;
            nLeaves = nLeaves + 1;
            If ( pLogOutput <> 0 );
                LogOutput( cMsgInfoLevel, Expand( 'Adding leaf [%sLeaf%] into hierarchy [%sHier%].' ) );
            EndIf;
        EndIf;
        nLeaf = nLeaf + 1;
    End;
EndIf;

# Summary information printout
If( nElems  > 0 );
    sElems  = NumberToString( nElems );
    If ( pLogOutput <> 0 );
        LogOutput( cMsgInfoLevel, Expand( 'Added [%sElems%] elements from hierarchy [%sHier%] into [%cHierLeaves%] hierarchy of [%sDim%] dimension.' ) );
    EndIf;
EndIf;
If( nLeaves > 0 );
    sLeaves = NumberToString( nLeaves );
    If ( pLogOutput <> 0 );
        LogOutput( cMsgInfoLevel, Expand( 'Added [%sLeaves%] leaves into hierarchy [%sHier%] of [%sDim%] dimension.' ) );
    EndIf;
EndIf;
If( sDim @<> sDimPrev & (nElems + nLeaves) > 0 );
    nDimsChanged = nDimsChanged + 1;
EndIf;
sDimPrev    = sDim;

### END METADATA
574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,37
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
  If ( nDimsChanged > 0 );
    sProcessAction = Expand( 'Modified [%sDimsChanged%] dimensions out of [%sDims%] matching the filter.' );
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

### END EPILOG
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
