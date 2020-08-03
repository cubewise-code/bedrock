601,100
602,"}bedrock.security.client.password.reset"
562,"NULL"
586,
585,
564,
565,"uVbRrG@o\=sFEMW2PLxOca3v`iFL5:Y:7Wr2\K<lmR74lqJN_zksiGQW_tJ=y?UW6:qM8g>6vVJ<p5dpLgnbBRtR]^0=8iPGetA^zrbc0]OmC982uq3ACTuG0jHlamEV=dUwLTjo\AcHiwKFNUs3pN<zAnzn[dhTK@XkpVBV=uA8j:AH^HgEiNkZhPknGiQw6Qtn41a0"
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
pClient
pPassword
pDelim
561,5
1
1
2
2
2
590,5
pLogOutput,0
pStrictErrorHandling,0
pClient,""
pPassword,""
pDelim,"&"
637,5
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pClient,"REQUIRED: Clients (Separated by delimiter (e.g. Client1&Client2), Accepts Wild card (e.g. *Client,*Client*, Client*))"
pPassword,"REQUIRED: New Password"
pDelim,"OPTIONAL: Delimiter character (default value if blank = '&')"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,192
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.security.client.password.reset', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
	    'pClient', '', 'pPassword', '', 'pDelim', '&'
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
# This process can be used by admins to reset a client password.

# Use case: Intended for production.
# 1/ When a user has forgotten his/her password this TI can be used to reset it.

# Note:
# Naturally, a valid client(s) (pClient) is mandatory otherwise the process will abort.
# Multiple clients can be specified separated by a delimiter.
# It has to be run by an ADMIN person otherwsie it will abort.
#EndRegion @DOC

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName       = GetProcessName();
cUserName           = TM1User();
cTimeStamp          = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt          = NumberToString( INT( RAND( ) * 1000 ));
cTempSub            = cThisProcName | '_' | cTimeStamp | '_' | cRandomInt;
cTempFile           = GetProcessErrorFileDirectory | cTempSub | '.csv';
cClientDim          = '}Clients';
cClientHier         = cClientDim;
cMsgErrorLevel      = 'ERROR';
cMsgErrorContent    = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo            = 'Process:%cThisProcName% run with parameters pClient:%pClient%, pPassword:******, pDelim:%pDelim%.' ;  

### Validate Parameters ###
nErrors             = 0;

# If blank delimiter specified then convert to default
If( pDelim @= '' );
    pDelim = '&';
EndIf;

# If no clients have been specified then terminate process
If( Trim( pClient ) @= '' );
    nErrors = 1;
    sMessage = 'No clients specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Check if the person executing the process has admin rights

IF( CELLGETS( '}ClientGroups', cUserName, 'Admin' ) @<> 'ADMIN' & CELLGETS( '}ClientGroups', cUserName, 'DataAdmin' ) @<> 'DataAdmin' & cUserName @<> pClient );
    nErrors = 1;
    sMessage = 'No Admin access to change other clients password.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ENDIF;

