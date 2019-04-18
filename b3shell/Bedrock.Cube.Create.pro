601,100
602,"Bedrock.Cube.Create"
562,"NULL"
586,"Variables"
585,"Variables"
564,
565,"vX_fwSWUsa]vzJX\EE`>EEy<[3X;iGmwppM>DLJqyKm8LIJ?FrJ9z;UANhTqxV9bNVPpjIDtmtjAmvEFzB[agvY_^ID\veLSz:35]^klfpu?O^HsArhD_7rhPfXhHoP;?nb0P]WpRJurR5M`fxa=mZ3E0@w\qG[3BvmenG01Ghy\hYId<J;brBkzMcLI1x6:6oEPJ5tM"
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
560,5
pCube
pDims
pRecreate
pDimensionDelim
pDebug
561,5
2
2
1
2
1
590,5
pCube,""
pDims,""
pRecreate,0
pDimensionDelim,"+"
pDebug,0
637,5
pCube,"Cube Name"
pDims,"Dim1&Dim2&Dim3&Dim4&Dim5"
pRecreate,"If cube exists delete and recreate (Default=0)"
pDimensionDelim,"Delimiter for Dimension list"
pDebug,"Debug: 0"
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

### Constants ###

cProcess = 	'Bedrock.Cube.Create';
cUser = TM1User();
cTimeStamp = 	TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = 	NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = 	GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt;
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
  AsciiOutput( sDebugFile, '            pDims:             ' | pDims );
  AsciiOutput( sDebugFile, '            pRecreate:          ' | NumberToString( pRecreate) );
  AsciiOutput( sDebugFile, '            pDimensionDelim:    ' | pDimensionDelim );

EndIf;

sProc = '}bedrock.cube.create';

nRes = EXECUTEPROCESS( sProc,
  'pLogOutput', pDebug,
  'pCube', pCube,
  'pDims', pDims,
  'pRecreate', pRecreate,
  'pDelim', pDimensionDelim
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

575,16

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
920,0
921,""
922,""
923,0
924,""
925,""
926,""
927,""
