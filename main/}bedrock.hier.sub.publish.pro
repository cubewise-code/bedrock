601,100
602,"}bedrock.hier.sub.publish"
562,"NULL"
586,
585,
564,
565,"rBX:WRm^5BE2FebAb6al=ROwqGQJmv>OgayqZ8TABPm6iBm:u@mKYXM?1OSf]meA?dQ8nHp0gVz6rbwar7ThHMz0i][iG5`IYg;<Eg]IyjrdfNQxT`3v5?nCuBUEHM;bvINzqGQRi78kGwz6I8Fucz:W5F_=jc7ef9VTPgZFGi[w`la43^4aM3aI`w=M9yg1vUdSS^xw"
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
pDim
pHier
pSub
pOverwrite
561,6
1
1
2
2
2
1
590,6
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pHier,""
pSub,""
pOverwrite,0
637,6
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"REQUIRED: dimension name (if a dim:hier tuple is supplied then the hierarchy parameter will be ignored)"
pHier,"OPTIONAL: hierarchy name (if blank assume same named hierarchy. delimited dim:hier can also be passed in the dimension parameter)"
pSub,"REQUIRED: private subset name"
pOverwrite,"OPTIONAL: Overwrite Existing public subset with same name? (Boolean 1=Yes)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,131
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.sub.publish', 'pLogOutput', pLogOutput, 'pStrictErrorHandling', pStrictErrorHandling,
    	'pDim', '', 'pHier', '', 'pSub', '',
    	'pOverwrite', 0
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
# This process converts a private subset to a public subset for the named client.
#
# Use case: Intended for development/prototyping or production.
# 1. Make private subset public to enable public consumption.
#
# Note:
# * A valid dimension name pDim is mandatory otherwise the process will abort.
# * Also, a valid subset name pSub _belonging to the user running the process_ is mandatory otherwise the process will abort.
# * This process must be run by the user owning the private subset; it canot be run by another user.
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
cLogInfo            = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%, pSub:%pSub%, pSubPublish:%pSubPublish%, pOverwrite:%pOverwrite%.' ;

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

# Validate Dimension & Hierarchy
If( Scan(':', pDim ) > 0 );
    pHier       = SubSt( pDim, Scan(':', pDim )+1, Long(pDim) - Scan(':', pDim ) );
    pDim        = SubSt( pDim, 1, Scan(':', pDim )-1 );
EndIf;
If( pHier @= '' );
    pHier = pDim;
EndIf;
If( Trim( pDim ) @= '' );
    sMessage    = 'No dimension specified';
    nErrors     = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( DimensionExists( pDim ) = 0 );
    sMessage = Expand('Dimension %pDim% does not exist on server');
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( HierarchyExists( pDim, pHier ) = 0 );
    sMessage = Expand('Hierarchy %pHier% does not exist in dimension %pDim%');
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;
If( pHier @= pDim );
    sDimHier = pDim;
Else;
    sDimHier = Expand('%pDim%:%pHier%');
EndIf;

# Validate Subset
If( Trim( pSub ) @= '' );
    sMessage = 'No private subset specified';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# No way to check if private subset exists with TurboIntegrator except via file system.
# Could include data directory param and concatenate with user, cube and view to check
# if private subset exists to handle error in the case that private sub does not exist

# Check for valid overwrite parameters
If( pOverwrite <> 0 & pOverwrite <> 1 );
    sMessage = 'Invalid overwrite existing public subset selection: ' | NumberToString( pOverwrite );
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

If( pOverwrite = 0 & HierarchySubsetExists( pDim, pHier, pSub ) = 1 );
    # If NOT overwriting current public subset AND subset of the same name already exists then cause minor error ( major error if not handled )
    sMessage = 'Public subset of same name already exists and Overwrite=0 specified';
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

### Publish the subset ###
# PublishSubset publishes a named private subset on the server. This function was introduced in Planning Analytics 2.0.9.10/TM1 Server 11.8.9 and cannot be used in previous versions.
PublishSubset( sDimHier, pSub, pOverwrite );

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully published subset %pSub% in hierarchy %pDim%:%pHier% created by cient %pClient%.' );
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
