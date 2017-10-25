601,100
602,"Bedrock.Dim.Export"
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"hhxV?gwyaZl?Vv4YotvwpmJI1x@C<`Y<sCfXpIrZyXGWu9pA6D0sskM8xZo8eDXRbt51@OkLm^tH<N6Uy@NjL\7DamEtpXeuuxU7?I\^YnmOIFGuejf5U>i`2sh<2gb?NA2@xdhPY;18F0FeeJGUL[Ag=Yf0Y0Z:8lu8I[QY6u2czktn7oNub3zKh6TxR_vKH2Hu\Uz>"
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
pTitleRecord,1
pDebug,0
637,5
pDimension,"Dimension"
pExportPath,"Export file path"
pExportFile,"Export file name (default extension .csv)"
pTitleRecord,"Boolean 1 = Yes - Include header row"
pDebug,"Debug Mode"
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
603,0
572,108

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.0.0~~##
#####################################################################################

# This process will Export all Dimension elements to a File.


### Constants ###

cProcess = 'Bedrock.Dim.Export';
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

### Constants
cCubeS1 = '}DimensionProperties';

### Assign Data Source ###

DatasourceNameForServer = pDimension;
DatasourceNameForClient = pDimension;
DataSourceType = 'SUBSET';
DatasourceDimensionSubset = 'ALL';


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,108

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################


### Check for error in prolog ###

If( nErrors > 0 );
  ProcessBreak;
EndIf;


### Record Count

nRecordCount = nRecordCount + 1;

### Export Header Information

## Line 1: File Metadata information
If( 
nRecordCount = 1 & pTitleRecord = 1 );
  AsciiOutput( sFilename,
    'Export from dimension: ' | pDimension | ', all elements in index order. Total elements=' |
      NumberToString( DimSiz( pDimension ) ) | '. On ' | Date( Now, 1 ) | ' at ' | Time );

## Line 2: Source Dimension
AsciiOutput( sFilename,
    pDimension  );

## Line 2: Sort Order Information
sSortElementType = CELLGETS( cCubeS1, pDimension, 'SORTELEMENTSTYPE' );
sSortComponentType = CELLGETS( cCubeS1, pDimension, 'SORTCOMPONENTSTYPE' );
sSortElementSense =  CELLGETS( cCubeS1, pDimension, 'SORTELEMENTSSENSE' );
sSortComponentSense =  CELLGETS( cCubeS1, pDimension, 'SORTCOMPONENTSSENSE' );
AsciiOutput( sFilename,
    sSortElementType , sSortComponentType , sSortElementSense , sSortComponentSense  );

## Line 3: Header Information
  AsciiOutput( sFilename, 'Reserved' );

## Line 4: Header Information
  AsciiOutput( sFilename, 'Reserved' );

## Line 6: Header Information
  AsciiOutput( sFilename,
    'Line_Type', 'Element', 'Value_1', 'Value_2', 'Value_3' );

### Attribute Information 
  sAttrDimName = '}ElementAttributes_' | pDimension;
  IF(
  DimensionExists( sAttrDimName ) = 1 );
    nIndex = 1;
    nLimit = DIMSIZ ( sAttrDimName );
    WHILE( nIndex <= nLimit );
      sElName = DIMNM( sAttrDimName, nIndex );
      sElType = DTYPE( sAttrDimName, sElName );
      AsciiOutput( sFilename, 'A', sElName, sElType );
      nIndex = nIndex + 1;
    END; 
  ENDIF;

ENDIF;


### Element Information
nElIndex = DIMIX ( pDimension, vElement );
sElType = DTYPE( pDimension, vElement );
AsciiOutput( sFilename,
  'E', vElement, sElType, NumberToString( nElIndex ) );

### Element Parents
nElPar =ELPARN( pDimension, vElement );
IF(
nElPar > 0 );
  nIndex = 1;
  nLimit = nElPar;
  WHILE( nIndex <= nLimit );
    sElPar = ELPAR( pDimension, vElement, nIndex );
    sElType = DTYPE( pDimension, sElPar );
    nElWgt  = ElWeight( pDimension, sElPar, vElement );
    AsciiOutput( sFilename, 'P', vElement, sElPar, sElType, NumberToString( nElWgt ) );
    nIndex = nIndex + 1;
  END;
ENDIF;

### Attribute Value 
IF(
DimensionExists( sAttrDimName ) = 1 );
  nIndex = 1;
  nLimit = DIMSIZ ( sAttrDimName );
  WHILE( nIndex <= nLimit );
    sElName = DIMNM( sAttrDimName, nIndex );
    sElType = DTYPE( sAttrDimName, sElName );
    IF(
    sElType @= 'AN' );
      sAttrValue = NumberToString( ATTRN( pDimension, vElement, sElName ) );
    ELSE;
      sAttrValue = ATTRS( pDimension, vElement, sElName );
    ENDIF;
    AsciiOutput( sFilename, 'V', vElement, sElName, sAttrValue );
    nIndex = nIndex + 1;
  END;
ENDIF;

575,35

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
