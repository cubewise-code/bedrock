601,100
602,"Bedrock.Server.WriteToMessageLog"
562,"NULL"
586,
585,
564,
565,"aaG2fVf7dHGIKUJLVguASa`X2Yc90aN;@sE4kwM4o=A9X[qMNuzd[iAO>A\KOSp^QKC]AuaoxR@VlGSG8u?:cR:XZhR3:FC^J0TE:5q4soI<MV>KcPn5sC]TkkEIFH?HmQ4^@>meX=pU3JF2[SMA9HeOqBrHQ6S>>ERIiY9QEHtL[Q9?s[y1RmGv[Ml0?1kqomH:h^o_"
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
560,3
pDebug
pType
pMessage
561,3
1
2
2
590,3
pDebug,0
pType,""
pMessage,""
637,3
pDebug,"Debug Mode (String)"
pType,"pType (String) INFO, DEBUG or ERROR"
pMessage,"pMessage (String)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,50

#****Begin: Generated Statements***
#****End: Generated Statements****


################################################################################################# 
##~~Copyright bedrocktm1.org 2017 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
################################################################################################# 


# This process will write a Message into the TM1 MessageLog. 
#This Process was changed into shell, that will call another process from Bedrock v4.

### Constants ###

cProcess = 'WriteToMessageLog' ;
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.';
cLF = Char ( 10 );

### Validate Parameters ###

nErr = 0;
sErr = '';

### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pType : ' | pType );
  AsciiOutput( sDebugFile, '            pMessage : ' | pMessage );
EndIf;


  EXECUTEPROCESS('}bedrock.server.writetomessagelog',
  'pLevel', pType,
  'pStrictErrorHandling',1,
  'pMessage', pMessage
  );



### End Prolog ###
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,33

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';

  # Log errors
  If( nErr <> 0 );
    AsciiOutput( sDebugFile, 'Errors Occurred' );
  EndIf;

  # Log finish time
  AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

EndIf;


If( nErr <> 0 );
  ItemReject( sErr );
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