### Check for errors before continuing
If( nErrors > 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

### Split pClient into individual clients and reset password ###

sClients = pClient;
nDelimiterIndex = 1;

While( nDelimiterIndex <> 0 );
  nDelimiterIndex = Scan( pDelim, sClients );
  If( nDelimiterIndex = 0 );
    sClient = sClients;
  Else;
    sClient = Trim( SubSt( sClients, 1, nDelimiterIndex - 1 ) );
    sClients = Trim( Subst( sClients, nDelimiterIndex + Long(pDelim), Long( sClients ) ) );
  EndIf;
  
  If(Scan('*',sClient) = 0);
  # Don't attempt to update a blank client
    If( sClient @<> '' );
      If( DimIx( '}Clients', sClient ) <> 0 );
        If( nErrors = 0 );
          sClient = DimensionElementPrincipalName( '}Clients', sClient );
          AssignClientPassword( sClient, pPassword );
        EndIf;
      EndIf;
    EndIf;
  Else;
    # Wildcard search string
    iCount = 0;
    iCheck = 1;
    sChar = sClient;
    While (iCheck > 0);
      iCheck = Scan('*',sChar);
      If( iCheck > 0 );
        iCount = iCount + 1;
        sChar = Subst(sChar,iCheck+1,(long(sChar)-iCheck));
      Endif;
    End;
    If(iCount = 1);
      ##If the wilcardsearch is *String, below code will get executed
      if(Subst(sClient,iCount,1) @= '*');
        sClient1 = '"'| Subst(sClient,iCount+1,(Long(sClient)- iCount))|'"';
        sTempCount = NumbertoString(Long(sClient)-iCount);
        sMdx = '{FILTER({TM1SUBSETALL(['|cClientDim|':'|cClientHier|'])},
                (Right( ['|cClientDim|':'|cClientHier|'].[}TM1_DefaultDisplayValue],'| sTempCount|') ='|sClient1|'))}';
        If( SubsetExists( cClientDim, cTempSub ) = 1 );
            # If a delimited list of client names includes wildcards then we may have to re-use the subset multiple times
            SubsetMDXSet( cClientDim, cTempSub, sMDX );
        Else;
            # temp subset, therefore no need to destroy in epilog
            SubsetCreatebyMDX( cTempSub, sMDX, cClientDim, 1 );
        EndIf;        

        nCount = 1;
        nHier_Sub_Size = HierarchySubsetGetSize(cClientDim, cClientHier, cTempSub);
        While (nCount <= nHier_Sub_Size);
          nSubsetIndex = 1;
          sTemp = HierarchySubsetElementGetIndex (cClientDim, cClientHier, cTempSub, '', nSubsetIndex);
          sElement = HierarchySubsetGetElementName(cClientDim, cClientHier, cTempSub, nCount);
          AssignClientPassword(sElement,pPassword);
          nCount = nCount +1;
        End;
        ##If the wilcardsearch is String*, below code will get executed
        ElseIf(Subst(sClient,Long(sClient),1) @= '*');
      
        sClient1 = '"'| Subst(sClient,iCount,(Long(sClient)- iCount))|'"';
        sMdx = '{FILTER({TM1SUBSETALL(['|cClientDim|':'|cClientHier|'])},
                (INSTR('| NumbertoString(iCount)|', ['|cClientDim|':'|cClientHier|'].[}TM1_DefaultDisplayValue],'|sClient1|') ='| NumbertoString(iCount)|'))}';
        If( SubsetExists( cClientDim, cTempSub ) = 1 );
            # If a delimited list of client names includes wildcards then we may have to re-use the subset multiple times
            SubsetMDXSet( cClientDim, cTempSub, sMDX );
        Else;
            # temp subset, therefore no need to destroy in epilog
            SubsetCreatebyMDX( cTempSub, sMDX, cClientDim, 1 );
        EndIf;        

        nCount = 1;
        nHier_Sub_Size = HierarchySubsetGetSize(cClientDim, cClientHier, cTempSub);
        While (nCount <= nHier_Sub_Size);
          nSubsetIndex = 1;
          sTemp = HierarchySubsetElementGetIndex (cClientDim, cClientHier, cTempSub, '', nSubsetIndex);
          sElement = HierarchySubsetGetElementName(cClientDim, cClientHier, cTempSub, nCount);
          AssignClientPassword(sElement,pPassword);
          nCount = nCount +1;
        End;
      Endif;
    Else;
      ##If the wilcardsearch is *String*, below code will get executed
      sClient1 = '"'| Subst(sClient,iCount,(Long(sClient)- iCount))|'"';
      sMdx = '{FILTER({TM1SUBSETALL(['|cClientDim|':'|cClientHier|'])},
              (INSTR(1,['|cClientDim|':'|cClientHier|'].[}TM1_DefaultDisplayValue],'|sClient1|') <> 0))}';
      If( SubsetExists( cClientDim, cTempSub ) = 1 );
            # If a delimited list of Client names includes wildcards then we may have to re-use the subset multiple times
            SubsetMDXSet( cClientDim, cTempSub, sMDX );
      Else;
            # temp subset, therefore no need to destroy in epilog
            SubsetCreatebyMDX( cTempSub, sMDX, cClientDim, 1 );
      EndIf;

      nCount = 1;
      nHier_Sub_Size = HierarchySubsetGetSize(cClientDim, cClientHier, cTempSub);
      While (nCount <= nHier_Sub_Size);
        nSubsetIndex = 1;
        sTemp = HierarchySubsetElementGetIndex (cClientDim, cClientHier, cTempSub, '', nSubsetIndex);
        sElement = HierarchySubsetGetElementName(cClientDim, cClientHier, cTempSub, nCount);
        AssignClientPassword(sElement,pPassword);
        nCount = nCount +1;
      End;
    Endif;
  EndIf;
End;


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,27

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully reset password for client %pClient% .' );
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
