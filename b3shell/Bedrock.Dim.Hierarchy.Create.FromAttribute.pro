601,100
602,"Bedrock.Dim.Hierarchy.Create.FromAttribute"
562,"VIEW"
586,"}ElementAttributes_}Clients"
585,"}ElementAttributes_}Clients"
564,
565,"vX_fwSWUsa]vzJX\EE`>EEa<[3X;iGmgwpM>DLJqyKm8LiB?FrJ9z;UANxPxxV9jNVP0bIDtmtZEm6LFzB[agvY_^ItSveLSz:35Q^klfpu?O^xuBrhD_7rhPfXhHeP;?NmPZ]WpRJu2X5MPjxa=hZ3E0@w\qG[3BvmnnG`8Ghy\hRId<J;brbczMcLI1H?j5oEPJ5tM"
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
570,Temp
571,All
569,0
592,0
599,1000
560,8
pDimension
pAttribute
pTopNode
pPrefix
pSuffix
pUnwind
pEmptyConsol
pDebug
561,8
2
2
2
2
2
1
1
1
590,8
pDimension,"Cost Centre"
pAttribute,"Finance"
pTopNode,"Total Finance"
pPrefix,""
pSuffix,"( Finance )"
pUnwind,1
pEmptyConsol,0
pDebug,1
637,8
pDimension,"Dimension"
pAttribute,"Attribute"
pTopNode,"Optional: The name of the consolidation top element"
pPrefix,"Optional: Prefix before the attribute value"
pSuffix,"Optional: Suffix after the attribute value"
pUnwind,"Boolean: 1 = True unwind current hierarchy."
pEmptyConsol,"Optional: 1 = Remove empty consoldation from dimension."
pDebug,"pDebug"
577,6
vElement
vAttribute
vValue
NVALUE
SVALUE
VALUE_IS_STRING
578,6
2
2
2
1
2
1
579,6
1
2
3
0
0
0
580,6
0
0
0
0
0
0
581,6
0
0
0
0
0
0
582,3
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
603,0
572,222

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

# This process will create a parent rollup attribute for the nominated top node hierarchy
# and populate the value of the immediate parent within the nominated hierarchy for each
# element in the dimension.

# Note:
# - It is assumed each element exists ONLY ONCE within the hierarchy.
# - This should hold true except in exceptional circumstances


### Constants ###

cProcess = 'Bedrock.Dim.Hierarchy.Create.FromAttribute';
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cDataView = '}Bedrock_' | cTimeStamp | '_' | sRandomInt ;
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.';
cAttributeDim = '}ElementAttributes_' | pDimension;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension : ' | pDimension );
  AsciiOutput( sDebugFile, '            pAttribute : ' | pAttribute );
  AsciiOutput( sDebugFile, '              pTopNode : ' | pTopNode );
  AsciiOutput( sDebugFile, '              pPrefix : ' | pPrefix );
  AsciiOutput( sDebugFile, '              pSuffix : ' | pSuffix );
  AsciiOutput( sDebugFile, '            pUnwind    : ' | NumberToString( pUnwind ) );


EndIf;


### Validate Parameters ###

nErrors = 0;

## Validate dimension
If( Trim( pDimension ) @= '' );
  nErrors = 1;
  sMessage = 'No dimension specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

If( DimensionExists( pDimension ) = 0 );
  nErrors = 1;
  sMessage = 'Dimension: ' | pDimension | ' does not exist';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

If( SUBST( pDimension, 1, 1 ) @= '}' );
  nErrors = 1;
  sMessage = 'Dimension: ' | pDimension | ' is a system dimension.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;


## Validate attribute
If( 
Trim( pAttribute ) @= '' );
  nErrors = 1;
  sMessage = 'No attribute specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

If( 
DimIx( cAttributeDim, pAttribute ) = 0 );
  nErrors = 1;
  sMessage = 'Attribute: ' | pAttribute | ' does not exists in dimension: ' | pDimension;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

