601,100
602,"Bedrock.Dim.CloneFromSubset.Flat"
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"rvcFUp]A\\VUjZH^TXa]]hDi>LJ:KuFYVZV72?F=2JivG9PslavY4xLmFuaBdZkA5cS69Yhe_Ue40d77Q?uf5oh@FB`qZukhnpLwzD\hCCvQDi48>v_;lC@AFwC2j6t=fS;DyTWDBimF[VfkWo^k2:iWefjiHXf[K<>=D6afvE_lAIFJ\tWpd>jZUX4F\0vu8`ha61xg"
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
pSourceDim
pSubset
pTargetDim
pAttr
pDebug
561,5
2
2
2
1
1
590,5
pSourceDim,""
pSubset,""
pTargetDim,""
pAttr,0
pDebug,0
637,5
pSourceDim,"Source Dimension"
pSubset,"Source Subset"
pTargetDim,"Target Dimension"
pAttr,"Include Attributes? (Boolean 1=True)"
pDebug,"Debug Mode"
577,1
vElement
578,1
2
579,1
1
580,1
0
581,1
0
582,1
VarType=32ColType=827
603,0
572,53

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4.


### Constants ###
cProcess = 'Bedrock.Dim.CloneFromSubset.Flat' ;
cUser = TM1User();
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.';
cUser = TM1User;
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cSubset =  '}Bedrock_' | sRandomInt;


### Initialise Debug ###

If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  AsciiOutput( sDebugFile, 'TM1 User:        ' | cUser );
  AsciiOutput( sDebugFile, '' );
  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pSourceDim : ' | pSourceDim );
  AsciiOutput( sDebugFile, '            pSourceSub : ' | pSubset );
  AsciiOutput( sDebugFile, '            pTargetDim : ' | pTargetDim );
  AsciiOutput( sDebugFile, '            pAttr      : ' | NumberToString( pAttr ) );
  AsciiOutput( sDebugFile, '' );

EndIf;


EXECUTEPROCESS('}bedrock.hier.create.fromsubset',
  'pSrcDim', pSourceDim,
  'pSrcHier', '',
  'pSubset', pSubset,
  'pTgtDim', pTargetDim,
  'pTgtHier', '',
  'pAttr', pAttr,
  'pUnwind', 0,
  'pFlat', 1
  );

### End Prolog ###
573,10

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.0.0~~##
################################################################################################# 



574,10

#****Begin: Generated Statements***
#****End: Generated Statements****

######################################
##~~  Copyright Cubewise P/L 2010 ~~##
######################################



575,10

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################
##~~ Copyright Cubewise P/L 2010 ~~##
#####################################



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
