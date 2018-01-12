601,100
602,"Bedrock.Dim.Sub.Create"
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"pI2NjSW>NYhOnZkEaul9eWpt:4`07o?^2nOV[eCTp1HZ_Z\BY6z3UmAwl<ry4c_fbAtsY?8:MP7JSh;IwbwRy\Z@^d73<oM:6=vTj<Y8FVuFE0WWJ<j5_QOMTRqK7:voAtJ9QRKkvZ8ARyOhu;90xrk9ottsq7]64ilEsT=URhaP\dYA5W]?>sONE>HJV?[czFIq`Yoj"
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
560,12
pDimension
pSubset
pConsol
pAttribute
pAttributeValue
pLevelFrom
pLevelTo
pExclusions
pDelimiter
pAddToSubset
pAlias
pDebug
561,12
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
590,12
pDimension,""
pSubset,""
pConsol,""
pAttribute,""
pAttributeValue,""
pLevelFrom,0
pLevelTo,20
pExclusions,""
pDelimiter,"&"
pAddToSubset,0
pAlias,""
pDebug,0
637,12
pDimension,"Dimension"
pSubset,"Subset"
pConsol,"Consolidated Element (Blank Equals All)"
pAttribute,"Attribute (Blank Equals All)"
pAttributeValue,"Attribute Value"
pLevelFrom,"From Element Level"
pLevelTo,"To Element Level"
pExclusions,"Elements to Exclude From Subset (Seperated by Delimiter)"
pDelimiter,"Delimiter"
pAddToSubset,"Add to Subset if it Already Exists (0=No 1=Yes)"
pAlias,"Set Alias for Subset"
pDebug,"Debug Mode"
577,1
vElement
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
572,262

#****Begin: Generated Statements***
#****End: Generated Statements****

### Start Prolog ###

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will create a static subset

# Note:
# - This process uses a number of parameters to determine what to include in the subset:
#   - pConsol      : If specified, only elements that are descendants of the consol will be included in the subset
#                    If blank, then this filter will be ignored
#   - pAttribute   : If specified, only elements that have a value equivalent to pAttributeValue will be included
#                    in the subset. If blank, this filter will be ignored
#   - pLevelFrom   : Only elements with a level greater than or equal to pLevelFrom will be included in the subset
#   - pLevelTo     : Only elements with a level less than or equal to pLevelFrom will be included in the subset
#   - pExclusions  : If pExclusions is specified then the elements (seperated by a delimiter) will be excluded
#                    from the subset
#   - pAddToSubset : If the specified subset already exists then this parameter will control whether elements will
#                    be added to the existing subset (value 1) or a new subset will be created (value 0)


### Constants ###

cProcess = 'Bedrock.Dim.Sub.Create';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;

cAttributeDim = '}ElementAttributes_' | pDimension;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension      : ' | pDimension );
  AsciiOutput( sDebugFile, '            pSubset         : ' | pSubset );
  AsciiOutput( sDebugFile, '            pConsol         : ' | pConsol );
  AsciiOutput( sDebugFile, '            pAttribute      : ' | pAttribute );
  AsciiOutput( sDebugFile, '            pAttributeValue : ' | pAttributeValue );
  AsciiOutput( sDebugFile, '            pLevelFrom      : ' | NumberToString( pLevelFrom ) );
  AsciiOutput( sDebugFile, '            pLevelTo        : ' | NumberToString( pLevelTo ) );
  AsciiOutput( sDebugFile, '            pExclusions     : ' | pExclusions );
  AsciiOutput( sDebugFile, '            pDelimiter      : ' | pDelimiter );
  AsciiOutput( sDebugFile, '            pAddToSubset    : ' | NumberToString( pAddToSubset ) );
  AsciiOutput( sDebugFile, '            pAlias      : ' | pAlias );

EndIf;


### Validate Parameters ###

nErrors = 0;

## Validate dimension
IF(
Trim( pDimension ) @= '' );
  nErrors = 1;
  sMessage = 'No dimension specified.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

