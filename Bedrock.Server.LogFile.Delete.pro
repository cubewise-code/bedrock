601,100
602,"Bedrock.Server.LogFile.Delete"
562,"NULL"
586,
585,
564,
565,"iusfqZha@a1R2@;7[P6y]7j38ompMHdfeNl>Gn83_=QtLQ>D4NPG\B1mfJzWoWbn[chUViYd=S^eHrdwDtL:^y=A3v;\t0r@8cYeXzWKleYbD4s8@KKd9`V`[wy=VX`p5]eJThRXiG?cW<SbbqDJh6QGYqH5`6iFz7hygdogS8539NIr3j0LoHk\Fqum6^]QSIL01p?5"
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
571,
569,0
592,0
599,1000
560,6
pLogDir
pLogDays
pErrorDays
pBedrockDays
pCSVDays
pDebug
561,6
2
1
1
1
1
1
590,6
pLogDir,""
pLogDays,7
pErrorDays,21
pBedrockDays,7
pCSVDays,7
pDebug,0
637,6
pLogDir,"Log file directory. (Blank = from TM1 configuration file)"
pLogDays,"The number of days to retain log Files"
pErrorDays,"The number of day to retain TM1 Error Logs"
pBedrockDays,"The number of days to retain Bedrock Debug Files"
pCSVDays,"The number of days to retain CSV files"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,107

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will back up the Data Directory


### Constants ###

cProcess = 'Bedrock.Server.LogFile.Delete';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;



### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Output parameters
  AsciiOutput( sDebugFile, 'Parameters: pLogFile:     ' | pLogDir );
  AsciiOutput( sDebugFile, '            pLogDays:     ' | NumberToString( pLogDays) );
  AsciiOutput( sDebugFile, '            pErrorDays:   ' | NumberToString( pErrorDays ) );
  AsciiOutput( sDebugFile, '            pBedrockDays: ' | NumberToString( pBedrockDays ) );
  AsciiOutput( sDebugFile, '            pCSVDays:     ' | NumberToString( pCSVDays ) );

EndIf;


### Validate Parameters ###

nErrors = 0;

IF(
pLogDir @= '');
  pLogDir = GetProcessErrorFileDirectory;
ELSE;
  ## Remove leading and/or trailing spaces
  pLogDir = Trim( pLogDir );
ENDIF;

## Remove trailing \ from directory names if present
If(
SubSt( pLogDir, Long( pLogDir ), 1 ) @= '\' );
  pLogDir = SubSt( pLogDir, 1, Long( pLogDir ) - 1 );
EndIf;

# Check that target Logging Directory exists
If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'Target Directory: ' |  pLogDir );
ENDIF;

If( FileExists( pLogDir ) = 0 );
  If( pDebug >= 1 );
    nErrors = 1;
    sMessage = 'Logging directory does not exist: ' | pLogDir;
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

sLogDays = NumberToString( ROUND( pLogDays ) );
sErrorDays = NumberToString( ROUND( pErrorDays ) );
sBedrockDays = NumberToString( ROUND( pBedrockDays ) );
sCSVDays = NumberToString( ROUND( pCSVDays ) );

### Save the model to disk
ExecuteProcess( 'Bedrock.Server.SaveDataAll' );

### Create Execute File File ###
DatasourceASCIIQuoteCharacter='';


If( pDebug >= 1 );
  ASCIIOUTPUT( sDebugFile, '' );
  ASCIIOUTPUT( sDebugFile, 'forfiles -p "'| pLogDir |'" -s -m tm1s*.log -d -' | sLogDays | ' -c "cmd /c del @path"' );
  ASCIIOUTPUT( sDebugFile, 'forfiles -p "'| pLogDir |'" -s -m tm1auditstore*.log -d -' | sLogDays | ' -c "cmd /c del @path"' );
  ASCIIOUTPUT( sDebugFile, 'forfiles -p "'| pLogDir |'" -s -m TM1ProcessError*.log -d -' | sErrorDays | ' -c "cmd /c del @path"' );
  ASCIIOUTPUT( sDebugFile, 'forfiles -p "'| pLogDir |'" -s -m Bedrock*.* -d -' | sBedrockDays | ' -c "cmd /c del @path"' );
  ASCIIOUTPUT( sDebugFile, 'forfiles -p "'| pLogDir |'" -s -m *.csv -d -' | sCSVDays | ' -c "cmd /c del @path"' );
  ASCIIOUTPUT( sDebugFile, 'forfiles -p "'| pLogDir |'" -s -m *.cma -d -' | sCSVDays | ' -c "cmd /c del @path"' );
  ASCIIOUTPUT( sDebugFile, 'forfiles -p "'| pLogDir |'" -s -m *.txt -d -' | sCSVDays | ' -c "cmd /c del @path"' );
ENDIF;
If( pDebug <= 1 );
  sFileName = 'Bedrock Remove Logs.bat';
  ASCIIOUTPUT( sDebugFile, 'Echo Off' );
  ASCIIOUTPUT( sFileName, 'forfiles -p "'| pLogDir |'" -s -m tm1s*.log -d -' | sLogDays | ' -c "cmd /c del @path"' );
  ASCIIOUTPUT( sFileName, 'forfiles -p "'| pLogDir |'" -s -m tm1auditstore*.log -d -' | sLogDays | ' -c "cmd /c del @path"' );
  ASCIIOUTPUT( sFileName, 'forfiles -p "'| pLogDir |'" -s -m TM1ProcessError*.log -d -' | sErrorDays | ' -c "cmd /c del @path"' );
  ASCIIOUTPUT( sFileName, 'forfiles -p "'| pLogDir |'" -s -m Bedrock*.* -d -' | sBedrockDays | ' -c "cmd /c del @path"' );
  ASCIIOUTPUT( sFileName, 'forfiles -p "'| pLogDir |'" -s -m *.csv -d -' | sCSVDays | ' -c "cmd /c del @path"' );
  ASCIIOUTPUT( sFileName, 'forfiles -p "'| pLogDir |'" -s -m *.cma -d -' | sCSVDays | ' -c "cmd /c del @path"' );
  ASCIIOUTPUT( sFileName, 'forfiles -p "'| pLogDir |'" -s -m *.txt -d -' | sCSVDays | ' -c "cmd /c del @path"' );
ENDIF;

### End Prolog ###
573,7

#****Begin: Generated Statements***
#****End: Generated Statements****


#****Begin: Generated Statements***
#****End: Generated Statements****
574,7

#****Begin: Generated Statements***
#****End: Generated Statements****


#****Begin: Generated Statements***
#****End: Generated Statements****
575,47

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.0.0~~##
#####################################################################################

# Set debug file name
sDebugFile = cDebugFile | 'Epilog.debug';

### Copy Data Dir to Backup ###
sCommand = sFileName;

If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'Execute Command: ' | sCommand );
EndIf;

If( pDebug <= 1 );
  ExecuteCommand ( sCommand, 1 );
  ASCIIDelete( sFileName);
EndIf;


### Initialise Debug ###

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
