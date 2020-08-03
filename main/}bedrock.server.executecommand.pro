601,100
602,"}bedrock.server.executecommand"
562,"NULL"
586,
585,
564,
565,"aaA6uti35[8_z<n9B1sY0IO@Eo@E>InokY0ErPWIxMgeht^vi^08AHegQ6O^UWJ:c0QVTBUm\=w1l6yUbtq4tO^>q<]I;o5auxasGT07qSX?Okq;dHN\7srIi_2Sp_S`ZgIxcdrVyMD<tj7wmgg_H]]LWPINdVl?Pcw\K?QB<RCXX\uDQO5o9s?1Z_RRu0^gvZOx6Bkg"
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
560,4
pLogOutput
pStrictErrorHandling
pCommand
pWait
561,4
1
1
2
2
590,4
pLogOutput,0
pStrictErrorHandling,0
pCommand,""
pWait,"0"
637,4
pLogOutput,"Optional: write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pCommand,"The full command line string to execute"
pWait,"Wait for command to finish 0=false 1=true"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,47
#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This process will run the TI ExecuteCommand function.

# Use case: Intended for production.
# 1/ To run an executeCommand function from any part of the model, including RushTI or third party system without direct access to TI Editor.
# 2/ To remove the requirement of creating a one off process to use this function

#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName = GetProcessName();
cUserName = TM1User();
cMsgErrorLevel = 'ERROR';
cMsgErrorContent = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';

## LogOutput parameters
If( pLogOutput = 1 );
  sLogInfo = Expand('Process:%cThisProcName% run with parameters: pCommand: %pCommand%, pWait: %pWait%'); 
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
nWait = StringToNumber ( pWait );

# Check if the pCommand parameter is enclosed in quotes and add if not
573,2
#****Begin: Generated Statements***
#****End: Generated Statements****
574,2
#****Begin: Generated Statements***
#****End: Generated Statements****
575,30
#****Begin: Generated Statements***
#****End: Generated Statements****

### LogOutput ###

If( pLogOutput = 1 );
    sSec     = NumberToStringEx( 86400*(Now() - nStart),'#,##0.0', '.', ',' );
    sLogInfo = Expand('Process:%cThisProcName% completed. Elapsed time %sSec% seconds.'); 
    LogOutput( 'INFO', sLogInfo );
EndIf;

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
    sProcessAction = Expand( 'Process:%cThisProcName% completed successfully.' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogoutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );   
    EndIf;
EndIf;

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
