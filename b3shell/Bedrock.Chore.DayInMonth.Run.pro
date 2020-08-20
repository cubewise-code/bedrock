﻿601,100
602,"Bedrock.Chore.DayInMonth.Run"
562,"NULL"
586,
585,
564,
565,"s=55_Jgqb`pEYzSbVJSaxM`0BcgbH<TjgfKYlgvuC7olm;Y:w@=KeV9WPlJV<zk^tfKiOnhuNfHKq6QajqM[`_;q2vXSFz8Cr4aJfnU0hDq>pNA1FO9FTom4RG^3?VocVZr0@9_d\oCNe[EzwNUD;B]xaR_vS8e@qzMzfckXbzM>japZ1Vy2WrPV==C>Z9cMlPabw\Fa"
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
pDelimiter,"Optional: String array delimiter. Only 1 character allowed (Blank=&)"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,55

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

### Initialise Debug ###
If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDays            : ' | pDays );
  AsciiOutput( sDebugFile, '            pDelimiter       : ' | pDelimiter );
  AsciiOutput( sDebugFile, '            pDebug           : ' | NumberToString( pDebug ) );
EndIf;

#Call v4 TI
EXECUTEPROCESS('}bedrock.chore.execution.check',
  'pLogOutput', pDebug,
  'pStrictErrorHandling',1,
  'pMonthDays', pDays,
  'pWeekDays', '',
  'pDelim', pDelimiter,
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
