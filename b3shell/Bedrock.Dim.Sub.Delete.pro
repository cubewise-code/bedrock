601,100
602,"Bedrock.Dim.Sub.Delete"
562,"NULL"
586,
585,
564,
565,"spMkz5cmg?l0bi<=eeiypl@P1:@6^4lt04ACiOoxLnD>CA:arspmw4yJ^cTQdm3Bvv0v:RCO=a`aPUGhuD`Ig1oklI|zIA`6QG>MH37CCgHGuFsA9r9<TzYslNwL__Yvlr>P\0x<NNxbQVaVDx?MX>XHqZ0zrI@\LlESE5A2wR>bIrddn_DqCksN5:L4wV7F^jgoF9U"
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
pDimensions
pSubsets
pDelimiter
pMode
pDebug
561,5
2
2
2
1
1
590,5
pDimensions,""
pSubsets,"}Bedrock*"
pDelimiter,"&"
pMode,0
pDebug,0
637,5
pDimensions,"List of Dimensions Separated by Delimiter (Blank = All Dimensions)"
pSubsets,"List of Subsets Separated by Delimiter. Wild-cards Permitted on Subset Names."
pDelimiter,"Delimiter Character"
pMode,"<=1 destroy subset 2 delete all elements"
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
cDimension      = '}Dimensions';
cB4Proc         = '}bedrock.hier.sub.delete';

### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimensions : ' | pDimensions );
  AsciiOutput( sDebugFile, '            pSubsets    : ' | pSubsets );
  AsciiOutput( sDebugFile, '            pDelimiter  : ' | pDelimiter );
  AsciiOutput( sDebugFile, '            pMode       : ' | NumberToString(pMode) );

EndIf;

#### Disclaimer for Bedrock v4 ######
If ( pMode > 2);
  nErrors = nErrors + 1;
  sMessage = Expand( 'Bedrock v4: pMode > 2 is not supported. Please review the parameter value.' );
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  ProcessError();
EndIf;

# change in "ALL" handling. Blank = All in v3, in v4 must be explicitly passed as wildcard *
If( pDimensions @= '' );
  sDimensions = '*';
Else;
  sDimensions = pDimensions;
EndIf;

nRet = ExecuteProcess( cB4Proc,
                       'pLogOutput', 0,
                       'pStrictErrorHandling',1,
                       'pDim', sDimensions,
                       'pHier', '',
                       'pSub', pSubsets,
                       'pDelim', pDelimiter,
                       'pMode', pMode
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
  Endif;
  ProcessError;
EndIf;
### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,17

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
