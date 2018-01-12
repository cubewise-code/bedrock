601,100
602,"Bedrock.Cube.Clone"
562,"VIEW"
586,"Bedrock Test"
585,"Bedrock Test"
564,
565,"oy^9]C^:Rt>@@BrapR=C1hWpG;3MzoMT>]OYE7Ra`f7OYnu]Q4p6D90c6usDc^dYYB2xQx?aeZR;fo;:fAk`nGEjfj`??j`O?lYazpGeF3cs;j0LM_<no0tI^aeWy>6TD=ZBcXHnl0E:O3ec;b?[O59J_zmGz\:li>ZMrwxuI[1ql`=aoS?aFT@UJVp5c25>llpLJI@9"
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
571,
569,0
592,0
599,1000
560,7
pSourceCube
pTargetCube
pIncludeRules
pIncludeData
pSourceView
pRuleValues
pDebug
561,7
2
2
1
1
2
1
1
590,7
pSourceCube,""
pTargetCube,""
pIncludeRules,1
pIncludeData,0
pSourceView,""
pRuleValues,1
pDebug,0
637,7
pSourceCube,"Source Cube"
pTargetCube,"Target Cube to create/re-create"
pIncludeRules,"Include cube rules? (Boolean Yes = 1)"
pIncludeData,"Include cube data? (Boolean Yes = 1)"
pSourceView,"Source View (blank = whole cube If pIncludeData=1)"
pRuleValues,"Skip rule values? (1=skip)"
pDebug,"Debug Mode"
577,28
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
V26
V27
V28
578,28
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
579,28
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
580,28
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
581,28
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
582,28
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
572,248

#****Begin: Generated Statements***
#****End: Generated Statements****


#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process replicates an existing cube.
# Option to include data and rules with the creation of the cube.
# If a target cube name is specIfied that already exists in the model the cube will be destroyed and recreated.
# If the target cube is left blank or is the same as the source cube the cloned cube will inherit the source
# cube name with "_Clone" appended.

# Notes:
# - As this TI has a view as a data source it requires the implicit variables NValue, SValue and Value_is_String
# - To edit this TI in Architect a tmp cube with minimum 24 dims is needed as the preview data source or set the data
#   source to ASCII and manually edit the TI in notepad after saving to add back the required implicit view variables


### Constants ###

cProcess = 'Bedrock.Cube.Clone';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pSourceCube   : ' | pSourceCube );
  AsciiOutput( sDebugFile, '            pTargetCube   : ' | pTargetCube );
  AsciiOutput( sDebugFile, '            pIncludeRules : ' | NumberToString( pIncludeRules ) );
  AsciiOutput( sDebugFile, '            pIncludeData  : ' | NumberToString( pIncludeData ) );
  AsciiOutput( sDebugFile, '            pSourceView   : ' | pSourceView );
  AsciiOutput( sDebugFile, '            pRuleValues   : ' | NumberToString( pRuleValues ) );

EndIf;


### Initialise ###

nDataCheck = 0;


### Validate Parameters ###

nErrors = 0;

