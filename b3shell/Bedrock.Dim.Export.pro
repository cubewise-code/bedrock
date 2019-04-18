﻿601,100
602,"Bedrock.Dim.Export"
562,"NULL"
586,"}Cubes"
585,"}Cubes"
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
589,
568,""""
570,
571,All
569,0
592,0
599,1000
560,5
pDimension
pExportPath
pExportFile
pTitleRecord
pDebug
561,5
2
2
2
1
1
590,5
pDimension,""
pExportPath,""
pExportFile,""
pTitleRecord,1
pDebug,0
637,5
pDimension,"Required: Dimension"
pExportPath,"Optional: Target Directory Path (defaults to Error File Directory)"
pExportFile,"Optional: Target File Name (defaults to Dimension_Export.csv if blank)"
pTitleRecord,"Boolean 1 = Yes - Include header row"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,60

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.0.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4.

# This process will Export all Dimension elements to a File.
##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName   = GetProcessName();
cUserName       = TM1User();
cMsgErrorContent= 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cTimeStamp      = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile      = GetProcessErrorFileDirectory | cThisProcName | '.' | cTimeStamp | '.' | cRandomInt ;

### Initialise Debug ###
If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension   : ' | pDimension );
  AsciiOutput( sDebugFile, '            pExportPath  : ' | pExportPath );
  AsciiOutput( sDebugFile, '            pExportFile  : ' | pExportFile );
  AsciiOutput( sDebugFile, '            pTitleRecord : ' | NumberToString( pTitleRecord ) );

EndIf;

nRet = EXECUTEPROCESS('}bedrock.hier.export',
  'pLogOutput', pDebug,
  'pDim', pDimension,
  'pHier', '',
  'pTgtDir', pExportPath,
  'pTgtFile', pExportFile,
  'pTitleRecord', pTitleRecord,
  'pLegacy', 1
  );
  
  IF(nRet <> 0);
    sMessage = 'the process incurred at least 1 major error and consequently aborted. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% aborted. Check tm1server.log for details.' );
    ProcessError;
EndIf;

### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,10

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 



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
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
