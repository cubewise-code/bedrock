601,100
602,"Bedrock.Cube.Data.Copy.InterCube"
562,"NULL"
586,"Bedrock Source Cube"
585,"Bedrock Source Cube"
564,
565,"wuJT\H79p;q1tfhceu0^=Cbao=vYeC]ZCgv0vt[QzM=6`:_@l?b@Z1<yvUe]k8gB5;VN3?K6q=G;TJdTX^Up_6R>WO;6xA6u5bYE>6dktu9[pf1Oz\jxOI7chp<Gg7zyJW;7H;N]fwLx0VnYRj?e8P6;0D8s<0hxClFN@_g`AO`@;8DHMum\]6MfNT=qRPJITugU?TZY"
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
570,Default
571,
569,0
592,0
599,1000
560,17
pSourceCube
pFilter
pTargetCube
pMappingToNewDims
pSuppressConsol
pSuppressRules
pZeroTarget
pZeroSource
pDimensionDelim
pElementStartDelim
pElementDelim
pDeleteViewsAndSubsets
pView
pDebug
pFactor
pDropAndReattachRules
pCopyDataViaClonedCube
561,17
2
2
2
2
1
1
1
1
2
2
2
1
2
1
2
1
1
590,17
pSourceCube,"Source"
pFilter,"State: Victoria + Queensland & Source Measure: Revenue"
pTargetCube,"Target"
pMappingToNewDims,""
pSuppressConsol,1
pSuppressRules,1
pZeroTarget,1
pZeroSource,0
pDimensionDelim,"&"
pElementStartDelim,":"
pElementDelim,"+"
pDeleteViewsAndSubsets,1
pView,""
pDebug,1
pFactor,"1"
pDropAndReattachRules,0
pCopyDataViaClonedCube,0
637,17
pSourceCube,"REQUIRED: Cube data is being copied from"
pFilter,"OPTIONAL: Filter on source cube in format Year: 2006 + 2007 & Scenario: Actual + Budget. Blank for whole cube"
pTargetCube,"REQUIRED: Name of cube to copy the values to"
pMappingToNewDims,"REQUIRED IF TARGET HAS DIMS NOT IN SOURCE: DimX:InputElementForDimX & DimY:InputElementForDimY (specify an N level element for each new dim)"
pSuppressConsol,"OPTIONAL: Suppress Consolidations (Skip = 1) Only use 0 for strings"
pSuppressRules,"OPTIONAL: Suppress Rules (Skip = 1)"
pZeroTarget,"OPTIONAL: Zero out Target Element PRIOR to Copy? (Boolean 1=True) Clears combination of pFilter and pMappingToNewDims"
pZeroSource,"OPTIONAL: Zero out Source Element AFTER Copy? (Boolean 1=True). If pFilter is blank the whole source cube is cleared!"
pDimensionDelim,"OPTIONAL. Delimiter for start of Dimension/Element set"
pElementStartDelim,"OPTIONAL: Delimiter for start of element list"
pElementDelim,"OPTIONAL: Delimiter between elements"
pDeleteViewsAndSubsets,"OPTIONAL:  0 = Keep view and subsets"
pView,"OPTIONAL: Name of the views and subsets to create (if blank a timestamp and random number will be used)"
pDebug,"OPTIONAL: Debug = 0"
pFactor,"OPTIONAL: Multiply source value by factor (1 keeps the value as is). To modify existing values make the target element the same as the source with pZeroTarget = 0"
pDropAndReattachRules,"OPTIONAL: Drop rules before copying then reattach afterwards (1 = Yes"
pCopyDataViaClonedCube,"OPTIONAL: Copy via cloned cube. Only use if pSuppressRules = 0 and pDropAndReattachRules = 1 (1 = Yes"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,337

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

# This is the INTER process used to copy to a different cube
# Not to be confused with the INTRA process which is used within a cube