# Validate source cube
If( pSourceCube @= '' % CubeExists( pSourceCube ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid source cube specified: ' | pSourceCube;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate target cube
If( pTargetCube @= '' % pTargetCube @= pSourceCube );
  pTargetCube = pSourceCube | '_Clone';
EndIf;

# Validate View
If( pIncludeData = 1 & pSourceView @<> '' );
  If( ViewExists( pSourceCube, pSourceView ) = 0 );
    nErrors = 1;
    sMessage = 'Invalid view specified: ' | pSourceView | ' for cube: ' | pSourceCube;
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    DataSourceType = 'NULL';
    ItemReject( sMessage );
  EndIf;
EndIf;


### Determine number of dims in source cube ###

nDimensionCount = 0;
While( TabDim( pSourceCube, nDimensionCount + 1 ) @<> '' );
  nDimensionCount = nDimensionCount + 1;
End;

If( nDimensionCount > 27 );
  nErrors = 1;
  sMessage = 'Cube has too many dimensions: ' | pSourceCube | ' max 27 dims catered for, TI must be altered to accomodate.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;


### Check to see if target cube exists ###

If( CubeExists( pTargetCube ) = 1 );
  If( pDebug <= 1 );
    CubeDestroy( pTargetCube );
  EndIf;
EndIf;


### Determine dimensions in source cube ###

sDim1 = TabDim( pSourceCube, 1 );
sDim2 = TabDim( pSourceCube, 2 );
sDim3 = TabDim( pSourceCube, 3 );
sDim4 = TabDim( pSourceCube, 4 );
sDim5 = TabDim( pSourceCube, 5 );
sDim6 = TabDim( pSourceCube, 6 );
sDim7 = TabDim( pSourceCube, 7 );
sDim8 = TabDim( pSourceCube, 8 );
sDim9 = TabDim( pSourceCube, 9 );
sDim10 = TabDim( pSourceCube, 10 );
sDim11 = TabDim( pSourceCube, 11 );
sDim12 = TabDim( pSourceCube, 12 );
sDim13 = TabDim( pSourceCube, 13 );
sDim14 = TabDim( pSourceCube, 14 );
sDim15 = TabDim( pSourceCube, 15 );
sDim16 = TabDim( pSourceCube, 16 );
sDim17 = TabDim( pSourceCube, 17 );
sDim18 = TabDim( pSourceCube, 18 );
sDim19 = TabDim( pSourceCube, 19 );
sDim20 = TabDim( pSourceCube, 20 );
sDim21 = TabDim( pSourceCube, 21 );
sDim22 = TabDim( pSourceCube, 22 );
sDim23 = TabDim( pSourceCube, 23 );
sDim24 = TabDim( pSourceCube, 24 );
sDim25 = TabDim( pSourceCube, 25 );
sDim26 = TabDim( pSourceCube, 26 );
sDim27 = TabDim( pSourceCube, 27 );

### Create target cube ###

If( pDebug <= 1 );

  If( nDimensionCount = 2 );
    CubeCreate( pTargetCube, sDim1, sDim2 );
  ElseIf( nDimensionCount = 3 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3 );
  ElseIf( nDimensionCount = 4 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4 );
  ElseIf( nDimensionCount = 5 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5 );
  ElseIf( nDimensionCount = 6 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6 );
  ElseIf( nDimensionCount = 7 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7 );
  ElseIf( nDimensionCount = 8 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8 );
  ElseIf( nDimensionCount = 9 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9 );
  ElseIf( nDimensionCount = 10 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10 );
  ElseIf( nDimensionCount = 11 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11 );
  ElseIf( nDimensionCount = 12 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12 );
  ElseIf( nDimensionCount = 13 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13 );
  ElseIf( nDimensionCount = 14 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14 );
  ElseIf( nDimensionCount = 15 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15 );
  ElseIf( nDimensionCount = 16 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16 );
  ElseIf( nDimensionCount = 17 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16,
                sDim17 );
  ElseIf( nDimensionCount = 18 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16,
                sDim17, sDim18 );
  ElseIf( nDimensionCount = 19 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16,
                sDim17, sDim18, sDim19 );
  ElseIf( nDimensionCount = 20 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16,
                sDim17, sDim18, sDim19, sDim20 );
  ElseIf( nDimensionCount = 21 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16,
                sDim17, sDim18, sDim19, sDim20, sDim21 );
  ElseIf( nDimensionCount = 22 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16,
                sDim17, sDim18, sDim19, sDim20, sDim21, sDim22 );
  ElseIf( nDimensionCount = 23 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16,
                sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23 );
  ElseIf( nDimensionCount = 24 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16,
                sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24 );
  ElseIf( nDimensionCount = 25 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16,
                sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25 );
  ElseIf( nDimensionCount = 26 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16,
                sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26 );
  ElseIf( nDimensionCount = 27 );
    CubeCreate( pTargetCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16,
                sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27 );
  EndIf;

EndIf;


### Assign Datasource ###

If( pIncludeData = 1 );

  DataSourceType = 'VIEW';
  DatasourceNameForServer = pSourceCube;
  DatasourceNameForClient = pSourceCube;
  NValue = 0;
  SValue = '0';
  Value_is_String = 0;

  sSourceView = pSourceView;
  If( sSourceView @= '' );
    sSourceView = '}' | cProcess;
    If( ViewExists( pSourceCube, sSourceView ) = 0 );
      ViewCreate( pSourceCube, sSourceView );
    EndIf;
  EndIf;

  ViewExtractSkipCalcsSet( pSourceCube, sSourceView, 1 );
  ViewExtractSkipRuleValuesSet( pSourceCube, sSourceView, pRuleValues );
  ViewExtractSkipZeroesSet( pSourceCube, sSourceView, 1 );
  DatasourceCubeView = sSourceView;
Else;
  nDataCheck = nDataCheck + 1;
  DataSourceType = 'NULL';
EndIf;


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,228

#****Begin: Generated Statements***
#****End: Generated Statements****


#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################


### Check for error in prolog ###

If( nErrors > 0 );
  ProcessBreak;
EndIf;


### Check whether only cube structure being copied or also cube data ###

If( pIncludeData = 0 );
  ProcessBreak;
EndIf;


### Write data from source cube to target cube ###

# Selects the correct CellPut formula depending upon the number of dimensions in the cube
# and whether the value is numeric or string ( max 24 dims catered for in this code )
# value type determined by element type of last dimension in cube

If( pDebug <= 1 );

  If( nDimensionCount = 2 );
    sElType = DType( sDim2, v2 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v3 ), pTargetCube, v1, v2 );
    Else;
      CellPutS( v3, pTargetCube, v1, v2 );
    EndIf;
  ElseIf( nDimensionCount = 3 );
    sElType = DType( sDim3, v3 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v4 ), pTargetCube, v1, v2, v3 );
    Else;
      CellPutS( v4, pTargetCube, v1, v2, v3 );
    EndIf;
  ElseIf( nDimensionCount = 4 );
    sElType = DType( sDim4, v4 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v5 ), pTargetCube, v1, v2, v3, v4 );
    Else;
      CellPutS( v5, pTargetCube, v1, v2, v3, v4 );
    EndIf;
  ElseIf( nDimensionCount = 5 );
    sElType = DType( sDim5, v5 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v6 ), pTargetCube, v1, v2, v3, v4, v5 );
    Else;
      CellPutS( v6, pTargetCube, v1, v2, v3, v4, v5 );
    EndIf;
  ElseIf( nDimensionCount = 6 );
    sElType = DType( sDim6, v6 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v7 ), pTargetCube, v1, v2, v3, v4, v5, v6 );
    Else;
      CellPutS( v7, pTargetCube, v1, v2, v3, v4, v5, v6 );
    EndIf;
  ElseIf( nDimensionCount = 7 );
    sElType = DType( sDim7, v7 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v8 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7 );
    Else;
      CellPutS( v8, pTargetCube, v1, v2, v3, v4, v5, v6, v7 );
    EndIf;
  ElseIf( nDimensionCount = 8 );
    sElType = DType( sDim8, v8 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v9 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8 );
    Else;
      CellPutS( v9, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8 );
    EndIf;
  ElseIf( nDimensionCount = 9 );
    sElType = DType( sDim9, v9 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v10 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9 );
    Else;
      CellPutS( v10, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9 );
    EndIf;
  ElseIf( nDimensionCount = 10 );
    sElType = DType( sDim10, v10 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v11 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 );
    Else;
      CellPutS( v11, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 );
    EndIf;
  ElseIf( nDimensionCount = 11 );
    sElType = DType( sDim11, v11 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v12 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 );
    Else;
      CellPutS( v12, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 );
    EndIf;
  ElseIf( nDimensionCount = 12 );
    sElType = DType( sDim12, v12 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v13 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 );
    Else;
      CellPutS( v13, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 );
    EndIf;
  ElseIf( nDimensionCount = 13 );
    sElType = DType( sDim13, v13 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v14 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 );
    Else;
      CellPutS( v14, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 );
    EndIf;
  ElseIf( nDimensionCount = 14 );
    sElType = DType( sDim14, v14 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v15 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 );
    Else;
      CellPutS( v15, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 );
    EndIf;
  ElseIf( nDimensionCount = 15 );
    sElType = DType( sDim15, v15 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v16 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 );
    Else;
      CellPutS( v16, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 );
    EndIf;
  ElseIf( nDimensionCount = 16 );
    sElType = DType( sDim16, v16 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v17 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 );
    Else;
      CellPutS( v17, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 );
    EndIf;
  ElseIf( nDimensionCount = 17 );
    sElType = DType( sDim17, v17 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v18 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 );
    Else;
      CellPutS( v18, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 );
    EndIf;
  ElseIf( nDimensionCount = 18 );
     sElType = DType( sDim18, v18 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v19 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 );
    Else;
      CellPutS( v19, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 );
    EndIf;
  ElseIf( nDimensionCount = 19 );
     sElType = DType( sDim19, v19 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v20 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 );
    Else;
      CellPutS( v20, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 );
    EndIf;
  ElseIf( nDimensionCount = 20 );
     sElType = DType( sDim20, v20 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v21 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 );
    Else;
      CellPutS( v21, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 );
    EndIf;
  ElseIf( nDimensionCount = 21 );
     sElType = DType( sDim21, v21 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v22 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 );
    Else;
      CellPutS( v22, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 );
    EndIf;
  ElseIf( nDimensionCount = 22 );
     sElType = DType( sDim22, v22 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v23 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 );
    Else;
      CellPutS( v23, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 );
    EndIf;
  ElseIf( nDimensionCount = 23 );
     sElType = DType( sDim23, v23 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v24 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
      v23 );
    Else;
      CellPutS( v24, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 );
    EndIf;
  ElseIf( nDimensionCount = 24 );
     sElType = DType( sDim24, v24 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v25 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
      v23, v24 );
    Else;
      CellPutS( v25, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24 );
    EndIf;
  ElseIf( nDimensionCount = 25 );
     sElType = DType( sDim25, v26 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v26 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
      v23, v24, v25 );
    Else;
      CellPutS( v26, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24,
            v25 );
    EndIf;
  ElseIf( nDimensionCount = 26 );
     sElType = DType( sDim26, v27 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v27 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
      v23, v24, v25, v26 );
    Else;
      CellPutS( v27, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24,
      v25, v26 );
    EndIf;
  ElseIf( nDimensionCount = 27 );
     sElType = DType( sDim27, v28 );
    If( sElType @<> 'S' );
      CellPutN( Numbr( v28 ), pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
      v23, v24, v25, v26, v27 );
    Else;
      CellPutS( v28, pTargetCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24,
      v25, v26 );
    EndIf;

  EndIf;
EndIf;


### End Data ###
575,62

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


### Attach rules to cloned cube ###

If( nErrors = 0 & pIncludeRules = 1 );
  sRuleFile = pSourceCube | '.rux';
  If( FileExists( sRuleFile ) = 1 );
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, 'Rules file found' );
    EndIf;
    If( pDebug <= 1 );
      RuleLoadFromFile( pTargetCube, sRuleFile );
    EndIf;
  Else;
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, 'Cannot attach rule.  No rules exist in source cube: ' | pSourceCube );
    EndIf;
  EndIf;
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
