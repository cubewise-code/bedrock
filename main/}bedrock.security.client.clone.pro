601,100
602,"}bedrock.security.client.clone"
562,"NULL"
586,
585,
564,
565,"d[stavWs7VVGSB>SSfCJ9]x;X9`m\msM99fM?Kki0F;SC;W?DzTymT\4\Zm3AzDR^HwkSGHAa8[;biPnU4^1w36k=dn]6tUS>GKln2BLeS]Fy9h=IHIpwzseg23I_TF_euR4a1?NPP?_Bni;]Yvj4XI_[1NSn\6]NIgqVEjxYBpsd?Rjgbhu6lDdo9B^AmX]jEvsF49C"
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
560,7
pLogOutput
pStrictErrorHandling
pSrcClient
pTgtClient
pMode
pDelim
pPassword
561,7
1
1
2
2
2
2
2
590,7
pLogOutput,0
pStrictErrorHandling,0
pSrcClient,""
pTgtClient,""
pMode,"REPLACE"
pDelim,"&"
pPassword,""
637,7
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pSrcClient,"REQUIRED: Source Client"
pTgtClient,"REQUIRED: List of Target Clients Separated by Delimiter"
pMode,"OPTIONAL: Mode REPLACE or ADD (default = REPLACE)"
pDelim,"OPTIONAL: Delimiter (Use for a list of target users. Defaults to & if blank.)"
pPassword,"OPTIONAL: Initial Password"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,130
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.security.client.clone', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pSrcClient', '', 'pTgtClient', '',
    	'pMode', 'REPLACE', 'pDelim', '&'
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
# This process will copy security from one user to another. Target client(s) will be created if it doesn't exist.

# Use case: Intended for production.
# 1/ When a company hires new employees their profile can be set up by cloning an existing employee.

# Note:
# Naturally, a valid source client (pSrcClient) is mandatory otherwise the process will abort.
# Also, a valid target client(s) (pTgtClient) must be specified, otherwise the process will abort:
# - Multiple target clients can be specified separated by a delimiter.
# - If target client doesn't already exist then Bedrock.Security.Client.Create will be called.
# - The process has 2 modes REPLACE (default) clears any existing group memberships. ADD only adds new ones. 
#EndRegion @DOC

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;


### Constants ###
cThisProcName       = GetProcessName();
cTimeStamp          = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt          = NumberToString( INT( RAND( ) * 1000 ));
cUserName           = TM1User();
cMsgErrorLevel      = 'ERROR';
cMsgErrorContent    = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo            = 'Process:%cThisProcName% run with parameters pSrcClient:%pSrcClient%, pTgtClient:%pTgtClient%, pMode:%pMode%, pDelim:%pDelim%.' ;  
  
## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors             = 0;

# If blank delimiter specified then convert to default
If( pDelim @= '' );
    pDelim          = '&';
EndIf;

# If blank mode specified then convert to default
If( pMode @= '' );
    pMode           = 'REPLACE';
EndIf;

# If unsupported mode specified then abort
If( pMode @= 'ADD' % pMode @= 'REPLACE' );
    # all is OK
Else; 
    nErrors         = 1;
    sMessage        = 'Invalid mode specified. Must be ADD or REPLACE';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# If no source client has been specified then terminate process
If( Trim( pSrcClient ) @= '' );
    nErrors         = 1;
    sMessage        = 'No source client specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( DimIx( '}Clients', pSrcClient ) = 0 );
    nErrors         = 1;
    sMessage        = 'Source client does not exist';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
Else;
    pSrcClient      = DimensionElementPrincipalName( '}Clients', pSrcClient );
EndIf;

# If no target clients have been specified then terminate process
If( Trim( pTgtClient ) @= '' );
    nErrors         = 1;
    sMessage        = 'No target client(s) specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( DimIx( '}Clients', pTgtClient ) > 0 );
    pTgtClient      = DimensionElementPrincipalName( '}Clients', pTgtClient );
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

### Split pClients into individual Clients and add only if they don't exist ###

sClients            = Trim( pTgtClient );
nDelimiterIndex     = 1;

# loop delimited string of target clients
While( nDelimiterIndex <> 0 );
    nDelimiterIndex = Scan( pDelim, sClients );
    If( nDelimiterIndex = 0 );
        sClient     = sClients;
    Else;
        sClient     = Trim( SubSt( sClients, 1, nDelimiterIndex - 1 ) );
        sClients    = Trim( Subst( sClients, nDelimiterIndex + Long(pDelim), Long( sClients ) ) );
    EndIf;
    # Don't attempt to add a blank client
    If( sClient @<> '' );
        If( DimIx( '}Clients', sClient ) = 0 );
            ExecuteProcess( '}bedrock.security.client.create', 'pStrictErrorHandling', pStrictErrorHandling, 'pClient', sClient);
        EndIf;
    EndIf;
End;


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,69

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 


### Update group memberships ###
sClients            = Trim( pTgtClient );
nDelimiterIndex     = 1;

# loop delimited string of target clients
While( nDelimiterIndex <> 0 );
    nDelimiterIndex = Scan( pDelim, sClients );
    If( nDelimiterIndex = 0 );
        sClient     = sClients;
    Else;
        sClient     = Trim( SubSt( sClients, 1, nDelimiterIndex - 1 ) );
        sClients    = Trim( Subst( sClients, nDelimiterIndex + Long(pDelim), Long( sClients ) ) );
    EndIf;
    If( DimIx( '}Clients', sClient ) >= 1 );
        IF (pPassword @<>'');
          sPassExists = CellGetS('}ClientProperties', sClient, 'PASSWORD');
          IF (sPassExists @='');
            AssignClientPassword( sClient, pPassword );
          EndIf;  
        EndIf;
        sClient     = DimensionElementPrincipalName( '}Clients', sClient );
        # loop all security groups
        nGroupIndex = 1;
        nMaxGroups  = DimSiz( '}Groups' );
        While( nGroupIndex <= nMaxGroups );
            sGroup  = DimNm( '}Groups', nGroupIndex );
            If( sGroup @= CellGetS( '}ClientGroups', pSrcClient, sGroup ) );
                AssignClientToGroup( sClient, sGroup );
            Else;
                If( pMode @= 'REPLACE' );
                    # don't need to check if user in group. If user not in group then no error with RemoveClientFromGroup function
                    RemoveClientFromGroup( sClient, sGroup );
                EndIf;
            EndIf;
            nGroupIndex = nGroupIndex + 1;
            # exit loop of }Groups 
        End;
    EndIf;
    # exit loop of target clients 
End;

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully cloned %pSrcClient% to %pTgtClient% by %pMode%.' );
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
917,1
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
