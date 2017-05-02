601,100
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"hyanCZURaMy[CXcCUk;6q;h=aP?3_u`d6ZNYX\sQ3=3LZE]`@umYKvYVEdRIMfS]aN>w3sbMs20zX1\WUZc0AVaz>F[mf3Wy`]Yb@Kg>LY<XS\?S`8@jkuRk_J?^s4c=3VGt[iO`>X5;EZsV=yxrBVN_SqaS5[tKquI4DH:qkDOuq`T2]ELvO[;j4`6;l_15D78ra_bl"
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
pDimension
pExportPath
pExportFile
pTitleRecord
pDebug
561,5
2
2
2
1
1
590,5
pDimension,""
pExportPath,""
pExportFile,""
pTitleRecord,1.
pDebug,0.
637,5
pDimension,Dimension
pExportPath,Export file path
pExportFile,Export file name (default extension .csv)
pTitleRecord,Boolean 1 = Yes - Include header row
pDebug,Debug Mode
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
572,124

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 2.0.2~~##
#####################################################################################

# This process will Export all Dimension elements to a File.


### Constants ###

cProcess = 'Bedrock.Dim.ExportToFile';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 100000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension   : ' | pDimension );
  AsciiOutput( sDebugFile, '            pExportPath  : ' | pExportPath );
  AsciiOutput( sDebugFile, '            pExportFile  : ' | pExportFile );
  AsciiOutput( sDebugFile, '            pTitleRecord : ' | NumberToString( pTitleRecord ) );

EndIf;


### Initialise ###

nRecordCount = 0;


### Validate Parameters ###

nErrors = 0;

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
If( DimensionExists( pDimension ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dimension: ' | pDimension;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate export path
If( FileExists( pExportPath ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid export path specified. Folder does not exist.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

If( SubSt( pExportPath, Long( pExportPath ), 1 ) @<> '\' );
   pExportPath = pExportPath | '\';
EndIf;

# Validate export filename
If( pExportFile @= '' );
  pExportFile = pDimension | '_Export.csv';
Else;
  If( Scan( '.', pExportFile ) = 0 );
    # No file extension specified
    pExportFile = pExportFile | '.csv';
  EndIf;
EndIf;

# Construct full export filename including path
sFilename = pExportPath | pExportFile;


### Determine if alias exists. If multiple aliases exist just pick the first one ###

sAttributeDim = '}ElementAttributes_' | pDimension;
sAlias = '( no alias )';

If( DimensionExists( sAttributeDim ) = 1 );
  nElementCount = DimSiz( sAttributeDim );
  nElementIndex = 1;
  While( nElementIndex <= nElementCount );
    sAttribute = DimNm( sAttributeDim, nElementIndex );
    If( SubSt( DType( sAttributeDim, sAttribute ), 2, 1 ) @= 'A' );
      sAlias = sAttribute;
      nElementIndex = nElementCount;
    EndIf;
    nElementIndex = nElementIndex + 1;
  End;
EndIf;


### Assign Data Source ###

DatasourceNameForServer = pDimension;
DatasourceNameForClient = pDimension;
DataSourceType = 'SUBSET';
DatasourceDimensionSubset = 'ALL';


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,66

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 2.0.2~~##
#####################################################################################


### Check for error in prolog ###

If( nErrors > 0 );
  ProcessBreak;
EndIf;


### Check whether to write title records ###

nRecordCount = nRecordCount + 1;

If( nRecordCount = 1 & pTitleRecord = 1 );
  AsciiOutput(
    sFilename,
    'Export from dimension: ' | pDimension | ', all elements in index order. Total elements=' |
      NumberToString( DimSiz( pDimension ) ) | '. On ' | Date( Now, 1 ) | ' at ' | Time
  );
  AsciiOutput(
    sFilename,
    'Index', 'Element', 'Alias: ' | sAlias, 'El Type', 'Level', 'Num Children', 'Parent 1', 'Weight 1', 'Parent 2', 'Weight 2',
      'Parent 3', 'Weight 3', 'Parent 4', 'Weight 4', 'Parent 5', 'Weight 5'
  );
EndIf;


### Write dimension info to flat file ###

sIndex = NumberToString( DimIx( pDimension, vElement ) );
sType  = DType( pDimension, vElement );
sLevel = NumberToString( ElLev( pDimension, vElement ) );
sChild = NumberToString( ElCompN( pDimension, vElement ) );

sParent1 = ElPar( pDimension, vElement, 1 );
sParent2 = ElPar( pDimension, vElement, 2 );
sParent3 = ElPar( pDimension, vElement, 3 );
sParent4 = ElPar( pDimension, vElement, 4 );
sParent5 = ElPar( pDimension, vElement, 5 );

sWeight1 = NumberToString( ElWeight( pDimension, sParent1, vElement ) );
sWeight2 = NumberToString( ElWeight( pDimension, sParent2, vElement ) );
sWeight3 = NumberToString( ElWeight( pDimension, sParent3, vElement ) );
sWeight4 = NumberToString( ElWeight( pDimension, sParent4, vElement ) );
sWeight5 = NumberToString( ElWeight( pDimension, sParent5, vElement ) );

If( sAlias @<> '( no alias )' );
   sDescription = AttrS( pDimension, vElement, sAlias );
Else;
   sDescription = '';
EndIf;

AsciiOutput(
  sFilename, sIndex, vElement, sDescription, sType, sLevel, sChild, sParent1, sWeight1, sParent2, sWeight2,
    sParent3, sWeight3, sParent4, sWeight4, sParent5, sWeight5
);


### End Data ###
575,35

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 2.0.2~~##
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
