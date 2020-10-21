601,100
602,"Bedrock.Dim.Sub.Exclude"
562,"NULL"
586,
585,
564,
565,"aaGgBn1Ba7zHzpDn6SS?pA]]tVCAV>yomY]j7U>Mv14u^5tMmVYlL??<V@U^vKIA9>Kpf_HwCKQ^T<Ecsag84meyunS18aG?kVH?`4fO1`\Mj?d5QO<<7WJHPMh3IX3k4Sfw]K8FX_A[P`P4^==`reePl=Z:hd7JcYX89G]>st7E0TLA3Hh2_2uEKP@>baJeLDY_;FxI"
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
pDimension
pSubset
pElements
pDelimiter
pDebug
561,5
2
2
2
2
1
590,5
pDimension,""
pSubset,""
pElements,""
pDelimiter,"&"
pDebug,0
637,5
pDimension,"Dimension"
pSubset,"Subset"
pElements,"Elements to be Excluded (Separated by Delimiter)"
pDelimiter,"Delimiter"
pDebug,"Debug Mode"
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

# This process will remove specified elements from a subset
# If a leaf level element is specified it will be removed
# If a consolidated element is specified it will be removed as well as its descendants


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
  AsciiOutput( sDebugFile, 'Parameters: pDimension   : ' | pDimension );
  AsciiOutput( sDebugFile, '            pSubset      : ' | pSubset );
  AsciiOutput( sDebugFile, '            pElements  : ' | pElements );
  AsciiOutput( sDebugFile, '            pDelimiter   : ' | pDelimiter );

EndIf;

nRet = EXECUTEPROCESS('}bedrock.hier.sub.exclude',
  'pDim', pDimension,
  'pStrictErrorHandling',1,
  'pHier', '',
  'pSub', pSubset,
  'pEle', pElements,
  'pDelim', pDelimiter,
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
