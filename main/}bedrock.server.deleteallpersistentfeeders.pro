601,100
602,"}bedrock.server.deleteallpersistentfeeders"
562,"NULL"
586,
585,
564,
565,"i3;LQTII4ycCM6rrigHm<_@2TAO[20l{P]W3k[9ZPzx6hCJ8_mNjOQlFofT1?x;rD3isJTG62XcaWsUVR1j6jY;?C?KLces;5^B>]OoaL5u?P`BsQn<7_N?<BUWoCOJgRlb=P=Jm]c@2WMjVum3]?utwEK=`5zYLTmeWW<AgA;SiiuKh5PMKLkRd\r?Y|f<VAfEEsI\"
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
560,2
pLogOutput
pRun
561,2
1
2
590,2
pLogOutput,0
pRun,"Y"
637,2
pLogOutput,"Optional: write parameters and action summary to server message log (Boolean True = 1)"
pRun,"Optional: Do you want to delete Persistent Feeders? (Y or N)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,43

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This process will Delete Persistent feeders.

# Use case: Intended for development or production.
# 1/ Persistent feeders turned off in config file.
# 2/ Want to reprocess feeders.

# Note:
# Reprocessing feeders could take a long time and it may be better to run this overnight.
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName     = GetProcessName();
cUserName         = TM1User();
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pRun:%pRun% .'; 

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

nErrors = 0;

### Delete Feeders ###
If( pRun @= 'Y' );
    DeleteAllPersistentFeeders;
EndIf;
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,24

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
Else;
    sProcessAction = Expand( 'Process:%cThisProcName% successfully deleted persistant feeders.' );
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
