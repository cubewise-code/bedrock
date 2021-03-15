601,100
602,"Bedrock.Cube.ViewAndSubsets.Delete"
562,"NULL"
586,
585,
564,
565,"upj:B\WI:iJ`hFTV6yQDVa5UZKyb9Eyxxj`1i2=@OpGcBjqOpMfobriKUi9[dlqc`l_lncXevu`LWJ;h5LbxXxNnnz=sukD9V>S9c;x>5E;ASF12]lHClwze_KW<GBn]xNb]<O<fj77`e>XwAayzjlUg\8Q9l6xy5Xf11_`:0uq]nwie>iTK6;oY4Y0RhcYKC_Kfui@j"
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
589,"."
568,""""
570,
571,
569,0
592,0
599,1000
560,5
pCube
pView
pSubset
pMode
pDebug
561,5
2
2
2
1
1
590,5
pCube,""
pView,""
pSubset,""
pMode,1
pDebug,0
637,5
pCube,"Cube Name"
pView,"View Name"
pSubset,"Subset Name"
pMode,"Delete temporary view and Subset ( 0 = Retain View and Subsets 1 = Delete View and Subsets 2 = Delete View only )"
pDebug,"Debug"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,72

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName     = GetProcessName() ;
cUserName         = TM1User();
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile        = GetProcessErrorFileDirectory | cThisProcName | '.' | cTimeStamp | '.' | cRandomInt ;
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = '%cThisProcName% : %sMessage% : %cUserName%';
cMsgErrorShell    = Expand('Executing process %cThisProcName% has failed.');
cMsgInfoLevel     = 'INFO';
cMsgInfoContent   = '%cThisProcName% : %sMessage% : %cUserName%';

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCube  : ' | pCube );
  AsciiOutput( sDebugFile, '            pView  : ' | pView );
  AsciiOutput( sDebugFile, '            pSubset: ' | pSubset );
  AsciiOutput( sDebugFile, '            pMode  : ' | NumberToString( pMode) );

EndIf;

IF(pMode = 0);
  sMessage = 'Mode 0: Do not destroy views or subsets.';
  LogOutput( cMsgInfoLevel, Expand( cMsgInfoContent ) );
  ProcessQuit();
ENDIF;


sProc = '}bedrock.cube.viewandsubsets.delete';
nRes = EXECUTEPROCESS( sProc,
  'pLogOutput', pDebug,
  'pStrictErrorHandling',1,
  'pCube', pCube,
  'pView', pView,
  'pSub', pSubset,
  'pMode', pMode
  );

IF ( nRes <> ProcessExitNormal() );
    sMessage = 'the process incurred at least 1 major error and consequently aborted. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% aborted. Check tm1server.log for details.' );
    If ( pDebug >= 1 );
        AsciiOutput( sDebugFile, Expand( cMsgErrorContent ) );
        AsciiOutput( sDebugFile, Expand( 'Process exit code: %nRes%' ) );
        AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
    Endif;
    ProcessError();
ENDIF;
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,23

#****Begin: Generated Statements***
#****End: Generated Statements****


################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

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