If( 
DType( cAttributeDim, pAttribute ) @<> 'AS' );
  nErrors = 1;
  sMessage = 'Only string attributes may be used for this process.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

## Validate Parameter: pEmptyConsol
IF(
pEmptyConsol <> 1 & pEmptyConsol <> 0 );
  pEmptyConsol = 0;
  sMessage = 'Remove empty consolidation is Boolean. Reset parameter to 0.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
EndIf;


## UNWIND the dimension OR Add top node of the hierarchy.
IF(
pTopNode @= '' );
  sTopNode = pAttribute;
ELSE;
  sTopNode = pTopNode;
ENDIF;

If( 
DimIx( pDimension, sTopNode ) = 0 );
# Target consol does not exist then add element to dimension.
  IF( pDebug <= 1 );
    DimensionELementInsert( pDimension, '', sTopNode, 'C'); 
  ENDIF;

  IF( pDebug >= 1 );
    sMessage = 'New consolidation point added: ' | sTopNode;
    AsciiOutput( sDebugFile, sMessage );
  ENDIF;

ELSEIF(
pUnwind = 1 &
ElCompN( pDimension, sTopNode ) > 0  );
## The target consolidaiton exists in the dimension, unwind.
  If( pDebug <= 1 );
    ExecuteProcess('Bedrock.Dim.Hierarchy.Unwind.Consolidation'
      , 'pDimension', pDimension
      , 'pConsol', sTopNode
      , 'pRecursive', 1
      , 'pDebug', pDebug );
    EndIf;

    IF( pDebug >= 1 );
      sMessage = 'Consolidation point unwound: ' | sTopNode;
      AsciiOutput( sDebugFile, sMessage );
    ENDIF;

ELSE;
  ## Do nothing.

EndIf;

### Format Prefix and Suffix ###
IF(
pPrefix @<> '' );
  IF(
  SUBST( pPrefix, Long( pPrefix), 1) @<> ' ' );
    sPrefix = pPrefix | ' ';
  ELSE;
    sPrefix = pPrefix;
  ENDIF;
ENDIF;

IF(
pSuffix @<> '' );
  IF(
  SUBST( pSuffix, 1, 1) @<> ' ' );
    sSuffix = ' ' | pSuffix;
  ELSE;
    sSuffix = pSuffix;
  ENDIF;
ENDIF;

### BUILD DATA SOURCE ###

IF(
ViewExists( cAttributeDim, cDataView ) = 1 );
  ViewDestroy( cAttributeDim, cDataView );
ENDIF;
ViewCreate( cAttributeDim, cDataView );

ViewExtractSkipCalcsSet( cAttributeDim, cDataView, 0 );
ViewExtractSkipRuleValuesSet( cAttributeDim, cDataView,0 );
ViewExtractSkipZeroesSet( cAttributeDim, cDataView, 1 );

sDim = cAttributeDim;
IF(
SubsetExists( sDim, cDataView ) = 1 );
  SubsetDestroy( sDim, cDataView );
ENDIF;
SubsetCreate( sDim, cDataView );
SubsetElementInsert( sDim, cDataView, pAttribute, 1 );
ViewSubsetAssign(  cAttributeDim, cDataView, sDim, cDataView );

### Assign Datasource ###

DataSourceType = 'VIEW';
DatasourceNameForServer = cAttributeDim;
DatasourceNameForClient = cAttributeDim;
DatasourceCubeView = cDataView;

### End Prolog ###
573,60

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.0.0~~##
################################################################################################# 


### Check for errors in prolog ###

If( nErrors <> 0 );
  ProcessBreak;
EndIf;

### Initialise Debug ###

If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Metadata.debug';

EndIf;

### VALIDATE RECORD ###

## Skip if attribute is not populated.
if(
vElement @= sTopNode );
  ITEMSKIP;
ENDIF;

sParent = vValue;
If( sParent @= '' );
  ItemSkip;
EndIf;

