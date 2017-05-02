601,100
562,"CHARACTERDELIMITED"
586,"C:\Temp\Dim_Account.csv"
585,"C:\Temp\Dim_Account.csv"
564,
565,"mVUF1HZwgPxZ`aBIA=a@aG?QFvq5_j1lFy38eN3rBx=W3uA@=0IL^NSBW5Ak=`7@K2dIMtY[BLYnA<ggYefMJIbOgukX^I[Y3M=Ej7`I;UIqM=mKV5>VJHs5_LR4IDELbmkIwGBzqBp7NGIuRS5Tb8z5r@dL=USjohhKMoELu\c;PoqmopA3k2I:AlBtr=76q\600ws<"
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
568,""
570,
571,
569,2
592,0
599,1000
560,9
pSourceDir
pSourceFile
pDimension
pAlias
pAction
pTitleRows
pDelimiter
pQuote
pDebug
561,9
2
2
2
2
2
1
2
2
1
590,9
pSourceDir,""
pSourceFile,""
pDimension,""
pAlias,""
pAction,"Add"
pTitleRows,2.
pDelimiter,","
pQuote,"""
pDebug,0.
637,9
pSourceDir,Source Directory
pSourceFile,Source File
pDimension,Dimension
pAlias,Alias
pAction,'Add' OR 'Replace'
pTitleRows,Number of Title Rows to Skip
pDelimiter,Delimiter Character (default=Comma)
pQuote,Quote Character (default=Double Quote)
pDebug,Debug Mode
577,16
vIndex
vElement
vAlias
vElType
vLevel
vNumChildren
vParent1
vWeight1
vParent2
vWeight2
vParent3
vWeight3
vParent4
vWeight4
vParent5
vWeight5
578,16
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
2
1
2
1
2
1
579,16
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
580,16
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
581,16
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
582,16
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=33€ColType=827€
VarType=32€ColType=827€
VarType=33€ColType=827€
VarType=32€ColType=827€
VarType=33€ColType=827€
VarType=32€ColType=827€
VarType=33€ColType=827€
VarType=32€ColType=827€
VarType=33€ColType=827€
572,152





#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################

# This process will Create Dimensions from File.


### Constants ###

cProcess = 'Bedrock.Dim.ImportFromFile';
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
  AsciiOutput( sDebugFile, '            pDimension  : ' | pDimension );
  AsciiOutput( sDebugFile, '            pAction     : ' | pAction );
  AsciiOutput( sDebugFile, '            pTitleRows  : ' | NumberToString( pTitleRows ) );
  AsciiOutput( sDebugFile, '            pDelimiter  : ' | pDelimiter );
  AsciiOutput( sDebugFile, '            pQuote      : ' | pQuote );

EndIf;


### Validate Parameters ###

nErrors = 0;

# Validate source dir
If( FileExists( pSourceDir ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid source directory specified: folder does not exist.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

If( SubSt( pSourceDir, Long( pSourceDir ) - 1, 1 ) @<> '\' );
  pSourceDir = pSourceDir | '\';
EndIf;
sFilename = pSourceDir | pSourceFile;

# Validate source file
If( Trim( pSourceFile ) @= '' % FileExists( sFilename ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid source file specified: file does not exist in directory.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate dimension
If( Trim( pDimension ) @= '' );
  nErrors = 1;
  sMessage = 'No dimension specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate action
If( Upper( pAction ) @<> 'ADD' & Upper( pAction ) @<> 'REPLACE' );
  nErrors = 1;
  sMessage = 'Invalid action specified: ' | pAction | '. Valid actions are Add or Replace';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate delimiter and quote
If( pDelimiter @= '' );
  pDelimiter = ',';
EndIf;
If( pQuote @= '' );
  pQuote = '"';
EndIf;
If( Long( pDelimiter ) > 1 );
  nErrors = 1;
  sMessage = 'Invalid delimiter specified: ' | pDelimiter | ' record delimiter must be single character.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;
If( Long( pQuote ) > 1 );
  nErrors = 1;
  sMessage = 'Invalid string qualifier: ' | pQuote | ' quote character must be single character.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;


### Prepare target dimension ###

If( pDebug <= 1 );
  If( DimensionExists( pDimension ) = 1 );
    If( pAction @= 'Replace' );
      DimensionDeleteAllElements( pDimension );
    EndIf;
  Else;
    DimensionCreate( pDimension );
  EndIf;
EndIf;

### Add Alias Attribute ###
IF( pDebug <= 1 );
  IF( pAlias @<> '' );
    ATTRINSERT( pDimension, '', pAlias, 'A');
  ENDIF;
ENDIF;


### Assign Datasource ###

DataSourceType = 'CHARACTERDELIMITED';
DatasourceNameForServer = sFilename;
DatasourceNameForClient = sFilename;
DatasourceASCIIHeaderRecords = pTitleRows;
DatasourceASCIIDelimiter = pDelimiter;
DatasourceASCIIQuoteCharacter = pQuote;


### End Prolog ###
573,45





#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################


### Check for error in prolog ###

If( nErrors > 0 );
  ProcessBreak;
EndIf;


### Write data from source file to target dimension ###

If( pDebug <= 1 );
  DimensionElementInsert( pDimension, '', vElement, vElType );
  If( vParent1 @<> '' );
    DimensionElementInsert( pDimension, '', vParent1, 'C' );
    DimensionElementComponentAdd( pDimension, vParent1, vElement, vWeight1 );
  EndIf;
  If( vParent2 @<> '' );
    DimensionElementInsert( pDimension, '', vParent2, 'C' );
    DimensionElementComponentAdd( pDimension, vParent2, vElement, vWeight2 );
  EndIf;
  If( vParent3 @<> '' );
    DimensionElementInsert( pDimension, '', vParent3, 'C' );
    DimensionElementComponentAdd( pDimension, vParent3, vElement, vWeight3 );
  EndIf;
  If( vParent4 @<> '' );
    DimensionElementInsert( pDimension, '', vParent4, 'C' );
    DimensionElementComponentAdd( pDimension, vParent4, vElement, vWeight4 );
  EndIf;
  If( vParent5 @<> '' );
    DimensionElementInsert( pDimension, '', vParent5, 'C' );
    DimensionElementComponentAdd( pDimension, vParent5, vElement, vWeight5 );
  EndIf;
EndIf;


### End Metadata ###
574,13





#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################

### Load Alias ###
If( pDebug <= 1 );
  ATTRPUTS( vAlias, pDimension, vElement, pAlias );
ENDIF;
575,36





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
