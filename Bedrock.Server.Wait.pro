601,100
602,"Bedrock.Server.Wait"
562,"NULL"
586,
585,
564,
565,"d:K1aS4qRkMM3FKsVeQVel47AJ\FycLzF0]Y\[VF5kki:as;LJL<dnRWdw3EcUvQM`u7mBHO>MO7Ijq;wK84a^8Ra0FqNg8RqOL\=H<G^;5KFi:rtn1sg@G1<7=WIdxJK<\qabLAk]WLHUSkG^fCs5?PNcWyTYlGnUvYAK>m7jB@K=9WpimJqwmVQGwiWI]<ThmYJbD>"
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
pWaitSec,Seconds
pDebug,
577,0
578,0
579,0
580,0
581,0
582,0
572,43

#****Begin: Generated Statements***
#****End: Generated Statements****


#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.0.0~~##
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

### LOOP TIME ##
nStartNow = NOW();
nWaitTime = nStartNow + ( StringToNumber( pWaitSec ) / 86400 );


nTime = NOW();
WHILE( nTime <= nWaitTime );
  nTime = NOW();
END;


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
