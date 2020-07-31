601,100
602,"}bedrock.security.client.create"
562,"NULL"
586,
585,
564,
565,"nA;@E130BFc_iFaaxnq3nY5bn=F^4oB;AU]yrmlnY:2s=DF\S`bY@JcfzA7r:xgP3EKQ:j@euKn[HwD_VpIu7a7I:TcTlqZpaUUS;f3`DX=hd]tMgCbOqYjeNi:Kv5DWyn>:4QSQuGpfVRAW4LvPBv8unlKlvyo3Mr\RP_:m[VqjOyy63EeO50BL3p:LkJ@AS:P5Lwst"
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
560,6
pLogOutput
pStrictErrorHandling
pClient
pAlias
pPassword
pDelim
561,6
1
1
2
2
2
2
590,6
pLogOutput,0
pStrictErrorHandling,0
pClient,""
pAlias,""
pPassword,""
pDelim,"&"
637,6
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pClient,"REQUIRED: Single user name or list of users separated by delimiter"
pAlias,"OPTIONAL: single or delimited list of }TM1_DefaultDisplayValue alias to assign to user (if list of users then size of list of aliases must be the same!)"
pPassword,"OPTIONAL: Initial Password"
pDelim,"OPTIONAL: Delimiter (Blank = &)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,110
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.security.client.create', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
	    'pClient', '', 'pAlias', '', 'pPassword', '', 'pDelim', '&' 
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
# This process will create clients, assign a password and max ports.

# Use case: Intended for production.
# 1/ Create clients for multiple new hires simultaneously.

# Note:
# Naturally, a client (pClient) is mandatory otherwise the process will abort.
# - Multiple clients can be specified separated by a delimiter.
# - If client already exists then the process will not attempt to re-create it but will reset password and max ports.
# - Each client will have to be assigned to a group afterwards.
#EndRegion @DOC

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName       = GetProcessName();
cTimeStamp          = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt          = NumberToString( INT( RAND( ) * 1000 ));
cUserName           = TM1User();
cMsgErrorLevel      = 'ERROR';
cMsgErrorContent    = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo            = 'Process:%cThisProcName% run with parameters pClient:%pClient%, pPassword:******, pDelim:%pDelim%.' ;  

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors             = 0;

# If blank delimiter specified then convert to default
If( pDelim @= '' );
  pDelim            = '&';
EndIf;

# If no clients have been specified then terminate process
If( Trim( pClient ) @= '' );
  nErrors           = 1;
  sMessage          = 'No clients specified.';
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

# Alias
If( pAlias @<> '' );
    If( DimensionExists( '}ElementAttributes_}Clients' ) = 0 );
        AttrInsert( '}Clients', '', '}TM1_DefaultDisplayValue', 'A' );
    ElseIf( DimIx( '}ElementAttributes_}Clients', '}TM1_DefaultDisplayValue' ) = 0 );
        AttrInsert( '}Clients', '', '}TM1_DefaultDisplayValue', 'A' );
    EndIf;
EndIf;

### Split pClient into individual Clients and add ###
sClients            = pClient;
nDelimiterIndex     = 1;
While( nDelimiterIndex <> 0 );
    nDelimiterIndex   = Scan( pDelim, sClients );
    If( nDelimiterIndex = 0 );
        sClient         = sClients;
    Else;
        sClient         = Trim( SubSt( sClients, 1, nDelimiterIndex - 1 ) );
        sClients        = Trim( Subst( sClients, nDelimiterIndex + Long(pDelim), Long( sClients ) ) );
    EndIf;
    # Don't attempt to add a blank client
    If( sClient @<> '' );
        If( DimIx( '}Clients', sClient ) = 0 );
            If( nErrors = 0 );
                AddClient( sClient );
            EndIf;
        EndIf;
    EndIf;
End;

If( nErrors = 0 );
    DimensionSortOrder( '}Clients', 'ByName', 'Ascending', 'ByName' , 'Ascending' );
EndIf;


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,62

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 


### Update password & Alias

If( nErrors = 0 );

  sAliases  = pAlias;
  sClients  = pClient;
  nDelimiterIndex = 1;

  While( nDelimiterIndex > 0 );
    nDelimiterIndex = Scan( pDelim, sAliases );
    If( nDelimiterIndex = 0 );
      sAlias    = sAliases;
    Else;
      sAlias    = Trim( SubSt( sAliases, 1, nDelimiterIndex - 1 ) );
      sAliases  = Trim( Subst( sAliases, nDelimiterIndex + Long(pDelim), Long( sAliases ) ) );
    EndIf;
    nDelimiterIndex = Scan( pDelim, sClients );
    If( nDelimiterIndex = 0 );
      sClient   = sClients;
    Else;
      sClient   = Trim( SubSt( sClients, 1, nDelimiterIndex - 1 ) );
      sClients  = Trim( Subst( sClients, nDelimiterIndex + Long(pDelim), Long( sClients ) ) );
    EndIf;
    
    If( DimIx( '}Clients', sClient ) > 0 );
      AssignClientPassword( sClient, pPassword );
      If( sAlias @<> '' );
        AttrPutS( sAlias, '}Clients', sClient, '}TM1_DefaultDisplayValue', 1 );
      EndIf;
    EndIf;
  End;

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully added user(s) %pClient% to }Clients Dimension.' );
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
