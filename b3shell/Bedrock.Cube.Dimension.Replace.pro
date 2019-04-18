601,100
602,"Bedrock.Cube.Dimension.Replace"
562,"NULL"
586,
585,
564,
565,"qTUqEuTkF_grGGIsXylKS?6]o;[eTvqLQ43P]EmxQ[oT`[Y0nko4j\GvYmjgWm?TlhtZa0Xi<Ku7ZbXRT:r=D;o]y6xjEcCC;1m?}2cs5YYOuK126E8oM0lPY3ZPiaG64{bu7HPHPVotyX:dgYB1=xr5YL<xNJM5r2Ki_Ifbl2h8:vn_E9vy@Ij[ELG]XAB1P?Uo7a41"
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
560,5
pCube
pSourceDim
pTargetDim
pCtrlObjOverwrite
pDebug
561,5
2
2
2
1
1
590,5
pCube,""
pSourceDim,""
pTargetDim,""
pCtrlObjOverwrite,0
pDebug,0
637,5
pCube,"Cube"
pSourceDim,"Dimension to be replaced"
pTargetDim,"Replacement Dimension"
pCtrlObjOverwrite,"Allow overwrite control cubes"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,62

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
cThisProcName     = GetProcessName();
cUserName         = TM1User();
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile        = GetProcessErrorFileDirectory | cThisProcName | '.' | cTimeStamp | '.' | cRandomInt ;
cMsgErrorShell    = Expand('Executing process %cThisProcName% has failed.');
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = '%cThisProcName% : %sMessage% : %cUserName%';

### Initialise Debug ###
If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';
  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCube      : ' | pCube );
  AsciiOutput( sDebugFile, '            pSourceDim : ' | pSourceDim );
  AsciiOutput( sDebugFile, '            pTargetDim : ' | pTargetDim );
EndIf;

sProc = '}bedrock.cube.dimension.replace';
nRes = EXECUTEPROCESS( sProc,
  'pLogOutput', pDebug,
  'pCube', pCube,
  'pSrcDim', pSourceDim,
  'pTgtDim', pTargetDim,
  'pIncludeData', 0,
  'pIncludeRules', 0,
  'pCtrlObj', pCtrlObjOverwrite,
  'pTemp', 1
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
### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,19

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
