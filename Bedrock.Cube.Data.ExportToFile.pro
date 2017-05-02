601,100
562,"VIEW"
586,"myCube"
585,"myCube"
564,
565,"q4Bvx1CLLr4MVV`wGaDvq3d>n57kC5h^ktqe_uF<uc<o`BDwNAy[6^FGNosH;9YYYfSO@WKbh`J:vwt]vOk1AbyL`XJ_=fgv9r5KVt?gP]YHZymFy]Lbsu>wpx_uyXGJ;IhL9=v^OyvDi6_rs3fZBwtwpGRYYo6t3AyoLXnnSGpd[A7sjVLTYja4y[Y=0kD<fAIPQD\I"
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
570,z_TI_View
571,
569,0
592,0
599,1000
560,8
pCube
pDimension
pElement
pFilePath
pFileName
pSkipRules
pZeroSource
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
pCube,""
pDimension,""
pElement,""
pFilePath,""
pFileName,""
pSkipRules,1.
pZeroSource,0.
pDebug,0.
637,8
pCube,Cube
pDimension,Dimension
pElement,Element to Export Data From
pFilePath,Export Directory
pFileName,Export Filename (If Left Blank Defaults to cube_dim_ele_export.csv)
pSkipRules,Skip Rule Values? (1=Skip)
pZeroSource,Zero Out Element AFTER Copy? (Boolean 1=True)
pDebug,Debug Mode
577,25
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
578,25
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
579,25
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
580,25
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
581,25
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
582,25
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
572,191



#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################

# This TI is designed to copy all data in a given cube to a file for a given "element"
# (could be any dimension/element combination)

# Note:
# - As this TI has a view as a data source it requires the implicit variables NValue, SValue and Value_is_String
# - To edit this TI without VIZIER either a temp cube with 24 dims is needed as the preview data source or set the data
#   source to ASCII and manually edit the TI in notepad after saving to add back the required implicit view variables


### Constants ###

cProcess = 'Bedrock.Cube.Data.ExportToFile';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.';


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCube       : ' | pCube );
  AsciiOutput( sDebugFile, '            pDimension  : ' | pDimension );
  AsciiOutput( sDebugFile, '            pElement    : ' | pElement );
  AsciiOutput( sDebugFile, '            pFilePath   : ' | pFilePath );
  AsciiOutput( sDebugFile, '            pFileName   : ' | pFileName );
  AsciiOutput( sDebugFile, '            pSkipRules  : ' | NumberToString( pSkipRules ) );
  AsciiOutput( sDebugFile, '            pZeroSource : ' | NumberToString( pZeroSource ) );

EndIf;


### Validate Parameters ###

nErrors = 0;

