﻿601,100
602,"Bedrock.Security.Refresh"
562,"NULL"
586,
585,
564,
565,"kw0coUwQc5raPdeC2d2`A7ZtA653NiYSudltHPn_[7hiMY7EkA2N0_sxHB9SvcOgD7`<p60jvgi\J_l0c\OdHF@rO6fiYOjygt]Lx0z7Hf9sCN6:d15jd7iX3opbhVv8YVz1>yrl1De\bjOrCcc]@Bk17D_m5@7E4UH`c0jjMII=G;cmlhF`T<3lh]3OO?sZHeThDYon"
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
560,1
pDebug
561,1
1
590,1
pDebug,0
637,1
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,42

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4.

# This process refreshes TM1 security


### Constants ###

cProcess = 'Bedrock.Security.Refresh';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

EndIf;



EXECUTEPROCESS('}bedrock.security.refresh',
  'pLogOutput', pDebug
  );
  


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,10

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 



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
920,0
921,""
922,""
923,0
924,""
925,""
926,""
927,""
