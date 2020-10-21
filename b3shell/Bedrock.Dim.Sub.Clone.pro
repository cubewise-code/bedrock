601,100
602,"Bedrock.Dim.Sub.Clone"
562,"NULL"
586,"}Cubes"
585,"}Cubes"
564,
565,"jIr_LZvo[ua?=D<OgL<8:x`;dSr^2EYVFKo4^e_H0MS>4l6?ympE=pqjT4Tzmr1_3Fl8W:rQ_4ILvFJRT0rfY2ZJGVzFY=1vBIxNxOP7v;\>WQT2bAZ?ue``blILZd;nddlMfmG1AI:GP1xSS]nEbw0Cmyl8Wf@vMvGwU\j^zI_Ik>TqULtr?MfPm:Takw]G`l_7]Je7"
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
571,All
569,0
592,0
599,1000
560,5
pDimension
pTargetDim
pSourceSub
pTargetSub
pDebug
561,5
2
2
2
2
1
590,5
pDimension,""
pTargetDim,""
pSourceSub,""
pTargetSub," "
pDebug,0
637,5
pDimension,"Mandatory: Dimension where the subset exists"
pTargetDim,"Optional: Target dimension (blank = same as source)"
pSourceSub,"Mandatory: Source Subset"
pTargetSub,"Mandatory: Target Subset"
pDebug,"Optional: Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,58

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Copyright bedrocktm1.org 2013 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4.
# This process will create a copy of subset
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
  AsciiOutput( sDebugFile, 'Parameters: pDimension       : ' | pDimension );
  AsciiOutput( sDebugFile, '            pTargetDim         : ' | pTargetDim );
  AsciiOutput( sDebugFile, '            pSourceSub          : ' | pSourceSub );
  AsciiOutput( sDebugFile, '            pTargetSub         : ' | pTargetSub );
EndIf;

nRet = EXECUTEPROCESS('}bedrock.hier.sub.clone',
  'pLogOutput', pDebug,
  'pStrictErrorHandling',1,
  'pSrcDim', pDimension,
  'pSrcHier', '',
  'pSrcSub', pSourceSub,
  'pTgtDim', pTargetDim,
  'pTgtHier', ' ',
  'pTgtSub', pTargetSub,
  'pTemp', 0
  );
  
IF(nRet <> 0);
    sMessage = 'the process incurred at least 1 major error and consequently aborted. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% aborted. Check tm1server.log for details.' );
    ProcessError;
EndIf;



573,10

#****Begin: Generated Statements***
#****End: Generated Statements****


################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 


574,3

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
