601,100
602,"}bedrock.server.executecommand"
562,"NULL"
586,
585,
564,
565,"v]pAwxQv032bo0nv?_gAd_a9S<UClBYR3<1dvVZqe<BIHV\CTzc2bKjxhTb9=MQwFjK`:zqqC_AH>iD7y\vH;mM4`iStZX>j6VR5c2GNeTmYgJ1=WVShCe_I;0AY;yZ^<TpJXEf6_7?TzrRudiFMrf<D[Otp[:DWhGdFy2Z74rT1:q?sn9`vk2I^qt77\Wqtf6DYev>I"
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
589,","
568,""""
570,
571,
569,0
592,0
599,1000
560,5
pLogOutput
pStrictErrorHandling
pCommand
pWait
pPowerShell
561,5
1
1
2
1
1
590,5
pLogOutput,0
pStrictErrorHandling,0
pCommand,""
pWait,0
pPowerShell,0
637,5
pLogOutput,"Optional: write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pCommand,"The full command line string to execute"
pWait,"Wait for command to finish 0=false 1=true"
pPowerShell,"Execute a PowerShell script 0=false 1=true"
577,1
vCommandOutput
578,1
2
579,1
1
580,1
0
581,1
0
582,1
VarType=32ColType=827
603,0
572,81
#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This process will run the TI ExecuteCommand function and print the output to Server Logs.

# Use case: Intended for production.
# 1/ To run an ExecuteCommand function from any part of the model, including RushTI or third party system without direct access to TI Editor.
# 2/ To remove the requirement of creating a one off process to use this function
# 3/ To compress/uncompress files
# 4/ To copy files and folders from the TM1 server
# 5/ To delete files and folders from the TM1 server
# 6/ To list and kill tasks running in the TM1 server
# 7/ To export and import registry keys such as ODBC data sources

#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName = GetProcessName();
cUser = TM1User();
cUserName = '';
If( DimIx('}Clients', cUser) > 0 );
    cUserName = AttrS('}Clients', cUser, '}TM1_DefaultDisplayValue');
EndIf;
cUserName = IF( cUserName @<> '', cUserName, 'ADMIN' );
cMsgErrorLevel = 'ERROR';
cMsgErrorContent = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cCmdOutputDir = GetProcessErrorFileDirectory;
cCmdOutputFile = cCmdOutputDir | GetProcessName() | '.txt';

## LogOutput parameters
If( pLogOutput = 1 );
  sLogInfo = Expand('Process "%cThisProcName%" run with parameters: pCommand: "%pCommand%", pWait: %pWait%, pPowerShell: %pPowerShell%'); 
  LogOutput ( 'INFO', sLogInfo );
  nStart = Now();
EndIf;

### Validate Parameters ###
nErrors = 0;
If ( pCommand @= '' );
  sMessage = 'parameter pCommand is blank';
  LogOutput ( 'ERROR', sMessage );
  ProcessQuit;
EndIf;

### ExecuteCommand ###

# Check if the pCommand parameter is enclosed in quotes and remove it if it is
If( Subst(pCommand, 1, 1) @= '"' );
  sCommand = Delet(pCommand, 1, 1);
  sCommand = Delet(sCommand, Long(sCommand), 1);
Else;
  sCommand = pCommand;
EndIf;

If( pPowerShell = 1 );
  #Prepare the full command for Powershell
  sCommand = 'POWERSHELL.EXE -Command "& {' | pCommand | '}" 1> ' | cCmdOutputFile | ' 2>&1';
Else;
  #Prepare the full command for Windows CMD
  sCommand = 'CMD.EXE /C "' | sCommand | '" 1> ' | cCmdOutputFile | ' 2>&1';
EndIf;

#Execute the command in the TM1 server
ExecuteCommand ( sCommand, pWait );

#If pLogOutput is true then define the command output file as data source
If( pLogOutput = 1 );
  DataSourceType = 'CHARACTERDELIMITED';
  DatasourceNameForServer = cCmdOutputFile;
EndIf;
573,2
#****Begin: Generated Statements***
#****End: Generated Statements****
574,6
#****Begin: Generated Statements***
#****End: Generated Statements****

# Write the command output to Server Logs
sLogInfo = Expand('Process "%cThisProcName%": %vCommandOutput%');
LogOutput( 'INFO', sLogInfo);
575,34
#****Begin: Generated Statements***
#****End: Generated Statements****

### LogOutput ###

If( pLogOutput = 1 );
    sSec     = NumberToStringEx( 86400*(Now() - nStart),'#,##0.0', '.', ',' );
    sLogInfo = Expand('Process "%cThisProcName%" completed in %sSec% seconds.'); 
    LogOutput( 'INFO', sLogInfo );
EndIf;

### Return code & final error message handling
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process "%cThisProcName%" completed with errors. Check tm1server.log for details.' );
    If( pStrictErrorHandling = 1 ); 
        ProcessQuit; 
    EndIf;
Else;
    sProcessAction = Expand( 'Process "%cThisProcName%" completed successfully.' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogoutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );   
    EndIf;
EndIf;

### Optional: Clean the command output file
#sCommand = 'CMD.EXE /C "TYPE NUL > "' | cCmdOutputFile | '" "';
#ExecuteCommand( sCommand, 0 );

### End Epilog ###
576,
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
