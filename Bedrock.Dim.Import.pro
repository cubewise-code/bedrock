601,100
602,"Bedrock.Dim.Import"
562,"CHARACTERDELIMITED"
586,"C:\Users\adavis\Documents\Bedrock 3.0\Export\Column_Export.csv"
585,"C:\Users\adavis\Documents\Bedrock 3.0\Export\Column_Export.csv"
564,
565,"f=wzCqaBfLuAZUBfz3jQQ_sbdv>Sa3mRDxkxnh@qZdOQv5IgimW<0iRZx?G`B>lj>sQXOTw3_nTsW_EuJ?Y=r^t[16p@X6>4H[D1Yt?nh6[St9=1^<Gu0CUBFmrHclUCHvO<b@6si^4Vjw2HWxbC]:xImqI8L4ns6Qtqlf=rr0R5I2CdGoFtyREHNCkXtwvPaU0p7trq"
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
569,0
592,0
599,1000
560,4
pSourceDir
pSourceFile
pDimension
pDebug
561,4
2
2
2
1
590,4
pSourceDir,""
pSourceFile,""
pDimension,""
pDebug,0
637,4
pSourceDir,"Source Directory"
pSourceFile,"Source File"
pDimension,"Dimension"
pDebug,"Debug Mode"
577,6
V1
V2
V3
V4
V5
V6
578,6
2
2
2
2
2
2
579,6
1
2
3
4
5
6
580,6
0
0
0
0
0
0
581,6
0
0
0
0
0
0
582,6
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
603,0
572,125

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will Create Dimensions from File.


### Constants ###

cProcess = 'Bedrock.Dim.ImportFromFile';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp;

nMetaCount = 0;
nDataCount = 0;

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

EndIf;


### Validate Parameters ###

nErrors = 0;

## Validate source dir
If( FileExists( pSourceDir ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid source directory specified: folder does not exist.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;


nSourceFileLen = LONG( pSourceFile);
IF(
nSourceFileLen <= 3 );
  sSourceFile = TRIM( pSourceFile ) | '.csv';
ELSEIF(
SUBST( pSourceFile , nSourceFileLen - 3, 1 ) @<> '.' );
  sSourceFile = TRIM( pSourceFile ) | '.csv';
ELSE;
  sSourceFile = pSourceFile;
ENDIF;

If( SubSt( pSourceDir, Long( pSourceDir ) - 1, 1 ) @<> '\' );
  pSourceDir = pSourceDir | '\';
EndIf;
sFilename = pSourceDir | sSourceFile;

## Validate source file
If( Trim( pSourceFile ) @= '' % FileExists( sFilename ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid source file specified: file does not exist in directory.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

## Validate dimension
If( Trim( pDimension ) @= '' );
  nErrors = 1;
  sMessage = 'No dimension specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

### Prepare target dimension ###
If( pDebug <= 1 );
  If( DimensionExists( pDimension ) = 1 );
    ExecuteProcess('Bedrock.Dim.Hierarchy.Unwind.All',
      'pDimension', pDimension,
      'pDebug', pDebug );
  Else;
    DimensionCreate( pDimension );
  EndIf;
EndIf;

If( pDebug >= 1 );
  If( DimensionExists( pDimension ) = 1 );
    sMessage = 'Dimension unwound: ' | pDimension;
  Else;
    sMessage = 'Dimension created: ' | pDimension;
  EndIf;
  AsciiOutput( sDebugFile, sMessage );
EndIf;

### CONSTANTS ###
sAttrDimName = '}ElementAttributes_' | pDimension;
cCubeS1 = '}DimensionProperties';

### Assign Datasource ###

DataSourceType = 'CHARACTERDELIMITED';
DatasourceNameForServer = sFilename;
DatasourceNameForClient = sFilename;


### End Prolog ###
573,56

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################


### Initialise Debug ###

If( pDebug >= 1 );

  ## Set debug file name
  sDebugFile = cDebugFile | 'Metadata.debug';
EndIf;

### Check for error in prolog ###

If( nErrors > 0 );
  ProcessBreak;
EndIf;

### Metadata Count
nMetaCount = nMetaCount + 1;

### Validate record
IF(
nMetaCount < 7 );
  ITEMSKIP;
ENDIF;


### Build dimension

IF(
V1 @= 'E' );
  If( pDebug <= 1 );
    DimensionElementInsert( pDimension, '', V2, V3 );
  EndIf;
  If( pDebug >= 1 );
    ASCIIOUTPUT( sDebugFile, 'Element Added', V2, V3 );
  EndIf;

ELSEIF(
V1 @= 'P' );
  If( pDebug <= 1 );
    DimensionElementInsert( pDimension, '', V3, V4 );
    DimensionElementComponentAdd( pDimension, V3, V2, StringToNumber( V5 ) );
  EndIf;
  If( pDebug >= 1 );
    ASCIIOUTPUT( sDebugFile, 'Parent added Added', V2, V3, V5 );
  EndIf;

ENDIF;

574,58

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

### Initialise Debug ###
If( pDebug >= 1 );
  ## Set debug file name
  sDebugFile = cDebugFile | 'Data.debug';
EndIf;


### Data Count
nDataCount = nDataCount + 1;

### Load Data ###

IF(
nDataCount = 3);
  ## Set Dimension Sort 
  If( pDebug <= 1 );
    CELLPUTS( V1, cCubeS1 , pDimension, 'SORTELEMENTSTYPE' );
    CELLPUTS( V2, cCubeS1 , pDimension, 'SORTCOMPONENTSTYPE' );
    CELLPUTS( V3, cCubeS1 , pDimension, 'SORTELEMENTSSENSE' );
    CELLPUTS( V4, cCubeS1 , pDimension, 'SORTCOMPONENTSSENSE' );
  EndIf;
  If( pDebug >= 1 );
    ASCIIOUTPUT( sDebugFile, 'Sort Order set.', V1, V2, V3, V4 );
  EndIf;
ENDIF;


IF(
V1 @= 'A' );
  If( pDebug <= 1 );
    ATTRINSERT( pDimension, '', V2, SUBST( V3, 2, 1 ) );
  EndIf;
  If( pDebug >= 1 );
    ASCIIOUTPUT( sDebugFile, 'Create Attribute.', V2 );    
  EndIf;

ELSEIF(
V1 @= 'V' );
  If( pDebug <= 1 );
    IF(
    DTYPE( sAttrDimName, V3 ) @= 'AN' );
      ATTRPUTN( StringToNumber( V4 ), pDimension, V2, V3 );
    ELSE;
      ATTRPUTS( V4, pDimension, V2, V3 );
    ENDIF;
  EndIf;
  If( pDebug >= 1 );
    ASCIIOUTPUT( sDebugFile, 'Load Attribute.', V2, V3, V4);    
  EndIf;
ENDIF;
575,40

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
