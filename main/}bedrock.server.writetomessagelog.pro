601,100
602,"}bedrock.server.writetomessagelog"
562,"NULL"
586,
585,
564,
565,"vBuG@tFn49OROjK\4<0TudavHYbB[R`TQquC=D9rd`Qrkifk>JS]?lPL6eHzP;73sMxxIt5ynvU0J\n\B[6=dmCJ7;Pw3CzbdZiErbeJo<tYmwPU=_8_F<QJM@ElWtb<_nYauVCZp_A?baZ?NIn0\HV05`gfKmPlW7jnc6J5iflU?gawhP7B:pZdKeDKfAe22BUvr4Zk"
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
pLevel
pMessage
561,4
1
1
2
2
590,4
pLogOutput,0
pStrictErrorHandling,0
pLevel,""
pMessage,""
637,4
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pLevel,"REQUIRED: Severity of the message - INFO, DEBUG or ERROR"
pMessage,"REQUIRED: Message to display in TM1 server Message Log"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,69
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.server.writetomessagelog', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pLevel', '', 'pMessage', ''
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
# This process will write a Message into the TM1 server Message Log. 
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName       = GetProcessName();
cUserName           = TM1User();
cMsgErrorLevel      = 'ERROR';
cMsgErrorContent    = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo            = 'Process:%cThisProcName% run with parameters pLevel:%pLevel%, pMessage:%pMessage%.' ; 
cLF                 = Char ( 10 );

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors             = 0;
sErrors             = '';

# ValidateType
sType               = Upper ( pLevel );
If( sType @<> 'ERROR' & sType @<> 'WARN' & sType @<> 'DEBUG' & sType @<> 'INFO' );
    nErrors         = nErrors + 1;
    sMessage        = 'Invalid Type: ' | pLevel | cLF;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;
If( Long ( pMessage ) = 0 );
    nErrors         = nErrors + 1;
    sMessage        = sErrors | 'pMessage can not be empty.'  | cLF;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

### Action ###
LogOutput ( sType , pMessage );

573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,5

#****Begin: Generated Statements***
#****End: Generated Statements****


575,28

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully wrote message type %pLevel% with message %pMessage%.' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogoutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );   
    EndIf;
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
