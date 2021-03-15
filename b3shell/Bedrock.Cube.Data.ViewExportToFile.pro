601,100
602,"Bedrock.Cube.Data.ViewExportToFile"
562,"NULL"
586,"placeholder"
585,"placeholder"
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
570,placeholderView
571,
569,0
592,0
599,1000
560,9
pCube
pExportPath
pExportFile
pView
pSkipRuleValues
pSkipCalcValues
pSkipNullValues
pTitleRecord
pDebug
561,9
2
2
2
2
1
1
1
1
1
590,9
pCube,""
pExportPath,""
pExportFile,""
pView,""
pSkipRuleValues,1
pSkipCalcValues,1
pSkipNullValues,1
pTitleRecord,1
pDebug,0
637,9
pCube,"Source Cube"
pExportPath,"Export File Path (Defaults to Logging Directory if Left Blank)"
pExportFile,"If Blank Will Default to cube.view.export.csv"
pView,"Source View (Blank = Whole Cube)"
pSkipRuleValues,"Skip Rule Values? (Boolean 1=skip)"
pSkipCalcValues,"Skip Consol Values? (Boolean 1=skip)"
pSkipNullValues,"Skip Zero Values? (Boolean 1=skip)"
pTitleRecord,"Include Title Record in Export File? (Boolean 1=Yes)"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,93

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
cMsgErrorShell    = Expand('Executing process %sProc% has failed.');
cMsgErrorLevel    = 'ERROR';

### Initialise Debug ###
If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';
  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCube           : ' | pCube );
  AsciiOutput( sDebugFile, '            pExportPath     : ' | pExportPath );
  AsciiOutput( sDebugFile, '            pExportFile     : ' | pExportFile );
  AsciiOutput( sDebugFile, '            pView           : ' | pView );
  AsciiOutput( sDebugFile, '            pSkipRuleValues : ' | NumberToString( pSkipRuleValues ) );
  AsciiOutput( sDebugFile, '            pSkipCalcValues : ' | NumberToString( pSkipCalcValues ) );
  AsciiOutput( sDebugFile, '            pSkipNullValues : ' | NumberToString( pSkipNullValues ) );
  AsciiOutput( sDebugFile, '            pTitleRecord    : ' | NumberToString( pTitleRecord ) );
EndIf;


# Validate export path
If( Trim( pExportPath ) @= '' );
  pExportPath = SubSt( GetProcessErrorFileDirectory, 1, Long( GetProcessErrorFileDirectory )- 1 );
EndIf;

# Validate export file
If( Trim( pExportFile ) @= '' );
  sView = IF(Trim(pView)@='','All',pView);
  pExportFile = pCube |'.'| sView | '.Export.csv';
EndIf;

### Getting cube logging parameter
sCubeLogging = CellGetS('}CubeProperties', pCube, 'LOGGING' );
nCubeLogging = IF(sCubeLogging@='YES',1,0);


sProc = '}bedrock.cube.data.export';
nRet = ExecuteProcess( sProc,
  'pLogOutput', pDebug,
  'pStrictErrorHandling',1,
  'pCube', pCube,
  'pView', pView,
  'pFilter', '',
  'pSuppressZero', pSkipNullValues,
  'pSuppressConsol', pSkipCalcValues,
  'pSuppressRules', pSkipRuleValues,
  'pZeroSource', 0,
  'pCubeLogging', nCubeLogging,
  'pTemp', 1,
  'pFilePath', pExportPath,
  'pFileName', pExportFile,
  'pDelim', ',',
  'pQuote', '"',
  'pTitleRecord', pTitleRecord
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
    EndIf;
    ProcessError();
ENDIF;

### End Prolog ###
573,6

#****Begin: Generated Statements***
#****End: Generated Statements****



574,7

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
