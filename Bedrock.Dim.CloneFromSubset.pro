601,100
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"ctfaYSG\U>V;8m8u0@IW=f^9Um5\w97W772C4IhL7Wzm@x^4?L@TLT[lAOxYt`:@E:XuJslZYFvng@:Zdk8quuNA5le2ixjXJuE1BQUpTQESHP3P2Zn=ji`1Y>5I_C9SixK5SlT1xi[P<icYGc7YwztdI>:ZQD>A2T]w^lOw5>UpmQB>0^@dP6fZR<lgj5Fc<8ockaZW"
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
pAttr,1.
pDebug,1.
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
572,157

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 2.0.2~~##
#####################################################################################

# This process will clone the source dimension
# If the target dimension already exists then it will be overwritten


### Constants ###

cProcess = 'Bedrock.Dim.CloneFromSubset' ;
cUser = TM1User();

cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 100000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;

cSubset = '}' | cProcess;
cHierAttr = 'Bedrock.Descendant';
cAttrVal = 'Descendant';

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
  ENDIF;
ENDIF;


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
575,37

#****Begin: Generated Statements***
#****End: Generated Statements****


### Set Descendent attribute value
AttrDelete( pSourceDim, cHierAttr );
If( pAttr = 1 );
  AttrDelete( pTargetDim, cHierAttr );
ENDIF;

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
