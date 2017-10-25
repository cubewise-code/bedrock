601,100
602,"Bedrock.Server.Wait"
562,"NULL"
586,
585,
564,
565,"jkP>t5yGlSaLwZc@TKtp@i5c@JIwiiSk?f@bPV]_6N7YGQNtU16E^56oUCMjf_oX6dI[Up0Uh6rk?GjPvMA0lgRJpl8`XiJ;8g?pTIIW7y9`1>;0?ubdKZs923WLfZ?Mv7:wtOR>_7Xema<93iz;\mj@@:UZ3S;b7hFPAf5:m:Bdc4PrZ@O6>QdUS<AdY]^@TWp0LNTV"
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
572,38

#****Begin: Generated Statements***
#****End: Generated Statements****


#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################


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
nWaitTime = StringToNumber( pWaitSec ) * 1000;
Sleep ( nWaitTime );



573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,23

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.0.0~~##
#####################################################################################


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
