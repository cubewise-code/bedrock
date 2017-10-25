601,100
602,"Bedrock.Chore.DayOfWeek.Run"
562,"NULL"
586,
585,
564,
565,"ydsGYD7E@v>bCee87;^yRqh]eaiPNsXTmZoT;a:i@bh;a=ihEt45LdvqEj8JbhaD9FGiTDYPzvGNOVaRtqST`tQVl][MS`paD<Dc9iH0z0kvX81^ABdtk5y8x0AirHm19wJWTl?x:m[unuejCTjY[zw2TU\mHbj[VtCi[\ON7M>`3BMtBAxV[1h5@_JpZ9ZsmqYv1i7A"
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
560,8
pSunday
pMonday
pTuesday
pWednesday
pThursday
pFriday
pSaturday
pDebug
561,8
1
1
1
1
1
1
1
1
590,8
pSunday,1
pMonday,1
pTuesday,1
pWednesday,1
pThursday,1
pFriday,1
pSaturday,1
pDebug,0
637,8
pSunday,"(1) Run Chore on Sunday"
pMonday,"(1) Run Chore on Monday"
pTuesday,"(1) Run Chore on Tuesday"
pWednesday,"(1) Run Chore on Wednesday"
pThursday,"(1) Run Chore on Thursday"
pFriday,"(1) Run Chore on Friday"
pSaturday,"(1) Run Chore on Saturday"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,170

#****Begin: Generated Statements***
#****End: Generated Statements****


####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will quit a chore if the day of the week index does not validate against the week parameter.


### Constants ###

cProcess = 'Bedrock.Chore.DayOfWeek.Run';
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
  AsciiOutput( sDebugFile, 'Parameters:    pSunday: ' | NumberToString ( pSunday) );
  AsciiOutput( sDebugFile, '               pMonday: ' | NumberToString ( pMonday) );
  AsciiOutput( sDebugFile, '              pTuesday: ' | NumberToString ( pTuesday) );
  AsciiOutput( sDebugFile, '            pWednesday: ' | NumberToString ( pWednesday) );
  AsciiOutput( sDebugFile, '             pThursday: ' | NumberToString ( pThursday) );
  AsciiOutput( sDebugFile, '               pFriday: ' | NumberToString ( pFriday) );
  AsciiOutput( sDebugFile, '             pSaturday: ' | NumberToString ( pSaturday) );
  AsciiOutput( sDebugFile, '' );

EndIf;

## Get the day of the week index
nDayIndex = MOD( DayNo ( TODAY ) + 21915, 7 );

If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'Current Day Index: ' | NumberToString ( nDayIndex ) );
EndIf;

## Calculate the Natural Day
IF(
nDayIndex = 0 );
  sWeekday = 'Sunday';

ELSEIF(
nDayIndex = 1 );
  sWeekday = 'Monday';

ELSEIF(
nDayIndex = 2 );
  sWeekday = 'Tuesday';

ELSEIF(
nDayIndex = 3 );
  sWeekday = 'Wednesday';

ELSEIF(
nDayIndex = 4 );
  sWeekday = 'Thursday';

ELSEIF(
nDayIndex = 5 );
  sWeekday = 'Friday';

ELSEIF(
nDayIndex = 6 );
  sWeekday = 'Saturday';

ELSE;
  sWeekday = '';
ENDIF;

If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'Current Day      : ' | sWeekday );
EndIf;


## Validate the Day of the Week index
IF(
nDayIndex = 0 &
pSunday = 1 );
  If( pDebug >= 1 );
    sMessage = 'Processing Chore on ' | sWeekday | '.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
## Continue

ELSEIF(
nDayIndex = 1 &
pMonday = 1 );
  If( pDebug >= 1 );
    sMessage = 'Processing Chore on ' | sWeekday | '.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ## Continue

ELSEIF(
nDayIndex = 2 &
pTuesday = 1 );
  If( pDebug >= 1 );
    sMessage = 'Processing Chore on ' | sWeekday | '.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ## Continue

ELSEIF(
nDayIndex = 3 &
pWednesday = 1 );
  If( pDebug >= 1 );
    sMessage = 'Processing Chore on ' | sWeekday | '.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ## Continue

ELSEIF(
nDayIndex = 4 &
pThursday = 1 );
  If( pDebug >= 1 );
    sMessage = 'Processing Chore on ' | sWeekday | '.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ## Continue

ELSEIF(
nDayIndex = 5 &
pFriday = 1 );
  If( pDebug >= 1 );
    sMessage = 'Processing Chore on ' | sWeekday | '.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ## Continue

ELSEIF(
nDayIndex = 6 &
pSaturday = 1 );
  If( pDebug >= 1 );
    sMessage = 'Processing Chore on ' | sWeekday | '.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ## Continue

ELSE;  
  If( pDebug >= 1 );
    sMessage = 'Chore quitted on ' | sWeekday | '.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;

  If( pDebug <= 1 );
    ChoreQuit;
  EndIf;
ENDIF;


### Initialise Debug ###
If( 
pDebug >= 1 );

  # Log finish time
  AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

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
