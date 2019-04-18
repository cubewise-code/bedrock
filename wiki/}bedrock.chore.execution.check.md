## Description
   
 This TI was created to overcome the limited scheduling options in chores. In order to use this TI it has to be the 1st TI in the chore.  
 As an example, if you need to run a chore every Monday & Wednesday you would schedule it to run EVERY day but set the `pWeekDays` parameter to Mon & Wed.  
 The chore would then kick off every day but this TI will perform a ProcessExitByChoreQuit function on all days NOT mentioned in `pWeekDays`.  
     
**Use Case:**    For productive systems.  
1. A chore should run every 30 minutes between 8am & 8pm on weekdays. Schedule chore for every 30 minutes and include this process 1st in chore with parameters `pWeekDays`=MON&TUE&WED&THU&FRI `pStartTime`=8 `pEndTime`=20.  
2. A chore should run only on 1st calendar day of each month. Schedule chore for daily execution and include this process 1st in chore with parameters `pMonthDays`=1.  
     
**Note:**     
 This process will quit a chore if any time bound conditions which define when the chore should NOT run are met.  
 Specify only the parameter(s) needed.  
 The intention is to only quit on scheduled execution. The checks are bypassed if a chore is manually executed by a user. This is done by checking the TM1User function.  
 Time conditions are checked using these parameters in the following order of priority.  
   `pMonthDays`              Days in month when chore is allowed to run. Enter delimited list of days e.g. 1&2&30&31 (blank = no restriction on allowed days of month).  
   `pWeekDays`               Days in week when chore is allowed to run Enter delimited list of weekdays e.g. MON&FRI (blank = no restriction on allowed weekdays).  
   `pStartTime` & `pEndTime`   Time of day when chore is allowed to run e.g. `pStartTime`=7, `pEndTime`=22 execution will be allowed between 7AM & 10PM ( blank = no time-bound restrictionss).  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pMonthDays`|String||Optional: Delimited string of days in month as dd e.g. 01 & 02 & 30 & 31 (Blank=All)|
  |`pWeekDays`|String||Optional: Delimited string of days in week as ddd e.g. MON & WED (Blank=All)|
  |`pDelim`|String|`&`|Optional: String array delimiter. Only 1 character allowed (Blank=&)|
  |`pStartTime`|Numeric|`0`|Optional: Time to start running chore from in 24 hr time (at start of hour) (Blank=0)|
  |`pEndTime`|Numeric|`24`|Optional: Time to finish chore being able to start in 24 hr time (Blank=24)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
