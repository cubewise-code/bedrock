601,100
602,"Bedrock.Cube.Clone"
562,"NULL"
586,"Bedrock Test"
585,"Bedrock Test"
564,
565,"rOgXvg1K9T6YjD9sRfaOv6T[7Y5V60?r\bDW1ZjvkhDZK;NZBYSFvDhm^[ttX>6Tv4wPI\TBDMnJ4m^GRXgm[76SC[oG4x<iu6QrstS`hmUJ0Yb\;?S37MSkXm3k=I0KcQXdYqHm?R74p@A;U9cIx<lk<e_PiQRio39>s<=z_9kI@gIVn3tH>>H6dEcBrZ?WWQgn0lzr"
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
570,Temp
571,
569,0
592,0
599,1000
560,7
pSourceCube
pTargetCube
pIncludeRules
pIncludeData
pSourceView
pRuleValues
pDebug
561,7
2
2
1
1
2
1
1
590,7
pSourceCube,""
pTargetCube,""
pIncludeRules,1
pIncludeData,0
pSourceView,""
pRuleValues,1
pDebug,0
637,7
pSourceCube,"Source Cube"
pTargetCube,"Target Cube to create/re-create"
pIncludeRules,"Include cube rules? (Boolean Yes = 1)"
pIncludeData,"Include cube data? (Boolean Yes = 1)"
pSourceView,"Source View (blank = whole cube If pIncludeData=1)"
pRuleValues,"Skip rule values? (1=skip)"
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
cThisProcName   = GetProcessName();
cUserName       = TM1User();
cMsgErrorContent= 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cTimeStamp      = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile      = GetProcessErrorFileDirectory | cThisProcName | '.' | cTimeStamp | '.' | sRandomInt ;
cMsgErrorLevel  = 'ERROR';
nErrors         = 0;

### Initialise Debug ###
If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';
  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pSourceCube   : ' | pSourceCube );
  AsciiOutput( sDebugFile, '            pTargetCube   : ' | pTargetCube );
  AsciiOutput( sDebugFile, '            pIncludeRules : ' | NumberToString( pIncludeRules ) );
  AsciiOutput( sDebugFile, '            pIncludeData  : ' | NumberToString( pIncludeData ) );
  AsciiOutput( sDebugFile, '            pSourceView   : ' | pSourceView );
  AsciiOutput( sDebugFile, '            pRuleValues   : ' | NumberToString( pRuleValues ) );
EndIf;

#### Disclaimer for Bedrock v4 ######
If( pSourceView @<> '');
  nErrors = nErrors + 1;
  sMessage = Expand( 'Bedrock v4: pSourceView. This parameter is not supported any more. Use process }bedrock.cube.clone instead.' );
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  ProcessError();
EndIf;

######################
### Getting cube logging parameter
sCubeLogging = CellGetS('}CubeProperties', pSourceCube, 'LOGGING' );
nCubeLogging = IF(sCubeLogging@='YES',1,0);
    
nRet = ExecuteProcess('}bedrock.cube.clone',
	        'pSrcCube',pSourceCube,
          'pStrictErrorHandling',1,
	        'pTgtCube',pTargetCube,
        	'pIncludeRules',pIncludeRules,
        	'pIncludeData',pIncludeData,
        	'pFilter','',
        	'pDimDelim','&',
        	'pEleStartDelim',':',
        	'pEleDelim','+',
        	'pSuppressRules',pRuleValues,
        	'pTemp',1,
        	'pCubeLogging',nCubeLogging);

IF(nRet <> 0);
    sMessage = 'the process incurred at least 1 major error and consequently aborted. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% aborted. Check tm1server.log for details.' );
    If ( pDebug >= 1 );
        AsciiOutput( sDebugFile, Expand( cMsgErrorContent ) );
        AsciiOutput( sDebugFile, Expand( 'Process exit code: %nRes%' ) );
        AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
    Endif;
    ProcessError;
EndIf;


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,11

#****Begin: Generated Statements***
#****End: Generated Statements****


################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 



575,18

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
