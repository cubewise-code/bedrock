601,100
562,"NULL"
586,
585,
564,
565,"j^FjSJzkw`aPxo8Pgf[ya@iEfe3sb@pdeuw0<[ZYO^yAcB?MZvB0:V`t4cU[iSGPNjm]5pvqiz1XiEuYyeQ2z:<UCd?>I<[y9niv5C=XlJcUShVNZhxrqo7ziW8h<peRO5lvt\de_aX6?xaeFDvS_oZNB?SwAqab?]nxf:QeWhfet@UMom]<Mf`iJtZ@Sb6`]YJIVdYI"
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
pDebug,0.
637,1
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,40

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 2.0.2~~##
#####################################################################################

# This process will Save All Data


### Constants ###

cProcess = 'Bedrock.Server.SaveDataAll';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 100000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

EndIf;


### Save Data ###

If( pDebug <= 1 );
  SaveDataAll;
EndIf;


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,22

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 2.0.2~~##
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
638,1
804,0
1217,1
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
