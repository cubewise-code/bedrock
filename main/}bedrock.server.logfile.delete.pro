601,100
602,"}bedrock.server.logfile.delete"
562,"NULL"
586,
585,
564,
565,"gl4YRcFa@BDWZlrYA:Wc0o>C>dr2Kre6myTZLbcBGY4SR_y:\\vBUKg_i8Eq]`1k31<pq6^nsMjBxFKD6\c=9qMDXnAU>ZLDidIroly^_s?zu22DluE4;x`f^`I9JqMMhk6_Pq^vUpNOTrebGydxAb3PHqWlrB4wFbsr>SS03SfkRQQ1J=IKsId[UET\CincM>HN5QLH"
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
560,7
pLogOutput
pStrictErrorHandling
pTgtDir
pLogDays
pErrorDays
pBedrockDays
pCSVDays
561,7
1
1
2
1
1
1
1
590,7
pLogOutput,0
pStrictErrorHandling,0
pTgtDir,""
pLogDays,7
pErrorDays,21
pBedrockDays,7
pCSVDays,7
637,7
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pTgtDir,"OPTIONAL: Log file directory. (Blank = from TM1 configuration file)"
pLogDays,"REQUIRED: The number of days to retain log Files"
pErrorDays,"REQUIRED: The number of day to retain TM1 Error Logs"
pBedrockDays,"REQUIRED: The number of days to retain Bedrock Debug Files"
pCSVDays,"REQUIRED: The number of days to retain CSV files"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,131
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.server.logfile.delete', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
	    'pTgtDir', '',
    	'pLogDays', 7, 'pErrorDays', 21, 'pBedrockDays', 7, 'pCSVDays', 7
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
# This process will deletes the log files, csv file, debug files which are 'x' days old.

# Use case: Intended for production.
# 1/ Process cleans up old files to save space on hard disk.

# Note:
# The target directory (pTgtDir) will default to setting in TM1 configuration file if left blank.
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName     = GetProcessName();
cUserName         = TM1User();
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pTgtDir:%pTgtDir%, pLogDays:%pLogDays%, pErrorDays:%pErrorDays%, pBedrockDays:%pBedrockDays%, pCSVDays:%pCSVDays%.' ;  

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

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;

IF( pTgtDir @= '');
    pTgtDir = GetProcessErrorFileDirectory;
ELSE;
    ## Remove leading and/or trailing spaces
    pTgtDir = Trim( pTgtDir );
ENDIF;

## Remove trailing \ from directory names if present
If( SubSt( pTgtDir, Long( pTgtDir ), 1 ) @= sOSDelim );
    pTgtDir = SubSt( pTgtDir, 1, Long( pTgtDir ) - 1 );
EndIf;

# Check that target Logging Directory exists
If( FileExists( pTgtDir ) = 0 );
    nErrors = 1;
    sMessage = 'Logging directory does not exist: ' | pTgtDir;
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

sLogDays        = NumberToString( ROUND( pLogDays ) );
sErrorDays      = NumberToString( ROUND( pErrorDays ) );
sBedrockDays    = NumberToString( ROUND( pBedrockDays ) );
sCSVDays        = NumberToString( ROUND( pCSVDays ) );

### Create Execute File File ###
DatasourceASCIIQuoteCharacter='';

