601,100
602,"Bedrock.Cube.Data.ViewExportToFile"
562,"VIEW"
586,"placeholder"
585,"placeholder"
564,
565,"c?Ta6I7`Dob3RXM;5MT`5?POa1G]fhgOko]vdPGlT<C]>[Tbidsb]Bzx^cnFdj?0zhMWs@seCyA;r]a=X^Jk\F7EeGxpHEr?zmUSN:L4ESwoiXMqTaCcT6zbsim5E0C^OavwGrOx>:C>1JPxkJtbNlrvTO9PLD0c9VWWdXMJ0zGST^LKc;hP0Fg_ukP2Si;rCoN3hTUV"
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
570,placeholderView
571,
569,0
592,0
599,1000
560,9
pCube
pExportPath
pExportFile
pView
pSkipRuleValues
pSkipCalcValues
pSkipNullValues
pTitleRecord
pDebug
561,9
2
2
2
2
1
1
1
1
1
590,9
pCube,""
pExportPath,""
pExportFile,""
pView,""
pSkipRuleValues,1
pSkipCalcValues,1
pSkipNullValues,1
pTitleRecord,1
pDebug,0
637,9
pCube,"Source Cube"
pExportPath,"Export File Path (Defaults to Logging Directory if Left Blank)"
pExportFile,"If Blank Will Default to cube.view.export.csv"
pView,"Source View (Blank = Whole Cube)"
pSkipRuleValues,"Skip Rule Values? (Boolean 1=skip)"
pSkipCalcValues,"Skip Consol Values? (Boolean 1=skip)"
pSkipNullValues,"Skip Zero Values? (Boolean 1=skip)"
pTitleRecord,"Include Title Record in Export File? (Boolean 1=Yes)"
pDebug,"Debug Mode"
577,31
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
Value
578,31
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
2
579,31
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
31
580,31
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
0
581,31
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
0
582,31
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
VarType=32ColType=827
603,0
572,181

#****Begin: Generated Statements***
#****End: Generated Statements****




#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This cube exports data from the specified cube to an ASCII file.

# Note:
# - As this TI has a view as a data source it requires the implicit variables NValue, SValue and Value_is_String
# - To edit this TI in Architect a tmp cube with minimum 24 dims is needed as the preview data source or set the data
#   source to ASCII and manually edit the TI in notepad after saving to add back the required implicit view variables

### Constants ###

cProcess = 'Bedrock.Cube.Data.ViewExportToFile';
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
  AsciiOutput( sDebugFile, 'Parameters: pCube           : ' | pCube );
  AsciiOutput( sDebugFile, '            pExportPath     : ' | pExportPath );
  AsciiOutput( sDebugFile, '            pExportFile     : ' | pExportFile );
  AsciiOutput( sDebugFile, '            pView           : ' | pView );
  AsciiOutput( sDebugFile, '            pSkipRuleValues : ' | NumberToString( pSkipRuleValues ) );
  AsciiOutput( sDebugFile, '            pSkipCalcValues : ' | NumberToString( pSkipCalcValues ) );
  AsciiOutput( sDebugFile, '            pSkipNullValues : ' | NumberToString( pSkipNullValues ) );
  AsciiOutput( sDebugFile, '            pTitleRecord    : ' | NumberToString( pTitleRecord ) );

EndIf;


### Validate Parameters ###

nErrors = 0;
nRecordCount = 0;

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