# This process is used to copy data from a source cube to a target cube
# The target cube may have more or less or the same number of dimensions as the source cube
# Where the target and source cubes share the same dimensions, the process will match the dimensions
# even if their position in the cube is different
# An input element must be specified for each dimension which is in the target but not in the source
# using the parameter pMappingToNewDims
# The format of parameter pMappingToNewDims using default delimiters & and : is
#    DimInTargetButNotSource1:ElementOfDim & DimInTargetButNotSource2:ElementOfDim
# The input element must be an N level unless pSuppressConsol is set to 0.

# For dimensions in the source but not the target, the process will accumulate the values of all n level elements
# (or all n level elements specified by the pFilter parameter)

# The pFilter parameter contains the dimensons and elements to be used for filtering the source cube
# The format of the pFilter parameter is as follows, using default delimiters & + :
#     Dim1: Elem1 + Elem2 & Dim2: Elem3 + Elem4
# The dimension parameters do not need to be given in the index order of dimensions in the cube.
# The dimension name is specified as the first member of the delimited string of elements.
# If consolidations are skipped the N level children of any consolidated filter elements will be used
# Spaces are ignored so use them to make your filter more readable

# An example
# To copy the 2011 Actual Sales data from the Sales cube to the General Ledger cube
# set pFilter to Year: 2011 & Version: Actual
# Say the General Ledger cube has an Account dimension but the Sales cube doesn't.
# The Account for sales is 9999 (an n level element)
# so set the pMappingToNewDims parameter to Account:9999
# This will copy all Actual 2011 Sales to Account 9999 in the General Ledger
# If only sales for Company X are to be copied, set pFilter to Year: 2011 & Version: Actual & Company:X
# If sales from other companies are already in the General Ledger,
# set pZeroTarget to 0 to add Company X's data to the existing data
# Setting pZeroTarget to 1 will clear our data in the target cube for the elements specified in the
# pMappingToNewDims parameter and the pFilter parameter for dimensions that are in the target.

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
cMsgErrorLevel    = 'ERROR';
cMsgErrorConten   = '%cThisProcName% : %sMessage% : %cUserName%';
cMsgErrorShell    = Expand('Executing process %cThisProcName% has failed.');
cMsgInfoLevel     = 'INFO';
cMsgInfoContent   = '%cThisProcName% : %sMessage% : %cUserName%';


nErrors         = 0;
nRulesDropped   = 0;

### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pSourceCube         : ' | pSourceCube );

  AsciiOutput( sDebugFile, '            pFilter           : ' | pFilter );
  AsciiOutput( sDebugFile, '            pTargetCube     : ' | pTargetCube );
  AsciiOutput( sDebugFile, '            pMappingToNewDims     : ' | pMappingToNewDims );

  AsciiOutput( sDebugFile, '            pFactor      : ' |  pFactor );

  AsciiOutput( sDebugFile, '            pSuppressConsol      : ' | NumberToString( pSuppressConsol) );
  AsciiOutput( sDebugFile, '            pSuppressRules        : ' | NumberToString( pSuppressRules) );



  AsciiOutput( sDebugFile, '            pZeroTarget    : ' | NumberToString( pZeroTarget ) );
  AsciiOutput( sDebugFile, '            pZeroSource    : ' | NumberToString( pZeroSource ) );

  AsciiOutput( sDebugFile, '            pDimensionDelim   : ' | pDimensionDelim );
  AsciiOutput( sDebugFile, '            pElementStartDelim: ' | pElementStartDelim );
  AsciiOutput( sDebugFile, '            pElementDelim     : ' | pElementDelim );

  AsciiOutput( sDebugFile, '            pDeleteViewsAndSubsets    : ' | NumberToString( pDeleteViewsAndSubsets ) );
  AsciiOutput( sDebugFile, '            pView         : ' | pView );
  AsciiOutput( sDebugFile, '            pDebug       : ' | NumberToString( pDebug) );

EndIf;

#Convert pFactor to a number
nFactor = StringToNumber(pFactor);


