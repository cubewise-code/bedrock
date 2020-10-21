601,100
602,"Bedrock.Server.DataDir.Backup"
562,"NULL"
586,
585,
564,
565,"hLq1rLEIaz6V28z^hvkAVdxi86:mayR:ypXXz8?i8qhsGOtcG]Ibib<em]9qEzYS<QO9yKU@YdIl23AiAWof9A1r\4CIh0ItI<xdC`;0@L??gNqu?LfEt^^X?jQ0ZH4OBo>2D@gaTV7Sa`2YIhDSmVYV29v\5j`pp?Owa>62cI?HQAjFJxf>JFjO9vtOzIy@7x3v<oCJ"
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
pDataDir,"Source Directory to Backup"
pBackupDir,"Destination Directory for Backup"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,64

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 


#This Process was changed into shell, that will call another process from Bedrock v4.

### Constants ###

cProcess = 'Bedrock.Server.DataDir.Backup';
cUser = TM1User();
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;
cMsgErrorLevel = 'ERROR';
cMsgErrorContent = '%cProcess% : %sMessage% : %cUser%';
cMsgErrorShell = Expand('Executing process %cProcess% has failed.');

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


sProc = '}bedrock.server.dir.backup';

nRes = EXECUTEPROCESS( sProc,
  'pLogOutput', pDebug,
  'pStrictErrorHandling',1,
  'pSrcDir', pDataDir,
  'pTgtDir', pBackupDir
  );
  


IF ( nRes <> ProcessExitNormal() );
  sMessage = cMsgErrorShell;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  if ( pDebug >= 1 );
    AsciiOutput( sDebugFile, Expand( cMsgErrorContent ) );
    AsciiOutput( sDebugFile, Expand( 'Process exit code: %nRes%' ) );
    AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  endif;
  ProcessError();
ENDIF;


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,22

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 


### Initialise Debug ###

If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';
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
