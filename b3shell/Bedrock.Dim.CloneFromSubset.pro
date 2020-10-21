601,100
602,"Bedrock.Dim.CloneFromSubset"
562,"NULL"
586,"}Cubes"
585,"}Cubes"
564,
565,"okVsw8]KfRz_bKwa[RjvlIcq\B9Q@sUmgRRbvRNO8NMQ>ZO;>jQGm2Iz\n]hVJY?O3iI_e3bS?avQ;K]SvVaDRGaP@zQL@tqUIvxm944\MU\AU7ExZ3oRRpXg`sV8iF1W0UCPKo5rR_Go;McgWPed@vAQx\0wG3ID4:BFkWQ?Twd<9]=5E3R^RXNvg[]04iuyWzrbr2X"
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
560,6
pSourceDim
pSubset
pTargetDim
pAttr
pUnwind
pDebug
561,6
2
2
2
1
1
1
590,6
pSourceDim,""
pSubset,""
pTargetDim,""
pAttr,1
pUnwind,0
pDebug,0
637,6
pSourceDim,"Source Dimension"
pSubset,"Source Subset"
pTargetDim,"Target Dimension"
pAttr,"Include Attributes? (Boolean 1=True)"
pUnwind,"0 = Delete all Elements, 1 = Unwind Existing Elements, 2 = Do not change Existing Elements"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,64

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
cHierAttr         = 'Bedrock.Descendant';
cAttrVal          = 'Descendant';

### Initialise Debug ###
If( pDebug >= 1 );
  nRet = EXECUTEPROCESS('}bedrock.hier.create.fromsubset',
  'pLogOutput', 1,
  'pStrictErrorHandling',1,
  'pSrcDim', pSourceDim,
  'pSrcHier', '',
  'pSubset', pSubset,
  'pTgtDim', pTargetDim,
  'pTgtHier', '',
  'pAttr', pAttr,
  'pUnwind', pUnwind,
  'pFlat', 0
  );
Else;
  nRet = EXECUTEPROCESS('}bedrock.hier.create.fromsubset',
  'pLogOutput', 0,
  'pStrictErrorHandling',1,
  'pSrcDim', pSourceDim,
  'pSrcHier', '',
  'pSubset', pSubset,
  'pTgtDim', pTargetDim,
  'pTgtHier', '',
  'pAttr', pAttr,
  'pUnwind', pUnwind,
  'pFlat', 0
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
573,5

#****Begin: Generated Statements***
#****End: Generated Statements****


574,6

#****Begin: Generated Statements***
#****End: Generated Statements****



575,6

#****Begin: Generated Statements***
#****End: Generated Statements****


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
