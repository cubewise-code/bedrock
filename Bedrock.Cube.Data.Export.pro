601,100
602,"Bedrock.Cube.Data.Export"
562,"VIEW"
586,"Bedrock Test"
585,"Bedrock Test"
564,
565,"fFNugDan[8Rt7?uLzE8_TyqfjasfmMAGLXnRoreb=VyLI`r3nju>S\nZZa8_F99IFErO[2ZKQMnp98R8E>I_;^n]\nWUu=<l5T<ky5iP5?p@XR0e@orWJ9AQyt5=t6M\1hnkR_=xoFe@wyL]q3MHK\VDoAMU2bnmt]Qo_q^:y^BlxK3a;uWtc@UacW7Oyf9^XIffj4Ds"
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
560,13
pCube
pView
pFilter
pDimensionDelim
pElementStartDelim
pElementDelim
pSkipRules
pSkipCons
pZeroSource
pDestroyTempObj
pFilePath
pFileName
pDebug
561,13
2
2
2
2
2
2
1
1
1
1
2
2
1
590,13
pCube,""
pView,""
pFilter,""
pDimensionDelim,"&"
pElementStartDelim,":"
pElementDelim,"+"
pSkipRules,1
pSkipCons,1
pZeroSource,0
pDestroyTempObj,1
pFilePath,""
pFileName,""
pDebug,0
637,13
pCube,"Cube"
pView,"Temporary view name"
pFilter,"Filter: Year: 2006 + 2007 & Scenario: Actual + Budget & Organization: North America Operations"
pDimensionDelim,"Delimiter between dimensions"
pElementStartDelim,"Delimiter for start of element list"
pElementDelim,"Delimiter between elements"
pSkipRules,"Skip Rule Values? (1=Skip)"
pSkipCons,"Skip Consolidted Values? (1=Skip)"
pZeroSource,"Zero Out view AFTER Copy? (Boolean 1=True)"
pDestroyTempObj,"Retain temporary view and Subset ( 0 = Retain View and Subsets 1 = Delete View and Subsets 2 = Delete View only )"
pFilePath,"Export Directory"
pFileName,"Export Filename (If Left Blank Defaults to cube_dim_ele_export.csv)"
pDebug,"Debug Mode"
577,34
V1
V2
V3
V4
V5
V6
V7
V8
V9
V10
V11
V12
V13
V14
V15
V16
V17
V18
V19
V20
V21
V22
V23
V24
V25
V26
V27
V28
V29
V30
Value
NVALUE
SVALUE
VALUE_IS_STRING
578,34
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
1
2
1
579,34
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
0
0
0
580,34
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
0
0
0
581,34
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
572,202

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.0.2~~##
#####################################################################################

# This TI is designed to copy all data in a given cube to a file for a given "element"
# (could be any dimension/element combination)

# Note:
# - As this TI has a view as a data source it requires the implicit variables NValue, SValue and Value_is_String
# - To edit this TI without VIZIER either a temp cube with 27 dims is needed as the preview data source or set the data
#   source to ASCII and manually edit the TI in notepad after saving to add back the required implicit view variables


### Constants ###

cProcess = 'Bedrock.Cube.Data.Export';
cUser = TM1User();
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;
cDefaultView = 'Bedrock_' | sRandomInt ;
nDataCount = 0;

### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  AsciiOutput( sDebugFile, 'TM1 User:        ' | cUser );
  AsciiOutput( sDebugFile, '' );
  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCube:              ' | pCube );
  AsciiOutput( sDebugFile, '            pView:              ' | pView );
  AsciiOutput( sDebugFile, '            pFilter:            ' | pFilter );
  AsciiOutput( sDebugFile, '            pDimensionDelim:    ' | pDimensionDelim );
  AsciiOutput( sDebugFile, '            pElementStartDelim: ' | pElementStartDelim );
  AsciiOutput( sDebugFile, '            pElementDelim:      ' | pElementDelim );
  AsciiOutput( sDebugFile, '            pSkipCons:          ' | NumberToString( pSkipCons ) );
  AsciiOutput( sDebugFile, '            pSkipRules:         ' | NumberToString( pSkipRules ) );
  AsciiOutput( sDebugFile, '            pZeroSource:        ' | NumberToString( pZeroSource ) );
  AsciiOutput( sDebugFile, '            pDestroyTempObj:     ' | NumberToString( pDestroyTempObj ) );
  AsciiOutput( sDebugFile, '            pFilePath:          ' | pFilePath );
  AsciiOutput( sDebugFile, '            pFileName:          ' | pFileName );
  AsciiOutput( sDebugFile, '' );

  AsciiOutput( sDebugFile, 'Temporary View Name : ' | cDefaultView );
  AsciiOutput( sDebugFile, '' );
