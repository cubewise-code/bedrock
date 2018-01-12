601,100
602,"Bedrock.Cube.Data.Clear.All"
562,"NULL"
586,
585,
564,
565,"elaZ[yjl^DbSSu<w`1WUuRc:F5LSaUdw0Ag6M8YkS3Hu=JZdhKnL3]DIkfTAu<:BlV4wJiPWVOk1qte_D]6`OW?6@CC\]\WND8e2=wV>PtbP^gDsQbUjw1g=_?1^K?eJ;k2:pslLEIn{rtBff@u=mN2zIty5euf@j=oejF:1bXqpcymRsKwdkH[[J3OpwtV0F?IHagCK"
559,0
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
pCube
pDebug
561,2
2
1
590,2
pCube,""
pDebug,0
637,2
pCube,"Cube Name"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,72

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process clears a whole cube usig the CubeClearData function
# It can handle specific element references for any number of dimensions and elements.


### Constants ###

cProcess = 'Bedrock.Cube.Data.Clear.All';
cUser = TM1User();
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;
cDefaultView = 'zBedrock.' | sRandomInt ;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  AsciiOutput( sDebugFile, 'TM1 User:        ' | cUser );
  AsciiOutput( sDebugFile, '' );
  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCube:              ' | pCube );
  AsciiOutput( sDebugFile, '' );

EndIf;


### Validate Parameters ###

nErrors = 0;

# If no cube has been specified then terminate process
If( Trim( pCube ) @= '' );
  If( pDebug >= 1 );
    sMessage = 'No cube specified';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

# If specified cube does not exist then terminate process
If( CubeExists( pCube ) = 0 );
  If( pDebug >= 1 );
    sMessage = 'Cube: ' | pCube | ' does not exist';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

### Clear the cube ###
If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'Clearing the cube.' );
EndIf;
If( pDebug <= 1 );
   CubeClearData( pCube );
EndIf;


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,25

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################


### Initialise Debug ###

If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';

EndIf;

If( pDebug >= 1 );
  # Log finish time
  AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

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
918,0
919,0
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