If( sOS @= 'Windows');
  sFileName = GetProcessName() | '.bat';
  If( SubSt(pTgtDir, 1, 2) @<> '\\' );
    # local or mapped drive, use forfiles to delete files matching pattern and expiry days
    ASCIIOUTPUT(sFileName, Expand('forfiles -p "%pTgtDir%" -s -m tm1s*.log -d -%sLogDays% -c "cmd /c del @path"'));
    ASCIIOUTPUT(sFileName, Expand('forfiles -p "%pTgtDir%" -s -m tm1auditstore*.log -d -%sLogDays% -c "cmd /c del @path"'));
    ASCIIOUTPUT(sFileName, Expand('forfiles -p "%pTgtDir%" -s -m TM1ProcessError*.log -d -%sErrorDays% -c "cmd /c del @path"'));
    ASCIIOUTPUT(sFileName, Expand('forfiles -p "%pTgtDir%" -s -m Bedrock*.* -d -%sBedrockDays% -c "cmd /c del @path"'));
    ASCIIOUTPUT(sFileName, Expand('forfiles -p "%pTgtDir%" -s -m *.csv -d -%sCSVDays% -c "cmd /c del @path"'));
    ASCIIOUTPUT(sFileName, Expand('forfiles -p "%pTgtDir%" -s -m *.cma -d -%sCSVDays% -c "cmd /c del @path"'));
    ASCIIOUTPUT(sFileName, Expand('forfiles -p "%pTgtDir%" -s -m *.txt -d -%sCSVDays% -c "cmd /c del @path"'));
  Else;
    # UNC shared folder path (forfiles command doesn't work with UNC use robocopy instead, create temp dir, move files to temp dir, then delete folder and contents)
    ASCIIOUTPUT(sFileName, Expand('robocopy "%pTgtDir%" "%pTgtDir%\bedrocklogclear" "tm1s*.log" /mov /purge /MINAGE:%sLogDays% /copyall /s'));
    ASCIIOUTPUT(sFileName, Expand('robocopy "%pTgtDir%" "%pTgtDir%\bedrocklogclear" "tm1auditstore*.log" /mov /purge /MINAGE:%sLogDays% /copyall /s'));
    ASCIIOUTPUT(sFileName, Expand('robocopy "%pTgtDir%" "%pTgtDir%\bedrocklogclear" "Bedrock*.*" /mov /purge /MINAGE:%sErrorDays% /copyall /s'));
    ASCIIOUTPUT(sFileName, Expand('robocopy "%pTgtDir%" "%pTgtDir%\bedrocklogclear" "TM1ProcessError*.log" /mov /purge /MINAGE:%sBedrockDays% /copyall /s'));
    ASCIIOUTPUT(sFileName, Expand('robocopy "%pTgtDir%" "%pTgtDir%\bedrocklogclear" "*.csv" /mov /purge /MINAGE:%sCSVDays% /copyall /s'));
    ASCIIOUTPUT(sFileName, Expand('robocopy "%pTgtDir%" "%pTgtDir%\bedrocklogclear" "*.cma" /mov /purge /MINAGE:%sCSVDays% /copyall /s'));
    ASCIIOUTPUT(sFileName, Expand('robocopy "%pTgtDir%" "%pTgtDir%\bedrocklogclear" "*.txt" /mov /purge /MINAGE:%sCSVDays% /copyall /s'));
    ASCIIOUTPUT(sFileName, Expand('rmdir /s /q "%pTgtDir%\bedrocklogclear"'));
  EndIf;
Else;
  sFileName = GetProcessName() | '.sh';
  ASCIIOUTPUT(sFileName, Expand('find "%pTgtDir%" -type f -mtime +%sLogDays% -name "tm1s*.log" -exec rm {}\;'));
  ASCIIOUTPUT(sFileName, Expand('find "%pTgtDir%" -type f -mtime +%sLogDays% -name "tm1auditstore*.log" -exec rm {}\;'));
  ASCIIOUTPUT(sFileName, Expand('find "%pTgtDir%" -type f -mtime +%sErrorDays% -name "TM1ProcessError*.log" -exec rm {}\;'));
  ASCIIOUTPUT(sFileName, Expand('find "%pTgtDir%" -type f -mtime +%sBedrockDays% -name "bedrock*.*" -exec rm {}\;'));
  ASCIIOUTPUT(sFileName, Expand('find "%pTgtDir%" -type f -mtime +%sCSVDays% -name "*.csv" -exec rm {}\;'));
  ASCIIOUTPUT(sFileName, Expand('find "%pTgtDir%" -type f -mtime +%sCSVDays% -name "*.cma" -exec rm {}\;'));
  ASCIIOUTPUT(sFileName, Expand('find "%pTgtDir%" -type f -mtime +%sCSVDays% -name "*.txt" -exec rm {}\;'));
EndIf;

### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,37

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 3.0.0~~##
################################################################################################# 

### Copy Data Dir to Backup ###
sCommand = sFileName;

If(sOS @= 'Windows');
  ExecuteCommand( sCommand, 1 );
Else;
  ExecuteCommand( 'sh ' | sCommand, 1 );
EndIf;
ASCIIDelete( sFileName);

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully deleted log files from %pTgtDir% older then  %pLogDays%.' );
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
