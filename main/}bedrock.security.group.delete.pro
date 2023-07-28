601,100
602,"}bedrock.security.group.delete"
562,"NULL"
586,
585,
564,
565,"zvm9@J]hwbdwrrBBQr1LVYdTriad6rTJ3VFV5Mo68q6xzPi0rMlt5p9U7I;A>9y9XQCsVYAC8ursNa2odKYBItS`UIg`:ahhH@oOK7>zz:z^M?v]=@;U`mgAN:R5v0:9_lAimmpupwvVpR\4OPYIevOZtgT46<RlnY\a[436uxd_PX95yRmwcXGJ?U1sY<qcozfoGQ<n"
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
pGroup
pDelim
561,4
1
1
2
2
590,4
pLogOutput,0
pStrictErrorHandling,0
pGroup,""
pDelim,"&"
637,4
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pGroup,"REQUIRED: Groups (Separated by Delimiter, Accepts Wild card)"
pDelim,"OPTIONAL: Delimiter character (Defaults to & if left blank)"
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
    ExecuteProcess( '}bedrock.security.group.delete', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
	    'pGroup', '', 'pDelim', '&'
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
# This process will delete client groups.

# Use case: Intended for development or production.
# 1/ Clean up security groups after go live.
# 2/ Delete obsolete security groups as business needs change.

# Note:
# Naturally, a group (pGroup) is mandatory otherwise the process will abort:
# - Multiple groups can be specified separated by a delimiter.
# - If group does not exist then it will be skipped.
# - If multiple groups are specified and some don't exist and some do, then the ones that do exist will still be deleted.
#EndRegion @DOC

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName           = GetProcessName();
cTimeStamp              = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt              = NumberToString( INT( RAND( ) * 1000 ));
cTempSub                = cThisProcName | '_' | cTimeStamp | '_' | cRandomInt;
cTempFile               = GetProcessErrorFileDirectory | cTempSub | '.csv';
cGroupDim               = '}Groups';
cGroupHier              = cGroupDim;
cUserName               = TM1User();
cMsgErrorLevel          = 'ERROR';
cMsgErrorContent        = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo                = 'Process:%cThisProcName% run with parameters pGroup:%pGroup%, pDelim:%pDelim%.';
cBuiltInGroups          = 'ADMIN&SecurityAdmin&DataAdmin&OperationsAdmin&';

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;
# If blank delimiter specified then convert to default
If( pDelim @= '' );
    pDelim              = '&';
EndIf;

# If no groups have been specified then terminate process
If( Trim( pGroup ) @= '' );
    nErrors             = 1;
    sMessage            = 'No groups specified.';
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

# Check alias exists
If( DimensionExists('}ElementAttributes_'|cGroupDim) = 0 % DimIx('}ElementAttributes_'|cGroupDim, '}TM1_DefaultDisplayValue') = 0 );
    AttrInsert( cGroupDim, '', '}TM1_DefaultDisplayValue', 'A' );
EndIf;

### Split pGroups into individual groups and delete ###
sGroups                 = pGroup;
nDelimiterIndex         = 1;
While( nDelimiterIndex <> 0 );
  nDelimiterIndex = Scan( pDelim, sGroups );
  If( nDelimiterIndex = 0 );
        sGroup          = sGroups;
  Else;
        sGroup          = Trim( SubSt( sGroups, 1, nDelimiterIndex - 1 ) );
        sGroups         = Trim( Subst( sGroups, nDelimiterIndex + Long(pDelim), Long( sGroups ) ) );
  EndIf;
  
  If( Scan( '*', sGroup ) = 0);
    # Don't attempt to delete a blank group
    If( sGroup @<> '' );
        If( DimIx( '}Groups', sGroup ) > 0 );
            If( nErrors = 0 );
                If( Scan( Upper( sGroup ) |'&', Upper( cBuiltInGroups ) ) = 0 );
                    DeleteGroup( sGroup );
                Else;
                    nErrors = 1;
                    sMessage= Expand('Attempt to delete built-in group %sGroup%.');
                    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
                EndIf;
            EndIf;
            If( nErrors > 0 );
                ItemReject( Expand( cMsgErrorContent ) );
            EndIf;
        EndIf;
    EndIf;
  Else;
    # Wildcard search string
    iCount = 0;
    iCheck = 1;
    sChar = sGroup;
    While (iCheck > 0);
      iCheck = Scan('*',sChar);
      If( iCheck > 0 );
        iCount = iCount + 1;
        sChar = Subst(sChar,iCheck+1,(long(sChar)-iCheck));
      Endif;
    End;
    If(iCount = 1);
      ##If the wilcardsearch is *String, below code will get executed
      if(Subst(sGroup,iCount,1) @= '*');
        sGroup1 = '"'| Subst(sGroup,iCount+1,(Long(sGroup)- iCount))|'"';
        sTempCount = NumbertoString(Long(sGroup)-iCount);
        sMdx = '{FILTER({TM1SUBSETALL(['|cGroupDim|'].['|cGroupHier|'])},
                (Right( ['|cGroupDim|'].['|cGroupHier|'].[}TM1_DefaultDisplayValue],'| sTempCount|') ='|sGroup1|'))}+
                {FILTER({TM1SUBSETALL(['|cGroupDim|'].['|cGroupHier|'])},
                (Right( ['|cGroupDim|'].['|cGroupHier|'].CurrentMember.Name,'| sTempCount|') ='|sGroup1|'))}';
        If( SubsetExists( cGroupDim, cTempSub ) = 1 );
            # If a delimited list of Groups includes wildcards then we may have to re-use the subset multiple times
            SubsetMDXSet( cGroupDim, cTempSub, sMDX );
        Else;
            # temp subset, therefore no need to destroy in epilog
            SubsetCreatebyMDX( cTempSub, sMDX, cGroupDim, 1 );
        EndIf;

        nHier_Sub_Size = HierarchySubsetGetSize(cGroupDim, cGroupHier, cTempSub);
        nCount = nHier_Sub_Size;
        While (nCount >= 1);
          sTemp = HierarchySubsetElementGetIndex (cGroupDim, cGroupHier, cTempSub, '', 1);
          sElement = HierarchySubsetGetElementName(cGroupDim, cGroupHier, cTempSub, nCount);
          If( Scan( Upper( sElement ) |'&', Upper( cBuiltInGroups ) ) = 0 );
            DeleteGroup( sElement );
          Else;
            sMessage= 'Attempt to delete built-in group %sGroup%.';
            LogOutput( 'WARN', Expand( cMsgErrorContent ) );
          EndIF;
          nCount = nCount -1;
        End;
        ##If the wilcardsearch is String*, below code will get executed
        ElseIf(Subst(sGroup,Long(sGroup),1) @= '*');
        sGroup1 = '"'| Subst(sGroup,iCount,(Long(sGroup)- iCount))|'"';
        sMdx = '{FILTER({TM1SUBSETALL(['|cGroupDim|'].['|cGroupHier|'])},
                (INSTR('| NumbertoString(iCount)|', ['|cGroupDim|'].['|cGroupHier|'].[}TM1_DefaultDisplayValue],'|sGroup1|') ='| NumbertoString(iCount)|'))}+
                {FILTER({TM1SUBSETALL(['|cGroupDim|'].['|cGroupHier|'])},
                (INSTR('| NumbertoString(iCount)|', ['|cGroupDim|'].['|cGroupHier|'].CurrentMember.Name,'|sGroup1|') ='| NumbertoString(iCount)|'))}';
        If( SubsetExists( cGroupDim, cTempSub ) = 1 );
            # If a delimited list of Groups includes wildcards then we may have to re-use the subset multiple times
            SubsetMDXSet( cGroupDim, cTempSub, sMDX );
        Else;
            # temp subset, therefore no need to destroy in epilog
            SubsetCreatebyMDX( cTempSub, sMDX, cGroupDim, 1 );
        EndIf;

        nHier_Sub_Size = HierarchySubsetGetSize(cGroupDim, cGroupHier, cTempSub);
        nCount = nHier_Sub_Size;
        While (nCount >= 1);
          sTemp = HierarchySubsetElementGetIndex (cGroupDim, cGroupHier, cTempSub, '', 1);
          sElement = HierarchySubsetGetElementName(cGroupDim, cGroupHier, cTempSub, nCount);
          If( Scan( Upper( sElement ) |'&', Upper( cBuiltInGroups ) ) = 0 );
            DeleteGroup( sElement );
          Else;
            sMessage= 'Attempt to delete built-in group %sGroup%.';
            LogOutput( 'WARN', Expand( cMsgErrorContent ) );
          EndIF;
          nCount = nCount -1;
        End;
      Endif;
    Else;
      ##If the wilcardsearch is *String*, below code will get executed
      sGroup1 = '"'| Subst(sGroup,iCount,(Long(sGroup)- iCount))|'"';
      sMdx = '{FILTER({TM1SUBSETALL(['|cGroupDim|'].['|cGroupHier|'])},
              (INSTR(1,['|cGroupDim|'].['|cGroupHier|'].[}TM1_DefaultDisplayValue],'|sGroup1|') <> 0))}+
              {FILTER({TM1SUBSETALL(['|cGroupDim|'].['|cGroupHier|'])},
              (INSTR(1,['|cGroupDim|'].['|cGroupHier|'].CurrentMember.Name,'|sGroup1|') <> 0))}';
      If( SubsetExists( cGroupDim, cTempSub ) = 1 );
            # If a delimited list of Groups includes wildcards then we may have to re-use the subset multiple times
            SubsetMDXSet( cGroupDim, cTempSub, sMDX );
        Else;
            # temp subset, therefore no need to destroy in epilog
            SubsetCreatebyMDX( cTempSub, sMDX, cGroupDim, 1 );
        EndIf;

      nHier_Sub_Size = HierarchySubsetGetSize(cGroupDim, cGroupHier, cTempSub);
      nCount = nHier_Sub_Size;
      While (nCount >= 1);
        sTemp = HierarchySubsetElementGetIndex (cGroupDim, cGroupHier, cTempSub, '', 1);
        sElement = HierarchySubsetGetElementName(cGroupDim, cGroupHier, cTempSub, nCount);
          If( Scan( Upper( sElement ) |'&', Upper( cBuiltInGroups ) ) = 0 );
            DeleteGroup( sElement );
          Else;
            sMessage= 'Attempt to delete built-in group %sGroup%.';
            LogOutput( 'WARN', Expand( cMsgErrorContent ) );
          EndIF;
        nCount = nCount -1;
      End;
    Endif;
  EndIf;
End;

If( nErrors = 0 );
  DimensionSortOrder( '}Groups', 'ByName', 'Ascending', 'ByName' , 'Ascending' );
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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully deleted group %pGroup% from dimension %cGroupDim%.' );
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
