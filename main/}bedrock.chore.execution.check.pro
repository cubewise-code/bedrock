601,100
602,"}bedrock.chore.execution.check"
562,"NULL"
586,
585,
564,
565,"k0]JO?N]VwPa05kITBIUiG9i[JS[K2JbB0\50@34\T^G@LXu<3m@SV3S@[UDw@C[;qSdwis1prbgPDiHsynTBbUcv8bbqmSODRMMUA4jsWTy26MgPdP>yrv4EZl5yGb0\rI>Pk;uTu`f>=2_v_c^KBqx9Al^mV@@j1jRx3;HW\rDoImMY:GBt8==7DCXrPf;mNGSHJWB"
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
588,","
589,","
568,""""
570,
571,
569,0
592,0
599,1000
560,9
pLogOutput
pStrictErrorHandling
pMonthDays
pWeekDays
pDelim
pStartTime
pEndTime
pScheduleTimezone
pServerTimezone
561,9
1
1
2
2
2
1
1
2
2
590,9
pLogOutput,0
pStrictErrorHandling,0
pMonthDays,""
pWeekDays,""
pDelim,"&"
pStartTime,0
pEndTime,24
pScheduleTimezone,""
pServerTimezone,""
637,9
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pMonthDays,"OPTIONAL: Delimited string of days in month as dd e.g. 01 & 02 & 30 & 31 (Blank=All)"
pWeekDays,"OPTIONAL: Delimited string of days in week as ddd e.g. MON & WED (Blank=All)"
pDelim,"OPTIONAL: String array delimiter. Only 1 character allowed (Blank=&)"
pStartTime,"OPTIONAL: Time to start running chore from in 24 hr time (at start of hour) (Blank=0)"
pEndTime,"OPTIONAL: Time to finish chore being able to start in 24 hr time (Blank=24)"
pScheduleTimezone,"OPTIONAL: Timezone to check the days / hours in if it is different from server timezone"
pServerTimezone,"OPTIONAL: Timezone for server if ScheduleTimezone is different"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,231
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.chore.execution.check', 'pLogOutput', pLogOutput,
        'pStrictErrorHandling', pStrictErrorHandling,
        'pMonthDays', '', 
        'pWeekDays', '',
        'pDelim', '&',
        'pStartTime', 0, 'pEndTime', 24,
        'pScheduleTimezone','en-AU',
        'pServerTimezone','etc/UTC'
    );
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~## 
################################################################################################# 

#Region @DOC
# Description:
# This TI was created to overcome the limited scheduling options in chores. In order to use this TI it has to be the 1st TI in the chore.
# As an example, if you need to run a chore every Monday & Wednesday you would schedule it to run EVERY day but set the pWeekdays parameter to Mon & Wed.
# The chore would then kick off every day but this TI will perform a ProcessExitByChoreQuit function on all days NOT mentioned in pWeekdays.

# Alternative setup: instead of adding this TI as the 1st TI in the chore, you could also use ExecuteProcess to call it, 
# from the top of the Prolog of your first TI process. This is definitely easier than hardcoding process call parameters in the chore dialog.

# Timezones:
# pScheduleTimezone parameter allow specifying the timezone to perform checks in if server timezone is different to schedule one. E.g. PA server is running in UTC and time or days of week are to be checked in AEST. Full list of timezones https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
# pServerTimezone allows to cater for situations when PA server is running in local time in yet another timezone, e.g. you want to check chore schedule in timezone Europe/Munich for server running in Asia/Singapore

# Use case: For productive systems.
# 1. A chore should run every 30 minutes between 8am & 8pm on weekdays. Schedule chore for every 30 minutes and include this process 1st in chore with parameters pWeekDays=MON&TUE&WED&THU&FRI pStartTime=8 pEndTime=20.
# 2. A chore should run only on 1st calendar day of each month. Schedule chore for daily execution and include this process 1st in chore with parameters pMonthDays=1.

# Note:
# * This process will quit a chore if any time-bound, weekday-bound or date-bound conditions which define when the chore should NOT run are met.
# * Only the parameter(s) needed should be specified.
# * Only scheduled executions will be quit outside the parameters. The checks are bypassed if a chore is manually executed by a user. This is done by checking the TM1User function.
# * Time conditions are checked using these parameters in the following order of priority.
#   1. pMonthDays : Days in month when chore is allowed to run. Enter delimited list of days e.g. 1&2&30&31 (blank = no restriction on allowed days of month).
#   2. pWeekDays : Days in week when chore is allowed to run Enter delimited list of weekdays e.g. MON&FRI (blank = no restriction on allowed weekdays).
#   3. pStartTime & pEndTime : Time of day when chore is allowed to run e.g. pStartTime=7, pEndTime=22 execution will be allowed between 7AM & 10PM ( blank = no time-bound restrictions).
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName   = GetProcessName();
cUserName       = TM1User();
cTimeStamp      = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
cTempSub        = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cStartTime      = NumberToString( pStartTime );
cEndTime        = NumberToString( pEndTime );
cMsgErrorLevel  = 'ERROR';
cMsgErrorContent= 'User:%cUserName% Process:%cThisProcName% Message: %sMsg%';
cLogInfo        = 'User:%cUserName% Process:%cThisProcName% run to check if chore should run with parameters pMonthDays:%pMonthDays%, pWeekDays:%pWeekDays%, pDelim:%pDelim%, pStartTime:%cStartTime%, pEndTime:%cEndTime%, pScheduleTimezone: %pScheduleTimezone% pServerTimezone: %pServerTimezone%.' ; 
nErrors         = 0;
sMsg            = '';

## LogOutput parameters
IF( pLogOutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
EndIf;

### Check params
If( pDelim @= '' );
    pDelim = '&';
Else;
    pDelim = SubSt( pDelim, 1, 1 );
EndIf;

If( pMonthDays @= 'ALL' );
    pMonthDays = '';
EndIf;
If( pMonthDays @<> '' );
    If( SubSt( pMonthDays, Long( pMonthDays ), 1 ) @<> pDelim );
        pMonthDays = pMonthDays | pDelim;
    EndIf;
EndIf;

If( pWeekDays @= 'ALL' );
    pWeekDays = '';
EndIf;
If( pWeekDays @<> '' );
    pWeekDays = Upper( pWeekDays );
    If( SubSt( pWeekDays, Long( pWeekDays ), 1 ) @<> pDelim );
        pWeekDays = pWeekDays | pDelim;
    EndIf;
EndIf;

If( pStartTime <= 0 % pStartTime > 24 );
    pStartTime = 0;
Else;
    pStartTime = Round(pStartTime);
EndIf;
sStartTime = NumberToString( pStartTime );

If( pEndTime <= 0 % pEndTime > 24 );
    pEndTime = 24;
Else;
    pEndTime = Round(pEndTime);
EndIf;

If( pEndTime < pStartTime );
    pEndTime = pStartTime;
EndIf;
sEndTime = NumberToString( pEndTime );

### Initialize quit Boolean
bQuit = 0;

### Check the user
If( DIMIX( '}Clients', cUserName ) > 0 );
    If( pLogOutput >= 1 );
        sMsg = 'This chore will NOT quit since executed by a user.';
        LogOutput( 'INFO', Expand( cMsgErrorContent ) );
    EndIf;
Else;
    if (pScheduleTimezone@<>'');
        #initate the date format for conversion
        pServerTimezone = if (pServerTimezone@='','etc/UTC',pServerTimezone);
        # need to convert to UTC first and then restate in required timezones
        nUTCDateFormatter = NewDateFormatter('', 'etc/UTC', 'serial', 'full', 'datetime');
        nScheduleDateFormatter = NewDateFormatter('', pScheduleTimezone, 'serial', 'full', 'datetime');
        nServerDateFormatter = NewDateFormatter('', pServerTimezone, 'serial', 'full', 'datetime');
        sDateFormat = 'yyyy-MM-dd HH:mm:ss';
        sUTCTimeStamp = FormatDate(Now, sDateFormat, nUTCDateFormatter);
        nServerParsedDate = ParseDate( sUTCTimeStamp, sDateFormat, nServerDateFormatter );
    endif;
    ### Check the day of the month
    If( pMonthDays @<> '' );
        if (pScheduleTimezone @= '');
            sDayInMonth = TimSt(Now, '\d');
        else;
            sDayInMonth = FormatDate(nServerParsedDate, 'd', nScheduleDateFormatter);
        endif;
        If( Scan( sDayInMonth | pDelim, pMonthDays ) = 0 & Scan( sDayInMonth |' '| pDelim, pMonthDays ) = 0 );
            # could not find the day in the list of acceptable days
            bQuit = 1;
            sMsg = Expand('Bedrock debug %cThisProcName%: chore will quit. Could not find today %sDayInMonth% in list of acceptable days %pMonthDays%');
            IF( pLogOutput = 1 ); LogOutput( 'INFO', sMsg ); EndIf;
        Else;
            sMsg = Expand('Bedrock debug %cThisProcName%: today %sDayInMonth% found in list of acceptable days %pMonthDays%');
            IF( pLogOutput = 1 ); LogOutput( 'INFO', sMsg ); EndIf;
        EndIF;
    EndIf;

    ### Check the day of the week
    If( pWeekDays @<> '' );
        if (pScheduleTimezone @= '');
            # support for UseExcelSerialDate=T in TM1s.cfg
            nDayIndex = Mod( DayNo( Today ) + Dayno( '1960-01-01' ) / 21916 - 2, 7 );
            sWeekday = '';
            If( nDayIndex = 0 );
                sWeekday = 'SUN';
            ElseIf( nDayIndex = 1 );
                sWeekday = 'MON';
            ElseIf( nDayIndex = 2 );
                sWeekday = 'TUE';
            ElseIf( nDayIndex = 3 );
                sWeekday = 'WED';
            ElseIf( nDayIndex = 4 );
                sWeekday = 'THU';
            ElseIf( nDayIndex = 5 );
                sWeekday = 'FRI';
            ElseIf( nDayIndex = 6 );
                sWeekday = 'SAT';
            EndIf;
        else;
            sWeekday =  Upper (FormatDate(nServerParsedDate,  'eee', nScheduleDateFormatter));
        endif;
        If( Scan( sWeekday | pDelim, pWeekDays ) = 0 & Scan( sWeekday |' '| pDelim, pWeekDays ) = 0 );
            # could not find the day in the list of acceptable days
            bQuit = 1;
            pWeekDays = Delet( pWeekDays, Long( pWeekDays ), 1 );
            sMsg = Expand('Bedrock debug %cThisProcName%: chore will quit. Could not find today %sWeekday% in list of acceptable days %pWeekDays%');
            IF( pLogOutput = 1 ); LogOutput( 'INFO', sMsg ); EndIf;
        Else;
            pWeekDays = Delet( pWeekDays, Long( pWeekDays ), 1 );
            sMsg = Expand('Bedrock debug %cThisProcName%: today %sWeekday% found in list of acceptable days %pWeekDays%');
            IF( pLogOutput = 1 ); LogOutput( 'INFO', sMsg ); EndIf;
        EndIF;
    EndIf;
    
    ### Check the time of day
    if (pScheduleTimezone @= '');
        sMinute = TimSt(Now, '\h:\i');       
    else;
        sMinute = FormatDate(nServerParsedDate,  'HH:mm', nScheduleDateFormatter);
    endif;
    vTimeNow = StringToNumber(SubSt(sMinute, 1, 2));
    If( pStartTime = 0 & pEndTime = 24 );
        # no time exclusion parameters are set
    ElseIf( vTimeNow < pStartTime % vTimeNow >= pEndTime );
        # we are in the exclusion zone do not execute chore
        bQuit = 1;
        sMsg = Expand('Bedrock debug %cThisProcName%: chore will quit. current time %sMinute% is outside the defined execution time from %sStartTime%:00 to %sEndTime%:00');
        IF( pLogOutput = 1 ); LogOutput( 'INFO', sMsg ); EndIf;
    Else;
        # we are not in the exclusion zone, proceed as normal 
        sMsg = Expand('Bedrock debug %cThisProcName%: current time %sMinute% is within the defined execution time from %sStartTime%:00 to %sEndTime%:00');
        IF( pLogOutput = 1 ); LogOutput( 'INFO', sMsg ); EndIf;
    EndIF;

EndIf;

### Quit chore if quit conditions met
If( bQuit = 1 );
    sMsg = Expand('Bedrock debug %cThisProcName%: terminated the chore for the reasons stated above.');
    If( pLogOutput = 1 ); LogOutput( 'INFO' , Expand( cMsgErrorContent ) ); EndIf;
    nProcessReturnCode = ProcessExitByChoreQuit();
    sProcessReturnCode = 'ProcessExitByChoreQuit';
    ChoreQuit;
Else;
    ### Return Code
    sProcessAction      = Expand('Bedrock debug %cThisProcName%: validated the chore to run as normal.');
    sProcessReturnCode  = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode  = 1;
    If( pLogOutput = 1 ); LogOutput('INFO', Expand( sProcessAction ) );  EndIf;
EndIf;

### End Prolog ###
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,23

#****Begin: Generated Statements***
#****End: Generated Statements****

### Return code & final error message handling
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
    If( pStrictErrorHandling = 1 ); 
        ProcessQuit; 
    EndIf;
Else;
    sProcessAction = Expand( 'Process:%cThisProcName% completed normally' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogOutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );   
    EndIf;
EndIf;

### End Epilog ###
576,CubeAction=1511DataAction=1503CubeLogChanges=0_ParameterConstraints=e30=
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
