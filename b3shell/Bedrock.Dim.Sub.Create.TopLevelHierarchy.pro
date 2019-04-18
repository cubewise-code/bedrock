﻿601,100
602,"Bedrock.Dim.Sub.Create.TopLevelHierarchy"
562,"NULL"
586,
585,
564,
565,"y6`iolx\_u5mtH>E?Ij^8@x@8a4pmUW@SOnDaIlKqfP0Yb5?qm`HyPa[xHfHI2\uhv2o]ZioNaTej6GFf]sZnt2dB;]OI]nGQ7M=;8YiSb9AeD[SZ]owx2sBuIm8gZxB]Peephx^PQWB@LX]IDIHiMt2kP?Nl\q6j_kNRZ9yDN>u4^T2^Wvim9pQ7xCD3[bBVQjclyT2"
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
571,
569,0
592,0
599,1000
560,5
pDimension
pSubset
pConvertToStatic
pAlias
pDebug
561,5
2
2
1
2
1
590,5
pDimension,""
pSubset,""
pConvertToStatic,1
pAlias,""
pDebug,0
637,5
pDimension,"Dimension"
pSubset,"Subset"
pConvertToStatic,"Boolean: 1 = Convert to Static Subset"
pAlias,"Set Alias for Subset"
pDebug,"pDebug"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,59

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4.

# This process will Create a Top Level Hierarchy by N-Level Elements
# that is a subset of all "top node" elements ( Consolidated elements that have no parents )

### Constants ###

cThisProcName     = GetProcessName();
cUserName         = TM1User();
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile        = GetProcessErrorFileDirectory | cThisProcName | '.' | cTimeStamp | '.' | cRandomInt ;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension       : ' | pDimension );
  AsciiOutput( sDebugFile, '            pSubset          : ' | pSubset );
  AsciiOutput( sDebugFile, '            pConvertToStatic : ' | NumberToString( pConvertToStatic ) );

EndIf;


nRet = EXECUTEPROCESS('}bedrock.hier.sub.create.toplevelhierarchy',
  'pDim', pDimension,
  'pHier', '',
  'pSub', pSubset,
  'pConvertToStatic', pConvertToStatic,
  'pAlias', pAlias,
  'pTemp', 0
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

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,9

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
917,1
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
