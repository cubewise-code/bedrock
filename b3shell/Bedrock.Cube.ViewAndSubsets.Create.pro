601,100
602,"Bedrock.Cube.ViewAndSubsets.Create"
562,"NULL"
586,
585,
564,
565,"gOma`FCajiSAhLYJKEuVVOi]pHk_lK\0DoM0P`deS=0`Ic[c0O@q:T]xM<e[;eZa77^h<wYFpjG]8MM4l5gNt^Q;K<yntu5t=8NIKIyGQyNEZu`S7A>s_kM4G6=Z?bc6vJdThH0lGOV1R:DeBKn2nSba]hQSHdB>\1gxC^4UeY5g;OM^e`?BhHkI1Z2h]Gms=P5qnNvF"
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
560,9
pCube
pSuppressZero
pSuppressConsol
pSuppressRules
pDimensions
pDelimiter
pView
pSubset
pDebug
561,9
2
1
1
1
2
2
2
2
1
590,9
pCube,""
pSuppressZero,1
pSuppressConsol,1
pSuppressRules,1
pDimensions,""
pDelimiter,"&"
pView,""
pSubset,""
pDebug,0
637,9
pCube,"Cube"
pSuppressZero,"Suppress Zeros (Boolean Yes = 1)"
pSuppressConsol,"Suppress Calcs (Boolean Yes = 1)"
pSuppressRules,"Suppress Rules (Boolean Yes = 1)"
pDimensions,"Dimension(s) to create empty processing subsets for"
pDelimiter,"Delimiter"
pView,"View"
pSubset,"Subset"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,78

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
cThisProcName     = GetProcessName() ;
cUserName         = TM1User();
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile        = GetProcessErrorFileDirectory | cThisProcName | '.' | cTimeStamp | '.' | cRandomInt ;
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = '%cThisProcName% : %sMessage% : %cUserName%';
cMsgErrorShell    = Expand('Executing process %cThisProcName% has failed.');

### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCube           : ' | pCube );
  AsciiOutput( sDebugFile, '            pSuppressZero   : ' | NumberToString( pSuppressZero ) );
  AsciiOutput( sDebugFile, '            pSuppressConsol : ' | NumberToString( pSuppressConsol ) );
  AsciiOutput( sDebugFile, '            pSuppressRules  : ' | NumberToString( pSuppressRules ) );
  AsciiOutput( sDebugFile, '            pDimensions     : ' | pDimensions );
  AsciiOutput( sDebugFile, '            pDelimiter      : ' | pDelimiter );
  AsciiOutput( sDebugFile, '            pView           : ' | pView );
  AsciiOutput( sDebugFile, '            pSubset         : ' | pSubset );

EndIf;

sProc = '}bedrock.cube.viewandsubsets.create';
nRes = EXECUTEPROCESS( sProc,
  'pLogOutput', pDebug,
  'pStrictErrorHandling',1,
  'pCube', pCube,
  'pView', pView,
  'pSub', pSubset,
  'pDim', If( pDimensions @= 'EVERY', '*', pDimensions ),
  'pDelim',pDelimiter,
  'pSuppressZero', pSuppressZero,
  'pSuppressConsol', pSuppressConsol, 
  'pSuppressRules', pSuppressRules,
  'pTemp', 0
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
