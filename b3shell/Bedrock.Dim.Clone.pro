601,100
602,"Bedrock.Dim.Clone"
562,"NULL"
586,"}Cubes"
585,"}Cubes"
564,
565,"etnZ1aHRvXgqg=DuWfm:wMFdwTMHlAldyxusaRaL=PLr_Q0Lg_QoC[S4^@L]TF?gY615oUngPK@2<srd4DwOjXOj9UgE3[a;c3NYCZ4na;7LMQyQy\bdJbqrH_z^N@@X`@AlVeENc32YoB^DOrjOhb]G2gl@\43RYP`_X``@V@o^pWB_<VhJ^L0kei:9UTCljfItvog_"
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
pSourceDim
pTargetDim
pAttr
pUnwind
pDebug
561,5
2
2
1
1
1
590,5
pSourceDim,""
pTargetDim,""
pAttr,0
pUnwind,0
pDebug,0
637,5
pSourceDim,"Source Dimension"
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
572,56

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
cDebugFile        = GetProcessErrorFileDirectory | cThisProcName | '.' | cTimeStamp | '.';
cSubset           = cThisProcName | '_' |cTimeStamp | '_' | cRandomInt ;

### Initialise Debug ###
If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';
  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pSourceDim : ' | pSourceDim );
  AsciiOutput( sDebugFile, '            pTargetDim : ' | pTargetDim );
  AsciiOutput( sDebugFile, '            pUnwind    : ' | NumberToString( pUnwind ) );
  AsciiOutput( sDebugFile, '            pAttr      : ' | NumberToString( pAttr ) );
EndIf;

nRet = EXECUTEPROCESS('}bedrock.dim.clone',
  'pLogOutput', pDebug,
  'pStrictErrorHandling',1,
  'pSrcDim', pSourceDim,
  'pTgtDim', pTargetDim,
  'pHier', '*',
  'pAttr', pAttr,
  'pUnwind', pUnwind
  );


IF(nRet <> 0);
    sMessage = 'the process incurred at least 1 major error and consequently aborted. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% aborted. Check tm1server.log for details.' );
    ProcessError;
EndIf;

### End Prolog ###
573,10

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
################################################################################################# 



574,10

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
################################################################################################# 



575,10

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
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
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
