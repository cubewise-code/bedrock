601,100
602,"Bedrock.Dim.Sub.Create.ByElement"
562,"NULL"
586,
585,
564,
565,"z>wX]ycSByez\T1ybuM0keQQR2ajDq?RKZv7Ch]C?:]7\?X4zUfkBVxX_rHtaAMi4ncp@72^4vXkd5bthYD[x15I7Gz1sL;eju7`bf>rGlA9DwIk:AoGjKhHVEOkwp<RIcB7VY@oL_ZYr;N^=\wYyp\ymC5;`k\OsP>hB183Q:lR@@zCuuGh1sLeF8ojMd\76NRg1rXq"
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
560,7
pDimension
pSubset
pElements
pDelimiter
pAddToSubset
pAlias
pDebug
561,7
2
2
2
2
1
2
1
590,7
pDimension,""
pSubset,""
pElements,""
pDelimiter,""
pAddToSubset,0
pAlias,""
pDebug,0
637,7
pDimension,"Dimension"
pSubset,"Subset"
pElements,"Elements Separated by Delimiter"
pDelimiter,"Delimiter"
pAddToSubset,"Add to an existing Subset (Boolean: 1=True)"
pAlias,"Assign an alias to the subset"
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

# This process will create a static subset based on a list of supplied elements


### Constants ###

cProcess = 'Bedrock.Dim.Sub.Create.ByElement';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;


### Initialise Debug ###
## Set debug file name
 sDebugFile = cDebugFile | 'Prolog.debug';

If( pDebug >= 1 );

  ## Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  ## Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension   : ' | pDimension );
  AsciiOutput( sDebugFile, '            pSubset      : ' | pSubset );
  AsciiOutput( sDebugFile, '            pElements    : ' | pElements );
  AsciiOutput( sDebugFile, '            pDelimiter   : ' | pDelimiter );

EndIf;

EXECUTEPROCESS('}bedrock.hier.sub.create.byelement',
  'pDim', pDimension,
  'pStrictErrorHandling',1,
  'pHier', '',
  'pSub', pSubset,
  'pEle', pElements,
  'pDelim', pDelimiter,
  'pAddToSubset', pAddToSubset,
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
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
