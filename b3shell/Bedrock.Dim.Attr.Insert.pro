601,100
602,"Bedrock.Dim.Attr.Insert"
562,"NULL"
586,
585,
564,
565,"r[n0A:_CLm5G5V9NE>aHv1po>@g4lAIwxD0t=9fVR2M9]MMwmsl??wth<G1S=R_o8B3bbdgpC[e7ugEwW[E_yJC4zClnJWO2GeB?q20]sDm`0zpn9Oe:ZNvF<FO\=L5?CMP5NkpA@[d[9e9`]pHdIkEbMmetWj@=Xs=6Yj@t@NTzP<6_13^IqTP;qbTh0G@83LYRl]\7"
559,0
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
pDimension
pPrevAttr
pAttribute
pAttributeType
pDebug
561,5
2
2
2
2
1
590,5
pDimension,""
pPrevAttr,""
pAttribute,""
pAttributeType,""
pDebug,0
637,5
pDimension,"Dimension Name"
pPrevAttr,"Previous Attribute"
pAttribute,"Attribute Name"
pAttributeType,"Attribute Type"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,51

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
cRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile      = GetProcessErrorFileDirectory | cThisProcName | '.' | cTimeStamp | '.' | cRandomInt ;

### Initialise Debug ###
If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';
  # List parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension     : ' | pDimension );
  AsciiOutput( sDebugFile, '            pPrevAttr      : ' | pPrevAttr );
  AsciiOutput( sDebugFile, '            pAttribute     : ' | pAttribute );
  AsciiOutput( sDebugFile, '            pAttributeType : ' | pAttributeType );
EndIf;

nRet = EXECUTEPROCESS('}bedrock.dim.attr.create',
  'pLogOutput', pDebug,
  'pStrictErrorHandling',1,
  'pDim', pDimension,
  'pPrevAttr', pPrevAttr,
  'pAttr', pAttribute,
  'pAttrType', pAttributeType
  );

IF(nRet <> 0);
    sMessage = 'the process incurred at least 1 major error and consequently aborted. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% aborted. Check tm1server.log for details.' );
    ProcessError;
EndIf;


573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,4

#****Begin: Generated Statements***
#****End: Generated Statements****

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
918,0
919,0
920,0
921,""
922,""
923,0
924,""
925,""
926,""
927,""
