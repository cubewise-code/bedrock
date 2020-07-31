601,100
602,"}bedrock.cube.view.publish"
562,"NULL"
586,
585,
564,
565,"b?aAy7=BMM[VbSKvJ62VPODaKbH>2<0Dpxk_]2dFCR4^1rhQc4h><7678Lx6L4F3<XSd34TcEezMN8B6zKl70QtoNNmUKjYWA5@eMSTj@zS<00GDWkuR6b9j?<7X?OJxKZ<=yfhShZH?d[aFv7PtG:jlJm4IjfTG9Rn;5yGUZWvq>cMpoukeX:MDti_634DMRGLD4^et"
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
pCube
pView
pSubPublish
pOverwrite
561,6
1
1
2
2
1
1
590,6
pLogOutput,0
pStrictErrorHandling,0
pCube,""
pView,""
pSubPublish,1
pOverwrite,0
637,6
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pCube,"REQUIRED: Cube Name"
pView,"REQUIRED: Private View Name"
pSubPublish,"OPTIONAL: Publish Private Subsets? (Boolean 1=Yes)"
pOverwrite,"OPTIONAL: Overwrite Existing Named View? (Boolean 1=Yes)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,123
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.cube.view.publish', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pCube', '', 'pView', '',
    	'pSubPublish', 1, 'pOverwrite', 0
	);
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This process converts a private view to a public view for the named client.
#
# Use case: Intended for development/prototyping or production.
# 1. Make private view public to enable public consumption.
#
# Note:
# * A valid cube name pCube is mandatory otherwise the process will abort.
# * Also, a valid view name pView is mandatory otherwise the process will abort.
# * This process must be run by the user owning the private view; it canot be run by another user.
# * If the view contains private subsets they must also be made public or the view publish will fail.
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
cTempSubset         = cThisProcName | '_' | cTimeStamp | '_' | cRandomInt;
cTempFile           = GetProcessErrorFileDirectory | cTempSubset | '.csv';
sMessage            = 	'';
cMsgErrorLevel      = 'ERROR';
cMsgErrorContent    = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo            = 'Process:%cThisProcName% run with parameters pCube:%pCube%, pView:%pView%, pSubPublish:%pSubPublish%, pOverwrite:%pOverwrite%.' ;

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;

# create friendly name for user handle
If( DimIx( '}ElementAttributes_}Clients', '}TM1_DefaultDisplayValue' ) > 0 );
    pClient = AttrS( '}Clients', cUserName, '}TM1_DefaultDisplayValue' );
    If( pClient @= '' );
        pClient = cUserName;
    EndIf;
Else;
    pClient = cUserName;
EndIf;

# Validate Cube
If( Trim( pCube ) @= '' );
    sMessage = 'No cube specified';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( CubeExists( pCube ) = 0 );
    sMessage = Expand('Cube %pCube% does not exist on server');
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate view
If( Trim( pView ) @= '' );
    sMessage = 'No view specified';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# No way to check if private view exists except via file system.
# Could include data directory param and concatenate with user, cube and view to check
# if private view exists to handle error in the case that private view does not exist

# Check for valid view name, subset publish and overwrite parameters
If( pSubPublish <> 0 & pSubPublish <> 1 );
    sMessage = 'Invalid publish private subsets selection: ' | NumberToString( pSubPublish );
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

If( pOverwrite <> 0 & pOverwrite <> 1 );
    sMessage = 'Invalid overwrite existing public view selection: ' | NumberToString( pOverwrite );
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

If( pOverwrite = 0 & ViewExists( pCube, pView ) = 1 );
    # If NOT overwriting current public view AND view of the same name exists then cause minor error ( major error if not handled )
    sMessage = 'Public view of same name already exists and Overwrite=0 specified';
    nErrors = nErrors + 1;
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

### Publish the view ( and any private subsets ) ###
PublishView( pCube, pView, pSubPublish, pOverwrite );

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully published view %pView% in cube %pCube% created by cient %pClient%.' );
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