EndIf;


### Validate Parameters ###

# Validate cube
If(
CubeExists( pCube ) = 0 );
  If( pDebug >= 1 );
    sMessage = 'Invalid cube specified: ' | pCube;
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

## Validate the View parameter
If( TRIM(pView) @= '' );
  If( pDebug >= 1 );
    sMessage = 'Using default view: ' | cDefaultView;
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  cView = cDefaultView ;
Else ;
  If( pDebug >= 1 );
    sMessage = 'Using view: ' | pView;
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  cView = pView ;
EndIf;

# Validate file path
If(
Trim( pFilePath ) @= '' );
  pFilePath = GetProcessErrorFileDirectory;
Else;
  If(
  SubSt( pFilePath, Long( pFilePath ), 1 ) @= '\' );
    pFilePath = SubSt( pFilePath, 1, Long( pFilePath ) -1 );
  EndIf;
  If(
  FileExists( pFilePath ) = 0 );
   If( pDebug >= 1 );
     sMessage = 'Invalid export directory: ' | pFilePath;
     AsciiOutput( sDebugFile, sMessage );
   EndIf;
   ProcessQuit;
  EndIf;
  pFilePath = pFilePath | '\';
EndIf;

# Validate file name
If( pFileName @= '' );
  pFileName = pCube | '_Export.csv';
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
  nCount = nCount + 1;
End;
nDimensionCount = nCount - 1;

If( nDimensionCount > 27 );
  sMessage = 'Cube has too many dimensions: ' | pCube | '. Max of 27 dimensions.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

If( pDebug >= 1 );
  sMessage = 'Number of dimensions in the cube: ' | pCube | ': ' | NumberToString( nDimensionCount );
  AsciiOutput( sDebugFile, sMessage );
EndIf;

### Create Processing View for source version ###
If( pDebug <= 1 );
nRet = ExecuteProcess('Bedrock.Cube.View.Create',
  'pCube', pCube,
  'pView', cView,
  'pFilter', pFilter,
  'pSuppressZero', 1,
  'pSuppressConsol', pSkipCons,
  'pSuppressRules', pSkipRules,
  'pDimensionDelim', pDimensionDelim,
  'pElementStartDelim', pElementStartDelim,
  'pElementDelim', pElementDelim,
  'pDebug', pDebug);

  IF(
  nRet <> 0);
    If( pDebug >= 1 );
      sMessage = 'Error creating the view from the filter.';
      AsciiOutput(sDebugFile, sMessage);
    ENDIF;
    ProcessQuit;
  ENDIF;
ENDIF;

## Determine dimensions in source cube
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
If( pDebug >= 2 );
  ProcessBreak;
ELSE;
  DataSourceType = 'VIEW';
  DatasourceNameForServer = pCube;
  DatasourceNameForClient = pCube;
  DatasourceCubeView = cView;
ENDIF;

### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,159

#****Begin: Generated Statements***
#****End: Generated Statements****


#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.0.2~~##
#####################################################################################

### Data Count ###
nDataCount = nDataCount + 1;

### Output the Column titles;
IF(
nDataCount = 1);
  If( nDimensionCount = 2 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, 'Value' );
  ElseIf( nDimensionCount = 3 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, 'Value' );
  ElseIf( nDimensionCount = 4 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, 'Value' );
  ElseIf( nDimensionCount = 5 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, 'Value' );
  ElseIf( nDimensionCount = 6 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, 'Value' );
  ElseIf( nDimensionCount = 7 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, 'Value' );
  ElseIf( nDimensionCount = 8 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, 'Value' );
  ElseIf( nDimensionCount = 9 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9 );
  ElseIf( nDimensionCount = 10 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, 'Value' );
  ElseIf( nDimensionCount = 11 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, 'Value' );
  ElseIf( nDimensionCount = 12 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, 'Value' );
  ElseIf( nDimensionCount = 13 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, 'Value' );
  ElseIf( nDimensionCount = 14 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, 'Value' );
  ElseIf( nDimensionCount = 15 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, 'Value' );
  ElseIf( nDimensionCount = 16 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, 'Value' );
  ElseIf( nDimensionCount = 17 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, 'Value' );
  ElseIf( nDimensionCount = 18 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, 'Value' );
  ElseIf( nDimensionCount = 19 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, 'Value' );
  ElseIf( nDimensionCount = 20 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, 'Value' );
  ElseIf( nDimensionCount = 21 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, 'Value' );
  ElseIf( nDimensionCount = 22 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, 'Value' );
  ElseIf( nDimensionCount = 23 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, 'Value' );
  ElseIf( nDimensionCount = 24 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22,
      sDim23, sDim24, 'Value' );
  ElseIf( nDimensionCount = 25 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22,
      sDim23, sDim24, sDim25, 'Value' );
  ElseIf( nDimensionCount = 26 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22,
      sDim23, sDim24, sDim25, sDim26, 'Value' );
  ElseIf( nDimensionCount = 27 );
    AsciiOutput( cExportFile, 'Cube', sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22,
      sDim23, sDim24, sDim25, sDim26, sDim27, 'Value' );
  EndIf;

ENDIF;

### Export data from source version to file ###
# Selects the correct AsciiOutput formula depending upon the number of dimensions in the cube

IF(
SCAN( CHAR( 10 ), sValue ) > 0 );
  sValueCleaned = '';
  nNoChar = 1;
  nLimit = LONG( sValue);
  WHILE( nNoChar <= nLimit ) ;
    sChar = SUBST(  sValue, nNoChar, 1);
    IF(
    CODE( sChar, 1 ) <> 10 );
      sValueCleaned = sValueCleaned | sChar ;
    ELSE;
      sValueCleaned = sValueCleaned | ' ';
    ENDIF;
    nNoChar = nNoChar + 1;
  END;
  sValue = sValueCleaned;
ENDIF;



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
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
    v23, v24, sValue );
