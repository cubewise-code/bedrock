601,100
602,"}bedrock.cube.viewandsubsets.delete"
562,"NULL"
586,
585,
564,
565,"keV=<Gae3GwaRE7_FRc2Hji<1z7OJ=p9K<F2;0Y7g2hFxRf:`wB8Ecq@VS\D6bdNrPYDrzuupVy@ukmjN@k]U2B38ELhPlbe3I9fp5mXW_L;]IUC_zyZ=1?pJE_Acp1@53mnuI4`0R@5p_abDPg`4CBt55N_mtnaU?dRc=ypgOy5h[]azbnCWFlizIOQT1fG7S8Zn[Ry"
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
pSub
pMode
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
pCube,""
pView,""
pSub,""
pMode,1
637,6
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pCube,"REQUIRED: Cube Name"
pView,"REQUIRED: View Name"
pSub,"OPTIONAL: Subset Name (will default to pView if left blank)"
pMode,"REQUIRED: Delete temporary view and Subset (0 = Delete View and Subsets indirectly 1 = Delete View and Subsets directly 2 = Delete View only )"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,144
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.cube.viewandsubsets.delete', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
	    'pCube', '', 'pView', '', 'pSub', '', 'pMode', 1
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
# This process deletes a view and all subsets of the same name.

# Use case: 
# 1. In production environment used in Epilog to remove view & subsets used for processing.
# 2. In development/prototyping to manually clean up views & subsets. 

# Note:
# * Lists and wildcards are not supported in this process
# * A valid cube name pCube is mandatory otherwise the process will abort. 
# * A valid view name pView is mandatory otherwise the process will abort.
# * The matching assumption is based on **name**. Subsets of the same name as the view will be deleted (whether they were assigned to the view or not).
# * pMode 0 = Delete views and **indirectly** delete subsets via bedrock process call. If a subset cannot be deleted the process will continue and exit with minor error status.
# * pMode 1 = Delete views and **directly** delete subsets via SubsetDestroy function. If a subset cannot be deleted the process will abort with major error status.
# * pMode 2 = Delete views only and leave subsets as is.
#EndRegion @DOC

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName     = GetProcessName();
cUserName         = TM1User();
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cMsgInfoLevel     = 'INFO';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pCube:%pCube%, pView:%pView%, pSub:%pSub%, pMode:%pMode%.' ;  
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cTempSubset       = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
sMessage          = '';

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;

### Validate Paramters ##
IF( pMode <> 0 & pMode <> 1 & pMode <> 2 );
    sMessage = 'Invailid mode value provided %pMode%. Do not destroy views or subsets.';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ENDIF;

If( Trim( pCube ) @= '' );
    sMessage    = 'No cube specified.';
    nErrors     = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( CubeExists( pCube ) = 0 );    
    sMessage    = Expand( 'Invalid  cube specified: %pCube%.' );
    nErrors     = 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate pView 
If( Trim( pView ) @= '' );
    sMessage    = 'No view specified.';
    nErrors     = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( ViewExists(pCube, pView ) = 0 ); 
    sMessage    = Expand('There is no view :%pView% in %pCube% cube.') ;
    nErrors     = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
Else;
    cView       = Trim( pView );
EndIf;

# Validate psubset
If( pSub @= '' );
    cSubset     = Trim( pView );
Else;
    cSubset     = Trim( pSub );
EndIf;

### Check for errors before continuing
If( nErrors     > 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

## Clean up view
ViewDestroy( pCube, cView );

## Clean up subsets
If( pMode       <= 1 );

    nDimCount = 0;
    i = 1;
    sDimName = TabDim( pCube, i );
    While( sDimName @<> '' );
        If( SubsetExists ( sDimName, cSubset ) = 1 );
            If( pMode = 0 );
                # "indirect" deletion
                 nRet = ExecuteProcess( '}bedrock.hier.sub.delete',
                  'pStrictErrorHandling', pStrictErrorHandling,
                	'pLogOutput', pLogOutput,
                	'pDim', sDimName,
                	'pHier','',
                	'pSub', cSubset,
                	'pDelim', If( Scan( '&', cSubset ) = 0, '&', ':' ),
                	'pMode', 0
                );
                If( pLogOutput >= 1 & nRet <> ProcessExitNormal() );
                    nErrors = nErrors + 1;
                    sMessage = 'Subset %cSubset% in dimension %sDimName% could not be deleted. It may be used in another view.';
                    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
                EndIf;
            ElseIf( pMode = 1 );
                # pMode=1, "direct" deletion
                SubsetDestroy( sDimName, cSubset );
            EndIf;
        EndIf;
        i = i + 1;
        sDimName = TabDim( pCube, i );
    End;

EndIf;
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,28

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully deleted views and subsets for cube  %pCube%.' );
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
920,0
921,""
922,""
923,0
924,""
925,""
926,""
927,""
