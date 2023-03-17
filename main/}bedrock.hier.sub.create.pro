601,100
602,"}bedrock.hier.sub.create"
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"d3d9a>]0rXlc8nE]]ZZtNn?\27FUmD>C]1_3jPgTSs]h?yn6It7MWwzVJWQ4aQIogLbiA7RgLtv3@>7adEgT7gkIU`YLb5N4_TBR@7A`[Io?9RBfl4;fs3eFZw1Dzi^:z0b[?t3SSDb4p2==rJfPNPs>X\UUn9Lij3F<w=pXz9T[`IAbp3vo5o;iz9EC[m?AANL]SSF_"
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
560,15
pLogOutput
pStrictErrorHandling
pDim
pHier
pSub
pConsol
pAttr
pAttrValue
pLevelFrom
pLevelTo
pExclusions
pDelim
pAddToSubset
pAlias
pTemp
561,15
1
1
2
2
2
2
2
2
1
1
2
2
1
2
1
590,15
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pHier,""
pSub,""
pConsol,"*"
pAttr,""
pAttrValue,""
pLevelFrom,0
pLevelTo,999
pExclusions,""
pDelim,"&"
pAddToSubset,0
pAlias,""
pTemp,1
637,15
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"REQUIRED: Dimension name"
pHier,"OPTIONAL: Hierarchy name (default if blank = same named hierarchy)"
pSub,"REQUIRED: Subset name"
pConsol,"OPTIONAL: Elements within Consolidated Element (Blank or * Equals All)"
pAttr,"OPTIONAL: Attribute (Blank Equals All)"
pAttrValue,"OPTIONAL: Attribute Value"
pLevelFrom,"OPTIONAL: From Element Level"
pLevelTo,"OPTIONAL: To Element Level"
pExclusions,"OPTIONAL: Elements to Exclude From Subset (Separated by Delimiter, Accepts Wild card)"
pDelim,"OPTIONAL: Delimiter character"
pAddToSubset,"OPTIONAL: Add to Subset if it Already Exists (0=No 1=Yes)"
pAlias,"OPTIONAL: Set Alias for Subset"
pTemp,"OPTIONAL: Use temporary objects? (Boolean 1=True)"
577,1
vEle
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
572,230
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.sub.create', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pDim', '', 'pHier', '', 'pSub', '',
    	'pConsol', '*', 'pAttr', '', 'pAttrValue', '',
    	'pLevelFrom', 0, 'pLevelTo', 999,
    	'pExclusions', '', 'pDelim', '&',
    	'pAddToSubset', 0, 'pAlias', '',
    	'pTemp', 1
	);
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***
#****End: Generated Statements****


### Start Prolog ###

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This process will create a static subset in a Hierarchy of target Dimension.

# Note:
# This process uses a number of parameters to determine what to include in the subset:
# - pConsol: If specified, only elements that are descendants of the consol will be included in
#   the subset. If blank, then this filter will be ignored.
# - pAttr: If specified, only elements that have a value equivalent to pAttrValue will be included
#   in the subset. If blank, this filter will be ignored.
# - pLevelFrom: Only elements with a level greater than or equal to pLevelFrom will be included in
#   the subset.
# - pLevelTo: Only elements with a level less than or equal to pLevelFrom will be included in the
#   subset.
# - pExclusions: If pExclusions is specified then the elements (separated by a delimiter) will be
#   excluded from the subset. Wildcards characters `*` and `?` are accepted.
# - pAddToSubset : If the specified subset already exists then this parameter will control whether
#   elements will be added to the existing subset (value 1) or a new subset will be created
#   (value 0).
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
cLogInfo            = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%, pSub:%pSub%, pConsol:%pConsol%, pAttr:%pAttr%, pAttrValue:%pAttrValue%, pLevelFrom:%pLevelFrom%, pLevelTo:%pLevelTo%, pExclusions:%pExclusions%, pDelim:%pDelim%, pAddToSubset:%pAddToSubset%, pAlias:%pAlias%, pTemp:%pTemp%.'; 
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

## Validate dimension
IF( Trim( pDim ) @= '' );
    nErrors = 1;
    sMessage = 'No dimension specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIF( DimensionExists( pDim ) = 0 );
    nErrors = 1;
    sMessage = 'Invalid dimension: ' | pDim;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate Hierarchy
If( Trim( pHier ) @= '' );
    sHier = pDim;
Else;
    sHier = pHier;
EndIf;
IF( sHier @= 'Leaves' );
    nErrors = 1;
    sMessage = 'Invalid  Hierarchy: ' | pDim |':'|pHier;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIF(HierarchyExists(pDim, sHier ) = 0 );
    nErrors = 1;
    sMessage = 'Invalid dimension Hierarchy: ' | pDim |':'|sHier;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate subset
IF(Trim( pSub ) @= '' );
    nErrors = 1;
    sMessage = 'No subset specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate consolidation
pConsol = Trim( pConsol );
If( pConsol @<> '' & pConsol @<> '*' );
    If( ElementIndex(pDim, sHier, pConsol) = 0 );
        nErrors = 1;
        sMessage = 'The ' | pConsol | ' consolidation does not exist in the '| pDim |' dimension:Hierarchy ' | pDim |':'| sHier;
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    Else;
        pConsol = HierarchyElementPrincipalName(pDim, sHier, pConsol);
    EndIf;
EndIf;

