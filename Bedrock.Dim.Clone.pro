601,100
602,"Bedrock.Dim.Clone"
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"wkEEPzjloT=l?5ATh=LK[<1agREieZvUJjpYg]4[tlU0y\@wyizT?I<N^d132`Exdn5FDW\\1vRWkKl9OHBo6GbIl4Ex7;DjWkQ63E0J@I<\WmIjMo9JDch9h>YXXbRiA7RNS8OQ=E?]1>?IwYs?c^>2n[No`TbDbmso:h[z85BOT;STNxrt=bjrZ2Pjt8iUrPsj?@Wu"
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
pTargetDim
pAttr
pUnwind
pDebug
561,5
2
2
1
1
1
590,5
pSourceDim,""
pTargetDim,""
pAttr,0
pUnwind,0
pDebug,0
637,5
pSourceDim,"Source Dimension"
pTargetDim,"Target Dimension"
pAttr,"Include Attributes? (Boolean 1=True)"
pUnwind,"0 = Delete all Elements, 1 = Unwind Existing Elements, 2 = Do not change Existing Elements"
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
572,162

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will clone the source dimension
# If the target dimension already exists then it will be overwritten


### Constants ###

cProcess = 'Bedrock.Dim.Clone' ;
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.';
cSubset = cProcess;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pSourceDim : ' | pSourceDim );
  AsciiOutput( sDebugFile, '            pTargetDim : ' | pTargetDim );
  AsciiOutput( sDebugFile, '            pUnwind    : ' | NumberToString( pUnwind ) );
  AsciiOutput( sDebugFile, '            pAttr      : ' | NumberToString( pAttr ) );

EndIf;


### Validate Parameters ###

nErrors = 0;

# Validate source dimension
If ( DimensionExists( pSourceDim ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid source dimension: ' | pSourceDim;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate target dimension
If( 
pTargetDim @= '' % pTargetDim @= pSourceDim );
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
    ELSEIF(
    pUnwind = 2 );
       If( pDebug >= 1 );
         AsciiOutput( sDebugFile, 'Target dimension kept unchanged: ' | pTargetDim  );
       EndIf;
    ELSE;
      DimensionDeleteAllElements( pTargetDim );
      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, 'All element deleted from Target element: ' | pTargetDim  );
      EndIf;

    EndIf;
  EndIf;
EndIf;

### Set the target Sort Order ###
sSortElementsType = CELLGETS( '}DimensionProperties', pSourceDim, 'SORTELEMENTSTYPE');
sSortElementsSense  = CELLGETS( '}DimensionProperties', pSourceDim, 'SORTELEMENTSSENSE');
sSortComponentsType = CELLGETS( '}DimensionProperties', pSourceDim, 'SORTCOMPONENTSTYPE');
sSortComponentsSense = CELLGETS( '}DimensionProperties', pSourceDim, 'SORTCOMPONENTSSENSE');

If( pDebug <= 1 );
  DimensionSortOrder( pTargetDim, sSortComponentsType, sSortComponentsSense, sSortElementsType , sSortElementsSense);
EndIf;

If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'Dimension Sort: Sort Components Type : ' | sSortComponentsType );
  AsciiOutput( sDebugFile, '                Sort Components Sense: ' | sSortComponentsSense );
  AsciiOutput( sDebugFile, '                Sort Elements Type   : ' | sSortElementsType );
  AsciiOutput( sDebugFile, '                Sort Elements Sense  : ' | sSortElementsSense );
EndIf;

### Build Source Subset ###
If( SubsetExists( pSourceDim, cSubset ) = 1 );
  SubsetDeleteAllElements( pSourceDim, cSubset );
Else;
  SubsetCreate( pSourceDim, cSubset );
EndIf;
SubsetIsAllSet( pSourceDim, cSubset, 1 );


nSourceDimSize = DIMSIZ( pSourceDim );
nIndex = 1;
WHILE( nIndex <= nSourceDimSize );
  sElName = DIMNM( pSourceDim, nIndex);
  sElType = DTYPE( pSourceDim, sElName);
  
  If( pDebug <= 1 );
    DimensionElementInsert( pTargetDim, '', sElName, sElType );
  ENDIF;
  nIndex = nIndex + 1;
END;

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
      If( pDebug <= 1 );
        AttrInsert( pTargetDim, '', sAttrName, sAttrType );
      EndIf;
    nCount = nCount + 1;
  End;
EndIf;


### End Prolog ###
573,40

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################


### Check for errors in prolog ###

If( nErrors <> 0 );
  ProcessBreak;
EndIf;



### Add Elements to target dimension ###

If( pDebug <= 1 );

  sElType = DType( pSourceDim, vElement );

  IF( 
  sElType @= 'C' & 
  ElCompN( pSourceDim, vElement ) > 0 );
    nChildren = ElCompN( pSourceDim, vElement );
    nCount = 1;
    While( nCount <= nChildren );
      sChildElement = ElComp( pSourceDim, vElement, nCount );
      sChildWeight = ElWeight( pSourceDim, vElement, sChildElement );
      DimensionElementComponentAdd( pTargetDim, vElement, sChildElement, sChildWeight );
      nCount = nCount + 1;
    End;
  EndIf;

EndIf;


### End MetaData ###
574,52

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################


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
        If( sAttrVal @<> '' & CellIsUpdateable( '}ElementAttributes_' | pTargetDim, vElement, sAttrName ) = 1 );
          If( sAttrType @= 'A' );
            AttrPutS( sAttrVal, pTargetDim, vElement, sAttrName, 1 );
          Else;
            AttrPutS( sAttrVal, pTargetDim, vElement, sAttrName );
          EndIf;
        EndIf;
      Else;
        nAttrVal = AttrN( pSourceDim, vElement, sAttrName );
        If( nAttrVal <> 0 & CellIsUpdateable( '}ElementAttributes_' | pTargetDim, vElement, sAttrName ) = 1 );
          AttrPutN( nAttrVal, pTargetDim, vElement, sAttrName );
        EndIf;
      EndIf;
      nCount = nCount + 1;
    End;

  EndIf;

EndIf;


### End Data ###
575,50

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################


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

### Destroy Source Subset ###
If( pDebug <= 1 );
  If(
  SubsetExists( pSourceDim, cSubset ) = 1 );
    SubsetDestroy( pSourceDim, cSubset );
  EndIf;
ENDIF;

### If errors occurred terminate process with a major error status ###

If( nErrors <> 0 );
  ProcessQuit;
EndIf;

### Set the target Sort Order ###
If( pDebug >= 1 );
  CELLPUTS( sSortElementsType, '}DimensionProperties', pTargetDim, 'SORTELEMENTSTYPE');
  CELLPUTS( sSortElementsSense, '}DimensionProperties', pTargetDim, 'SORTELEMENTSSENSE');
  CELLPUTS( sSortComponentsType, '}DimensionProperties', pTargetDim, 'SORTCOMPONENTSTYPE');
  CELLPUTS( sSortComponentsSense, '}DimensionProperties', pTargetDim, 'SORTCOMPONENTSSENSE');
ENDIF;


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
