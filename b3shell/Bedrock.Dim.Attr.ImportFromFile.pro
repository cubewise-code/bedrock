601,100
602,"Bedrock.Dim.Attr.ImportFromFile"
562,"NULL"
586,"C:\TM1\Bedrock\Data\Bedrock.Z.Attr.Placeholder.csv"
585,"C:\TM1\Bedrock\Data\Bedrock.Z.Attr.Placeholder.csv"
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
569,1
592,0
599,1000
560,7
pDimension
pSourceDir
pSourceFile
pTitleRows
pDelimiter
pQuote
pDebug
561,7
2
2
2
1
2
2
1
590,7
pDimension,""
pSourceDir,""
pSourceFile,""
pTitleRows,1
pDelimiter,","
pQuote,"'"
pDebug,0
637,7
pDimension,"Target Dimension"
pSourceDir,"File Directory"
pSourceFile,"File Name"
pTitleRows,"Number of Title Rows to Skip"
pDelimiter,"Delimiter Character (default=Comma)"
pQuote,"Quote Character (default=Double Quote)"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,73

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
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cThisProcName | '.' | cTimeStamp | '.' | sRandomInt ;

nMetaDataCount = 0;

### Initialise Debug ###

If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';
  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pSourceDir  : ' | pSourceDir );
  AsciiOutput( sDebugFile, '            pSourceFile : ' | pSourceFile );
  AsciiOutput( sDebugFile, '            pDimension  : ' | pDimension );
  AsciiOutput( sDebugFile, '            pTitleRows  : ' | NumberToString( pTitleRows ) );
  AsciiOutput( sDebugFile, '            pDelimiter  : ' | pDelimiter );
  AsciiOutput( sDebugFile, '            pQuote      : ' | pQuote );
EndIf;

If( pDebug >= 1 );
  nRet = EXECUTEPROCESS('}bedrock.dim.attr.importfromfile',
  'pLogOutput', 1,
  'pDim', pDimension,
  'pSrcDir', pSourceDir,
  'pSrcFile', pSourceFile,
  'pTitleRows', pTitleRows,
  'pDelim', pDelimiter,
  'pQuote', pQuote
  );
Else;
  nRet = EXECUTEPROCESS('}bedrock.dim.attr.importfromfile',
  'pLogOutput', 0,
  'pDim', pDimension,
  'pSrcDir', pSourceDir,
  'pSrcFile', pSourceFile,
  'pTitleRows', pTitleRows,
  'pDelim', pDelimiter,
  'pQuote', pQuote
  );
Endif;  

IF(nRet <> 0);
    sMessage = 'the process incurred at least 1 major error and consequently aborted. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% aborted. Check tm1server.log for details.' );
    ProcessError;
EndIf;


### End Prolog ###
573,10

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 



574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,10

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 



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
