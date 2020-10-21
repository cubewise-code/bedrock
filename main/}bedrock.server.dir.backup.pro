﻿601,100
602,"}bedrock.server.dir.backup"
562,"NULL"
586,
585,
564,
565,"qzZERad=e^MvL`8jjaIphw2wgVSYDUyl_ka@b>9Y1Mn[UOSL\<Yu:kG1LoA3LeEjH=_V6RBL47Xi3T?xlqSP1FqjMau2n8r3PW0KLZ:zfQ\I2axDaG[lS@gw3PDK@u`xO<5v[ZF8sMQN8B6El[RZo;mqAV9@<pFU\[uovHeqEsSbPC4QGuEN3HEq9:eUDjZo3JckwGKD"
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
589,"."
568,""""
570,
571,
569,0
592,0
599,1000
560,4
pLogOutput
pStrictErrorHandling
pSrcDir
pTgtDir
561,4
1
1
2
2
590,4
pLogOutput,0
pStrictErrorHandling,0
pSrcDir,"."
pTgtDir,""
637,4
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pSrcDir,"REQUIRED: Source Directory to Backup"
pTgtDir,"REQUIRED: Destination Directory for Backup"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,143
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.server.dir.backup', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pSrcDir', '.', 'pTgtDir', ''
    );
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This process will back up the Data Directory.

# Use case: Intended for development and production.
# 1/ Backup Data directory every day during development.
# 2/ Backup Data directory every day during planning cycle.

# Note:
# Naturally, a valid data directory (pSrcDir) and targer directory (pTgtDir) is mandatory otherwise the process will abort.
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName       = GetProcessName();
cUserName           = TM1User();
cTimeStamp          = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt          = NumberToString( INT( RAND( ) * 1000 ));
cMsgErrorLevel      = 'ERROR';
cMsgErrorContent    = 'User:%cUserName% Process:%cThisProcName% Message:%sMessage%';
cLogInfo            = 'Process:%cThisProcName% run with parameters pSrcDir:%pSrcDir%, pTgtDir:%pTgtDir%.' ;  
#cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors             = 0;

# Remove leading and/or trailing spaces
pSrcDir             = Trim( pSrcDir );
pTgtDir             = Trim( pTgtDir );

## check operating system
If( Scan('/', GetProcessErrorFileDirectory)>0);
  sOS = 'Linux';
  sOSDelim = '/';
Else;
  sOS = 'Windows';
  sOSDelim = '\';
EndIf;

# Remove trailing \ from directory names if present
If( SubSt( pSrcDir, Long( pSrcDir ), 1 ) @= sOSDelim );
    pSrcDir         = SubSt( pSrcDir, 1, Long( pSrcDir ) - 1 );
EndIf;
If( SubSt( pTgtDir, Long( pTgtDir ),1 ) @= sOSDelim );
    pTgtDir         = SubSt( pTgtDir, 1, Long( pTgtDir ) - 1 );
EndIf;

# Check that data directory has been specified
If( pSrcDir @= '' );
    nErrors         = 1;
    sMessage        = 'No data directory specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( FileExists( pSrcDir ) = 0 );
    nErrors         = 1;
    sMessage        = 'Source data directory for backup does not exist: ' | pSrcDir;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Check that target directory has been specified
If( pTgtDir @= '' );
    nErrors         = 1;
    sMessage        = 'No backup directory specified';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( FileExists( pTgtDir ) = 0 );
    nErrors         = 1;
    sMessage        = 'Destination directory for backup does not exist: ' | pTgtDir;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

### Save the model to disk
ExecuteProcess( '}Bedrock.Server.SaveDataAll', 'pStrictErrorHandling', pStrictErrorHandling );
sMessage = 'TM1 Save Data All Complete.';
LogOutput('INFO', sMessage ); 

### Create batch files
DatasourceASCIIQuoteCharacter='';

### Create Make Directory Batch File
sFileName           = 'Bedrock.MkDir.bat' ;
sBackupDir          = pTgtDir | sOSDelim | 'TM1Backup_' | cTimeStamp;
If(sOS @= 'Windows');
  ASCIIOUTPUT( sFileName, 'md "' | sBackupDir |'"' );
EndIf;

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
If(sOS @= 'Windows');
  sText = 'XCOPY "'| pSrcDir |'" "'| sBackupDir|'" /i /c /s /e /y /exclude:Excludes.txt';
  ASCIIOUTPUT( sFileName, '@ECHO OFF');
  ASCIIOUTPUT( sFileName, sText );
Else;
  sText = 'rsync -rt --exclude-from=excludes.txt "' | pSrcDir | '" "' | sBackupDir |'"';
EndIf;


sMessage = 'Command Line: ' | sText;
LogOutput('INFO', sMessage ); 

### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,63

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

# Create backup directory
If(sOS @= 'Windows');
  ExecuteCommand ( 'Bedrock.MkDir.bat', 1 );
Else;
  ExecuteCommand ( 'mkdir "' | sBackupDir |'"', 1);
EndIf;
# Ensure backup directory created else abort
If( FileExists( sBackupDir ) = 0 );
    nErrors = 1;
    sMessage = 'Process Quit: Could not create backup directory: ' | sBackupDir;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    ProcessQuit;
ELSE;
      sMessage = 'Backup directory exists: ' | sBackupDir;
      LogOutput('INFO', sMessage ); 
EndIf;

### Copy Data Dir to Backup ###
If(sOS @= 'Windows');
  ExecuteCommand ( 'Bedrock.Server.DataDir.Backup.bat', 1 );
Else;
  ExecuteCommand ( sText, 1 );
EndIf;

### Delete temporary files ###
sFileName = 'Bedrock.Server.DataDir.Backup.bat' ;
ASCIIDelete( LOWER(sFileName) );
sFileName = 'Bedrock.MkDir.bat';
ASCIIDelete( LOWER(sFileName) );
sFileName = 'Excludes.txt';
ASCIIDelete( LOWER(sFileName) );

sMessage = 'Temporary files deleted.';
LogOutput('INFO', sMessage ); 

### Return code & final error message handling
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
    If( pStrictErrorHandling = 1 ); 
        ProcessQuit; 
    EndIf;
Else;
    sProcessAction = Expand( 'Process:%cThisProcName% successfully Backed up Dir %pSrcDir% to dir %pTgtDir%.' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogoutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );   
    EndIf;
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