IF(
DimensionExists( pDimension ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dimension: ' | pDimension;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

## Validate subset
IF(
Trim( pSubset ) @= '' );
  nErrors = 1;
  sMessage = 'No subset specified.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

## Validate consolidation
pConsol = Trim( pConsol );
If( pConsol @<> '' );
  If( DimIx( pDimension, pConsol ) = 0 );
    ## The consolidation point does not exist in the dimension.
    nErrors = 1;
    sMessage = 'The ' | pConsol | ' consolidation does not exist in the '| pDimension |' dimension.';
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    ItemReject( sMessage );
  EndIf;
EndIf;

## Validate attribute
pAttribute = Trim( pAttribute );
IF(
pAttribute @<> '' );

  If( DimensionExists( cAttributeDim ) = 0 );
    nErrors = 1;
    sMessage = 'Dimension: ' | pDimension | ' does not have any attributes.';
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    ItemReject( sMessage );
  EndIf;

  IF(
  DIMIX( cAttributeDim, pAttribute ) = 0 );
    nErrors = 1;
    sMessage = 'The ' | pAttribute |' attribute does not exist in the ' | pDimension | ' dimension.';
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    ItemReject( sMessage );
  EndIf;

  sAttributeType = DType( cAttributeDim, pAttribute );
  If(
  sAttributeType @= 'AN' % sAttributeType @= 'N' );
    If(
    pAttributeValue @= '' );
      nAttributeValue = 0;
   Else;
      nAttributeValue = StringToNumber( pAttributeValue );
    EndIf;
  EndIf;
EndIf;


## Validate element level
If(
pLevelFrom < 0 %
pLevelTo < 0 %
pLevelTo < pLevelFrom );
  nErrors = 1;
  sMessage = 'Element levels must be greater than or equal to zero and level to must be greater than or equal to level from';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Validate delimiter
IF(
pExclusions @<> '' & pDelimiter @= '' );
  ## Set to default parameter.
  pDelimiter = '&';
EndIf;

## Validate add to subset
IF(
pAddToSubset <> 0 & pAddToSubset <> 1 );
  nErrors = 1;
  sMessage = 'Invalid value for pAddToSubset: ' | NumberToString( pAddToSubset ) | '. Valid values are 0 and 1';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

## Validate Alias
sDimAttr = '}ElementAttributes_' | pDimension;
IF(
pAlias @<> '' );
  IF(
  DimensionExists( sDimAttr ) = 0 );
    sMessage = 'No attributes exist for the dimension: ' | pDimension;
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    pAlias = '';
  ElseIf(
  DIMIX( sDimAttr, pAlias ) = 0 );
    sMessage = 'The Alias: ' | pAlias | ' does not exist in the dimension: ' | pDimension;
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    pAlias = '';
  ElseIf(
  DTYPE( sDimAttr, pAlias ) @<> 'AA' );
    sMessage = 'The Alias: ' | pAlias | ' is not an Alias in the dimension: ' | sDimAttr;
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    pAlias = '';
  EndIf;

ENDIF;

### Prepare subset ###
IF(
SubsetExists( pDimension, pSubset ) = 1 );
  If( pAddtoSubset <> 1 );
    If( pDebug <= 1 );
      SubsetDeleteAllElements( pDimension, pSubset );
    EndIf;
    nSubsetSize = 0;

    If( pDebug >= 1 );
      sMessage = 'Subset: ' | pSubset | ' exists. Delete all elements from the subset.';
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
  Else;
    nSubsetSize = SubsetGetSize( pDimension, pSubset );

    If( pDebug >= 1 );
      sMessage = 'Subset: ' | pSubset | ' exists. Add to subset.';
      AsciiOutput( sDebugFile, sMessage );
    EndIf;

  EndIf;
Else;
  If( pDebug <= 1 );
    SubsetCreate( pDimension, pSubset );
  EndIf;
  If( pDebug >= 1 );
    sMessage = 'Subset: ' | pSubset | ' does not exist. Create Subset.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  nSubsetSize = 0;
EndIf;

### Set Alias ###
IF(
pAlias @<> '' );
  If( pDebug <= 1 );
    SubsetAliasSet( pDimension, pSubset, pAlias );
  EndIf;

  If( pDebug >= 1 );
    sMessage = 'The Alias: ' | pAlias | ' has been set.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
ENDIF;

### Assign Datasource ###

DatasourceNameForServer = pDimension;
DataSourceDimensionSubset = 'All';


### End Prolog ###
573,65

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Metadata.debug';

EndIf;


### Check for errors in prolog ###

If( nErrors <> 0 );
  ProcessBreak;
EndIf;


### Add elements to subset ###

## Check that element is a descendant of specified consolidation
If( pConsol @<> '' );
  If( ElIsAnc( pDimension, pConsol, vElement) = 0 & vElement @<> pConsol );
    ItemSkip;
  EndIf;
EndIf;

## Check that element has a matching attribute value
If( pAttribute @<> ''  );
  If( sAttributeType @= 'AN' % sAttributeType @= 'N' );
    If( AttrN( pDimension, vElement, pAttribute ) <> nAttributeValue );
      ItemSkip;
    EndIf;
  Else;
    If( AttrS( pDimension, vElement, pAttribute ) @<> pAttributeValue );
      ItemSkip;
    EndIf;
  EndIf;
EndIf;

## Check that element has an appropriate element level
nElementLevel = ElLev( pDimension, vElement );
If( nElementLevel < pLevelFrom % nElementLevel > pLevelTo );
  ItemSkip;
EndIf;

## Add element to subset
nSubsetSize = nSubsetSize + 1;
If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'Element: ' | vElement | ' to be added to subset.' );
EndIf;
If( pDebug <= 1 );
  SubsetElementInsert( pDimension, pSubset, vElement, nSubsetSize );
EndIf;


### End Metadata ###
574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,60

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';

EndIf;





### Process Exclusions ###

IF(
 nErrors = 0 & pDebug <= 1 &
Trim( pExclusions ) @<> '' );
  ExecuteProcess( 'Bedrock.Dim.Sub.Exclude',
    'pDimension', pDimension,
    'pSubset', pSubset,
    'pElements', pExclusions,
    'pDelimiter', pDelimiter,
    'pDebug', pDebug
  );
EndIf;


### Finalise Debug ###

If( pDebug >= 1 );

  # Log errors
  If( nErrors <> 0 );
    AsciiOutput( sDebugFile, 'Errors Occurred' );
  EndIf;

  # Log finish time
  AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

EndIf;


### If errors occurred terminate process with a major error status ###

If( nErrors <> 0 );
  ProcessQuit;
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
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