# If parent does not exist AND allow insertion of new parents is TRUE then insert new consol

sElPar = sPrefix | sParent | sSuffix;



If( pDebug <= 1 );

  ## Add the attribute value to the top node.
  DimensionElementComponentAdd( pDimension,  sTopNode, sElPar, 1 );

  DimensionElementInsert( pDimension, '', sElPar, 'C' );
  DimensionElementComponentAdd( pDimension, sElPar, vElement, 1 );
EndIf;

If( pDebug >= 1 );
    sMsg = 'Added to the Hierarchy.';
    AsciiOutput( sDebugFile, vElement, sElPar, vElement, sMsg );
Endif;




### End Metadata ###
574,80

#****Begin: Generated Statements***
#****End: Generated Statements****



################################################################################################# 
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.0.0~~##
################################################################################################# ####################

### Initialise Debug ###

If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Data.debug';

EndIf;

### VALIDATE RECORD ###

## Skip leaf element
IF(
DTYPE( pDimension, vElement ) @<> 'C' );
  ITEMSKIP;
ENDIF;

## Skip if attribute is not populated.
if(
vElement @= sTopNode );
  ITEMSKIP;
ENDIF;

## Skip if there is no nominated parent element.
sParent = vValue;
If( sParent @= '' );
  sMsg = 'ItemSkip: No parent.' ;
  AsciiOutput( sDebugFile, vElement, sPrefix, vValue, sSuffix,  sMsg );
  ItemSkip;
EndIf;


## Loop through all the parent of the element.

nIndex = 1;
nLimit = ELPARN( pDimension, vElement );

WHILE( nIndex <= nLimit );
  sElPar = ELPAR( pDimension, vElement, nIndex );
  IF(
  ELISANC ( pDimension,  sTopNode, sElPar ) = 1 %
  sElPar @= sTopNode );
  ## The parent is a member of the top node or is the top node.
    IF(
    sElPar @<> sPrefix | sParent | sSuffix );
    ## Remove component from the heirarchy.

      IF(
      pDebug <= 1 );
        sMsg = 'Delete component.';
        AsciiOutput( sDebugFile, vElement, sPrefix, vValue, sSuffix,  sElPar, sMsg );

      ExecuteProcess('Bedrock.Dim.Element.Component.Delete'
        , 'pDimension', pDimension
        , 'pParent', sElPar
        , 'pElement', vElement
        , 'pDebug', pDebug );
      ENDIF;

    ELSE;
      IF(
      pDebug <= 1 );
        sMsg = 'Keep Component.' ;
        AsciiOutput( sDebugFile, vElement, sPrefix, vValue, sSuffix,  sElPar, sMsg );
    ENDIF;


    ENDIF;
  ENDIF;
  nIndex = nIndex + 1;
END;
575,63

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.0.0~~##
################################################################################################# 


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';

  # Log errors
  If( nErrors <> 0 );
    AsciiOutput( sDebugFile, 'Errors Occurred' );
  EndIf;

  # Log finish time
  AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

EndIf;

If( nErrors <> 0 );
  ProcessQuit;
EndIf;

### Destroy temporary views and susbsets ###
If( pDebug <= 1 );
  ExecuteProcess('Bedrock.Cube.ViewAndSubsets.Delete',
    'pCube', cAttributeDim,
    'pView', cDataView,
    'pSubset', cDataView,
    'pMode', 1,
    'pDebug', pDebug);
ENDIF;

### Clean Empty consolidation.
IF(
pEmptyConsol = 1 );

  If( pDebug <= 1 );
    ExecuteProcess('Bedrock.Dim.EmptyConsols.Delete'
      , 'pDimension', pDimension
      , 'pDebug', pDebug );
  EndIf;

  If( pDebug >= 1 );
    sMsg = 'Removed empty consolidations.';
    AsciiOutput( sDebugFile, sMsg );
  Endif;
ENDIF;


### If errors occurred terminate process with a major error status ###




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
