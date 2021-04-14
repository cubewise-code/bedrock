601,100
602,"}bedrock.server.dir.backup"
562,"NULL"
586,
585,
564,
565,"zau=kBQo@r95WR]@:T<q?rth8aaz7x=gyDsiyc\eIqikxzVo;eHSVEkboR<@NM8HakZuIo_Ap5WBytZi[B:<Lj=r[m^<9XC8L2j8DTA<9O4Pfs:0Hjw4td5wC6PTP<0@M4sx=^djlc<26GLo@Sk4i7z1r4[BW:?VFwd028Me13eKwl<V`6=zu0eHz6KOUWLC[HgyFrro"
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
560,8
pLogOutput
pStrictErrorHandling
pSrcDir
pTgtDir
pExcludeFilter
pDelim
pSubDirCopy
pRobocopy
561,8
1
1
2
2
2
2
1
1
590,8
pLogOutput,0
pStrictErrorHandling,0
pSrcDir,"."
pTgtDir,""
pExcludeFilter,".log & .cfg & .csv & .cmal & .txt & .feeders"
pDelim,"&"
pSubDirCopy,1
pRobocopy,0
637,8
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pSrcDir,"REQUIRED: Source Directory to Backup"
pTgtDir,"REQUIRED: Destination Directory for Backup"
pExcludeFilter,"OPTIONAL: Exclude filter (To include all files use pFilterExclude = """")"
pDelim,"OPTIONAL: Delimiter"
pSubDirCopy,"OPTIONAL: Include subdirectories? (Boolean True = 1)"
pRobocopy,"OPTIONAL: Use robocopy? (Boolean True = 1), WIN only"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,186
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.server.dir.backup', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pSrcDir', '.', 'pTgtDir', '','pExcludeFilter', '.cub & .dim', 'pDelim', '&', 'pSubDirCopy ', 1, 'pRobocopy ', 1
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
cLogInfo            = 'Process:%cThisProcName% run with parameters pSrcDir:%pSrcDir%, pTgtDir:%pTgtDir%, pExcludeFilter:%pExcludeFilter%, pDelim:%pDelim%, pSubDirCopy:%pSubDirCopy%, pRobocopy:%pRobocopy%.' ;

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
If( SubSt( GetProcessErrorFileDirectory, 2, 1 ) @= ':' );
  sOS = 'Windows';
  sOSDelim = '\';
ElseIf( Scan( '/', GetProcessErrorFileDirectory ) > 0 );
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
ExecuteProcess( '}bedrock.server.savedataall', 'pStrictErrorHandling', pStrictErrorHandling );
sMessage = 'TM1 Save Data All Complete.';
If( pLogoutput = 1 );
	LogOutput('INFO', sMessage ); 
EndIf;

### Create batch files
DatasourceASCIIQuoteCharacter='';

### Create Make Directory Batch File
sFileName           = 'Bedrock.MkDir.bat' ;
sBackupDir          = pTgtDir | sOSDelim | 'TM1Backup_' | cTimeStamp;
If(sOS @= 'Windows');
  ASCIIOUTPUT( sFileName, 'md "' | sBackupDir |'"' );
EndIf;

### Create Exclude File ###
If(pRobocopy = 1);
	# robocopy uses different file format with rcj file and * wildcard character
	sFileNameExclude =  pSrcDir | sOSDelim | 'Excludes' | cTimeStamp | cRandomInt| '.rcj';
    ASCIIOUTPUT( sFileNameExclude, '/xf');
    sExcludeWCPrefix = '*';
Else;
	sFileNameExclude =  'Excludes' | cTimeStamp | cRandomInt| '.txt';
    sExcludeWCPrefix = '';
EndIf;
pExcludeFilter = TRIM(pExcludeFilter);

If(pExcludeFilter @<> ''); 
    If( SCAN(pDelim, pExcludeFilter) > 0);
        # parse multiple exclusions
        While(LONG(pExcludeFilter) > 0);
            If(SCAN(pDelim, pExcludeFilter) > 0);
                sExcludePart = TRIM(SUBST(pExcludeFilter, 1, SCAN(pDelim, pExcludeFilter) - 1));
                pExcludeFilter = TRIM(DELET(pExcludeFilter, 1,SCAN(pDelim, pExcludeFilter) + LONG(pDelim) - 1));
            Else;
                sExcludePart = pExcludeFilter;
                pExcludeFilter = '';
            EndIf;
            ASCIIOUTPUT( sFileNameExclude, sExcludeWCPrefix | sExcludePart);
        End;
    Else;
        ASCIIOUTPUT( sFileNameExclude, sExcludeWCPrefix | pExcludeFilter);
    EndIf;
Else;
    ASCIIOUTPUT( sFileNameExclude, '');
EndIf;

### Create Batch File ###
sFileName = 'Bedrock.Server.DataDir.Backup.bat';
If(sOS @= 'Windows');
  If(pSubDirCopy = 1);
  	cSubDirCopy = '/s /e';
  Else;
  	cSubDirCopy = '';
  EndIf;
  If(pRobocopy = 1);
  	sText = 'robocopy "'| pSrcDir |'" "'| sBackupDir | '" '  | cSubDirCopy | ' /job:"'| sFileNameExclude | '"';
  Else;
  	sText = 'XCOPY "'| pSrcDir |'" "'| sBackupDir|'" /i /c '| cSubDirCopy |' /y /exclude:'| sFileNameExclude;
  EndIf;
  ASCIIOUTPUT( sFileName, '@ECHO OFF');
  ASCIIOUTPUT( sFileName, sText );
Else;
  #sOS is Linux
  If(pSubDirCopy = 1);
  	cSubDirCopy = 'r';
  Else;
  	cSubDirCopy = '';
  EndIf;
  sText = 'rsync -' | cSubDirCopy | 't --exclude-from=' | sFileNameExclude | ' "' | pSrcDir | '" "' | sBackupDir |'"';
EndIf;

sMessage = 'Command Line: ' | sText;
If( pLogoutput = 1 );
	LogOutput('INFO', sMessage ); 
EndIf;

### End Prolog ###
573,1

574,1

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
sFileName = sFileNameExclude;
ASCIIDelete( LOWER(sFileNameExclude) );

sMessage = 'Temporary files deleted.';
If( pLogoutput = 1 );
 	LogOutput('INFO', sMessage ); 
EndIf;

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
576,_ParameterConstraints=e30=
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
