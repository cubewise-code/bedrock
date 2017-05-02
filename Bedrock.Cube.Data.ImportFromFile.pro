601,100
562,"CHARACTERDELIMITED"
586,"D:\TM1\CubeExport.csv"
585,"D:\TM1\CubeExport.csv"
564,
565,"gTChEXYa?nTBPt\NADQClL`Xv3KF3S8zKZe63Qq_KvJNu>]gqly0YSZXOX<N4LdM34sA8T5cyhI[Ew?\SRm8F9h<@kh@Qn:Ur1lFG^tx9srlAQVzK8rMwYo]gt15N[VRxb4_=]rzc\jE0E7MVesIAzLO8>h6Dy4UsQrBTawQ\VpP[P@PM5:pd@00Nnk??13vUJbuu2Ny"
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
569,1
592,0
599,1000
560,7
pSourceDir
pSourceFile
pTargetCube
pTitleRows
pDelimiter
pQuote
pDebug
561,7
2
2
2
1
2
2
1
590,7
pSourceDir,""
pSourceFile,""
pTargetCube,""
pTitleRows,1.
pDelimiter,","
pQuote,"""
pDebug,0.
637,7
pSourceDir,Source Directory
pSourceFile,Source File
pTargetCube,Target Cube
pTitleRows,Number of Title Rows to Skip
pDelimiter,Delimiter Character (default=Comma)
pQuote,Quote Character (default=Double Quote)
pDebug,Debug Mode
577,26
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
578,26
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
579,26
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
580,26
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
581,26
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
582,26
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
572,181

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################

# This process will load a CSV text file to the specfied cube

# Notes:
# - The assumed file format is as per standard CMA export
# - v1 specIfies cube name, subsequent fields specify cube address ( individual element names )
# - vN specIfies cell data value to load. With provision for files with header rows


### Constants ###

cProcess = 'Bedrock.Cube.Data.ImportFromFile';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.';


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pSourceDir  : ' | pSourceDir );
  AsciiOutput( sDebugFile, '            pSourceFile : ' | pSourceFile );
  AsciiOutput( sDebugFile, '            pTargetCube : ' | pTargetCube );
  AsciiOutput( sDebugFile, '            pTitleRows  : ' | NumberToString( pTitleRows ) );
  AsciiOutput( sDebugFile, '            pDelimiter  : ' | pDelimiter );
  AsciiOutput( sDebugFile, '            pQuote      : ' | pQuote );

EndIf;


### Validate Parameters ###

nErrors = 0;

# Validate source directory
If( SubSt( pSourceDir, Long( pSourceDir ) - 1, 1 ) @= '\' );
  pSourceDir = SubSt( pSourceDir, 1, Long( pSourceDir ) - 1 );
EndIf;
If( FileExists( pSourceDir ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid source directory specified: folder does not exist.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate source file
If( Trim( pSourceFile ) @= '' );
  nErrors = 1;
  sMessage = 'Invalid source file specfied: file name is blank.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

sFile = pSourceDir | '\' | pSourceFile;
If( FileExists( sFile ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid source file specfied: file does not exist in directory.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate cube
If( CubeExists( pTargetCube ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid target cube specfied: ' | pTargetCube;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate delimiter
If( pDelimiter @= '' );
  pDelimiter = ',';
EndIf;
If( Long( pDelimiter ) > 1 );
  nErrors = 1;
  sMessage = 'Invalid delimiter specfied: ' | pDelimiter | ' field delimiter must be single character.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate quote character
If( pQuote @= '' );
  pQuote = '"';
EndIf;
If( Long( pQuote ) > 1 );
  nErrors = 1;
  sMessage = 'Invalid string qualIfier: ' | pQuote | ' quote character must be single character.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;


### Determine number of dims in target cube ###

nDimensionCount = 0;
While( TabDim( pTargetCube, nDimensionCount + 1 ) @<> '' );
  nDimensionCount = nDimensionCount + 1;
End;

If( nDimensionCount > 24 );
  nErrors = 1;
  sMessage = 'Cube has too many dimensions: ' | pTargetCube | ' max 24 dims catered for, TI must be altered to accomodate.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;


### Determine dimensions in target cube, we need to know this to test cell type before loading ###

sDim1 = TabDim( pTargetCube, 1 );
sDim2 = TabDim( pTargetCube, 2 );
sDim3 = TabDim( pTargetCube, 3 );
sDim4 = TabDim( pTargetCube, 4 );
sDim5 = TabDim( pTargetCube, 5 );
sDim6 = TabDim( pTargetCube, 6 );
sDim7 = TabDim( pTargetCube, 7 );
sDim8 = TabDim( pTargetCube, 8 );
sDim9 = TabDim( pTargetCube, 9 );
sDim10 = TabDim( pTargetCube, 10 );
sDim11 = TabDim( pTargetCube, 11 );
sDim12 = TabDim( pTargetCube, 12 );
sDim13 = TabDim( pTargetCube, 13 );
sDim14 = TabDim( pTargetCube, 14 );
sDim15 = TabDim( pTargetCube, 15 );
sDim16 = TabDim( pTargetCube, 16 );
sDim17 = TabDim( pTargetCube, 17 );
sDim18 = TabDim( pTargetCube, 18 );
sDim19 = TabDim( pTargetCube, 19 );
sDim20 = TabDim( pTargetCube, 20 );
sDim21 = TabDim( pTargetCube, 21 );
sDim22 = TabDim( pTargetCube, 22 );
sDim23 = TabDim( pTargetCube, 23 );
sDim24 = TabDim( pTargetCube, 24 );


### Assign Datasource ###

DataSourceType = 'CHARACTERDELIMITED';
DatasourceNameForServer = sFile;
DatasourceNameForClient = sFile;
DatasourceASCIIHeaderRecords = pTitleRows;
DatasourceASCIIDelimiter = pDelimiter;
DatasourceASCIIQuoteCharacter = pQuote;


### End Prolog ###
573,2


574,242

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################

# It would be too exhaustive to error trap elements not existing in dimension for each possible number of dimensions
# If an incorrect source file is specfied for a target cube then the TI will error with standard TI error messages.
# Note: that the assumed file format is standard .cma cube export of Cube, d1, d2, dn, value
# This is equivalent to using the Bedrock.Cube.ExportToFile TI with 'No' selected for 'Include View Name'


### Check for error in prolog ###

If( nErrors > 0 );
  ProcessBreak;
EndIf;


### Write data from source file to target cube ###

If( pDebug <= 1 );

  If( nDimensionCount = 2 );
    If( CellIsUpdateable( pTargetCube, v2, v3 ) = 1 );
      sElType = DType( sDim2, v3 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v4 ), pTargetCube, v2, v3 );
      Else;
        CellPutS( v4, pTargetCube, v2, v3 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 3 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4 ) = 1 );
      sElType = DType( sDim3, v4 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v5 ), pTargetCube, v2, v3, v4 );
      Else;
        CellPutS( v5, pTargetCube, v2, v3, v4 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 4 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5 ) = 1 );
      sElType = DType( sDim4, v5 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v6 ), pTargetCube, v2, v3, v4, v5 );
      Else;
        CellPutS( v6, pTargetCube, v2, v3, v4, v5 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 5 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6 ) = 1 );
      sElType = DType( sDim5, v6 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v7 ), pTargetCube, v2, v3, v4, v5, v6 );
      Else;
        CellPutS( v7, pTargetCube, v2, v3, v4, v5, v6 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 6 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6, v7 ) = 1 );
      sElType = DType( sDim6, v7 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v8 ), pTargetCube, v2, v3, v4, v5, v6, v7 );
      Else;
        CellPutS( v8, pTargetCube, v2, v3, v4, v5, v6, v7 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 7 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6, v7, v8 ) = 1 );
      sElType = DType( sDim7, v8 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v9 ), pTargetCube, v2, v3, v4, v5, v6, v7, v8 );
      Else;
        CellPutS( v9, pTargetCube, v2, v3, v4, v5, v6, v7, v8 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 8 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9 ) = 1 );
      sElType = DType( sDim8, v9 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v10 ), pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9 );
      Else;
        CellPutS( v10, pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 9 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10 ) = 1 );
      sElType = DType( sDim9, v10 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v11 ), pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10 );
      Else;
        CellPutS( v11, pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 10 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 ) = 1 );
      sElType = DType( sDim10, v11 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v12 ), pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 );
      Else;
        CellPutS( v12, pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 11 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 ) = 1 );
      sElType = DType( sDim11, v12 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v13 ), pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 );
      Else;
        CellPutS( v13, pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 12 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 ) = 1 );
      sElType = DType( sDim12, v13 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v14 ), pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 );
      Else;
        CellPutS( v14, pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 13 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 ) = 1 );
      sElType = DType( sDim13, v14 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v15 ), pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 );
      Else;
        CellPutS( v15, pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 14 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 ) = 1 );
      sElType = DType( sDim14, v15 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v16 ), pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 );
      Else;
        CellPutS( v16, pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 15 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 ) = 1 );
      sElType = DType( sDim15, v16 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v17 ), pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 );
      Else;
        CellPutS( v17, pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 16 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 ) = 1 );
      sElType = DType( sDim16, v17 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v18 ), pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 );
      Else;
        CellPutS( v18, pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 17 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 ) = 1 );
      sElType = DType( sDim17, v18 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v19 ), pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 );
      Else;
        CellPutS( v19, pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 18 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 ) = 1 );
      sElType = DType( sDim18, v19 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v20 ), pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 );
      Else;
        CellPutS( v20, pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 19 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 ) = 1 );
      sElType = DType( sDim19, v20 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v21 ), pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 );
      Else;
        CellPutS( v21, pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 20 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 ) = 1 );
      sElType = DType( sDim20, v21 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v22 ), pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 );
      Else;
        CellPutS( v22, pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 21 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 ) = 1 );
      sElType = DType( sDim21, v22 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v23 ), pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 );
      Else;
        CellPutS( v23, pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 22 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 ) = 1 );
      sElType = DType( sDim22, v23 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v24 ), pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 );
      Else;
        CellPutS( v24, pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 23 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
    v23, v24 ) = 1 );
      sElType = DType( sDim23, v24 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v25 ), pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
        v23, v24 );
      Else;
        CellPutS( v25, pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 24 );
    If( CellIsUpdateable( pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
    v23, v24, v25 ) = 1 );
      sElType = DType( sDim24, v25 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v26 ), pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
        v23, v24, v25 );
      Else;
        CellPutS( v26, pTargetCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25 );
      EndIf;
    EndIf;
  EndIf;

EndIf;


### End Data ###
575,35

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


### If errors occurred terminate process with a major error status ###

If( nErrors <> 0 );
  ProcessQuit;
EndIf;


### End Epilog ###
576,CubeAction=1511€DataAction=1503€CubeLogChanges=0€
638,1
804,0
1217,65535
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
