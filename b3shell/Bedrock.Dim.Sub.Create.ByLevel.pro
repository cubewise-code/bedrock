601,100
602,"Bedrock.Dim.Sub.Create.ByLevel"
562,"NULL"
586,
585,
564,
565,"qjBU>9L7r0lSk7A`_aMDfMi0gZkruny^5vxr65;oYlpT57uyf=XmhFMF=MUP6k4:<LeeLAg7bQ45P_TEefWgo^imNQz1e7X>iZYlRdN7RoqD8t6BCX]5HaK;ev]`@CpuI\X7uC6ti4hmjS5s2RRd1x4NHkvIZnPW6JagD;DpYrTQaQ9GEmqlSi^OD5Ep[]T@ChtMjw5<"
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
pSort
pConvertStatic
pAlias
pDebug
561,5
2
1
1
2
1
590,5
pDimension,""
pSort,0
pConvertStatic,1
pAlias,""
pDebug,0
637,5
pDimension,"Dimension Name"
pSort,"Sort the Subset (1)"
pConvertStatic,"Convert the Subset to Static (1)"
pAlias,"Assign an alias to the subset"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,53

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4.

# This process creates static subsets named "All level <nn>" for the specified
# dimension level or for all levels in the dimension


### Constants ###

cProcess = 'Bedrock.Dim.Sub.Create.ByLevel';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension     : ' | pDimension );
  AsciiOutput( sDebugFile, '            pSort          : ' | NumberToString( pSort ) );
  AsciiOutput( sDebugFile, '            pConvertStatic : ' | NumberToString( pConvertStatic ) );
  AsciiOutput( sDebugFile, '            pAlias : ' | pAlias );
EndIf;


EXECUTEPROCESS('}bedrock.hier.sub.create.bylevel',
  'pDim', pDimension,
  'pHier', '',
  'pSort', pSort,
  'pConvertStatic', pConvertStatic,
  'pAlias', pAlias,
  'pTemp', 0
  );




### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

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
