﻿601,100
602,"Bedrock.Cube.View.Create"
562,"NULL"
586,"Variables"
585,"Variables"
564,
565,"zhztWfLkbNjaB9juBb=6fEc_ipaDIXA24WR3;XS<dbAkBnW`s[13F?;JKFKK]r=hmnGhT>1a`\N>drW0=pKTieVZU?W@P6;12gRo2uR;:DjKnCZnOMp14X`7]PO\mWUcy=<uVmjHrywEnuIV^8FSjLgMR21yNwfJG6oWeShu7P2jGJyGi2bVubDoVbmt\ppeqF39@Jos"
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
570,All
571,
569,0
592,0
599,1000
560,10
pCube
pView
pFilter
pSuppressZero
pSuppressConsol
pSuppressRules
pDimensionDelim
pElementStartDelim
pElementDelim
pDebug
561,10
2
2
2
1
1
1
2
2
2
1
590,10
pCube,""
pView,""
pFilter,""
pSuppressZero,1
pSuppressConsol,1
pSuppressRules,1
pDimensionDelim,"&"
pElementStartDelim,":"
pElementDelim,"+"
pDebug,0
637,10
pCube,"Cube Name"
pView,"Name of the View"
pFilter,"Filter: Year: 2006 + 2007 & Scenario: Actual + Budget & Organization: North America Operations"
pSuppressZero,"Suppress Zero Data (Skip = 1)"
pSuppressConsol,"Suppress Consolidations (Skip = 1)"
pSuppressRules,"Suppress Rules (Skip = 1)"
pDimensionDelim,"Delimiter for start of Dimension/Element set"
pElementStartDelim,"Delimiter for start of element list"
pElementDelim,"Delimiter between elements"
pDebug,"Debug: 0"
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

### Constants ###

cProcess = 'Bedrock.Cube.View.Create';
cUser = TM1User();
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;
cMsgErrorLevel = 'ERROR';
cMsgErrorContent = '%cProcess% : %sMessage% : %cUser%';
cMsgErrorShell = Expand('Executing process %cProcess% has failed.');


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCube:              ' | pCube );
  AsciiOutput( sDebugFile, '            pView:              ' | pView );
  AsciiOutput( sDebugFile, '            pFilter:            ' | pFilter );
  AsciiOutput( sDebugFile, '            pSuppressZero:      ' | NumberToString( pSuppressZero) );
  AsciiOutput( sDebugFile, '            pSuppressConsol:    ' | NumberToString( pSuppressConsol) );
  AsciiOutput( sDebugFile, '            pSuppressRules:     ' | NumberToString( pSuppressRules) );
  AsciiOutput( sDebugFile, '            pDimensionDelim:    ' | pDimensionDelim );
  AsciiOutput( sDebugFile, '            pElementStartDelim: ' | pElementStartDelim );
  AsciiOutput( sDebugFile, '            pElementDelim:      ' | pElementDelim );

EndIf;

sProc = '}bedrock.cube.view.create';
nRes = EXECUTEPROCESS( sProc,
  'pLogOutput', pDebug,
  'pCube', pCube,
  'pView', pView,
  'pFilter', pFilter,
  'pSuppressZero', pSuppressZero,
  'pSuppressConsol', pSuppressConsol, 
  'pSuppressRules', pSuppressRules,
  'pDimDelim', pDimensionDelim, 
  'pEleStartDelim', pElementStartDelim, 
  'pEleDelim', pElementDelim,
  'pTemp' , 0 
  );

IF ( nRes <> ProcessExitNormal() );
  sMessage = cMsgErrorShell;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  if ( pDebug >= 1 );
    AsciiOutput( sDebugFile, Expand( cMsgErrorContent ) );
    AsciiOutput( sDebugFile, Expand( 'Process exit code: %nRes%' ) );
    AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  endif;
  ProcessError();
ENDIF;



573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,21

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
