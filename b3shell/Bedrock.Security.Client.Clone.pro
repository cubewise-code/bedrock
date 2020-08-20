﻿601,100
602,"Bedrock.Security.Client.Clone"
562,"NULL"
586,
585,
564,
565,"de94adpTcQFwQP[cF`N_opnuyUrH0bib0^W190@Nl=P\`cJOwuM9ic_TLQngz4^pPeNXiJ4?rq9UG92Pl3y4KK6IE`xziR;?uZpt@cIJagQ1S@B_n5IPs4z24L_U09H8OIe^1Hdfs;FxzfUxVJR[63gVM9xhV7F;bJtl^Gx86ggdU\xi:_J4ar^_a9]qoevNmS]mLD7o"
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
560,5
pSourceClient
pTargetClient
pMode
pDelimiter
pDebug
561,5
2
2
2
2
1
590,5
pSourceClient,""
pTargetClient,""
pMode,"REPLACE"
pDelimiter,"&"
pDebug,0
637,5
pSourceClient,"Source Client"
pTargetClient,"List of Target Clients Separated by Delimiter"
pMode,"Mode REPLACE or ADD (default = REPLACE)"
pDelimiter,"Delimiter (if a list of target users)"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,55

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4.

# This process will copy security from one user to another

# Notes:
# - Multiple clients can be specified separated by a delimiter
# - If client doesn't already exist then Bedrock.Security.Client.Create will be called
# - The process has 2 modes REPLACE (default) clears any existing group memberships. ADD only adds new ones.


### Constants ###

cProcess = 'Bedrock.Security.Client.Clone';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pSourceClient: ' | pSourceClient );
  AsciiOutput( sDebugFile, '            pTargetClient: ' | pTargetClient );
  AsciiOutput( sDebugFile, '            pMode: ' | pMode );
  AsciiOutput( sDebugFile, '            pDelimiter: ' | pDelimiter );

EndIf;

  
EXECUTEPROCESS('}bedrock.security.client.clone',
  'pLogOutput', pDebug,
  'pStrictErrorHandling',1,
  'pSrcClient', pSourceClient,
  'pTgtClient', pTargetClient,
  'pMode', pMode,
  'pDelim', pDelimiter
  );
  

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
