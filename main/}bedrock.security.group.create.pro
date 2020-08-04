601,100
602,"}bedrock.security.group.create"
562,"NULL"
586,
585,
564,
565,"c6tavyY\4i5uzUh?gAMJ;Me:U8_>[PPZB_THlU_xnNJb]q4BZp24AeaMk]bxzy3=4>FVU<4YVn]6J03Z[[:2xX<Mf^XfbOk@RV5>0kh4G2B=^1:jcuGMX8vEC_c`WRRLm9u8FeUo[cpZb45mPbIB>EdM[byciP@gx?eWQeMJ^v7_2r6Z\5=MZApVbzj7NzR?liJ4:QG>"
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
pGroup
pAlias
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
pGroup,""
pAlias,""
pDelim,"&"
637,5
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pGroup,"REQUIRED: Groups separated by delimiter"
pAlias,"OPTIONAL: single or delimited list of }TM1_DefaultDisplayValue alias to assign to group (if list of groups then size of list of aliases must be the same!)"
pDelim,"OPTIONAL: Delimiter character (Defaults to & if left blank)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,108
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.security.group.create', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
	    'pGroup', '', 'pAlias', '', 'pDelim', '&'
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
# This process will create client groups.

# Use case: Intended for development or production.
# 1/ Create initial security groups.
# 2/ Add security groups as business needs change.

# Note:
# Naturally, a group (pGroup) is mandatory otherwise the process will abort.
# - Multiple groups can be specified separated by a delimiter.
# - If group already exists then the process will skip that group.
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
cLogInfo            = 'Process:%cThisProcName% run with parameters pGroup:%pGroup%, pDelim:%pDelim%.' ;  

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

# If no groups have been specified then terminate process
If( Trim( pGroup ) @= '' );
    nErrors         = 1;
    sMessage        = 'No groups specified';
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
    If( DimensionExists( '}ElementAttributes_}Groups' ) = 0 );
        AttrInsert( '}Groups', '', '}TM1_DefaultDisplayValue', 'A' );
    ElseIf( DimIx( '}ElementAttributes_}Groups', '}TM1_DefaultDisplayValue' ) = 0 );
        AttrInsert( '}Groups', '', '}TM1_DefaultDisplayValue', 'A' );
    EndIf;
EndIf;

### Split pGroups into individual groups and add ###
sGroups = pGroup;
nDelimiterIndex = 1;
While( nDelimiterIndex <> 0 );
    nDelimiterIndex = Scan( pDelim, sGroups );
    If( nDelimiterIndex = 0 );
        sGroup = sGroups;
    Else;
        sGroup = Trim( SubSt( sGroups, 1, nDelimiterIndex - 1 ) );
        sGroups = Trim( Subst( sGroups, nDelimiterIndex + Long(pDelim), Long( sGroups ) ) );
    EndIf;
    # Don't attempt to add a blank group
    If( sGroup @<> '' );
        If( DimIx( '}Groups', sGroup ) = 0 );
            AddGroup( sGroup );
        Else;
            #Skip group
        EndIf;
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

575,60

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

### Update Alias

If( nErrors = 0 );

  sAliases  = pAlias;
  sGroups   = pGroup;
  nDelimiterIndex = 1;

  While( nDelimiterIndex > 0 );
    nDelimiterIndex = Scan( pDelim, sAliases );
    If( nDelimiterIndex = 0 );
      sAlias    = sAliases;
    Else;
      sAlias    = Trim( SubSt( sAliases, 1, nDelimiterIndex - 1 ) );
      sAliases  = Trim( Subst( sAliases, nDelimiterIndex + Long(pDelim), Long( sAliases ) ) );
    EndIf;
    nDelimiterIndex = Scan( pDelim, sGroups );
    If( nDelimiterIndex = 0 );
      sGroup   = sGroups;
    Else;
      sGroup   = Trim( SubSt( sGroups, 1, nDelimiterIndex - 1 ) );
      sGroups  = Trim( Subst( sGroups, nDelimiterIndex + Long(pDelim), Long( sGroups ) ) );
    EndIf;
    
    If( DimIx( '}Groups', sGroup ) > 0 );
      If( sAlias @<> '' );
        AttrPutS( sAlias, '}Groups', sGroup, '}TM1_DefaultDisplayValue', 1 );
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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully created Group %pGroup% .' );
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
