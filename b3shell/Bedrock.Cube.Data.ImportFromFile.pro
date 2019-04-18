601,100
602,"Bedrock.Cube.Data.ImportFromFile"
562,"NULL"
586,"C:\TM1\Bedrock\Data\Bedrock.Z.Cube.Placeholder.csv"
585,"C:\TM1\Bedrock\Data\Bedrock.Z.Cube.Placeholder.csv"
564,
565,"vX_fwSWUsa]vzJX\EE`>EEa<[3X;iGmgwpM>DLJqyKm8LiB?FrJ9z;UANxPxxV9jNVP0bIDtmtZEm6LFzB[agvY_^ItSveLSz:35Q^klfpu?O^xuBrhD_7rhPfXhHeP;?NmPZ]WpRJu2X5MPjxa=hZ3E0@w\qG[3BvmnnG`8Ghy\hRId<J;brbczMcLI1H?j5oEPJ5tM"
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
569,2
592,0
599,1000
560,11
pSourceDir
pSourceFile
pCube
pDimension
pSourceElement
pTargetElement
pTitleRows
pDelimiter
pQuote
pCumulate
pDebug
561,11
2
2
2
2
2
2
1
2
2
1
1
590,11
pSourceDir,""
pSourceFile,""
pCube,""
pDimension,""
pSourceElement,""
pTargetElement,""
pTitleRows,1
pDelimiter,","
pQuote,""""
pCumulate,0
pDebug,0
637,11
pSourceDir,"Source Directory"
pSourceFile,"Source File"
pCube,"Target Cube"
pDimension,"Dimension (Optional)"
pSourceElement,"Source Element ( Only required if a Dimensoin is used.)"
pTargetElement,"Target Element (Only required if Dimension is used.)"
pTitleRows,"Number of Title Rows to Skip"
pDelimiter,"Delimiter Character (default=Comma)"
pQuote,"Quote Character (default=Double Quote)"
pCumulate,"Accumulate Amounts"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,82

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
cMsgErrorLevel    = 'ERROR';
cMsgErrorShell    = Expand('Executing process %cThisProcName% has failed.');

### Initialise Debug ###
If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pSourceDir      : ' | pSourceDir );
  AsciiOutput( sDebugFile, '            pSourceFile     : ' | pSourceFile );
  AsciiOutput( sDebugFile, '            pCube           : ' | pCube );
  AsciiOutput( sDebugFile, '            pDimension      : ' | pDimension );
  AsciiOutput( sDebugFile, '            pSourceElement  : ' | pSourceElement );
  AsciiOutput( sDebugFile, '            pTargetElement  : ' | pTargetElement );
  AsciiOutput( sDebugFile, '            pTitleRows      : ' | NumberToString( pTitleRows ) );
  AsciiOutput( sDebugFile, '            pDelimiter      : ' | pDelimiter );
  AsciiOutput( sDebugFile, '            pQuote          : ' | pQuote );
  AsciiOutput( sDebugFile, '            pCumulate       : ' | NumberToString( pCumulate) );
  AsciiOutput( sDebugFile, '            pDebug          : ' | NumberToString( pDebug) );
EndIf;


### Getting cube logging parameter
sCubeLogging = CellGetS('}CubeProperties', pCube, 'LOGGING' );
nCubeLogging = IF(sCubeLogging@='YES',1,0);

sProc = '}bedrock.cube.data.import';
nRet = ExecuteProcess( sProc,
  'pLogOutput', pDebug,
  'pSrcDir', pSourceDir,
  'pSrcFile', pSourceFile,
  'pCube', pCube,
  'pDim', pDimension,
  'pSrcEle', pSourceElement,
  'pTgtEle', pTargetElement,
  'pTitleRows', pTitleRows,
  'pDelim', pDelimiter,
  'pQuote', pQuote,
  'pCumulate', pCumulate,
  'pCubeLogging', nCubeLogging
);

IF(nRet <> 0);
    sMessage = 'the process incurred at least 1 major error and consequently aborted. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% aborted. Check tm1server.log for details.' );
    If ( pDebug >= 1 );
        AsciiOutput( sDebugFile, Expand( cMsgErrorContent ) );
        AsciiOutput( sDebugFile, Expand( 'Process exit code: %nRes%' ) );
        AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
    EndIf;
    ProcessError();
ENDIF;
### End Prolog ###

573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,5

#****Begin: Generated Statements***
#****End: Generated Statements****


575,21

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
