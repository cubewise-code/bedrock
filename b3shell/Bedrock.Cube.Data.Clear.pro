601,100
602,"Bedrock.Cube.Data.Clear"
562,"NULL"
586,
585,
564,
565,"upj:B\WI:iJ`hFTV6yQDVa5UZKyb9Eyxxj`1i2=@OpGcBjqOpMfobriKUi9[dlqc`l_lncXevu`LWJ;h5LbxXxNnnz=sukD9V>S9c;x>5E;ASF12]lHClwze_KW<GBn]xNb]<O<fj77`e>XwAayzjlUg\8Q9l6xy5Xf11_`:0uq]nwie>iTK6;oY4Y0RhcYKC_Kfui@j"
559,0
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
589,"."
568,""""
570,
571,
569,0
592,0
599,1000
560,8
pCube
pView
pFilter
pDimensionDelim
pElementStartDelim
pElementDelim
pDestroyTempObj
pDebug
561,8
2
2
2
2
2
2
1
1
590,8
pCube,""
pView,""
pFilter,""
pDimensionDelim,"&"
pElementStartDelim,":"
pElementDelim,"+"
pDestroyTempObj,1
pDebug,0
637,8
pCube,"Cube Name"
pView,"Temp view name"
pFilter,"Filter: Year: 2006 + 2007 & Scenario: Actual + Budget & Organization: North America Operations"
pDimensionDelim,"Delimiter for start of Dimension/Element set"
pElementStartDelim,"Delimiter for start of element list"
pElementDelim,"Delimiter between elements"
pDestroyTempObj,"Delete temporary view and Subset ( 0 = Retain View and Subsets 1 = Delete View and Subsets 2 = Delete View only )"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,117

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4.
##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName   = GetProcessName();
cUserName       = TM1User();
cMsgErrorContent= 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cTimeStamp      = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile      = GetProcessErrorFileDirectory | cThisProcName | '.' | cTimeStamp | '.' | cRandomInt ;
cMsgErrorLevel  = 'ERROR';
cMsgErrorContent= '%cThisProcName% : %sMessage% : %cUserName%';
cMsgErrorShell  = Expand('Executing process %sProc% has failed.');
cDefaultView    = Expand( '%cThisProcName%_%cTimeStamp%_%cRandomInt%' );

### Initialise Debug ###

If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';
  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  AsciiOutput( sDebugFile, 'TM1 User:        ' | cUserName );
  AsciiOutput( sDebugFile, '' );
  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCube:              ' | pCube );
  AsciiOutput( sDebugFile, '            pView:              ' | pView );
  AsciiOutput( sDebugFile, '            pFilter:            ' | pFilter );
  AsciiOutput( sDebugFile, '            pDimensionDelim:    ' | pDimensionDelim );
  AsciiOutput( sDebugFile, '            pElementStartDelim: ' | pElementStartDelim );
  AsciiOutput( sDebugFile, '            pElementDelim:      ' | pElementDelim );
  AsciiOutput( sDebugFile, '            pDestroyTempObj:    ' | NumberToString( pDestroyTempObj) );
EndIf;

### Getting cube logging parameter
sCubeLogging = CellGetS('}CubeProperties', pCube, 'LOGGING' );
nCubeLogging = IF(sCubeLogging@='YES',1,0);
  
## Validate parameters. This validation is needed to ensure the shell process behaves as v3 Bedrock process

## Validate the View parameter
If( Trim( pFilter) @= '' & TRIM(pView) @= '' );
    If( pDebug >= 1 );
      sMessage = 'Filter and view have not been specified. Use "Clear Cube" as the filter to zero out the entire cube. ';
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    ProcessQuit;
ElseIf( TRIM(pView) @= '' & Trim( pFilter) @<> '' );
  If( pDebug >= 1 );
    sMessage = 'Using default view: ' | cDefaultView;
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  cView = cDefaultView;
ElseIf ( ViewExists( pCube, pView ) = 1 & Trim( pFilter) @= '' );
  If( pDebug >= 1 );
    sMessage = 'Using view: ' | pView;
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  cView = pView ;
  ## Do not destroy existing view
  pDestroyTempObj = 0;
ElseIf ( ViewExists( pCube, pView ) = 1 & Trim( pFilter) @<> '' );
  ## View will be recreated in epilog with pView name, in the case pDestroyTempObj = 0
  nRecreateView = 1;
EndIf;


sProc = '}bedrock.cube.data.clear';
If( Trim( pFilter) @= 'Clear Cube' );
  nRet = ExecuteProcess( sProc,
    'pLogOutput', pDebug,
    'pStrictErrorHandling',1,
    'pCube', pCube,
    'pView', '',
    'pFilter', '',
    'pDimDelim', pDimensionDelim,
    'pEleStartDelim', pElementStartDelim,
    'pEleDelim', pElementDelim,
    'pCubeLogging', nCubeLogging,
    'pTemp', pDestroyTempObj
  );
Else;
  nRet = ExecuteProcess( sProc,
    'pLogOutput', pDebug,
    'pStrictErrorHandling',1,
    'pCube', pCube,
    'pView', pView,
    'pFilter', pFilter,
    'pDimDelim', pDimensionDelim,
    'pEleStartDelim', pElementStartDelim,
    'pEleDelim', pElementDelim,
    'pCubeLogging', nCubeLogging,
    'pTemp', pDestroyTempObj
  );
EndIf;

IF(nRet <> 0);
    sMessage = 'the process incurred at least 1 major error and consequently aborted. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% aborted. Check tm1server.log for details.' );
    ProcessError;
ENDIF;

### End Prolog ###

573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,46

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Recreate temporary view if pDestroyTempObj = 0
IF ( pDestroyTempObj = 0 & nRecreateView = 1 );
    nRet = ExecuteProcess('}bedrock.cube.view.create',
	    'pLogOutput',pDebug,
	    'pCube',pCube,
	    'pView',pView,
	    'pFilter',pFilter,
	    'pSuppressZero',1,
	    'pSuppressConsol',1,
	    'pSuppressRules',1,
	    'pDimDelim',pDimensionDelim,
	    'pEleStartDelim',pElementStartDelim,
	    'pEleDelim',pElementDelim,
	    'pTemp', 0
	    );
	
	IF(nRet <> 0);
        sMessage = 'the process incurred at least 1 major error and consequently aborted. Please see above lines in this file for more details.';
        nProcessReturnCode = 0;
        LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
        sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% aborted. Check tm1server.log for details.' );
        ProcessError;
    ENDIF;
ENDIF;


### Initialise Debug ###

If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';
  # Log finish time
  AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

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
918,0
919,0
920,0
921,""
922,""
923,0
924,""
925,""
926,""
927,""
