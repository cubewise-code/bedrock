601,100
602,"Bedrock.Dim.Sub.Create.ByMDX"
562,"NULL"
586,"C:\TM1\Bedrock\Data\Bedrock.Z.MDX.Placeholder.csv"
585,"C:\TM1\Bedrock\Data\Bedrock.Z.MDX.Placeholder.csv"
564,
565,"upj:B\WI:iJ`hFTV6yQDVa5UZKyb9Eyxxj`1i2=@OpGcBjqOpMfobriKUi9[dlqc`l_lncXevu`LWJ;h5LbxXxNnnz=sukD9V>S9c;x>5E;ASF12]lHClwze_KW<GBn]xNb]<O<fj77`e>XwAayzjlUg\8Q9l6xy5Xf11_`:0uq]nwie>iTK6;oY4Y0RhcYKC_Kfui@j"
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
589,","
568,""""
570,
571,
569,0
592,0
599,1000
560,5
pDimension
pSubset
pMDXExpr
pConvertToStatic
pDebug
561,5
2
2
2
1
1
590,5
pDimension,""
pSubset,""
pMDXExpr,""
pConvertToStatic,1
pDebug,0
637,5
pDimension,"Dimension"
pSubset,"Subset"
pMDXExpr,"Valid MDX Expression for Specified Dimension"
pConvertToStatic,"Bolean: 1 = True (convert to static subset)"
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

# This process will Create a dynamic subset from an MDX expression
# that evaluates to a non-empty set in the specified dimension.
# If the MDX does not compile or produces an empty set the process will error.
# If convert to static is true then the MDX subset will be replaced by a static subset.

### Constants ###

cProcess = 'Bedrock.Dim.Sub.Create.ByMDX';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;
cTempSubset = cProcess | '.' | sRandomInt;
cTempFile = GetProcessErrorFileDirectory | cTempSubset | '.csv';

sMDXExpr = pMDXExpr;

### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension       : ' | pDimension );
  AsciiOutput( sDebugFile, '            pSubset          : ' | pSubset );
  AsciiOutput( sDebugFile, '            pMDXExpr         : ' | pMDXExpr );
  AsciiOutput( sDebugFile, '            pConvertToStatic : ' | NumberToString( pConvertToStatic ) );

EndIf;

EXECUTEPROCESS('}bedrock.hier.sub.create.bymdx',
  'pLogOutput', pDebug,
  'pStrictErrorHandling',1,
  'pDim', pDimension,
  'pHier', '',
  'pSub', pSubset,
  'pMDXExpr', pMDXExpr,
  'pConvertToStatic', pConvertToStatic,
  'pTemp', 0
  );

### End Prolog ###
573,5

#****Begin: Generated Statements***
#****End: Generated Statements****


574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,11

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 



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
920,0
921,""
922,""
923,0
924,""
925,""
926,""
927,""
