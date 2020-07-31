601,100
602,"}bedrock.security.client.delete"
562,"NULL"
586,
585,
564,
565,"iQsN9NRXYaSc3<LxC0NZ[CE7J3pkMZJZYTkox@Q2pFW;2@xXt3xDjE;]>t\bU>Lm>BIlu:Bjm[gTYI=`F0w;38NxJw]UxGkOU[c0l[ej50Hb916OCaq0RJk?u_VZLimI>Fi<>NEE7<vmojZ<q><3nb_iqWp^K:IE\oi^d_p@LznoGm1i>7ZyIG7h0?`jJ<Ua@2e<Mdnq"
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
pClient
pDelim
561,4
1
1
2
2
590,4
pLogOutput,0
pStrictErrorHandling,0
pClient,""
pDelim,"&"
637,4
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pClient,"REQUIRED: Clients (Separated by delimiter (e.g. Client1&Client2), Accepts Wild card (e.g. *Client,*Client*, Client*))"
pDelim,"OPTIONAL: Delimiter (default value if blank = '&')"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,222
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
	ExecuteProcess( '}bedrock.security.client.delete', 'pLogOutput', pLogOutput,
	    'pStrictErrorHandling', pStrictErrorHandling,
	    'pClient', '', 'pDelim', '&'
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
# This process will delete clients.

# Use case: Intended for development and production.
# 1/ Clean up users after go live.
# 2/ Remove old employees from the system on termination.

# Note:
# Naturally, a valid client(s) (pClient) is mandatory otherwise the process will abort:
# - Multiple clients can be specified separated by a delimiter. 
#EndRegion @DOC

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName = GetProcessName();
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cTempSub = cThisProcName | '_' | cTimeStamp | '_' | cRandomInt;
cTempFile = GetProcessErrorFileDirectory | cTempSub | '.csv';
cClientDim = '}Clients';
cClientHier = cClientDim;
cUserName         = TM1User();
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pClient:%pClient%, pDelim:%pDelim%.' ; 

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;

# If blank delimiter specified then convert to default
If( pDelim @= '' );
  pDelim = '&';
EndIf;

# If no clients have been specified then terminate process
If( Trim( pClient ) @= '' );
  nErrors = 1;
  sMessage = 'No clients specified';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Check alias exists
If( DimensionExists('}ElementAttributes_'|cClientDim) = 0 % DimIx('}ElementAttributes_'|cClientDim, '}TM1_DefaultDisplayValue') = 0 );
    AttrInsert( cClientDim, '', '}TM1_DefaultDisplayValue', 'A' );
EndIf;

### Split pClient into individual clients and delete ###
sClients            = pClient;
nDelimiterIndex     = 1;
While( nDelimiterIndex <> 0 );
  nDelimiterIndex = Scan( pDelim, sClients );
  If( nDelimiterIndex = 0 );
    sClient = sClients;
  Else;
    sClient = Trim( SubSt( sClients, 1, nDelimiterIndex - 1 ) );
    sClients = Trim( Subst( sClients, nDelimiterIndex + Long(pDelim), Long( sClients ) ) );
  EndIf;
  
  If( Scan( '*', sClient ) = 0);
    If( sClient @<> '' );
      If( DimIx( cClientDim, sClient ) <> 0 );
        sClient = DimensionElementPrincipalName(cClientDim,sClient);
        If( sClient @<> 'Admin' & sClient @<> TM1User() );
            DeleteClient(sClient);
        ElseIf( sClient @= 'Admin' );
            nErrors = 1;
            sMessage = 'Skipping attempt to delete Admin user.';
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        ElseIf( sClient @= TM1User() );
            nErrors = 1;
            sMessage = 'Skipping attempt to delete self.';
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        EndIf;
      Else;
        nErrors = 1;
        sMessage = 'Client: ' | sClient | ' does not exist.';
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
      Endif;
      If( nErrors > 0 );
          ItemReject( Expand( cMsgErrorContent ) );
      EndIf;
    Endif;  
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
        sMdx = '{FILTER({TM1SUBSETALL(['|cClientDim|'].['|cClientHier|'])},
                (Right( ['|cClientDim|'].['|cClientHier|'].[}TM1_DefaultDisplayValue],'| sTempCount|') ='|sClient1|'))}+
                {FILTER({TM1SUBSETALL(['|cClientDim|'].['|cClientHier|'])},
                (Right( ['|cClientDim|'].['|cClientHier|'].CurrentMember.Name,'| sTempCount|') ='|sClient1|'))}';
        If( SubsetExists( cClientDim, cTempSub ) = 1 );
            # If a delimited list of Client names includes wildcards then we may have to re-use the subset multiple times
            SubsetMDXSet( cClientDim, cTempSub, sMDX );
        Else;
            # temp subset, therefore no need to destroy in epilog
            SubsetCreatebyMDX( cTempSub, sMDX, cClientDim, 1 );
        EndIf;
        
        nHier_Sub_Size = HierarchySubsetGetSize(cClientDim, cClientHier, cTempSub);
        nCount = nHier_Sub_Size;
        While (nCount >= 1);
          sTemp = HierarchySubsetElementGetIndex(cClientDim, cClientHier, cTempSub, '', 1);
          sElement = HierarchySubsetGetElementName(cClientDim, cClientHier, cTempSub, nCount);
          If( sElement @<> 'Admin' & sElement @<> TM1User() );
              DeleteClient(sElement);
          ElseIf( sElement @= 'Admin' );
              LogOutput( 'WARN', 'Skipping attempt to delete Admin user.' );
          ElseIf( sElement @= TM1User() );
              LogOutput( 'WARN', 'Skipping attempt to delete self.' );
          EndIf;
          nCount = nCount -1;
        End;
        ##If the wilcardsearch is String*, below code will get executed
        ElseIf(Subst(sClient,Long(sClient),1) @= '*');

        sClient1 = '"'| Subst(sClient,iCount,(Long(sClient)- iCount))|'"';
        sMdx = '{FILTER({TM1SUBSETALL(['|cClientDim|'].['|cClientHier|'])},
                (INSTR('| NumbertoString(iCount)|', ['|cClientDim|'].['|cClientHier|'].[}TM1_DefaultDisplayValue],'|sClient1|') ='| NumbertoString(iCount)|'))}+
                {FILTER({TM1SUBSETALL(['|cClientDim|'].['|cClientHier|'])},
                (INSTR('| NumbertoString(iCount)|', ['|cClientDim|'].['|cClientHier|'].CurrentMember.Name,'|sClient1|') ='| NumbertoString(iCount)|'))}';
        If( SubsetExists( cClientDim, cTempSub ) = 1 );
            # If a delimited list of Client names includes wildcards then we may have to re-use the subset multiple times
            SubsetMDXSet( cClientDim, cTempSub, sMDX );
        Else;
            # temp subset, therefore no need to destroy in epilog
            SubsetCreatebyMDX( cTempSub, sMDX, cClientDim, 1 );
        EndIf;

        nHier_Sub_Size = HierarchySubsetGetSize(cClientDim, cClientHier, cTempSub);
        nCount = nHier_Sub_Size;
        While (nCount >= 1);
          sTemp = HierarchySubsetElementGetIndex (cClientDim, cClientHier, cTempSub, '', 1);
          sElement = HierarchySubsetGetElementName(cClientDim, cClientHier, cTempSub, nCount);
          If( sElement @<> 'Admin' & sElement @<> TM1User() );
              DeleteClient(sElement);
          ElseIf( sElement @= 'Admin' );
              LogOutput( 'WARN', 'Skipping attempt to delete Admin user.' );
          ElseIf( sElement @= TM1User() );
              LogOutput( 'WARN', 'Skipping attempt to delete self.' );
          EndIf;
          nCount = nCount -1;
        End;
      Endif;
    Else;
      ##If the wilcardsearch is *String*, below code will get executed
      sClient1 = '"'| Subst(sClient,iCount,(Long(sClient)- iCount))|'"';
      sMdx = '{FILTER({TM1SUBSETALL(['|cClientDim|'].['|cClientHier|'])},
              (INSTR(1,['|cClientDim|'].['|cClientHier|'].[}TM1_DefaultDisplayValue],'|sClient1|') <> 0))}+
              {FILTER({TM1SUBSETALL(['|cClientDim|'].['|cClientHier|'])},
              (INSTR(1,['|cClientDim|'].['|cClientHier|'].CurrentMember.Name,'|sClient1|') <> 0))}';
      If( SubsetExists( cClientDim, cTempSub ) = 1 );
            # If a delimited list of Client names includes wildcards then we may have to re-use the subset multiple times
            SubsetMDXSet( cClientDim, cTempSub, sMDX );
      Else;
            # temp subset, therefore no need to destroy in epilog
            SubsetCreatebyMDX( cTempSub, sMDX, cClientDim, 1 );
      EndIf;

      nHier_Sub_Size = HierarchySubsetGetSize(cClientDim, cClientHier, cTempSub);
      nCount = nHier_Sub_Size;
      While (nCount >= 1);
        sTemp = HierarchySubsetElementGetIndex (cClientDim, cClientHier, cTempSub, '', 1);
        sElement = HierarchySubsetGetElementName(cClientDim, cClientHier, cTempSub, nCount);
          If( sElement @<> 'Admin' & sElement @<> TM1User() );
              DeleteClient(sElement);
          ElseIf( sElement @= 'Admin' );
              LogOutput( 'WARN', 'Skipping attempt to delete Admin user.' );
          ElseIf( sElement @= TM1User() );
              LogOutput( 'WARN', 'Skipping attempt to delete self.' );
          EndIf;
        nCount = nCount -1;
      End;
    Endif;
  EndIf;
End;

If( nErrors = 0 );
  DimensionSortOrder( cClientDim, 'ByName', 'Ascending', 'ByName' , 'Ascending' );
EndIf;


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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully deleted Client %pClient% from dimension %cClientDim%.' );
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
