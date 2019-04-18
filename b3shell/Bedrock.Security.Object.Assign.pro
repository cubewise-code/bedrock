601,100
602,"Bedrock.Security.Object.Assign"
562,"NULL"
586,
585,
564,
565,"vX_fwSWUsa]vzJX\EE`>EEa<[3X;iGmgwpM>DLJqyKm8LiB?FrJ9z;UANxPxxV9jNVP0bIDtmtZEm6LFzB[agvY_^ItSveLSz:35Q^klfpu?O^xuBrhD_7rhPfXhHeP;?NmPZ]WpRJu2X5MPjxa=hZ3E0@w\qG[3BvmnnG`8Ghy\hRId<J;brbczMcLI1H?j5oEPJ5tM"
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
560,7
pGroups
pObjectType
pObjects
pSecurityLevel
pSecurityRefresh
pDelimiter
pDebug
561,7
2
2
2
2
2
2
1
590,7
pGroups,""
pObjectType,""
pObjects,""
pSecurityLevel,""
pSecurityRefresh,"No"
pDelimiter,"&"
pDebug,0
637,7
pGroups,"List of Groups Separated by Delimiter"
pObjectType,"Type of Object to Assign Security To (Application/Cube/Dimension/Process/Chore)"
pObjects,"List of Objects Separated by Delimiter"
pSecurityLevel,"Security Level (Read/Write/Admin/None)"
pSecurityRefresh,"Refresh Security? (Default = No)"
pDelimiter,"Delimiter"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,62

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4.

# This process will assign security to specified object

# Note:
# - Before using this process, you must first initialise object security.
# - For Applications, in Server Explorer go to Applications -> Security Assignments and assign
#   an access security for an Application. For other object types follow a similar process but for that object type
# - Then from the Server Explorer go to your ServerName -> Security -> Refresh Security
# - Multiple groups can be specified separated by delimiter
# - Multiple objects can be specified separated by delimiter
# - If groups and/or objects that don't exist are specified, then they will be skipped but
#   valid groups and ojects will still be processed


### Constants ###

cProcess = 'Bedrock.Security.Object.Assign';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;
cSecurityCube = '}' | pObjectType | 'Security';


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pGroups          : ' | pGroups );
  AsciiOutput( sDebugFile, '            pObjectType      : ' | pObjectType );
  AsciiOutput( sDebugFile, '            pObjects         : ' | pObjects );
  AsciiOutput( sDebugFile, '            pSecurityLevel   : ' | pSecurityLevel );
  AsciiOutput( sDebugFile, '            pSecurityRefresh : ' | pSecurityRefresh );
  AsciiOutput( sDebugFile, '            pDelimiter       : ' | pDelimiter );

EndIf;


EXECUTEPROCESS('}bedrock.security.object.assign',
  'pLogOutput', pDebug,
  'pGroup', pGroups,
  'pObjectType', pObjectType,
  'pObject', pObjects,
  'pSecurityLevel', pSecurityLevel,
  'pSecurityRefresh', pSecurityRefresh,
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
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
