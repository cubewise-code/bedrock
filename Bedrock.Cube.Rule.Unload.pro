601,100
602,"Bedrock.Cube.Rule.Unload"
562,"CHARACTERDELIMITED"
586,"C:\TM1Data\Bedrock3\Data\Excel.RUX"
585,"C:\TM1Data\Bedrock3\Data\Excel.RUX"
564,
565,"wJ>B^t?<=aK?XVcyauU_6iwa34g16ZZ:jzN1cHvX1?kHnpvdpTIt\yd0Nhr817I8e_J1KOLHR;WlnO=MA:7]cykL[aUvo^F<Bq3HRiQoCX4?Tg:]i[<FHBYtzaB`0;[yIB@KoKvpBan<Rt9XEWVr7Y<Qf>nx@YpB6tp9CaC21OXFqVhFCwqfakSpmDQEyqOkc1Z0d2[K"
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
560,3
pSourceCube
pRuleName
pDebug
561,3
2
2
1
590,3
pSourceCube,""
pRuleName,""
pDebug,0
637,3
pSourceCube,"Unload rule from this cube."
pRuleName,"Optional: The name of the temporary rule file."
pDebug,"Debug Mode"
577,1
V1
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
572,112

#****Begin: Generated Statements***
#****End: Generated Statements****


####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

## This process will copy the rule rule file to a temporary file and load a blank rule file.


### Constants ###

cProcess = 'Bedrock.Cube.Rule.Unload';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;

cBlankRuleName = 'BlankRuleFile.rux';
nErrors = 0;

### PROCESS PROPERTIES
DatasourceASCIIDelimiter = '';
DatasourceASCIIQuoteCharacter = '';

### Initialise Debug ###
If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters:    pSourceCube: ' | pSourceCube );
  AsciiOutput( sDebugFile, '               pRuleName: ' | pRuleName );
  AsciiOutput( sDebugFile, '' );

EndIf;

### VALIDATE PARAMETERS ###
## Check if the cube exists.
IF(
pSourceCube @= '' % 
CubeExists( pSourceCube ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid source cube specified: ' | pSourceCube;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
ELSE;
  cSourceCube = pSourceCube;
EndIf;

## Check if a rule file exists.
cCubeRuleFileName = cSourceCube | '.rux';
IF(
FileExists( cCubeRuleFileName ) = 0 );
  nErrors = 1;
  sMessage = 'No Rule file found for cube: ' | cSourceCube;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

## Set the Backup rule file name
IF(
pRuleName @= '' );
  cBkpRuleName = cSourceCube  | '_Bedrock.txt';
ELSE;
    cBkpRuleName = pRuleName;
ENDIF;
IF( pDebug >= 1 );
  sMsg = 'Set backup rule filename: ' | cBkpRuleName | '.';
  AsciiOutput( sDebugFile, sMessage );
ENDIF;

## Delete old Backup files
IF(
FileExists( cBkpRuleName ) = 0 );
  ASCIIDelete( cBkpRuleName );
ENDIF;

### BLANK RULE FILE ###
## Check if the rule file 
IF(
FileExists( cBlankRuleName ) = 0 );
  If( pDebug <= 1 );
    ASCIIOUTPUT( cBlankRuleName, 'SKIPCHECK;' );
    ASCIIOUTPUT( cBlankRuleName, '' );
    ASCIIOUTPUT( cBlankRuleName, 'FEEDERS;' );
  EndIf;

  If( pDebug >= 1 );
    sMsg =  'No Blank Rule file. Create Blank Rule file ' | cBlankRuleName | '.';
    ASCIIOUTPUT( cDebugFile, sMsg );
  EndIf;

ENDIF;

### SET DATA SOURCE ###



DatasourceType = 'CHARACTERDELIMITED';
DatasourceNameForServer =cCubeRuleFileName;
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,12

#****Begin: Generated Statements***
#****End: Generated Statements****



### OUTPUT BACKUP RULE FILE

ASCIIOUTPUT( cBkpRuleName, v1 );



575,44

#****Begin: Generated Statements***
#****End: Generated Statements****


### Initialise Debug ###
If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';

EndIf;


### LOAD BLANK RULE FILE ###
IF( pDebug >= 1 );
  sMsg = 'Load Blank Rule file.';
  AsciiOutput( sDebugFile, sMsg );
ENDIF;

IF( pDebug <= 1 );
  RuleLoadFromFile( cSourceCube, cBlankRuleName );
ENDIF;

### Finalise Debug ###

If( pDebug >= 1 );
  ## Log errors
  If( nErrors <> 0 );
    AsciiOutput( sDebugFile, 'Errors Occurred' );
  EndIf;

  ## Log finish time
  AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

EndIf;


## If errors occurred terminate process with a major error status ###
If( nErrors <> 0 );
  ProcessQuit;
EndIf;


### End Epilog ###
576,CubeAction=1511DataAction=1503CubeLogChanges=0
930,0
638,1
804,0
1217,0
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
