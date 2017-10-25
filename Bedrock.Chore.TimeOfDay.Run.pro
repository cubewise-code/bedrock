601,100
602,"Bedrock.Chore.TimeOfDay.Run"
562,"NULL"
586,
585,
564,
565,"qQJN=D7XtdwC49UAja;bC8:1q\_P?[@r5upyWiau>wpEUj[Ij<TP^;<vkaEBPra6GJbzCsc[W=UEI1e>BI3uoBFu2_m>2kRn\pk]NVdCyPy7DStjzOeCa2DZDGrs0YleUp6xaGMYhnWx<8yrErfYR4l0yedNU>6`=QK^AxEs=wQa?2@MWcV_?9Z[2`12AFZg=ZQnoCK4"
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
pStartTime
pEndTime
pDebug
561,3
1
1
1
590,3
pStartTime,7
pEndTime,22
pDebug,0
637,3
pStartTime,"Time to start running chore from in 24 hr time (at start of hour)"
pEndTime,"Time to finish chore being able to start in 24 hr time (at end of hour)"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,67

#****Begin: Generated Statements***
#****End: Generated Statements****


####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will quit a chore if the day of the week index does not validate against the week parameter.


### Constants ###

cProcess = 'Bedrock.Chore.TimeOfDay.Run';
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
  AsciiOutput( sDebugFile, 'Parameters:    pStarttime: ' | NumberToString ( pStarttime) );
  AsciiOutput( sDebugFile, '               pEndtime: ' | NumberToString ( pEndtime) );
  AsciiOutput( sDebugFile, '' );

EndIf;

################################
##~~    Check whether to run: do not run during overnight batch window

sMinute = TIMST(NOW, '\h:\i:00');
vTimeNow = StringToNumber(SubSt(sMinute, 1, 2));
bQuit = 0;

IF( pStartTime = 0 % pEndTime = 0 % pEndTime <= pStartTime );
  # time exclusion parameters are incorrect so we ignire them
ElseIF( vTimeNow < pStartTime % vTimeNow > pEndTime );
  # exclusion params are OK and we are in the exclusion zone do not execute Data tab, proceed directly to Epilog
  bQuit = 1;
Else;
  # exclusion params are OK and we are not in the exclusion zone, proceed as normal 
EndIF;

If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'Time is: ' | sMinute );
EndIf;

If( bQuit = 1 );
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, 'Chore will quit.' );
  # Log finish time
  AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  EndIf;
  If( pDebug <= 1 );
    ChoreQuit;
  EndIf;
EndIf;

573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,3

#****Begin: Generated Statements***
#****End: Generated Statements****
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
