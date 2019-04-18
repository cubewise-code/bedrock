601,100
602,"Bedrock.Cube.Data.Export"
562,"NULL"
586,"}APQ Staging TempSource"
585,"}APQ Staging TempSource"
564,
565,"r4MUyZ6Tu]a86D=J4<aO1;8kJVknsGNdRloq;2WrXL>=u71LRvVAk0ELAmfCMw<F8fN10a\;afCqd=OKNo?LRd\7ryJGu:klr:r7=5CFt1yyhAT?HMfIHgp3R\o0dvtN=JV3lb]vmmzLMgWCwn9[28M^oC;[]Ya9@ntDi\3m4]Y2IVzRKvij@46;F:ZQk9U@BKTnxrh6"
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
570,}TI_Dummy_View
571,
569,0
592,0
599,1000
560,15
pCube
pView
pFilter
pDimensionDelim
pElementStartDelim
pElementDelim
pSkipRules
pSkipCons
pZeroSource
pDestroyTempObj
pFilePath
pFileName
pDelimiter
pQuote
pDebug
561,15
2
2
2
2
2
2
1
1
1
1
2
2
2
2
1
590,15
pCube,""
pView,""
pFilter,""
pDimensionDelim,"&"
pElementStartDelim,":"
pElementDelim,"+"
pSkipRules,1
pSkipCons,1
pZeroSource,0
pDestroyTempObj,1
pFilePath,""
pFileName,""
pDelimiter,","
pQuote,""""
pDebug,0
637,15
pCube,"Cube"
pView,"Temporary view name"
pFilter,"Filter: Year: 2006 + 2007 & Scenario: Actual + Budget & Organization: North America Operations"
pDimensionDelim,"Delimiter between dimensions"
pElementStartDelim,"Delimiter for start of element list"
pElementDelim,"Delimiter between elements"
pSkipRules,"Skip Rule Values? (1=Skip)"
pSkipCons,"Skip Consolidted Values? (1=Skip)"
pZeroSource,"Zero Out view AFTER Copy? (Boolean 1=True)"
pDestroyTempObj,"Retain temporary view and Subset ( 0 = Retain View and Subsets 1 = Delete View and Subsets )"
pFilePath,"Export Directory (will default to log file path)"
pFileName,"Export Filename (If Left Blank Defaults to cube_dim_ele_export.csv)"
pDelimiter,"AsciiOutput delimiter character"
pQuote,"AsciiOutput quote character"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,90

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
  AsciiOutput( sDebugFile, '            pSkipCons:          ' | NumberToString( pSkipCons ) );
  AsciiOutput( sDebugFile, '            pSkipRules:         ' | NumberToString( pSkipRules ) );
  AsciiOutput( sDebugFile, '            pZeroSource:        ' | NumberToString( pZeroSource ) );
  AsciiOutput( sDebugFile, '            pDestroyTempObj:    ' | NumberToString( pDestroyTempObj ) );
  AsciiOutput( sDebugFile, '            pFilePath:          ' | pFilePath );
  AsciiOutput( sDebugFile, '            pFileName:          ' | pFileName );
  AsciiOutput( sDebugFile, '            pDelimiter:         ' | pDelimiter );
  AsciiOutput( sDebugFile, '            pQuote:             ' | pQuote );
  AsciiOutput( sDebugFile, '' );
  AsciiOutput( sDebugFile, '' );
EndIf;

### Getting cube logging parameter
sCubeLogging = CellGetS('}CubeProperties', pCube, 'LOGGING' );
nCubeLogging = IF(sCubeLogging@='YES',1,0);

sProc = '}bedrock.cube.data.export';
nRet = ExecuteProcess( sProc,
  'pLogOutput', 0,
  'pCube', pCube,
  'pView', pView,
  'pFilter', pFilter,
  'pDimDelim', pDimensionDelim,
  'pEleStartDelim', pElementStartDelim,
  'pEleDelim', pElementDelim,
  'pSuppressZero', 1,
  'pSuppressConsol', pSkipCons,
  'pSuppressRules', pSkipRules,
  'pZeroSource', pZeroSource,
  'pCubeLogging', nCubeLogging,
  'pTemp', pDestroyTempObj,
  'pFilePath', pFilePath,
  'pFileName', pFileName,
  'pDelim', pDelimiter,
  'pQuote', pQuote,
  'pTitleRecord', 1
);

IF ( nRet <> ProcessExitNormal() );
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

574,6

#****Begin: Generated Statements***
#****End: Generated Statements****



575,22

#****Begin: Generated Statements***
#****End: Generated Statements****


################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 


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