# Validate view
If( pView @<> ''  & ViewExists( pCube, pView ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid view specified: ' | pCube | ', ' | pView | '. View does not exist.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate export path
If( Trim( pExportPath ) @= '' );
  pExportPath = SubSt( GetProcessErrorFileDirectory, 1, Long( GetProcessErrorFileDirectory )- 1 );
ElseIf( FileExists( pExportPath ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid export path specified. Folder does not exist.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate export file
If( pExportFile @= '' );
  If( pView @= '' );
    sView = 'All';
  Else;
    sView = pView;
  EndIf;
  pExportFile = pCube |'.'| sView | '.Export.csv';
Else;
  If( Scan( '.', pExportFile ) = 0 );
    # No file extension specified
    pExportFile = pExportFile | '.csv';
  EndIf;
EndIf;

If( SubSt( pExportPath, Long( pExportPath ), 1 ) @<> '\' );
  pExportPath = pExportPath | '\';
EndIf;
sFile = pExportPath | pExportFile;


### Determine number of dims in source cube ###

nNumDims = 0;
While( TabDim( pCube, nNumDims + 1 ) @<> '' );
  nNumDims = nNumDims + 1;
End;

If( nNumDims > 24 );
  nErrors = 1;
  sMessage = 'Cube has too many dimensions: ' | pCube | ' max 24 dims catered for, TI must be altered to accomodate.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;


### Determine dimensions in source cube (used only in export title row) ###

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


### Assign Datasource ###

NValue = 0;
SValue = '0';
Value_is_String = 0;

If( pView @= '' );
  # Create view
  pView = '}' | cProcess;
  If( ViewExists( pCube, pView ) = 0 );
    ViewCreate( pCube, pView );
  EndIf;
EndIf;

DataSourceType = 'VIEW';
DatasourceNameForServer = pCube;
DatasourceNameForClient = pCube;
DatasourceCubeView = pView;

ViewExtractSkipCalcsSet( pCube, pView, pSkipCalcValues );
ViewExtractSkipRuleValuesSet( pCube, pView, pSkipRuleValues );
ViewExtractSkipZeroesSet( pCube, pView, pSkipNullValues );


### End Prolog ###
573,6

#****Begin: Generated Statements***
#****End: Generated Statements****



574,168

#****Begin: Generated Statements***
#****End: Generated Statements****




#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################


### Check for error in prolog ###

If( nErrors <> 0 );
  ProcessBreak;
EndIf;


If( pDebug <= 1 );

  ### Check whether to write title records ###

  nRecordCount = nRecordCount + 1;

  If( nRecordCount = 1 & pTitleRecord = 1 );

    If( pSkipCalcValues = 1 );
      sExportCond = ' SkipCalcs=True ';
    Else;
      sExportCond = ' SkipCalcs=False ';
    EndIf;

    If( pSkipRuleValues = 1 );
      sExportCond = sExportCond | 'SkipRules=True ';
    Else;
      sExportCond = sExportCond | 'SkipRules=False ';
    EndIf;

    If( pSkipNullValues = 1 );
      sExportCond = sExportCond | 'SkipNull=True';
    Else;
      sExportCond = sExportCond | 'SkipNull=False';
    EndIf;

    AsciiOutput( sFile, 'Export from cube: ' | pCube | ' view: ' | pView | '. On ' | DATE( NOW, 1 ) | ' at ' | TIME | sExportCond );

    If( nNumDims = 2 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, 'Value' );
    ElseIf( nNumDims = 3 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, 'Value' );
    ElseIf( nNumDims = 4 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, 'Value' );
    ElseIf( nNumDims = 5 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, 'Value' );
    ElseIf( nNumDims = 6 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, 'Value' );
    ElseIf( nNumDims = 7 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, 'Value' );
    ElseIf( nNumDims = 8 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, 'Value' );
    ElseIf( nNumDims = 9 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, 'Value' );
    ElseIf( nNumDims = 10 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, 'Value' );
    ElseIf( nNumDims = 11 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, 'Value' );
    ElseIf( nNumDims = 12 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, 'Value' );
    ElseIf( nNumDims = 13 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, 'Value' );
    ElseIf( nNumDims = 14 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13,
                   sDim14, 'Value' );
    ElseIf( nNumDims = 15 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13,
                   sDim14, sDim15, 'Value' );
    ElseIf( nNumDims = 16 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13,
                   sDim14, sDim15, sDim16, 'Value' );
    ElseIf( nNumDims = 17 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13,
                   sDim14, sDim15, sDim16, sDim17, 'Value' );
    ElseIf( nNumDims = 18 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13,
                   sDim14, sDim15, sDim16, sDim17, sDim18, 'Value' );
    ElseIf( nNumDims = 19 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13,
                   sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, 'Value' );
    ElseIf( nNumDims = 20 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13,
                   sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, 'Value' );
    ElseIf( nNumDims = 21 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13,
                   sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, 'Value' );
    ElseIf( nNumDims = 22 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13,
                   sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, 'Value' );
    ElseIf( nNumDims = 23 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13,
                   sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, 'Value' );
    ElseIf( nNumDims = 24 );
      AsciiOutput( sFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13,
                   sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, 'Value' );
    EndIf;
  EndIf;


  ### Write data from source cube to export file ###

  # Selects the correct AsciiOutput formula depending upon the number of dimensions in the cube

  If( nNumDims = 2 );
    AsciiOutput( sFile, pCube, v1, v2, SValue );
  ElseIf( nNumDims = 3 );
    AsciiOutput( sFile, pCube, v1, v2, v3, SValue );
  ElseIf( nNumDims = 4 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, SValue );
  ElseIf( nNumDims = 5 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, SValue );
  ElseIf( nNumDims = 6 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, v6, SValue );
  ElseIf( nNumDims = 7 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, v6, v7, SValue );
  ElseIf( nNumDims = 8 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, SValue );
  ElseIf( nNumDims = 9 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, SValue );
  ElseIf( nNumDims = 10 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, SValue );
  ElseIf( nNumDims = 11 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, SValue );
  ElseIf( nNumDims = 12 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, SValue );
  ElseIf( nNumDims = 13 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, SValue );
  ElseIf( nNumDims = 14 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, SValue );
  ElseIf( nNumDims = 15 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, SValue );
  ElseIf( nNumDims = 16 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, SValue );
  ElseIf( nNumDims = 17 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, SValue );
  ElseIf( nNumDims = 18 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, SValue );
  ElseIf( nNumDims = 19 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, SValue );
  ElseIf( nNumDims = 20 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, SValue );
  ElseIf( nNumDims = 21 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21,
                 SValue );
  ElseIf( nNumDims = 22 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21,
                 v22, SValue );
  ElseIf( nNumDims = 23 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21,
                 v22, v23, SValue );
  ElseIf( nNumDims = 24 );
    AsciiOutput( sFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21,
                 v22, v23, v24, SValue );
  EndIf;

EndIf;


### End Data ###
575,38

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
