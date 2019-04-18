601,100
602,"Bedrock.Chore.DayOfWeek.Run"
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
572,140

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# ####################
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4.
##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName   = GetProcessName();
cUserName       = TM1User();
cMsgErrorContent= 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cTimeStamp      = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile      = GetProcessErrorFileDirectory | cThisProcName | '.' | cTimeStamp | '.' | cRandomInt ;
cTempSubset     = cThisProcName | '.' | cRandomInt;
cTempFile       = GetProcessErrorFileDirectory | cTempSubset | '.csv';

#transformation of numeric parameters into one string parameter, for v4 format:

If (pSunday = 1);
  sSunday = 'SUN ';
  nFirst = 1;
ElseIf (pSunday = 0);
  sSunday = '';
  nFirst = 0;
Endif;

If (pMonday = 1);
  If (nFirst = 0);
  sMonday = 'MON ';
  nFirst = 1;
  ElseIf (nFirst = 1);
  sMonday = '& MON ';  
  EndIf;
ElseIf (pMonday = 0);
  sMonday = '';
Endif;

If (pTuesday = 1);
  If (nFirst = 0);
  sTuesday = 'TUE ';
  nFirst = 1;
  ElseIf (nFirst = 1);
  sMonday = '& TUE ';
  EndIf;
ElseIf (pMonday = 0);
  sMonday = '';
Endif;

If (pWednesday = 1);
  If (nFirst = 0);
  sWednesday = 'WED ';
  nFirst = 1;
  ElseIf (nFirst = 1);
  sWednesday = '& WED ';
  EndIf;
ElseIf (pWednesday = 0);
  sWednesday = '';
Endif;

If (pThursday = 1);
  If (nFirst = 0);
  sThursday = 'THU ';
  nFirst = 1;
  ElseIf (nFirst = 1);
  sWednesday = '& THU ';
  EndIf;
ElseIf (pThursday = 0);
  sThursday = '';
Endif;

If (pFriday = 1);
  If (nFirst = 0);
  sFriday = 'FRI ';
  nFirst = 1;
  ElseIf (nFirst = 1);
  sFriday = '& FRI '; 
  EndIf;
ElseIf (pFriday = 0);
  sFriday = '';
Endif;

If (pSaturday = 1);
  If (nFirst = 0);
  sSaturday = 'SAT ';
  nFirst = 1;
  ElseIf (nFirst = 1);
  sSaturday = '& SAT ';
  EndIf;
ElseIf (pSaturday = 0);
  sSaturday = '';
Endif;

#Combine all days into one string
SweekDays = sSunday | sMonday | sTuesday | sWednesday | sThursday | sFriday | sSaturday ;

### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pSunday          : ' | NumberToString( pSunday ) );
  AsciiOutput( sDebugFile, '            pMonday          : ' | NumberToString( pMonday ) );
  AsciiOutput( sDebugFile, '            pTuesday         : ' | NumberToString( pTuesday  ) );
  AsciiOutput( sDebugFile, '            pWednesday       : ' | NumberToString( pWednesday ) );
  AsciiOutput( sDebugFile, '            pThursday        : ' | NumberToString( pThursday ) );
  AsciiOutput( sDebugFile, '            pFriday          : ' | NumberToString( pFriday ) );
  AsciiOutput( sDebugFile, '            pSaturday        : ' | NumberToString( pSaturday ) );
  AsciiOutput( sDebugFile, '            sWeekDays        : ' | sWeekDays );
  AsciiOutput( sDebugFile, '            pDebug           : ' | NumberToString( pDebug ) );


EndIf;

#Call v4 TI
EXECUTEPROCESS('}bedrock.chore.execution.check',
  'pLogOutput', pDebug,
  'pMonthDays', '',
  'pWeekDays', sWeekDays,
  'pDelim', '&',
  'pStartTime', '',
  'pEndTime', ''
  );

If(nProcessReturnCode = ProcessExitByChoreQuit() );
    ChoreQuit;
Endif;
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
