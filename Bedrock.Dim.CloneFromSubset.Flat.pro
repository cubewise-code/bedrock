601,100
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"dkZIalu`T4<uczgqK<DDfsYCyjzYooSEll7C9TykK7u?tjx;`t\EzKl_zXGT<]v2R:I^MgcaHZ=IVJuUrtGPi1=;ze61v8HeVb\n6p9JrxG_lDuf_3@t5awD?aeXd@YOOnwa9dRXH:cZ`ydHH^hX>J<NCBMj5s^3I906iA[B1ccoa0zb=LOlIkXCllxGr3b_KN6w:x4i"
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
560,5
pSourceDim
pSubset
pTargetDim
pAttr
pDebug
561,5
2
2
2
1
1
590,5
pSourceDim,""
pSubset,""
pTargetDim,""
pAttr,0.
pDebug,0.
637,5
pSourceDim,Source Dimension
pSubset,Source Subset
pTargetDim,Target Dimension
pAttr,Include Attributes? (Boolean 1=True)
pDebug,Debug Mode
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
572,121

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 2.0.2~~##
#####################################################################################

# This process will clone the source dimension
# If the target dimension already exists then it will be overwritten


### Constants ###

cProcess = 'Bedrock.Dim.CloneFromSubset.Flat' ;
cUser = TM1User();
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 100000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;
cUser = TM1User;
cSubset = '}Bedrock_' | cUser ;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  AsciiOutput( sDebugFile, 'TM1 User:        ' | cUser );
  AsciiOutput( sDebugFile, '' );
  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pSourceDim : ' | pSourceDim );
  AsciiOutput( sDebugFile, '            pSourceSub : ' | pSubset );
  AsciiOutput( sDebugFile, '            pTargetDim : ' | pTargetDim );
  AsciiOutput( sDebugFile, '            pAttr      : ' | NumberToString( pAttr ) );
  AsciiOutput( sDebugFile, '' );
EndIf;


### Validate Parameters ###

nErrors = 0;

# Validate source dimension
IF(
DimensionExists( pSourceDim ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid source dimension: ' | pSourceDim;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

## Validate Source Subset
IF(
SubsetExists( pSourceDim, pSubset) = 0 );
  sMessage = 'Invalid source subset: ' | pSubset;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
ELSE;
  cSubset = pSubset;
  nSubsetSize = SubsetGetSize( pSourceDim, pSubset );
  AsciiOutput( sDebugFile, '            Subset Siz      : ' | NumberToString( nSubsetSize ) );
ENDIF;


# Validate target dimension
If( pTargetDim @= '' % pTargetDim @= pSourceDim );
  pTargetDim = pSourceDim | '_Clone';
EndIf;


### Create target dimension ###
IF(
pDebug <= 1 );
  If( DimensionExists( pTargetDim ) = 0 );
    DimensionCreate( pTargetDim );
  Else;
    ExecuteProcess( 'Bedrock.Dim.Hierarchy.Unwind.All',
      'pDimension', pTargetDim,
      'pDebug', pDebug );
  EndIf;
ENDIF;


### Assign Data Source ###
DatasourceNameForServer = pSourceDim;
DatasourceNameForClient = pSourceDim;
DataSourceType = 'SUBSET';
DatasourceDimensionSubset = cSubset;


### Replicate Attributes ###

# Note: DType on Attr dim returns "AS", "AN" or "AA" need to strip off leading "A"

sAttrDim = '}ElementAttributes_' | pSourceDim;
If( pAttr = 1 & DimensionExists( sAttrDim ) = 1 );
  nNumAttrs = DimSiz( sAttrDim );
  nCount = 1;
  While( nCount <= nNumAttrs );
    sAttrName = DimNm( sAttrDim, nCount );
    sAttrType = SubSt(DType( sAttrDim, sAttrName ), 2, 1 );
    If( sAttrName @<> 'Format' );
      If( pDebug <= 1 );
        AttrInsert( pTargetDim, '', sAttrName, sAttrType );
      EndIf;
    EndIf;
    nCount = nCount + 1;
  End;
EndIf;


### End Prolog ###
573,30

#****Begin: Generated Statements***
#****End: Generated Statements****

######################################
##~~  Copyright Cubewise P/L 2010 ~~##
######################################


### Check for errors in prolog ###

If( nErrors <> 0 );
  ProcessBreak;
EndIf;


### Add Elements to cloned dimension ###

If( pDebug <= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Metadata.debug';

  ## Add the element to the target dimension.
  DimensionElementInsert( pTargetDim, '', vElement, 'N' );
ELSE ;
  ASCIIOUTPUT( sDebugFile, vElement );
EndIf;


### End MetaData ###
574,48

#****Begin: Generated Statements***
#****End: Generated Statements****

######################################
##~~  Copyright Cubewise P/L 2010 ~~##
######################################


### Check for errors in prolog ###

If( nErrors <> 0 );
  ProcessBreak;
EndIf;


### Replicate Attributes ###

# Note: DTYPE on Attr dim returns "AS", "AN" or "AA" need to strip off leading "A"

If( pDebug <= 1 );

  If( pAttr = 1 & DimensionExists( sAttrDim ) = 1 );

    nCount = 1;
    While( nCount <= nNumAttrs );
      sAttrName = DimNm( sAttrDim, nCount );
      sAttrType = SubSt( DTYPE( sAttrDim, sAttrName ), 2, 1 );
      If( sAttrType @= 'S' % sAttrType @= 'A' );
        sAttrVal = AttrS( pSourceDim, vElement, sAttrName );
        If( sAttrVal @<> '' );
          AttrPutS( sAttrVal, pTargetDim, vElement, sAttrName );
        EndIf;
      Else;
        nAttrVal = AttrN( pSourceDim, vElement, sAttrName );
        If( nAttrVal <> 0 );
          AttrPutN( nAttrVal, pTargetDim, vElement, sAttrName );
        EndIf;
      EndIf;
      nCount = nCount + 1;
    End;

  EndIf;

EndIf;


### End Data ###
575,35

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################
##~~ Copyright Cubewise P/L 2010 ~~##
#####################################


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


### If errors occurred terminate process with a major error status ###

If( nErrors <> 0 );
  ProcessQuit;
EndIf;


### End Epilog ###
576,CubeAction=1511DataAction=1503CubeLogChanges=0
638,1
804,0
1217,1
900,
901,
902,
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
917,1
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
