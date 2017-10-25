601,100
602,"Bedrock.Cube.Data.ImportFromFile"
562,"CHARACTERDELIMITED"
586,"C:\TM1\Bedrock\Data\Bedrock.Z.Cube.Placeholder.csv"
585,"C:\TM1\Bedrock\Data\Bedrock.Z.Cube.Placeholder.csv"
564,
565,"oSxjFb0dgMW3ap_arjFfzBEV>u?d8<V>Q@>nPglK8VU8t;GR9@uU7jX1so7PrYC<dnu=tHxkyjiwIcv^kv<FXYtsmPaUKHkTYYk0MIsKt42S?oWV\YBE`ZXIiiX[zcrEkibNxXAm=BL3i=zgtvdHQ\_H]8Jk;bgtv@r\<_Q5egkr]Op34?zKXum533ptGWt^P?ex07C1"
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
571,
569,2
592,0
599,1000
560,11
pSourceDir
pSourceFile
pCube
pDimension
pSourceElement
pTargetElement
pTitleRows
pDelimiter
pQuote
pCumulate
pDebug
561,11
2
2
2
2
2
2
1
2
2
1
1
590,11
pSourceDir,""
pSourceFile,""
pCube,""
pDimension,""
pSourceElement,""
pTargetElement,""
pTitleRows,1
pDelimiter,","
pQuote,""""
pCumulate,0
pDebug,0
637,11
pSourceDir,"Source Directory"
pSourceFile,"Source File"
pCube,"Target Cube"
pDimension,"Dimension (Optional)"
pSourceElement,"Source Element ( Only required if a Dimensoin is used.)"
pTargetElement,"Target Element (Only required if Dimension is used.)"
pTitleRows,"Number of Title Rows to Skip"
pDelimiter,"Delimiter Character (default=Comma)"
pQuote,"Quote Character (default=Double Quote)"
pCumulate,"Accumulate Amounts"
pDebug,"Debug Mode"
577,30
v1
v2
v3
v4
v5
v6
v7
v8
v9
v10
v11
v12
v13
v14
v15
v16
v17
v18
v19
v20
v21
v22
v23
v24
v25
v26
v27
v28
v29
v30
578,30
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
579,30
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
580,30
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
581,30
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
582,30
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
603,0
572,276

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will load a CSV text file to the specified cube

# Notes:
# - The assumed file format is as per standard CMA export
# - v1 specIfies cube name, subsequent fields specify cube address ( individual element names )
# - vN specIfies cell data value to load. With provision for files with header rows


### Constants ###

cProcess = 'Bedrock.Cube.Data.ImportFromFile';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;

nRecordProcessedCount = 0;
nRecordPostedCount = 0;

### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pSourceDir      : ' | pSourceDir );
  AsciiOutput( sDebugFile, '            pSourceFile     : ' | pSourceFile );
  AsciiOutput( sDebugFile, '            pCube           : ' | pCube );
  AsciiOutput( sDebugFile, '            pDimension      : ' | pDimension );
  AsciiOutput( sDebugFile, '            pSourceElement  : ' | pSourceElement );
  AsciiOutput( sDebugFile, '            pTargetElement  : ' | pTargetElement );
  AsciiOutput( sDebugFile, '            pTitleRows      : ' | NumberToString( pTitleRows ) );
  AsciiOutput( sDebugFile, '            pDelimiter      : ' | pDelimiter );
  AsciiOutput( sDebugFile, '            pQuote          : ' | pQuote );
  AsciiOutput( sDebugFile, '            pCumulate       : ' | NumberToString( pCumulate) );
  AsciiOutput( sDebugFile, '            pDebug          : ' | NumberToString( pDebug) );
EndIf;


### Validate Parameters ###

# Validate source directory
If( 
SubSt( pSourceDir, Long( pSourceDir ) - 1, 1 ) @= '\' );
  pSourceDir = SubSt( pSourceDir, 1, Long( pSourceDir ) - 1 );
EndIf;
If( 
FileExists( pSourceDir ) = 0 );
  If( pDebug >= 1 );
    sMessage = 'Invalid source directory specified: folder does not exist.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

# Validate source file
If( 
Trim( pSourceFile ) @= '' );
  If( pDebug >= 1 );
    sMessage = 'Invalid source file specified: file name is blank.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

sFile = pSourceDir | '\' | pSourceFile;
If( FileExists( sFile ) = 0 );
  If( pDebug >= 1 );
  sMessage = 'Invalid source file specified: file does not exist in directory:' | sFile;
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

## Validate cube
If( CubeExists( pCube ) = 0 );
  If( pDebug >= 1 );
    sMessage = 'Invalid target cube specified: ' | pCube;
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

## Validate Dimension
pDimension = TRIM( pDimension);

If(
pDimension @<> '');
  IF(
  DimensionExists( pDimension ) = 0 );
    If( pDebug >= 1 );
      sMessage = 'Invalid dimension specified: ' | pDimension;
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    ProcessQuit;
  EndIf;

  # Validate Source Element
  If(
  pSourceElement @= '' );
      If( pDebug >= 1 );
        sMessage = 'Error: The Source Element parameter is blank.';
        AsciiOutput( sDebugFile, sMessage );
      EndIf;
      ProcessQuit;
    EndIf;

  If(
  DIMIX( pDimension, pSourceElement ) = 0 );
    sMessage = 'Invalid source element, ' | pSourceElement | ' specified for ' | pDimension | ' dimension.';
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    ProcessQuit;
  EndIf;
  sSourceElement = DimensionElementPrincipalName( pDimension, pSourceElement);

  # Validate Target Element
  If(
  pTargetElement @= '' );
    If( pDebug >= 1 );
      sMessage = 'Error: The Target Element parameter is blank.';
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    ProcessQuit;
  EndIf;


  If(
  DIMIX( pDimension, pTargetElement ) = 0 );
    sMessage = 'Invalid target element, ' | pTargetElement | ' specified for ' | pDimension | ' dimension.';
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    ProcessQuit;
  EndIf;

ENDIF;


## Validate delimiter
If( 
pDelimiter @= '' );
  pDelimiter = ',';
EndIf;
If( Long( pDelimiter ) > 1 );
   sMessage = 'Invalid delimiter specified: ' | pDelimiter | ' field delimiter must be single character.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

## Validate quote character
If( pQuote @= '' );
  pQuote = '"';
EndIf;
If( 
Long( pQuote ) > 1 );
  nErrors = 1;
  sMessage = 'Invalid string qualIfier: ' | pQuote | ' quote character must be single character.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;


### Determine number of dims in target cube ###
nCount = 1;
nDimensionIndex = 0;
While( 
TabDim( pCube, nCount ) @<> '' );
  sDimension = TabDim( pCube, nCount );
  If( sDimension @= pDimension );
    nDimensionIndex = nCount;
  EndIf;
  nCount = nCount + 1;
End;
nDimensionCount = nCount - 1;

## Validate the dimension is part of the cube.
IF( 
pDimension @= '');
  ## CONTINUE;
ELSE;
  If( 
  nDimensionIndex = 0 );
    nErrors = 1;
    If( pDebug >= 1 );
      sMessage = 'Specified dimension: ' | pDimension | ' is not a component of the cube: ' | pCube;
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    ProcessQuit;
  ELSE;
    If( pDebug >= 1 );
      sMessage = 'The ' | pCube | ' has ' | NumberToString( nDimensionCount) | ' dimensions.';
      AsciiOutput( sDebugFile, sMessage );
      sMessage = 'Specified dimension: ' | pDimension |
        ', is dimension index: ' | NumberToString( nDimensionIndex ) |
        ', the target cube: ' | pCube;
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
  EndIf;
ENDIF;

If( nDimensionCount > 27 );
  nErrors = 1;
  If( pDebug >= 1 );
    sMessage = 'Cube has too many dimensions: ' | pCube | ' max 27 dimensions.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ProcessQuit;
EndIf;



### Determine dimensions in target cube, we need to know this to test cell type before loading ###
sDim1 = TabDim( pCube, 1 );
sDim2 = TabDim( pCube, 2 );
sDim3 = TabDim( pCube, 3 );
sDim4 = TabDim( pCube, 4 );
sDim5 = TabDim( pCube, 5 );
sDim6 = TabDim( pCube, 6 );
sDim7 = TabDim( pCube, 7 );
sDim8 = TabDim( pCube, 8 );
sDim9 = TabDim( pCube, 9 );
sDim10 = TabDim( pCube, 10 );
sDim11 = TabDim( pCube, 11 );
sDim12 = TabDim( pCube, 12 );
sDim13 = TabDim( pCube, 13 );
sDim14 = TabDim( pCube, 14 );
sDim15 = TabDim( pCube, 15 );
sDim16 = TabDim( pCube, 16 );
sDim17 = TabDim( pCube, 17 );
sDim18 = TabDim( pCube, 18 );
sDim19 = TabDim( pCube, 19 );
sDim20 = TabDim( pCube, 20 );
sDim21 = TabDim( pCube, 21 );
sDim22 = TabDim( pCube, 22 );
sDim23 = TabDim( pCube, 23 );
sDim24 = TabDim( pCube, 24 );
sDim25 = TabDim( pCube, 25 );
sDim26 = TabDim( pCube, 26 );
sDim27 = TabDim( pCube, 27 );

### Assign Datasource ###

DataSourceType = 'CHARACTERDELIMITED';
DatasourceNameForServer = sFile;
DatasourceNameForClient = sFile;
DatasourceASCIIHeaderRecords = pTitleRows;
DatasourceASCIIDelimiter = pDelimiter;
DatasourceASCIIQuoteCharacter = pQuote;

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | '_Data.debug';
ENDIF;


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,646

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# It would be too exhaustive to error trap elements not existing in dimension for each possible number of dimensions
# If an incorrect source file is specfied for a target cube then the TI will error with standard TI error messages.
# Note: that the assumed file format is standard .cma cube export of Cube, d1, d2, dn, value
# This is equivalent to using the Bedrock.Cube.ExportToFile TI.


## Increase Record count
nRecordProcessedCount = nRecordProcessedCount + 1;


### Determine target dimension SubStitution ###
IF( pDimension @<>'');

  If( nDimensionIndex = 1 );
    IF( v2 @= sSourceElement );
      v2 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 2 );
    IF( v3 @= sSourceElement );
      v3 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 3 );
    IF( v4 @= sSourceElement );
      v4 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 4 );
     IF( v5 @= sSourceElement );
      v5 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 5 );
    IF( v6 @= sSourceElement );
      v6 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 6 );
    IF( v7 @= sSourceElement );
      v7 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 7 );
    IF( v8 @= sSourceElement );
      v8 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 8 );
    IF( v9 @= sSourceElement );
      v9 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 9 );
    IF( v10 @= sSourceElement );
      v10 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 10 );
    IF( v11 @= sSourceElement );
      v11 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 11 );
    IF( v12 @= sSourceElement );
      v12 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 12 );
    IF( v13 @= sSourceElement );
      v13 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 13 );
    IF( v14 @= sSourceElement );
      v14 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 14 );
    IF( v15 @= sSourceElement );
      v15 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 15 );
    IF( v16 @= sSourceElement );
      v16 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 16 );
    IF( v17 @= sSourceElement );
      v17 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 17 );
    IF( v18 @= sSourceElement );
      v18 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 18 );
    IF( v19 @= sSourceElement );
      v19 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 19 );
    IF( v20 @= sSourceElement );
      v20 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 20 );
    IF( v21 @= sSourceElement );
      v21 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 21 );
    IF( v22 @= sSourceElement );
      v22 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 22 );
    IF( v23 @= sSourceElement );
      v23 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 23 );
    IF( v24 @= sSourceElement );
      v24 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 24 );
    IF( v25 @= sSourceElement );
      v25 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 25 );
    IF( v26 @= sSourceElement );
      v26 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 26 );
    IF( v27 @= sSourceElement );
      v27 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;
  ElseIf( nDimensionIndex = 27 );
    IF( v28 @= sSourceElement );
      v27 = pTargetElement;
    ELSE;
      ITEMSKIP;
    ENDIF;

  EndIf;
ENDIF;

### Write data from source file to target cube ###
If( pDebug <= 1 );
  If( nDimensionCount = 2 );
    If( CellIsUpdateable( pCube, v2, v3 ) = 1 );
      sElType = DType( sDim2, v3 );
      sDim = SubST ( v1, LONG('}ElementAttributes_')+1, 9999);

      IF( sElType @= 'AS');
        AttrPutS( v4, sDim, v2, v3, 1 );
      ELSEIF( sElType @= 'AA');
        AttrPutS( v4, sDim, v2, v3 );
      ELSEIF( sElType @= 'AN');
        AttrPutN( NUMBR(v4), sDim, v2, v3 );
      ELSEIF( sElType @= 'S');
        CellPutS( v4, pCube, v2, v3 );
      Else;
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3 );
          nCbal = nObal + Numbr( v4 );
        ELSE;
          nCbal = Numbr( v4 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 3 );
    If( CellIsUpdateable( pCube, v2, v3, v4 ) = 1 );
      sElType = DType( sDim3, v4 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4 );
          nCbal = nObal + Numbr( v5 );
        ELSE;
          nCbal = Numbr( v5 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4 );
      Else;
        CellPutS( v5, pCube, v2, v3, v4 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 4 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5 ) = 1 );
      sElType = DType( sDim4, v5 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5 );
          nCbal = nObal + Numbr( v6 );
        ELSE;
          nCbal = Numbr( v6 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5 );
      Else;
        CellPutS( v6, pCube, v2, v3, v4, v5 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 5 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6 ) = 1 );
      sElType = DType( sDim5, v6 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6 );
          nCbal = nObal + Numbr( v7 );
        ELSE;
          nCbal = Numbr( v7 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6 );
      Else;
        CellPutS( v7, pCube, v2, v3, v4, v5, v6 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 6 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7 ) = 1 );
      sElType = DType( sDim6, v7 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7 );
          nCbal = nObal + Numbr( v8 );
        ELSE;
          nCbal = Numbr( v8 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7 );
      Else;
        CellPutS( v8, pCube, v2, v3, v4, v5, v6, v7 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 7 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8 ) = 1 );
      sElType = DType( sDim7, v8 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8 );
          nCbal = nObal + Numbr( v9 );
        ELSE;
          nCbal = Numbr( v9 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8 );
      Else;
        CellPutS( v9, pCube, v2, v3, v4, v5, v6, v7, v8 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 8 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9 ) = 1 );
      sElType = DType( sDim8, v9 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9 );
          nCbal = nObal + Numbr( v10 );
        ELSE;
          nCbal = Numbr( v10 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9 );
      Else;
        CellPutS( v10, pCube, v2, v3, v4, v5, v6, v7, v8, v9 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 9 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10 ) = 1 );
      sElType = DType( sDim9, v10 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10 );
          nCbal = nObal + Numbr( v11 );
        ELSE;
          nCbal = Numbr( v11 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10 );
      Else;
        CellPutS( v11, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 10 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 ) = 1 );
      sElType = DType( sDim10, v11 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 );
          nCbal = nObal + Numbr( v12 );
        ELSE;
          nCbal = Numbr( v12 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 );
      Else;
        CellPutS( v12, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 11 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 ) = 1 );
      sElType = DType( sDim11, v12 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 );
          nCbal = nObal + Numbr( v13 );
        ELSE;
          nCbal = Numbr( v13 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 );
      Else;
        CellPutS( v13, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 12 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 ) = 1 );
      sElType = DType( sDim12, v13 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 );
          nCbal = nObal + Numbr( v14 );
        ELSE;
          nCbal = Numbr( v14 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 );
      Else;
        CellPutS( v14, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 13 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 ) = 1 );
      sElType = DType( sDim13, v14 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 );
          nCbal = nObal + Numbr( v15 );
        ELSE;
          nCbal = Numbr( v15 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 );
      Else;
        CellPutS( v15, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 14 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 ) = 1 );
      sElType = DType( sDim14, v15 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 );
          nCbal = nObal + Numbr( v16 );
        ELSE;
          nCbal = Numbr( v16 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 );
      Else;
        CellPutS( v16, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 15 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 ) = 1 );
      sElType = DType( sDim15, v16 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 );
          nCbal = nObal + Numbr( v17 );
        ELSE;
          nCbal = Numbr( v17 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 );
      Else;
        CellPutS( v17, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 16 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 ) = 1 );
      sElType = DType( sDim16, v17 );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 );
          nCbal = nObal + Numbr( v18 );
        ELSE;
          nCbal = Numbr( v18 );
        Endif;
      If( sElType @<> 'S' );
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 );
      Else;
        CellPutS( v18, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 17 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 ) = 1 );
      sElType = DType( sDim17, v18 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 );
          nCbal = nObal + Numbr( v19 );
        ELSE;
          nCbal = Numbr( v19 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 );
      Else;
        CellPutS( v19, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 18 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 ) = 1 );
      sElType = DType( sDim18, v19 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 );
          nCbal = nObal + Numbr( v20 );
        ELSE;
          nCbal = Numbr( v20 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 );
      Else;
        CellPutS( v20, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 19 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 ) = 1 );
      sElType = DType( sDim19, v20 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 );
          nCbal = nObal + Numbr( v21 );
        ELSE;
          nCbal = Numbr( v21 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 );
      Else;
        CellPutS( v21, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 20 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 ) = 1 );
      sElType = DType( sDim20, v21 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 );
          nCbal = nObal + Numbr( v22 );
        ELSE;
          nCbal = Numbr( v22 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 );
      Else;
        CellPutS( v22, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 21 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 ) = 1 );
      sElType = DType( sDim21, v22 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 );
          nCbal = nObal + Numbr( v23 );
        ELSE;
          nCbal = Numbr( v23 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 );
      Else;
        CellPutS( v23, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 22 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 ) = 1 );
      sElType = DType( sDim22, v23 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 );
          nCbal = nObal + Numbr( v24 );
        ELSE;
          nCbal = Numbr( v24 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 );
      Else;
        CellPutS( v24, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 23 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
    v23, v24 ) = 1 );
      sElType = DType( sDim23, v24 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
            v23, v24 );
          nCbal = nObal + Numbr( v25 );
        ELSE;
          nCbal = Numbr( v25 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
          v23, v24 );
      Else;
        CellPutS( v25, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 24 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
      v23, v24, v25 ) = 1 );
      sElType = DType( sDim24, v25 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
            v23, v24, v25 );
          nCbal = nObal + Numbr( v26 );
        ELSE;
          nCbal = Numbr( v26 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
          v23, v24, v25 );
      Else;
        CellPutS( v26, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
          v23, v24, v25 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 25 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
      v23, v24, v25, v26 ) = 1 );
      sElType = DType( sDim25, v26 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
            v23, v24, v25, v26 );
          nCbal = nObal + Numbr( v27 );
        ELSE;
          nCbal = Numbr( v27 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
          v23, v24, v25, v26 );
      Else;
        CellPutS( v27, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
          v23, v24, v25, v26 );
      EndIf;
    EndIf;
ElseIf( nDimensionCount = 26 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
    v23, v24, v25, v26, v27 ) = 1 );
      sElType = DType( sDim26, v27 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
            v23, v24, v25, v26, v27 );
          nCbal = nObal + Numbr( v28 );
        ELSE;
          nCbal = Numbr( v28 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
        v23, v24, v25, v26, v27 );
      Else;
        CellPutS( v28, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21,
          v22, v23, v24, v25, v26, v27 );
      EndIf;
    EndIf;
ElseIf( nDimensionCount = 27 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
    v23, v24, v25, v26, v27, v28 ) = 1 );
      sElType = DType( sDim27, v28 );
      If( sElType @<> 'S' );
        IF(
        pCumulate >= 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
            v23, v24, v25, v26, v27, v28 );
          nCbal = nObal + Numbr( v29 );
        ELSE;
          nCbal = Numbr( v29 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
          v23, v24, v25, v26, v27, v28 );
      Else;
        CellPutS( v29, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21,
          v22, v23, v24, v25, v26, v27, v28 );
      EndIf;
    EndIf;


  EndIf;
EndIf;

If( pDebug >= 1 );
  ASCIIOutput( sDebugFile, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, 
    v24, v25, v26, v27, v28, v29);
ENDIF;


## Increase Record count
nRecordPostedCount = nRecordPostedCount + 1;
### End Data ###
575,37

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
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
  AsciiOutput( sDebugFile,'Record Processed: ' | NumberToString( nRecordProcessedCount ) );
  AsciiOutput( sDebugFile,'Record Load: ' | NumberToString( nRecordPostedCount ) );
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
