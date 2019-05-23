﻿601,100
602,"}bedrock.cube.data.import"
562,"CHARACTERDELIMITED"
586,"C:\TM1\Bedrock\Data\Bedrock.Z.Cube.Placeholder.csv"
585,"C:\TM1\Bedrock\Data\Bedrock.Z.Cube.Placeholder.csv"
564,
565,"g21[6axa0R@Pqav;4L\qoikyj68<wL5ak?dbGLxL4\cB\8d?<PgN2Li<su`6P8BD]GX@iTyD3aW<iex[Z4GvCN`11g8E9@jSkiad_b<:Ks1?ez=zyR\3G:eySNZD`?_2Oby4FhvNinsPe4QHI8n5gZM\@XKGSv0;a]l\Nhnmg=<Z]uGhAQ:OjcN_A^Py0:MdCQ]bfuf<"
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
560,12
pLogOutput
pCube
pSrcDir
pSrcFile
pDim
pSrcEle
pTgtEle
pTitleRows
pDelim
pQuote
pCumulate
pCubeLogging
561,12
1
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
590,12
pLogOutput,0
pCube,""
pSrcDir,""
pSrcFile,""
pDim,""
pSrcEle,""
pTgtEle,""
pTitleRows,1
pDelim,","
pQuote,""""
pCumulate,0
pCubeLogging,0
637,12
pLogOutput,"Required: write parameters and action summary to server message log (Boolean True = 1)"
pCube,"Required: Target Cube"
pSrcDir,"Optional: Source Directory (will default to error log path)"
pSrcFile,"Optional: Source File (will default to pCube_Export.csv )"
pDim,"Optional: Dimension"
pSrcEle,"Optional: Source Element ( Only required if a Dimension is used.)"
pTgtEle,"Optional: Target Element (Only required if Dimension is used.)"
pTitleRows,"Required: Number of Title Rows to Skip"
pDelim,"Required: AsciiOutput delimiter character (Default=comma, exactly 3 digits = ASCII code)"
pQuote,"Required: Quote (Accepts empty quote, exactly 3 digits = ASCII code)"
pCumulate,"Required: Accumulate Amounts (0 = Overwrite values, 1 = Accumulate values)"
pCubeLogging,"Required: Cube Logging (0 = No transaction logging, 1 = Logging of transactions)"
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
572,302
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.cube.data.import', 'pLogOutput', pLogOutput,
    	'pCube', '', 'pSrcDir', '', 'pSrcFile', '',
    	'pDim', '', 'pSrcEle', '', 'pTgtEle', '',
    	'pTitleRows', 1, 'pDelim', ',', 'pQuote', '"',
    	'pCumulate', 0, 'pCubeLogging', 0
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
# This process will load a csv text file to the target cube.

# Use case: Intended for development/prototyping or in Production environment.
#1/ Import data from another TM1 model.
#2/ To eliminate possibility of locking it is sometimes better to export and import when needing to copy data from one cube to another.

# Note:
# Naturally, a valid target cube name (pCube) is mandatory otherwise the process will abort.
# The default input path is the same as the error file path if not specified.
# If the file name is left blank, the process will look for a file called pCube_Export.csv.

# Format:
# The assumed file format is as per standard CMA export:
# - v1 specIfies cube name, subsequent fields specify cube address ( individual element names ).
# - vN specIfies cell data value to load. With provision for files with header rows.
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName     = GetProcessName();
cUserName         = TM1User();
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cTempSub          = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pSrcDir:%pSrcDir%, pSrcFile:%pSrcFile%, pCube:%pCube%, pDim:%pDim%, pSrcEle:%pSrcEle%, pTgtEle:%pTgtEle%, pTitleRows:%pTitleRows%, pDelim:%pDelim%, pQuote:%pQuote%, pCumulate:%pCumulate%, pCubeLogging:%pCubeLogging%.' ;   
cLenASCIICode = 3;

pDelimiter        = TRIM(pDelim);

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

nRecordProcessedCount   = 0;
nRecordPostedCount      = 0;
nErrors                 = 0;


### Validate Parameters ###
pSourceDir    = TRIM(pSrcDir);
pSourceFile   = TRIM(pSrcFile);

# Validate source directory
If(Trim( pSourceDir ) @= '' );
    pSourceDir = GetProcessErrorFileDirectory;
ElseIf( FileExists( pSourceDir ) = 0 );
  sMessage = 'Invalid source directory specified: folder does not exist.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

If( SubSt( pSourceDir, Long( pSourceDir ) - 1, 1 ) @= '\' );
  pSourceDir = SubSt( pSourceDir, 1, Long( pSourceDir ) - 1 );
EndIf;

If( pSourceFile @= '' );
    pSourceFile = Expand('%pCube%_Export.csv');
EndIf;

sFile = pSourceDir | '\' | pSourceFile;
# Validate source file
If( FileExists( sFile ) = 0 );
  sMessage = 'Invalid source file specified: file does not exist in directory:' | sFile;
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate cube
If( Trim( pCube ) @= '' );
  sMessage = 'No target cube specified.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( CubeExists( pCube ) = 0 );
  sMessage = 'Invalid target cube specified: ' | pCube;
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate file delimiter & quote character
If( pDelimiter @= '' );
    pDelimiter = ',';
Else;
    # If length of pDelimiter is exactly 3 chars and each of them is decimal digit, then the pDelimiter is entered as ASCII code
    nValid = 0;
    If ( LONG(pDelimiter) = cLenASCIICode );
      nChar = 1;
      While ( nChar <= cLenASCIICode );
        If( CODE( pDelimiter, nChar )>=CODE( '0', 1 ) & CODE( pDelimiter, nChar )<=CODE( '9', 1 ) );
          nValid = 1;
        Else;
          nValid = 0;
        EndIf;
        nChar = nChar + 1;
      End;
    EndIf;
    If ( nValid<>0 );
      pDelimiter=CHAR(StringToNumber( pDelimiter ));
    Else;
      pDelimiter = SubSt( Trim( pDelimiter ), 1, 1 );
    EndIf;
EndIf;
If( pQuote @= '' );
    ## Use no quote character 
Else;
    # If length of pQuote is exactly 3 chars and each of them is decimal digit, then the pQuote is entered as ASCII code
    nValid = 0;
    If ( LONG(pQuote) = cLenASCIICode );
      nChar = 1;
      While ( nChar <= cLenASCIICode );
        If( CODE( pQuote, nChar ) >= CODE( '0', 1 ) & CODE( pQuote, nChar ) <= CODE( '9', 1 ) );
          nValid = 1;
        Else;
          nValid = 0;
        EndIf;
        nChar = nChar + 1;
      End;
    EndIf;
    If ( nValid<>0 );
      pQuote=CHAR(StringToNumber( pQuote ));
    Else;
      pQuote = SubSt( Trim( pQuote ), 1, 1 );
    EndIf;
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
  ProcessBreak;
EndIf;

## Validate Dimension
pDimension      = TRIM( pDim);
pSourceElement  = TRIM(pSrcEle);
pTargetElement  = TRIM(pTgtEle);

IF( pDimension @<> '');
    
  IF( DimensionExists( pDimension ) = 0 );
    sMessage = 'Invalid dimension specified: ' | pDimension;
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  EndIf;

  # Validate Source Element
  If( pSourceElement @= '' );
    sMessage = 'Error: The Source Element parameter is blank.';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  EndIf;

  If( DIMIX( pDimension, pSourceElement ) = 0 );
    sMessage = 'Invalid source element, ' | pSourceElement | ' specified for ' | pDimension | ' dimension.';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  EndIf;
  sSourceElement = DimensionElementPrincipalName( pDimension, pSourceElement);

  # Validate Target Element
  If( pTargetElement @= '' );
    sMessage = 'Error: The Target Element parameter is blank.';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  ElseIf( DIMIX( pDimension, pTargetElement ) = 0 );
    sMessage = 'Invalid target element, ' | pTargetElement | ' specified for ' | pDimension | ' dimension.';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  EndIf;
  sTargetElement = DimensionElementPrincipalName( pDimension, pTargetElement);

ENDIF;


## Validate delimiter
pDelimiter = TRIM(pDelim);
If( pDelimiter @= '' );
  sMessage = 'Error: The file delimiter parameter is blank.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( Long( pDelimiter ) > 1 );
  sMessage = 'Invalid delimiter specified: ' | pDelimiter | ' field delimiter must be single character.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate quote character
If( pQuote @= '' );
  sMessage = 'Error: The quote charecter is blank.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( Long( pQuote ) > 1 );
  sMessage = 'Invalid string qualIfier: ' | pQuote | ' quote character must be single character.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
    ProcessBreak;
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
IF( pDimension @= '');
  ## CONTINUE;
ELSEIf( nDimensionIndex = 0 );
    sMessage = 'Specified dimension: ' | pDimension | ' is not a component of the cube: ' | pCube;
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ENDIF;

If( nDimensionCount > 27 );
  sMessage = 'Cube has too many dimensions: ' | pCube | ' max 27 dimensions.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
    ProcessBreak;
EndIf;

### Determine dimensions in target cube, we need to know this to test cell type before loading ###
sDim1  = TabDim( pCube, 1 );
sDim2  = TabDim( pCube, 2 );
sDim3  = TabDim( pCube, 3 );
sDim4  = TabDim( pCube, 4 );
sDim5  = TabDim( pCube, 5 );
sDim6  = TabDim( pCube, 6 );
sDim7  = TabDim( pCube, 7 );
sDim8  = TabDim( pCube, 8 );
sDim9  = TabDim( pCube, 9 );
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

#CubeLogging
sCubeLogging = CellGetS('}CubeProperties', pCube, 'LOGGING' );
CubeSetLogChanges( pCube, pCubeLogging);

### Assign Datasource ###
DataSourceType                  = 'CHARACTERDELIMITED';
DatasourceNameForServer         = sFile;
DatasourceNameForClient         = sFile;
DatasourceASCIIHeaderRecords    = pTitleRows;
DatasourceASCIIDelimiter        = pDelimiter;
DatasourceASCIIQuoteCharacter   = pQuote;

### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,479

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

# It would be too exhaustive to error trap elements not existing in dimension for each possible number of dimensions
# If an incorrect source file is specfied for a target cube then the TI will error with standard TI error messages.
# Note: that the assumed file format is standard .cma cube export of Cube, d1, d2, dn, value
# This is equivalent to using the Bedrock.Cube.ExportToFile TI.

## Increase Record count
nRecordProcessedCount = nRecordProcessedCount + 1;

### Determine target dimension SubStitution ###
IF( pDimension @<>'');
  
  IF(sSourceElement@<>Expand('%v'|numbertostring(nDimensionIndex+1)|'%'));
   itemskip;
  Endif; 
  
  v2 = IF(nDimensionIndex = 1, sTargetElement, v2);
  v3 = IF(nDimensionIndex = 2, sTargetElement, v3);
  v4 = IF(nDimensionIndex = 3, sTargetElement, v4);
  v5 = IF(nDimensionIndex = 4, sTargetElement, v5);
  v6 = IF(nDimensionIndex = 5, sTargetElement, v6);
  v7 = IF(nDimensionIndex = 6, sTargetElement, v7);
  v8 = IF(nDimensionIndex = 7, sTargetElement, v8);
  v9 = IF(nDimensionIndex = 8, sTargetElement, v9);
  v10 = IF(nDimensionIndex = 9, sTargetElement, v10);
  v11 = IF(nDimensionIndex = 10, sTargetElement, v11);
  v12 = IF(nDimensionIndex = 11, sTargetElement, v12);
  v13 = IF(nDimensionIndex = 12, sTargetElement, v13);
  v14 = IF(nDimensionIndex = 13, sTargetElement, v14);
  v15 = IF(nDimensionIndex = 14, sTargetElement, v15);
  v16 = IF(nDimensionIndex = 15, sTargetElement, v16);
  v17 = IF(nDimensionIndex = 16, sTargetElement, v17);
  v18 = IF(nDimensionIndex = 17, sTargetElement, v18);
  v19 = IF(nDimensionIndex = 18, sTargetElement, v19);
  v20 = IF(nDimensionIndex = 19, sTargetElement, v20);
  v21 = IF(nDimensionIndex = 20, sTargetElement, v21);
  v22 = IF(nDimensionIndex = 21, sTargetElement, v22);
  v23 = IF(nDimensionIndex = 22, sTargetElement, v23);
  v24 = IF(nDimensionIndex = 23, sTargetElement, v24);
  v25 = IF(nDimensionIndex = 24, sTargetElement, v25);
  v26 = IF(nDimensionIndex = 25, sTargetElement, v26);
  v27 = IF(nDimensionIndex = 26, sTargetElement, v27);

Endif;
 

### Write data from source file to target cube ###

If( nDimensionCount = 2 );
    If( CellIsUpdateable( pCube, v2, v3 ) = 1 );
        sElType = DType( sDim2, v3 );
        sDim = SubST ( sDim2, LONG('}ElementAttributes_')+1, 9999);

        IF( sElType @= 'AS');
            AttrPutS( v4, sDim, v2, v3, 1 );
        ELSEIF( sElType @= 'AA');
            AttrPutS( v4, sDim, v2, v3 );
        ELSEIF( sElType @= 'AN');
            AttrPutN( NUMBR(v4), sDim, v2, v3 );
        ELSEIF( sElType @= 'S');
            CellPutS( v4, pCube, v2, v3 );
        ElseIF( DimIx( sDim2, v3 ) <> 0 );
            IF(pCumulate = 1);
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
            IF(pCumulate = 1);
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
            IF(pCumulate = 1);
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
        IF(pCumulate = 1);
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
        IF(pCumulate = 1);
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
        IF( pCumulate = 1);
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
        IF( pCumulate = 1);
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
        IF( pCumulate = 1);
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
        IF(pCumulate = 1);
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
        IF(pCumulate = 1);
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
        IF( pCumulate = 1);
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
        IF(pCumulate = 1);
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
        IF(pCumulate = 1);
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
        IF(pCumulate = 1);
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
        IF(pCumulate = 1);
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
        IF(pCumulate = 1);
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
        IF(pCumulate = 1);
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
        IF(pCumulate = 1);
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
        IF(pCumulate = 1);
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
        IF(pCumulate = 1);
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
        IF(pCumulate = 1);
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
        IF(pCumulate = 1);
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
        IF(pCumulate = 1);
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
        IF(pCumulate = 1);
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
        IF( pCumulate = 1);
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
        IF(pCumulate = 1);
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
  
## Increase Record count
nRecordPostedCount = nRecordPostedCount + 1;
### End Data ###
575,36

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Cube Logging
CubeSetLogChanges( pCube, IF(sCubeLogging@='YES',1,0) );
    
### If errors occurred terminate process with a major error status ###
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 major error and consequently aborted. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% aborted. Check tm1server.log for details.' );
    ProcessError;
EndIf;

### Return code & final error message handling
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
Else;
    sProcessAction = Expand( 'Process:%cThisProcName% successfully imported data from file %sFile%.' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogoutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );   
    EndIf;
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
920,0
921,""
922,""
923,0
924,""
925,""
926,""
927,""
