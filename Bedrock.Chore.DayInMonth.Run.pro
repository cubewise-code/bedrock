601,100
602,"Bedrock.Chore.DayInMonth.Run"
562,"NULL"
586,
585,
564,
565,"bmaiKP0ujPW^`QNl5`sXIVDmX5=S>C:4kWWB8SN2@WujsTUMqN:=9b5_`zQ27qE0P_ynjmb9h01m9r447eysUI<x3W`V@?]PLd=gIf^]<_>rv3irfIi`qH2hk3MW]ykV?siLRAni3T^Q7BFed=S@6qbrBT5;LLKhbSqX@n7]pJvNk8z@CCe=uzO_Hc9HALs>fwoIDEdN"
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
pDays
pDelimiter
pDebug
561,3
2
2
1
590,3
pDays,""
pDelimiter,"&"
pDebug,0
637,3
pDays,"Delimited string of days in month as dd e.g. 1 & 2 & 30 & 31"
pDelimiter,""
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,64

#****Begin: Generated Statements***
#****End: Generated Statements****


####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will quit a chore if the day of the month does not validate against the parameter.


### Constants ###

cProcess = 'Bedrock.Chore.DayInMonth.Run';
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
  AsciiOutput( sDebugFile, 'Parameters:    pDays: ' | pDays );
  AsciiOutput( sDebugFile, '               pDelimiter: ' | pDelimiter );
  AsciiOutput( sDebugFile, '' );

EndIf;

################################
##~~    Check whether to run: do not run during overnight batch window

sDay = TIMST(NOW, '\d');
bQuit = 0;

IF( Scan( sDay, pDays ) = 0 & Scan( pDelimiter | sDay, pDays ) = 0 & Scan( sDay | pDelimiter, pDays ) = 0 & Scan( pDelimiter |' '| sDay, pDays ) = 0 & Scan( sDay |' '| pDelimiter, pDays ) = 0 );
  # could not find the day in the list of acceptable days
  bQuit = 1;
Else;
  # day is within the list of run params are, proceed as normal 
EndIF;

If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'The day of the month is: ' | sDay );
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
