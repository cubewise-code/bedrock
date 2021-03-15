601,100
602,"Bedrock.Server.DataDir.ListContents"
562,"NULL"
586,
585,
564,
565,"ieUfkI;Wja<VHDFBtuExl\eT^<Ut\iHF1arPOwpO^kJO0jdHnNkgm0sfuSw:V8RtI3`i7Ju=w0;ER83tzZ_a9Lxu8GtZ0\>ef7T4_S9eUqkR?wIPY6rldYs@_RYTTqAXH3t6L6mw7\Zv;5td5nfrmMbdtMPa]QX57M`sr^@GgZWn_AdkU@I]Jvg:BpPEWV5EiHhoe?_x"
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
560,2
pDataDir
pDebug
561,2
2
1
590,2
pDataDir,""
pDebug,1
637,2
pDataDir,"Data Directory (Leave Blank to use TM1 Settings)"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,53

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

# This process will list all files and processes in the data directory
# as text file output in the data directory itself
# In some cases the path to the batch file (in the data directory) must be fully qualified
#This Process was changed into shell, that will call another process from Bedrock v4.

### Constants ###

cProcess = 'Bedrock.Server.DataDir.ListContents';
cUser = TM1User();
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;
cBatchFile = cProcess | '.bat';


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  AsciiOutput( sDebugFile, 'TM1 User:        ' | cUser );
  AsciiOutput( sDebugFile, '' );
  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDataDir: ' | pDataDir );
  AsciiOutput( sDebugFile, '' );
EndIf;


### Build Command ###
nErrors = 0;


EXECUTEPROCESS('}bedrock.server.dir.listcontents',
  'pLogOutput', pDebug,
  'pStrictErrorHandling',1,
  'pSrcDir', pDataDir
  );



### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,23

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
