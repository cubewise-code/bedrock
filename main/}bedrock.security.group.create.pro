601,100
602,"}bedrock.security.group.create"
562,"NULL"
586,
585,
564,
565,"ySF9ZNo`VdEVis_e<W\<gvS_taep>8wHOTmqEf7>orR7T?aHY2KPs@9`Js;h@8vX4MJ2S96TeeW682as8fKW41E<hpnPhnD>HxeEgB\yLDcXZ_gmpsd7ZSj_fj^wLh3LN>JNiky=gH^T6Mg0>1pDyaNUDYLq:YEpeesu^G<W5GYIPZU:dW_E2N6:pwHU>i4CRtU\iT33"
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
560,3
pLogOutput
pGroup
pDelim
561,3
1
2
2
590,3
pLogOutput,0
pGroup,""
pDelim,"&"
637,3
pLogOutput,"Optional: write parameters and action summary to server message log (Boolean True = 1)"
pGroup,"Required: Groups separated by delimiter"
pDelim,"Optional: Delimiter character (Defaults to & if left blank)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,86

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
    ProcessBreak;
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
