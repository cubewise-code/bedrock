601,100
602,"Bedrock.Cube.View.Publish"
562,"NULL"
586,
585,
564,
565,"k3R7R1`4I2SagG:FYgapakaETIo3;1Po`PstFM7uey]pTVZh_G<T:S4XUq`I:H0dsUaL\gLUE@;[omIew@St:qNEYwT62CkjXd8SG0\;^MC0:FY0Vo:mN6BmSsqoQHcAP?<0B[zZOlAg_r0jlMc<aRnXpZ^S6NtAgkJm;fL3Fss`8h[TAe\`lKTheJ=_?5Ah`FW`M=yo"
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
pClient
pCube
pView
pSubPublish
pOverwrite
pDebug
561,6
2
2
2
1
1
1
590,6
pClient,""
pCube,""
pView,""
pSubPublish,1
pOverwrite,0
pDebug,0
637,6
pClient,"Client Name"
pCube,"Cube Name"
pView,"Private View Name"
pSubPublish,"Publish Private Subsets? (Boolean 1=Yes)"
pOverwrite,"Overwrite Existing Named View? (Boolean 1=Yes)"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,67

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4.

### Constants ###

cProcess = 'Bedrock.Cube.View.Publish';
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

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pClient     : ' | pClient );
  AsciiOutput( sDebugFile, '            pCube       : ' | pCube );
  AsciiOutput( sDebugFile, '            pView       : ' | pView );
  AsciiOutput( sDebugFile, '            pSubPublish : ' | NumberToString( pSubPublish ) );
  AsciiOutput( sDebugFile, '            pOverwrite  : ' | NumberToString( pOverwrite ) );

EndIf;

sProc = '}bedrock.cube.view.publish';

nRes = EXECUTEPROCESS( sProc,
  'pLogOutput', pDebug,
  'pCube', pCube,
  'pView', pView,
  'pSubPublish', pSubPublish,
  'pOverwrite', pOverwrite
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

575,18

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 


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
