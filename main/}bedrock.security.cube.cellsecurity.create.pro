601,100
602,"}bedrock.security.cube.cellsecurity.create"
562,"NULL"
586,
585,
564,
565,"rHn\3utj\u7e8yi^W6zWBO8v>Mag3qi}B85s3RrRMuYz3\efw^R2;lZnAUi>Wl8EA2Oq63Bz8nY1=PaA9=eSaMmz0hbC]a[8fXzuq23qKfNSEmvuiwaVG[JzibiePgDmq20BC[6T9>CM[Ae:WBv]6_a?5V5Ty1cLLdCd:Q^1EWs[kXDKjR<L6FN0PscAfS6BYc:yu`UqrHn\3utj\u7e8yi^W6tWBO8v>Mag3qi=H85s3RrRMuYz3\hfw^R2;lZnA%O;WlhBA2OQ13Bz8ni==0dA9=eSaMmz0hrB]a[8fXzUt23qKfNSEmF4ewaVG[Jzibie00@mqb6bM[6T9>CmVAe:^BvM2_a?5V5Ty1cLLdse:Q>=EWs[+[DKjR<L6V@0PscAfS:BSc:yu`Uq"
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
560,3
pLogOutput
pCube
pDim
561,3
1
2
2
590,3
pLogOutput,0
pCube,""
pDim,""
637,3
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pCube,"REQUIRED: Cube to create cell security for"
pDim,"REQUIRED: Map of dimensions to include in cell security as a array of 1:0 colon delimited e.g. ""1:0:0:1:0"""
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,127
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.security.cube.cellsecurity.create', 'pLogOutput', pLogOutput,
	    'pCube', '', 'pDim', ''
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
# This process will create a cell security cube for the specified cube for the specified list of dimensions 
# using the TI function _CellSecurityCubeCreate_. The benefit of this process is not needing to write a custom
# process each time in order to create a cell security cube.

# Use case: Intended for development.
# 1/ Set up cell security cubes

# Note:
# * Naturally, a valid cube (pCube) is mandatory otherwise the process will abort.
# * If cell security has already been set up the TI will abort.
# * The pDim parameter must map _ALL_ the dimensions in order in the cube with a 0 or 1.
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
cMsgErrorContent    = 'User:%cUserName% Process:%cThisProcName% Message:%sMessage%';
cLogInfo            = 'Process:%cThisProcName% run with parameters pCube:%pCube%, pDim:%pDim%.' ;  
cDelim              = ':';

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;

# If no cube has been specified then terminate process
If( Trim( pCube ) @= '' );
    nErrors = 1;
    sMessage = 'No cube specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( CubeExists( pCube ) = 0 );
    nErrors = 1;
    sMessage = Expand('Cube %pCube% does not exist.');
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Check if cell security cube already exists
If( CubeExists(  '}CellSecurity_' | pCube ) = 1 );
    nErrors = 1;
    sMessage = 'Cell Security cube already exists.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
    ProcessBreak;
EndIf;

### Count dimensions in cube ###
nDims               = 0;
iDim                = 1;
While( TabDim( pCube, iDim ) @<> '' );
   nDims            = iDim;
   iDim             = iDim + 1;
End;

### Count dimensions mapped in pDim ###
sDimensions         = pDim;
nDelimiterIndex     = 1;
nMapDims            = 0;
iDim                = 1;
While( nDelimiterIndex <> 0 );
    nMapDims        = iDim;
    nDelimiterIndex = Scan( cDelim, sDimensions );
    If( nDelimiterIndex = 0 );
        sDimension  = sDimensions;
    Else;
        sDimension  = Trim( SubSt( sDimensions, 1, nDelimiterIndex - 1 ) );
        sDimensions = Trim( Subst( sDimensions, nDelimiterIndex + Long(cDelim), Long( sDimensions ) ) );
    EndIf;
    # Redundant?
    If( sDimension @= '1' );
        sMessage    = ' INCLUDE in cell security cube';
    ElseIf( sDimension @= '0' );
        sMessage    = ' EXCLUDE from cell security cube';
    Else;
        sMessage    = ' INVALID map parameter: ' | sDimension;
    EndIF;
    iDim            = iDim + 1;
End;

### Check dimension count of dimension map vs. dimensions in cube ###
If( nDims <> nMapDims );
    nErrors         = 1;
    sMessage        = 'Parameter count of dimension map does not match dimension count of cube!';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
Else;
    nRet            = CellSecurityCubeCreate ( pCube, pDim );
    If( nRet = 1 );
        sMessage    = '}CellSecurity_' | pCube | ' successfully created';
        LogOutput( 'INFO', Expand( cMsgErrorContent ) );
    Else;
        sMessage    = 'Error. Could not create }CellSecurity_' | pCube;
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    EndIf;
EndIf;

### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,25

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully created cell security for %pCube% and %pDim%.' );
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
920,0
921,""
922,""
923,0
924,""
925,""
926,""
927,""