# Validate cube
If( CubeExists( pCube ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid source cube specified: ' | pCube;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate dimension
If( DimensionExists( pDimension ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dimension specified: ' | pDimension;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

If( DimIx( pDimension, pElement ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid element specified: ' | pElement;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate file path
If( Trim( pFilePath ) @= '' );
  pFilePath = GetProcessErrorFileDirectory;
Else;
  If( SubSt( pFilePath, Long( pFilePath ), 1 ) @= '\' );
    pFilePath = SubSt( pFilePath, 1, Long( pFilePath ) -1 );
  EndIf;
  If( FileExists( pFilePath ) = 0 );
    nErrors = 1;
    sMessage = 'Invalid export directory: ' | pFilePath;
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    DataSourceType = 'NULL';
    ItemReject( sMessage );
  EndIf;
  pFilePath = pFilePath | '\';
EndIf;

# Validate file name
If( pFileName @= '' );
  pFileName = pCube |'.'| pDimension |'.'| pElement | '.Export.csv';
EndIf;

cExportFile = pFilePath | pFileName;
If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'Export file: ' | cExportFile );
EndIf;


### Determine number of dims in source cube & check that version dimension exists in cube ###

nCount = 1;
nDimensionIndex = 0;
While( TabDim( pCube, nCount ) @<> '' );
  sDimension = TabDim( pCube, nCount );
  If( sDimension @= pDimension );
    nDimensionIndex = nCount;
  EndIf;
  nCount = nCount + 1;
End;
nDimensionCount = nCount - 1;

If( nDimensionIndex = 0 );
  nErrors = 1;
  sMessage = 'Specified dimension: ' | pDimension | ' is not a component of the target cube: ' | pCube;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

If( nDimensionCount > 24 );
  nErrors = 1;
  sMessage = 'Cube has too many dimensions: ' | pCube | ' max 24 dims catered for, TI must be altered to accomodate.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;


### Debug ###

If( pDebug >= 1 );
  AsciiOutput(
    sDebugFile,
    'Dimension "' | pDimension | '" index.', NumberToString( nDimensionIndex ),
    'Number of dimensions in ' | pCube | ' cube.', NumberToString( nDimensionCount )
  );
  AsciiOutput( sDebugFile, 'Source element: ' | pElement );
EndIf;


### Create Processing View for source version ###

cTempViewFrom = '}' | cProcess | '.' | NumberToString( Int( Rand() * 100000 ) );
cTempSubFrom = cTempViewFrom;

If( ViewExists( pCube, cTempViewFrom ) = 0 );
  ViewCreate( pCube, cTempViewFrom );
EndIf;
If( SubsetExists( pDimension, cTempSubFrom ) = 0 );
  SubsetCreate( pDimension, cTempSubFrom );
EndIf;
SubsetElementInsert( pDimension, cTempSubFrom, pElement, 1 );

ViewSubsetAssign( pCube, cTempViewFrom, pDimension, cTempSubFrom );

# If skip rules not 0 or 1 then set to 1 ( =skip )
If( pSkipRules <> 0 & pSkipRules <> 1 );
  pSkipRules = 1;
EndIf;

ViewExtractSkipCalcsSet( pCube, cTempViewFrom, 1 );
ViewExtractSkipRuleValuesSet( pCube, cTempViewFrom, pSkipRules );
ViewExtractSkipZeroesSet( pCube, cTempViewFrom, 1 );


### Assign Datasource ###

DataSourceType = 'VIEW';
DatasourceNameForServer = pCube;
DatasourceNameForClient = pCube;
DatasourceCubeView = cTempViewFrom;


### End Prolog ###
573,2


574,69



#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################


### Check for error in prolog ###

If( nErrors > 0 );
  ProcessBreak;
EndIf;


### Export data from source version to file ###

# Selects the correct AsciiOutput formula depending upon the number of dimensions in the cube

If( nDimensionCount = 2 );
  AsciiOutput( cExportFile, pCube, v1, v2, sValue );
ElseIf( nDimensionCount = 3 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, sValue );
ElseIf( nDimensionCount = 4 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, sValue );
ElseIf( nDimensionCount = 5 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, sValue );
ElseIf( nDimensionCount = 6 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, sValue );
ElseIf( nDimensionCount = 7 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, sValue );
ElseIf( nDimensionCount = 8 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, sValue );
ElseIf( nDimensionCount = 9 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, sValue );
ElseIf( nDimensionCount = 10 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, sValue );
ElseIf( nDimensionCount = 11 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, sValue );
ElseIf( nDimensionCount = 12 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, sValue );
ElseIf( nDimensionCount = 13 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, sValue );
ElseIf( nDimensionCount = 14 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, sValue );
ElseIf( nDimensionCount = 15 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, sValue );
ElseIf( nDimensionCount = 16 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, sValue );
ElseIf( nDimensionCount = 17 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, sValue );
ElseIf( nDimensionCount = 18 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, sValue );
ElseIf( nDimensionCount = 19 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, sValue );
ElseIf( nDimensionCount = 20 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, sValue );
ElseIf( nDimensionCount = 21 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, sValue );
ElseIf( nDimensionCount = 22 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, sValue );
ElseIf( nDimensionCount = 23 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, sValue );
ElseIf( nDimensionCount = 24 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, sValue );
EndIf;


### End Data ###
575,53



#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';

EndIf;


### Delete source data ###

If( pDebug <= 1 & nErrors = 0 & pZeroSource = 1 );

  nOldCubeLogChanges = CubeGetLogChanges( pCube );
  CubeSetLogChanges( pCube, 0 );
  ViewZeroOut( pCube, cTempViewFrom );
  CubeSetLogChanges( pCube, nOldCubeLogChanges );

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
576,CubeAction=1511€DataAction=1503€CubeLogChanges=0€
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