# Check if there is a rules file to drop
# if not, ignore the pDropAndReattachRules parameter and proceed without dropping the rules
If(pDropAndReattachRules = 1);
    sRuleFile = pTargetCube | '.rux';
    If( FileExists( sRuleFile ) <> 1 );
      sMessage = 'Rule file not found for cube: '|pTargetCube;
      LogOutput( cMsgInfoLevel, Expand( cMsgInfoContent ) );
      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, sMessage );
      EndIf;
      pDropAndReattachRules = 0;
    EndIf;
EndIf;


### Getting cube logging parameter
sCubeLogging = CellGetS('}CubeProperties', pTargetCube, 'LOGGING' );
nCubeLogging = IF(sCubeLogging@='YES',1,0);


#################### Calling Bedrock v4 processes #######################

# Drop the rule
If(pDropAndReattachRules = 1);
  
  sProc = '}bedrock.cube.rule.manage';

  nRes = EXECUTEPROCESS( sProc,
    'pLogOutput', pDebug,
    'pCube', pTargetCube,
    'pMode', 'UNLOAD'
    );
    
  IF ( nRes <> ProcessExitNormal() );
    sMessage = cMsgErrorShell;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    if ( pDebug >= 1 );
      AsciiOutput( sDebugFile, Expand( cMsgErrorContent ) );
      AsciiOutput( sDebugFile, Expand( 'Process %sProc% exit code: %nRes%' ) );
      AsciiOutput( sDebugFile, Expand( 'Process %sProc% Finished: ') | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
    endif;
    ProcessError();
  ENDIF;
  
Endif;  


# Copy 
If(pCopyDataViaClonedCube = 0);
  
  # copy back to source cube
  sProc = '}bedrock.cube.data.copy.intercube';
  nRet = ExecuteProcess( sProc,
    'pLogOutput', pDebug,
    'pSrcCube', pSourceCube,
    'pFilter', pFilter,
    'pTgtCube', pTargetCube,
    'pMappingToNewDims', pMappingToNewDims,
    'pSuppressConsol', pSuppressConsol,
    'pSuppressRules', pSuppressRules,
    'pZeroSource', pZeroSource,
    'pZeroTarget', pZeroTarget,
    'pFactor', nFactor,
    'pDimDelim', pDimensionDelim,
    'pEleStartDelim', pElementStartDelim,
    'pEleDelim', pElementDelim,
    'pTemp', pDeleteViewsAndSubsets,
    'pCubeLogging', nCubeLogging
    );  
    
  IF ( nRes <> ProcessExitNormal() );
    sMessage = cMsgErrorShell;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    if ( pDebug >= 1 );
      AsciiOutput( sDebugFile, Expand( cMsgErrorContent ) );
      AsciiOutput( sDebugFile, Expand( 'Process %sProc% exit code: %nRes%' ) );
      AsciiOutput( sDebugFile, Expand( 'Process %sProc% Finished: ') | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
    endif;
    ProcessError();
  ENDIF;
  
Endif;  


# COPYING THROUGH THE CLONE CUBE   
# Set the parameter pCopyDataViaClonedCube to 1
# to avoid recalculating the cache each time a cell is copied
# Calculated values can be copied to a tempororary cloned cube
# then the rules can be dropped, the data can be copied
# and then the rules can be reattached on the epilog

If(pCopyDataViaClonedCube = 1);
    
  sClonedCube = pSourceCube | cUserName | cRandomInt;

  # Note that pSuppressRules = 1 to skip rules
  # The Bedrock Cube Clone process uses 1 for the pRuleValues parameter to skip rules
  # So pSuppressRules can be passed to pRuleValues

  # copy to clone
  sProc = '}bedrock.cube.clone';

  nRes = EXECUTEPROCESS( sProc,
    'pLogOutput', pDebug,
    'pSrcCube', pSourceCube,
    'pTgtCube', sClonedCube,
    'pIncludeRules', 0,
    'pIncludeData', 1, 
    'pFilter', pFilter,
    'pSuppressRules', pSuppressRules,
    'pCubeLogging', 0
    );
    
  IF ( nRes <> ProcessExitNormal() );
    sMessage = cMsgErrorShell;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    if ( pDebug >= 1 );
      AsciiOutput( sDebugFile, Expand( cMsgErrorContent ) );
      AsciiOutput( sDebugFile, Expand( 'Process %sProc% exit code: %nRes%' ) );
      AsciiOutput( sDebugFile, Expand( 'Process %sProc% Finished: ') | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
    endif;
    ProcessError();
  ENDIF;


  # copy back to source cube
  sProc = '}bedrock.cube.data.copy.intercube';

  nRet = ExecuteProcess( sProc,
    'pLogOutput', pDebug,
    'pSrcCube', sClonedCube,
    'pFilter', pFilter,
    'pTgtCube', pTargetCube,
    'pMappingToNewDims', pMappingToNewDims,
    'pSuppressConsol', 1,
    'pSuppressRules', pSuppressRules,
    'pZeroSource', 0,
    'pZeroTarget', pZeroTarget,
    'pDimDelim', pDimensionDelim,
    'pEleStartDelim', pElementStartDelim,
    'pEleDelim', pElementDelim,
    'pTemp', pDeleteViewsAndSubsets,
    'pCubeLogging', nCubeLogging
    );  
    
    
  IF ( nRes <> ProcessExitNormal() );
    sMessage = cMsgErrorShell;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    if ( pDebug >= 1 );
      AsciiOutput( sDebugFile, Expand( cMsgErrorContent ) );
      AsciiOutput( sDebugFile, Expand( 'Process %sProc% exit code: %nRes%' ) );
      AsciiOutput( sDebugFile, Expand( 'Process %sProc% Finished: ') | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
    endif;
    ProcessError();
  ENDIF;
  
  # cleaning the source view in source cube if required
  IF( pZeroSource = 1);
  
    sProc = '}bedrock.cube.data.clear';
    nRet = ExecuteProcess( sProc,
    'pLogOutput', pDebug,
    'pCube', pSourceCube,
    'pView', pView,
    'pFilter', pFilter,
    'pDimDelim', pDimensionDelim,
    'pEleStartDelim', pElementStartDelim,
    'pEleDelim', pElementDelim,
    'pTemp', pDeleteViewsAndSubsets,
    'pCubeLogging', nCubeLogging
    );

    IF(nRet <> 0);
      sMessage = 'Error clearing the source view.';
      nErrors = nErrors + 1;
      LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
      ProcessError();
    ENDIF;
    
  Endif;

  # destroy clone cube
  sProc = '}bedrock.cube.delete';
  
  nRes = EXECUTEPROCESS( sProc,
  'pCube', sClonedCube,
  'pCtrlObj', 0
  );

  IF ( nRes <> ProcessExitNormal() );
    sMessage = cMsgErrorShell;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    if ( pDebug >= 1 );
      AsciiOutput( sDebugFile, Expand( cMsgErrorContent ) );
      AsciiOutput( sDebugFile, Expand( 'Process %sProc% exit code: %nRes%' ) );
      AsciiOutput( sDebugFile, Expand( 'Process %sProc% Finished: ') | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
    endif;
    ProcessError();
  ENDIF;

EndIf;



# Return the rule
If(pDropAndReattachRules = 1);
    
  sProc = '}bedrock.cube.rule.manage';

  nRes = EXECUTEPROCESS( sProc,
    'pLogOutput', pDebug,
    'pCube', pTargetCube,
    'pMode', 'LOAD'
    );
    
  IF ( nRes <> ProcessExitNormal() );
    sMessage = cMsgErrorShell;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    if ( pDebug >= 1 );
      AsciiOutput( sDebugFile, Expand( cMsgErrorContent ) );
      AsciiOutput( sDebugFile, Expand( 'Process %sProc% exit code: %nRes%' ) );
      AsciiOutput( sDebugFile, Expand( 'Process %sProc% Finished: ') | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
    endif;
    ProcessError();
  ENDIF;
    
EndIf;

573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,8

#****Begin: Generated Statements***
#****End: Generated Statements****





575,21

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';
  # Log finish time
  AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

EndIf;

### End Epilog ###




576,CubeAction=1511?DataAction=1503?CubeLogChanges=0?
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
