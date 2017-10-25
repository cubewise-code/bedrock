601,100
602,"Bedrock.Server.DataDir.Backup"
562,"NULL"
586,
585,
564,
565,"p8UXNxS5OvXmRHWSaQ^^sO4:RZM<0YFt]^K@TrXN_N;Jd_QPWFYVtJWBs\TdxJ9GqCj<amnUzK9f9m3NLjkmuW95?c@oY@\1rW5odfXe\Spgi:emu^1DnCWbGq<7TX9W0_yh7aJAmGtzadnlzoAH3tCOwtWLiwdvMYkk06Tx>p5HDKlie5F>hVlN<WT8jIsDdHntwWbD"
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
560,3
pDataDir
pBackupDir
pDebug
561,3
2
2
1
590,3
pDataDir,""
pBackupDir,""
pDebug,0
637,3
pDataDir,Source Directory to Backup
pBackupDir,Destination Directory for Backup
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,137

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will back up the Data Directory


### Constants ###

cProcess = 'Bedrock.Server.DataDir.Backup';
cUser = TM1User();
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  AsciiOutput( sDebugFile, 'TM1 User:        ' | cUser );
  AsciiOutput( sDebugFile, '' );
  # Output parameters
  AsciiOutput( sDebugFile, 'Parameters: pDataDir:    ' | pDataDir );
  AsciiOutput( sDebugFile, '            pBackupDir:  ' | pBackupDir );
  AsciiOutput( sDebugFile, '' );
EndIf;


### Validate Parameters ###

nErrors = 0;

# Remove leading and/or trailing spaces
pDataDir = Trim( pDataDir );
pBackupDir = Trim( pBackupDir );

# Remove trailing \ from directory names if present
If( SubSt( pDataDir, Long( pDataDir ), 1 ) @= '\' );
   pDataDir = SubSt( pDataDir, 1, Long( pDataDir ) - 1 );
EndIf;
If( SubSt( pBackupDir, Long( pBackupDir ),1 ) @= '\' );
   pBackupDir = SubSt( pBackupDir, 1, Long( pBackupDir ) - 1 );
EndIf;

# Check that data directory has been specified
If( pDataDir @= '' );
  nErrors = 1;
  sMessage = 'No data directory specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

# Check that data directory exists
If( FileExists( pDataDir ) = 0 );
  nErrors = 1;
  sMessage = 'Source directory for backup does not exist: ' | pDataDir;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

# Check that target directory has been specified
If( pBackupDir @= '' );
  nErrors = 1;
  sMessage = 'No backup directory specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

# Check that target directory exists
If( FileExists( pBackupDir ) = 0 );
  nErrors = 1;
  sMessage = 'Destination directory for backup does not exist: ' | pBackupDir;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

### Save the model to disk
If( pDebug <= 1 );
  ExecuteProcess( 'Bedrock.Server.SaveDataAll',
    'pDebug', pDebug );
  If( pDebug >= 1 );
    sMessage = 'TM1 Save Data All Complete.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
EndIf;



### Create batch files
DatasourceASCIIQuoteCharacter='';

### Create Make Directory Batch File
sBackupDir = pBackupDir | '\TM1Backup_' | cTimeStamp;
sFileName = 'Bedrock.MkDir.bat' ;
ASCIIOUTPUT( sFileName, 'md "' | sBackupDir |'"' );

### Create Exclude File ###
sFileName = 'Excludes.txt';
ASCIIOUTPUT( sFileName, '.log');
ASCIIOUTPUT( sFileName, '.cfg');
ASCIIOUTPUT( sFileName, '.csv');
ASCIIOUTPUT( sFileName, '.cmal');
ASCIIOUTPUT( sFileName, '.txt');
ASCIIOUTPUT( sFileName, '.feeders');

### Create Batch File ###
sFileName = 'Bedrock.Server.DataDir.Backup.bat';

sText = 'XCOPY "'| pDataDir |'" "'| sBackupDir|'" /i /c /s /e /y /exclude:Excludes.txt';
ASCIIOUTPUT( sFileName, '@ECHO OFF');
ASCIIOUTPUT( sFileName, sText );

If( pDebug >= 1 );
  sMessage = 'Command Line: ' | sText;
  AsciiOutput( sDebugFile, sMessage );
EndIf;


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,82

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################


### Initialise Debug ###

If( pDebug >= 1 );
  ## Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';
EndIf;

### Create Backup Subfolder ###
If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'Full Backup Directory: ' | sBackupDir | '\' );
EndIf;

If( pDebug <= 1 );
  ExecuteCommand ( 'Bedrock.MkDir.bat ', 1 );
  If( FileExists( sBackupDir ) = 0 );
    nErrors = 1;
    If( pDebug >= 1 );
      sMessage = 'Process Quit: Could not create backup directory: ' | sBackupDir;
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    ProcessQuit;
  ELSE;
    If( pDebug >= 1 );
      sMessage = 'Backup directory exists: ' | sBackupDir;
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
  EndIf;
EndIf;


### Copy Data Dir to Backup ###

sCommand = 'Bedrock.Server.DataDir.Backup.bat';

If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'Backup Command: ' | sCommand );
EndIf;

If( pDebug <= 1 );
  ExecuteCommand ( sCommand, 1 );
EndIf;

### Delete batch file ###
If( pDebug <= 1 );
  sFileName = 'Bedrock.Server.DataDir.Backup.bat' ;
  ASCIIDelete( sFileName );
  sFileName = 'Bedrock.MkDir.bat';
  ASCIIDelete( sFileName );
  sFileName = 'Excludes.txt';
  ASCIIDelete( sFileName );
  If( pDebug >= 1 );
    sMessage = 'Temporary files deleted.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
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
