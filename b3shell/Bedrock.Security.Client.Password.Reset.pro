601,100
602,"Bedrock.Security.Client.Password.Reset"
562,"NULL"
586,
585,
564,
565,"lDttXc2NfKj6aYE4>gRY2kdW>^f03Q3Rjo;ui@eVX`0EAqoG?F`3HGjSWwFt?eB7wgOB]Ogmr6KOKHc;kx:ZR6hNME8z]X8eeogQ0hhe<TV[r12WaFG9]VWE\R\meT_HFwtur^h80hej5mgw1lW7ryy8?a\2k<:BjF;A`OK\<M^bcGATM99IqYUls@\Xyn:S1o`pq=[t"
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
560,4
pClients
pPassword
pDelimiter
pDebug
561,4
2
2
2
1
590,4
pClients,""
pPassword,""
pDelimiter,"&"
pDebug,0
637,4
pClients,"Client Names Separated by Delimiter"
pPassword,"New Password"
pDelimiter,"Delimiter character"
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

#This Process was changed into shell, that will call another process from Bedrock v4.

# This process can be used by admins to reset a client password.
# If called from a workbook/websheet in conjunction with the TM1User function
# can also be used by users to change their password


### Constants ###

cProcess = 'Bedrock.Security.Client.Create';
cTM1User = TM1User();
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
  AsciiOutput( sDebugFile, 'Preocess Execute: ' | cTM1User );
  AsciiOutput( sDebugFile, 'Parameters: pClients   : ' | pClients );
  AsciiOutput( sDebugFile, '            pPassword  : *** Not logged for security reasons ***' );
  AsciiOutput( sDebugFile, '            pDelimiter : ' | pDelimiter );

EndIf;



EXECUTEPROCESS('}bedrock.security.client.password.reset',
  'pLogOutput', pDebug,
  'pStrictErrorHandling',1,
  'pClient', pClients,
  'pPassword', pPassword,
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
