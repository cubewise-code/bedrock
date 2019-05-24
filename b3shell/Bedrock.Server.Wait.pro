601,100
602,"Bedrock.Server.Wait"
562,"NULL"
586,
585,
564,
565,"n=T@\t691C=P^4aY63Z]_>DQAt`@p57D@G_>KAu9;i<?UFVYxasCzQBN[Zr8Sw[nYSQwD5tzcvsFY_?Qr7S1trDd\3LS]f<:I]6V@@<hfvX[T\;Q_69;N3s4e`5`h8YpgtT\Hs6k0QEMr^55SS89[^TpB]NP2p2sUu;:rdhShFmi4mM9`h^\q0NVyioExC\PJp;1>44v"
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
560,2
pWaitSec
pDebug
561,2
2
1
590,2
pWaitSec,""
pDebug,0
637,2
pWaitSec,"Seconds"
pDebug,""
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,43

#****Begin: Generated Statements***
#****End: Generated Statements****


################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4.

### Constants ###

cProcess = 'Bedrock.Server.Wait';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;

### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  AsciiOutput( sDebugFile, '' );
  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pWaitSec:      ' | pWaitSec );

EndIf;

### SLEEP ##
#nWaitTime = StringToNumber( pWaitSec ) * 1000;
#Sleep ( nWaitTime );


EXECUTEPROCESS('}bedrock.server.wait',
  'pLogOutput', pDebug,
  'pWaitSec', StringToNumber( pWaitSec )
  );

573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

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


### End Prolog ###
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