## Validate attribute
pAttr = Trim( pAttr );
IF(pAttr @<> '' );

    If( DimensionExists( cAttributeDim ) = 0 );
        nErrors = 1;
        sMessage = 'Dimension: ' | pDim | ' does not have any attributes.';
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    EndIf;
    
    IF(DIMIX( cAttributeDim, pAttr ) = 0 );
        nErrors = 1;
        sMessage = 'The ' | pAttr |' attribute does not exist in the ' | pDim | ' dimension.';
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    EndIf;
    
    sAttributeType = DType( cAttributeDim, pAttr );
    If(sAttributeType @= 'AN' % sAttributeType @= 'N' );
        If(pAttrValue @= '' );
            nAttributeValue = 0;
        Else;
            nAttributeValue = StringToNumber( pAttrValue );
        EndIf;
    EndIf;
    
EndIf;

## Validate element level parameters
If(pLevelFrom < 0 % pLevelTo < 0 % pLevelTo < pLevelFrom );
    nErrors = 1;
    sMessage = 'Element levels must be greater than or equal to zero and level to must be greater than or equal to level from';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate delimiter
IF( pExclusions @<> '' & pDelim @= '' );
    ## Set to default parameter.
    pDelimiter = '&';
EndIf;

## Validate add to subset
IF( pAddToSubset <> 0 & pAddToSubset <> 1 );
    nErrors = 1;
    sMessage = 'Invalid value for pAddToSubset: ' | NumberToString( pAddToSubset ) | '. Valid values are 0 and 1';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate Alias
sDimAttr = '}ElementAttributes_' | pDim;
IF( pAlias @<> '' );
    
    IF(DimensionExists( sDimAttr ) = 0 );
        sMessage = 'No attributes exist for the dimension: ' | pDim;
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        pAlias = '';
    ElseIf(DIMIX( sDimAttr, pAlias ) = 0 );
        sMessage = 'The alias: ' | pAlias | ' does not exist as an attribute in the dimension: ' | pDim;
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        pAlias = '';
    ElseIf(DTYPE( sDimAttr, pAlias ) @<> 'AA' );
        sMessage = 'The alias: ' | pAlias | ' is not an Alias type of attribute in the dimension: ' | sDimAttr;
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        pAlias = '';
    EndIf;

ENDIF;

## Validate pTemp
IF( pTemp <> 0 & pTemp <> 1 );
    nErrors = 1;
    sMessage = 'Wrong parameter pTemp value (only 0 or 1 accepted).';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Check for errors before preparing subset
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

### Prepare subset ###
IF( HierarchySubsetExists( pDim,sHier, pSub ) = 1 );
    If( pAddtoSubset <> 1 );
        HierarchySubsetDeleteAllElements( pDim, sHier, pSub );
        nSubsetSize = 0;
    Else;
        nSubsetSize = HierarchySubsetGetSize(pDim, sHier, pSub );
    EndIf;
Else;
    HierarchySubsetCreate( pDim, sHier, pSub, pTemp );
    nSubsetSize = 0;
EndIf;

### Set Alias ###
IF(pAlias @<> '' );
      HierarchySubsetAliasSet( pDim, pHier, pSub, pAlias);
ENDIF;

### Assign Datasource ###

DatasourceNameForServer     = pDim|':'|sHier;
DataSourceDimensionSubset   = 'All';


### End Prolog ###
573,53

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 


### Check for errors in prolog ###
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;


### Add elements to subset ###

## Check that element is a descendant of specified consolidation
If( pConsol @<> '' & pConsol @<> '*' );
  If(ElementIsAncestor(pDim, pHier, pConsol, vEle) = 0 & vEle @<> pConsol );
    ItemSkip;
  EndIf;
EndIf;

## Check that element has a matching attribute value
If( pAttr @<> ''  );
  If( sAttributeType @= 'AN' % sAttributeType @= 'N' );
    If( ElementAttrN( pDim, pHier, vEle, pAttr ) <> nAttributeValue );
      ItemSkip;
    EndIf;
  Else;
    If( ElementAttrS( pDim, pHier, vEle, pAttr ) @<> pAttrValue );
      ItemSkip;
    EndIf;
  EndIf;
EndIf;

## Check that element has an appropriate element level
nElementLevel = ElementLevel( pDim, pHier, vEle );
If( nElementLevel < pLevelFrom % nElementLevel > pLevelTo );
  ItemSkip;
EndIf;

## Add element to subset
nSubsetSize = nSubsetSize + 1;

HierarchySubsetElementInsert( pDim, pHier, pSub, vEle, nSubsetSize );

### End Metadata ###
574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,61

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

    ### Process Exclusions ###
    IF( nErrors = 0 & Trim( pExclusions ) @<> '' );
        ExecuteProcess( '}bedrock.hier.sub.exclude',
            'pLogOutput', pLogOutput,
            'pStrictErrorHandling', pStrictErrorHandling,
            'pDim', pDim,
            'pHier', pHier,
            'pSub', pSub,
            'pExclusions', pExclusions,
            'pDelim', pDelim
            );
    EndIf;
    
    ### Get subset size ###
    nSubSiz = SubsetGetSize( pDim|':'|sHier, pSub );
    sSubSiz = NumberToString( nSubSiz );
    If( nSubSiz = 0 );
        nErrors = 1;
        sMessage= 'Subset contains no elements.';
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    EndIf;
EndIf;
    
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
    sProcessAction = Expand( 'Process:%cThisProcName% created subset %pDim%:%pHier%:%pSub% with %sSubSiz% elements. ' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogoutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );   
    EndIf;
EndIf;

### End Epilog ###
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
920,0
921,""
922,""
923,0
924,""
925,""
926,""
927,""