ElseIf( nDimensionCount = 25 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
    v23, v24, v25, sValue );
ElseIf( nDimensionCount = 26 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
    v23, v24, v25, v26, sValue );
ElseIf( nDimensionCount = 27 );
  AsciiOutput( cExportFile, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
    v23, v24, v25, v26, v27, sValue );
EndIf;



### End Data ###
575,59

#****Begin: Generated Statements***
#****End: Generated Statements****


#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.0.2~~##
#####################################################################################


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';

EndIf;


### Delete source data ###
If(
pDebug <= 1 &
pZeroSource = 1 );

  ViewZeroOut( pCube, cView );
  If( pDebug >= 1 );
    sMessage = 'Source Data has been zero out.';
    AsciiOutput( sDebugFile, sMessage );
  Endif;
ELSE;
  If( pDebug >= 1 );
    sMessage = 'Source Data has been retained.';
    AsciiOutput( sDebugFile, sMessage );
  Endif;
EndIf;

### Destroy temporary views and susbsets ###
If( pDebug <= 1 );
  ExecuteProcess('Bedrock.Cube.ViewAndSubsets.Delete',
    'pCube', pCube,
    'pView', cView,
    'pSubset', cView,
    'pMode', pDestroyTempObj,
    'pDebug', pDebug);
ENDIF;

### Finalise Debug ###

If( pDebug >= 1 );

  # Log finish time
  AsciiOutput( sDebugFile, 'Record Exported : ' | NumberToString( nDataCount) );
  AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

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
