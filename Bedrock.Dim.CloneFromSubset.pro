601,100
602,"Bedrock.Dim.CloneFromSubset"
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"w<Zs5;NNH7gy57F:q<ft\`sa@aXrPBmU<rMRbX2bOT3eycM0vDjn\7cU@fi[;9QYWLNm0fZ7XKo[_s5`uOvd3eusvuEJ>DGSep[f?YKa;DM`k\[Gtf@;_DIxR<ST[pyeUF=:PPJ8oSNHQA\D::qtZYI@W<h1\ny]hXNi_bS[QvE:gSm]:cU2]nnVM<d1;Zz>syu2D2n9"
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
560,6
pSourceDim
pSubset
pTargetDim
pAttr
pUnwind
pDebug
561,6
2
2
2
1
1
1
590,6
pSourceDim,""
pSubset,""
pTargetDim,""
pAttr,1
pUnwind,0
pDebug,0
637,6
pSourceDim,"Source Dimension"
pSubset,"Source Subset"
pTargetDim,"Target Dimension"
pAttr,"Include Attributes? (Boolean 1=True)"
pUnwind,"0 = Delete all Elements, 1 = Unwind Existing Elements"
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
572,174

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.0.2~~##
#####################################################################################

# This process will clone the source dimension
# If the target dimension already exists then it will be overwritten


### Constants ###

cProcess = 'Bedrock.Dim.CloneFromSubset' ;
cUser = TM1User();

cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ) );
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;

cHierAttr = 'Bedrock.Descendant';
cAttrVal = 'Descendant';

### Initialise Debug ###

# Set debug file name
sDebugFile = cDebugFile | 'Prolog.debug';

If( pDebug >= 1 );

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  AsciiOutput( sDebugFile, 'TM1 User:        ' | cUser );
  AsciiOutput( sDebugFile, '' );
  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pSourceDim : ' | pSourceDim );
  AsciiOutput( sDebugFile, '            pSourceDim : ' | pSubset );
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

## Validate target dimension
If( pTargetDim @= '' % pTargetDim @= pSourceDim );
  pTargetDim = pSourceDim | '_Clone';
EndIf;

### Create target dimension ###
If( pDebug <= 1 );
  If( 
  DimensionExists( pTargetDim ) = 0 );
    DimensionCreate( pTargetDim );
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, 'Target dimension created: ' | pTargetDim  );
    EndIf;

  Else;
    IF(
    pUnwind = 1 );
      ExecuteProcess( 'Bedrock.Dim.Hierarchy.Unwind.All',
        'pDimension', pTargetDim,
        'pDebug', pDebug
        );
       If( pDebug >= 1 );
         AsciiOutput( sDebugFile, 'Target dimension unwound: ' | pTargetDim  );
       EndIf;

    ELSE;
      DimensionDeleteAllElements( pTargetDim );
      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, 'All element deleted from Target element: ' | pTargetDim  );
      EndIf;

    EndIf;
  EndIf;
EndIf;


### Assign Data Source ###
DatasourceNameForServer = pSourceDim;
DatasourceNameForClient = pSourceDim;
DataSourceType = 'SUBSET';
DatasourceDimensionSubset = cSubset;

### Set Descendent attribute value
AttrDelete( pSourceDim, cHierAttr );
AttrInsert( pSourceDim, '', cHierAttr, 'S' );

If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'Add elements to the dimension.' );
EndIf;

nIndex = 1;
nLimit = SubsetGetSize( pSourceDim, pSubset );
WHILE( nIndex <= nLimit);
  sElName = SubsetGetElementName( pSourceDim, pSubset, nIndex );
  AttrPuts( cAttrVal, pSourceDim, sElName, cHierAttr );
  sElType = DTYPE( pSourceDim, sElName );
  IF(
  sElType @<> 'S');
    sElType = 'N';
  ENDIF;
  If( pDebug <= 1 );
    DimensionElementInsert( pTargetDim, '', sElName, sELType);
  ENDIF;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sElName );
  EndIf;

  nIndex = nIndex + 1;
END;


### Replicate Attributes ###
# Note: DType on Attr dim returns "AS", "AN" or "AA" need to strip off leading "A"

sAttrDim = '}ElementAttributes_' | pSourceDim;
sLastAttr = '';
If( pAttr = 1 & DimensionExists( sAttrDim ) = 1 );
  nNumAttrs = DimSiz( sAttrDim );
  nCount = 1;
  While( nCount <= nNumAttrs );
    sAttrName = DimNm( sAttrDim, nCount );
    sAttrType = SubSt(DType( sAttrDim, sAttrName ), 2, 1 );
    If( pDebug <= 1 );
      AttrInsert( pTargetDim, sLastAttr, sAttrName, sAttrType );
      sLastAttr = sAttrName;
    EndIf;
    nCount = nCount + 1;
  End;
EndIf;

### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Metadata.debug';

EndIf;


### End Prolog ###
573,30

#****Begin: Generated Statements***
#****End: Generated Statements****

### Check for errors in prolog ###

If( nErrors <> 0 );
  ProcessBreak;
EndIf;

nIndex = 1;
nLimit = ELCOMPN( pSourceDim, vElement );
WHILE( nIndex <= nLimit );
  sElName = ELCOMP( pSourceDim, vElement, nIndex );
  sDecendant = ATTRS( pSourceDim, sElName, cHierAttr);
  IF(
  sDecendant @= cAttrVal);
    nElWeight = ELWEIGHT( pSourceDim, vElement, sElName );
    If( pDebug <= 1 );
      DimensionElementComponentAdd( pTargetDim, vElement, sElName, nElWeight );
    ENDIF;
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, vElement, sElName );
    EndIf;
  ENDIF;
  nIndex = nIndex + 1;
END;


### End MetaData ###
574,40

#****Begin: Generated Statements***
#****End: Generated Statements****


### Check for errors in prolog ###

If( nErrors <> 0 );
  ProcessBreak;
EndIf;


### Replicate Attributes ###

# Note: DTYPE on Attr dim returns "AS", "AN" or "AA" need to strip off leading "A"

If( pDebug <= 1 & pAttr = 1 );

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


### End Data ###
575,77

#****Begin: Generated Statements***
#****End: Generated Statements****

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';

EndIf;

### Set Target dimension sort order ###

sCube = '}DimensionProperties';
IF(
CubeExists ( sCube ) = 1 );

  ExecuteProcess('Bedrock.Cube.Data.Copy'
    , 'pCube', sCube
    , 'pDimension', '}Dimensions'
    , 'pSourceElement', pSourceDim
    , 'pTargetElement', pTargetDim
    , 'pSkipRules', 0
    , 'pZeroTarget', 1
    , 'pZeroSource', 0
   , 'pDestroyTempObj', 1
   , 'pDebug', pDebug
  );
ENDIF;

sCube = '}HierarchyProperties';
IF(
CubeExists ( sCube ) = 1 );

  ExecuteProcess('Bedrock.Cube.Data.Copy'
    , 'pCube', sCube
    , 'pDimension', '}Dimensions'
    , 'pSourceElement', pSourceDim
    , 'pTargetElement', pTargetDim
    , 'pSkipRules', 0
    , 'pZeroTarget', 1
    , 'pZeroSource', 0
   , 'pDestroyTempObj', 1
   , 'pDebug', pDebug
  );
ENDIF;


### Set Descendent attribute value
AttrDelete( pSourceDim, cHierAttr );
If( pAttr = 1 );
  AttrDelete( pTargetDim, cHierAttr );
ENDIF;

### Initialise Debug ###

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
