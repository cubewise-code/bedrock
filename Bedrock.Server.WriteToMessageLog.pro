601,100
602,"Bedrock.Server.WriteToMessageLog"
562,"NULL"
586,
585,
564,
565,"kE^dIe5d0F]ap[_bQ:^@]uOn0zsglIpPClMepyssYlmS07[rHESgrGRGkvl:1D1Lu1\ohM[YP=2rr[b@09A3UH\]6PxPBhHyY:uqwuA\;\zJ?3U?_=oZSp`0Slv7i9\uWmKAK7fRPUqEtctK0;8>U\5[nZLLPLnLmexMSbI51c>c96cYTwazyUy:TDG`oJA4XyiM1R6A"
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
pType,"pType (String) DEBUG, INFO, WARN, ERROR, FATAL"
pMessage,"pMessage (String)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,70

#****Begin: Generated Statements***
#****End: Generated Statements****


#####################################################################################
##~~Copyright bedrocktm1.org 2017 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################


# This process will write a Message into the TM1 MessageLog. 


### Constants ###

cProcess = 'WriteToMessageLog' ;
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.';
cLF = Char ( 10 );

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


### Validate Parameters ###

nErr = 0;
sErr = '';

# ValidateType

sType = Upper ( pType );
If ( sType @<> 'ERROR' & sType @<> 'DEBUG' & sType @<> 'INFO' & sType @<> 'WARN' & sType @<> 'FATAL'  );
  nErr = nErr + 1;
  sErr = 'Invalid Type: ' | pType | cLF;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sErr );
  EndIf;
EndIf;
If ( Long ( pMessage ) = 0 );
  nErr = nErr + 1;
  sErr= sErr | 'pMessage can''t be empty'  | cLF;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sErr );
  EndIf;
EndIf;

IF ( nErr >  0 );
  ItemSkip;
ENDIF;


### Action ###

LogOutput ( sType , pMessage );


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

#####################################################################################
##~~Copyright bedrocktm1.org 2017 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################


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
