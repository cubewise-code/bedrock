601,100
602,"Bedrock.Security.Client.Group.Assign"
562,"NULL"
586,
585,
564,
565,"dB\nan]FfL5BoLg@hA@qMmS37wRUnsr[PRR_\Chr:7UfgQ77t:sV=x;J5i0I5oy36OSJ?EGagnU9H2SPRa23jYFQ>6HBlvU@m8TczQ1SMreAyPZ;gIZ8knCuLirG3ahE0fR@fowHufbDiQR9wIWd<]iu2sxI4Y=w2YLWem5jg38]bL:3Hf>uZo:L8IwDY:_fnnosR^\f"
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
560,6
pClients
pGroups
pDelimiter
pAddOrRemove
pSecurityRefresh
pDebug
561,6
2
2
2
2
2
1
590,6
pClients,""
pGroups,""
pDelimiter,"&"
pAddOrRemove,"Add"
pSecurityRefresh,"Yes"
pDebug,0
637,6
pClients,"Client Names Separated by Delimiter"
pGroups,"Group Names Separated by Delimiter"
pDelimiter,"Delimiter"
pAddOrRemove,"Add or Remove"
pSecurityRefresh,"Refresh Security?"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,60

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4.

# This process will assign Client and Group Security

# Notes:
# - This process can either add or remove clients to groups based on pAddOrRemove
# - This process can work on a single client or multiple clients separated by a delimiter
# - This process can work on a single group or multiple groups separated by a delimiter
# - Therefore, it can be used to:
#   - Add/remove a single client to/from a single group
#   - Add/remove many clients to/from a single group
#   - Add/remove a single client to/from many groups
#   - Add/remove many clients to/from many groups
# - The caller can choose whether or not to refresh security at the end. Default is yes


### Constants ###

cProcess = 'Bedrock.Security.Client.Group.Assign';
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
  AsciiOutput( sDebugFile, 'Parameters: pClients         : ' | pClients );
  AsciiOutput( sDebugFile, '            pGroups          : ' | pGroups );
  AsciiOutput( sDebugFile, '            pAddOrRemove     : ' | pAddOrRemove );
  AsciiOutput( sDebugFile, '            pSecurityRefresh : ' | pSecurityRefresh );
  AsciiOutput( sDebugFile, '            pDelimiter       : ' | pDelimiter );

EndIf;

EXECUTEPROCESS('}bedrock.security.client.group.assign',
  'pLogOutput', pDebug,
  'pStrictErrorHandling',1,
  'pClient', pClients,
  'pGroup', pGroups,
  'pDelim', pDelimiter,
  'pAddOrRemove', pAddOrRemove,
  'pSecurityRefresh', pSecurityRefresh
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
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
