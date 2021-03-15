601,100
602,"Bedrock.Cube.Data.Copy.IntraCube"
562,"NULL"
586,"}APQ Staging TempSource"
585,"}APQ Staging TempSource"
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
589,"."
568,""""
570,}TI_Dummy_View
571,
569,0
592,0
599,1000
560,18
pCube
pView
pFilter
pElementMapping
pFactor
pDimensionDelim
pElementStartDelim
pElementDelim
pMappingDelimiter
pZeroTarget
pZeroSource
pDeleteViewsAndSubsets
pSuppressConsol
pSuppressRules
pAccumulate
pDropAndReattachRules
pCopyDataViaClonedCube
pDebug
561,18
2
2
2
2
1
2
2
2
2
1
1
1
1
1
1
1
1
1
590,18
pCube,"Source"
pView,"TestView"
pFilter,""
pElementMapping,"Version:Actual->Budget & Year:2011->2012 & Month:01->12"
pFactor,1
pDimensionDelim,"&"
pElementStartDelim,":"
pElementDelim,"+"
pMappingDelimiter,"->"
pZeroTarget,1
pZeroSource,0
pDeleteViewsAndSubsets,1
pSuppressConsol,1
pSuppressRules,1
pAccumulate,0
pDropAndReattachRules,0
pCopyDataViaClonedCube,0
pDebug,0
637,18
pCube,"REQUIRED: Cube Name"
pView,"OPTIONAL: Name of the views and subsets to create (if blank Bedrock + a random number will be used)"
pFilter,"OPTIONAL: Filter Unmapped Dimensions using format: Year: 2006 + 2007 & Scenario: Actual + Budget etc"
pElementMapping,"REQUIRED: Map source elements to target elements using format Dim1ToCopy:SourceElement->TargetElement & Dim2ToCopy:Source Element->TargetElement etc"
pFactor,"OPTIONAL: Multiply source value by factor (1 keeps the value as is). To modify existing values make the target element the same as the source with pZeroTarget = 0"
pDimensionDelim,"OPTIONAL: Delimiter for start of Dimension/Element set"
pElementStartDelim,"OPTIONAL: Delimiter for start of element list"
pElementDelim,"OPTIONAL: Delimiter between elements"
pMappingDelimiter,"OPTIONAL: Delimiter between source element and target element in pElementMapping"
pZeroTarget,"OPTIONAL: Zero out Target Element PRIOR to Copy? (Boolean 1=True)"
pZeroSource,"OPTIONAL: Zero out Source Element AFTER Copy? (Boolean 1=True)"
pDeleteViewsAndSubsets,"OPTIONAL: 0 = Keep view and subsets"
pSuppressConsol,"OPTIONAL: Suppress Consolidations (Skip = 1) Only 0 for strings"
pSuppressRules,"OPTIONAL: Suppress Rules (Skip = 1)"
pAccumulate,"OPTIONAL: 1 = Add source to existing value in target (if zero out target = 0 False). 0 = Replace target with source."
pDropAndReattachRules,"OPTIONAL: Drop rules before copying then reattach afterwards (1 = Yes"
pCopyDataViaClonedCube,"OPTIONAL: Copy via cloned cube. Only use if pSuppressRules = 0 and pDropAndReattachRules = 1 (1 = Yes"
pDebug,"OPTIONAL: Debug: 0"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,366

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

# This is the INTRA process used to copy within a cube
# Not to be confused with the INTER process which is used to copy to a different cube

# The pFilter parameter contains the dimensons and elements to be used for filtering
# on dimensions that are not mapped
# In other words, dimensions where the source element is the same as the target element
# The format of the pFilter parameter is as follows (using default delimiters & + :
#     Dim1: Elem1 + Elem2 & Dim2: Elem3 + Elem4
# The dimension parameters do not need to be given in the index order of dimensions in the cube.
# The dimension name is specified as the first member of the delimited string of elements.
# If consolidations are skipped the N level children of any consolidated filter elements will be used
# Spaces are ignored so use them to make your filter more readable

# The pElementMapping parameter is used for elements to be copied from a source element to a target element
# It uses the same pDimensionDelim and pElementStartDelim as pFilter
# but uses the pMappingDelimiter to separate the source element and target element
# e.g.
#     Dim1: SourceElement -> TargetElement & Dim2: SourceElement -> TargetElement
#
# The process adds the source elements used in the pElementMapping parameter to pFilter

# An example
# To copy the 2011 Actual data to 2012 Budget for Company ACME in the states of Utah and Nevada
# set pElementMapping to: Year:2011->2012 & Version:Actual->Budget
# and
# pFilter to: Company:ACME & State: Utah + Nevada
# The source will be filtered on 2011 Actual so you don't need to add 2011 Actual to the pFilter parameter

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
StringGlobalVariable('sTargetFilter');
nProcessReturnCode= 0;

### Constants ###
cThisProcName   = GetProcessName();
cUserName       = TM1User();
cMsgErrorContent= 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cTimeStamp      = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile      = GetProcessErrorFileDirectory | cThisProcName | '.' | cTimeStamp | '.' | cRandomInt ;
cMsgErrorLevel  = 'ERROR';
cMsgErrorContent= '%cThisProcName% : %sMessage% : %cUserName%';
cMsgErrorShell  = Expand('Executing process %cThisProcName% has failed.');
cMsgInfoLevel   = 'INFO';
cMsgInfoContent = '%cThisProcName% : %sMessage% : %cUserName%';

nErrors         = 0;
nRulesDropped   = 0;

### Initialise Debug ###
If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCube         : ' | pCube );
  AsciiOutput( sDebugFile, '            pView         : ' | pView );
  AsciiOutput( sDebugFile, '            pFilter           : ' | pFilter );
  AsciiOutput( sDebugFile, '            pElementMapping     : ' | pElementMapping );
  AsciiOutput( sDebugFile, '            pFactor     : ' | NUMBERTOSTRING (pFactor));

  AsciiOutput( sDebugFile, '            pDimensionDelim   : ' | pDimensionDelim );
  AsciiOutput( sDebugFile, '            pElementStartDelim: ' | pElementStartDelim );
  AsciiOutput( sDebugFile, '            pElementDelim     : ' | pElementDelim );
  AsciiOutput( sDebugFile, '            pMappingDelimiter     : ' | pMappingDelimiter );

  AsciiOutput( sDebugFile, '            pZeroTarget    : ' | NumberToString( pZeroTarget ) );
  AsciiOutput( sDebugFile, '            pZeroSource    : ' | NumberToString( pZeroSource ) );
  AsciiOutput( sDebugFile, '            pDeleteViewsAndSubsets    : ' | NumberToString( pDeleteViewsAndSubsets ) );

  AsciiOutput( sDebugFile, '            pSuppressConsol      : ' | NumberToString( pSuppressConsol) );
  AsciiOutput( sDebugFile, '            pSuppressRules        : ' | NumberToString( pSuppressRules) );

  AsciiOutput( sDebugFile, '            pAccumulate     : ' | NumberToString(pAccumulate));

  AsciiOutput( sDebugFile, '            pDropAndReattachRules     : ' | NumberToString(pDropAndReattachRules));
  AsciiOutput( sDebugFile, '            pCopyDataViaClonedCube     : ' | NumberToString(pCopyDataViaClonedCube));

  AsciiOutput( sDebugFile, '            pDebug       : ' | NumberToString( pDebug) );

EndIf;


#This Process was changed into shell, that will call another process from Bedrock v4.

# Check if there is a rules file to drop
# if not, ignore the pDropAndReattachRules parameter and proceed without dropping the rules
If(pDropAndReattachRules = 1);
    sRuleFile = pCube | '.rux';
    If( FileExists( sRuleFile ) <> 1 );
      sMessage = 'Rule file not found for cube: '|pCube;
      LogOutput( cMsgInfoLevel, Expand( cMsgInfoContent ) );
      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, sMessage );
      EndIf;
      pDropAndReattachRules = 0;
    EndIf;
EndIf;

### Getting cube logging parameter
sCubeLogging = CellGetS('}CubeProperties', pCube, 'LOGGING' );
nCubeLogging = IF(sCubeLogging@='YES',1,0);

# drop the rule
If(pDropAndReattachRules = 1);
  
  sProc = '}bedrock.cube.rule.manage';

  nRes = EXECUTEPROCESS( sProc,
    'pCube', pCube,
    'pMode', 'UNLOAD'
    );
    
  IF ( nRes <> ProcessExitNormal() );
    sMessage = cMsgErrorShell;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    if ( pDebug >= 1 );
      AsciiOutput( sDebugFile, Expand( cMsgErrorContent ) );
      AsciiOutput( sDebugFile, Expand( 'Process %sProc% exit code: %nRes%' ) );
      AsciiOutput( sDebugFile, Expand('Process %sProc% Finished: ') | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
    endif;
    ProcessError();
  ENDIF;
  
Endif;  
  
# MAIN COPY in the cube
If(pCopyDataViaClonedCube = 0);  

  sProc = '}bedrock.cube.data.copy';

  nRes = EXECUTEPROCESS( sProc,
    'pLogOutput', pDebug,
    'pStrictErrorHandling',1,
    'pCube', pCube,
    'pSrcView', pView,
    'pTgtView', '',
    'pFilter', pFilter,
    'pEleMapping', pElementMapping,
    'pMappingDelim', pMappingDelimiter,
    'pFactor', pFactor,
    'pDimDelim', pDimensionDelim,
    'pEleStartDelim', pElementStartDelim,
    'pEleDelim', pElementDelim,
    'pSuppressRules', pSuppressRules,
    'pCumulate', pAccumulate, 
    'pZeroSource', pZeroSource,
    'pZeroTarget', pZeroTarget,
    'pTemp', pDeleteViewsAndSubsets,
    'pCubeLogging', nCubeLogging
    );

  IF ( nRes <> ProcessExitNormal() );
    sMessage = cMsgErrorShell;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    if ( pDebug >= 1 );
      AsciiOutput( sDebugFile, Expand( cMsgErrorContent ) );
      AsciiOutput( sDebugFile, Expand( 'Process %sProc% exit code: %nRes%' ) );
      AsciiOutput( sDebugFile, Expand('Process %sProc% Finished: ') | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
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
    
  sClonedCube = pCube | cUserName | cRandomInt;

  # Note that pSuppressRules = 1 to skip rules
  # The Bedrock Cube Clone process uses 1 for the pRuleValues parameter to skip rules
  # So pSuppressRules can be passed to pRuleValues

  # copy to clone
  sProc = '}bedrock.cube.clone';

  nRes = EXECUTEPROCESS( sProc,
    'pLogOutput', pDebug,
    'pStrictErrorHandling',1,
    'pSrcCube', pCube,
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
      AsciiOutput( sDebugFile, Expand('Process %sProc% Finished: ') | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
    endif;
    ProcessError();
  ENDIF;

  # copy in Clone using the element mapping
  sProc = '}bedrock.cube.data.copy';

  nRes = EXECUTEPROCESS( sProc,
    'pLogOutput', pDebug,
    'pStrictErrorHandling',1,
    'pCube', sClonedCube,
    'pSrcView', pView,
    'pTgtView', '',
    'pFilter', pFilter,
    'pEleMapping', pElementMapping,
    'pMappingDelim', pMappingDelimiter,
    'pFactor', pFactor,
    'pDimDelim', pDimensionDelim,
    'pEleStartDelim', pElementStartDelim,
    'pEleDelim', pElementDelim,
    'pSuppressRules', pSuppressRules,
    'pCumulate', pAccumulate, 
    'pZeroSource', 1,
    'pZeroTarget', pZeroTarget,
    'pTemp', 1,
    'pCubeLogging', nCubeLogging
    );

  IF ( nRes <> ProcessExitNormal() );
    sMessage = cMsgErrorShell;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    if ( pDebug >= 1 );
      AsciiOutput( sDebugFile, Expand( cMsgErrorContent ) );
      AsciiOutput( sDebugFile, Expand( 'Process %sProc% exit code: %nRes%' ) );
      AsciiOutput( sDebugFile, Expand('Process %sProc% Finished: ') | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
    endif;
    ProcessError();
  ENDIF;
  
  
  # copy back to source cube
  sProc = '}bedrock.cube.data.copy.intercube';
  nRet = ExecuteProcess( sProc,
    'pLogOutput', pDebug,
    'pStrictErrorHandling',1,
    'pSrcCube', sClonedCube,
    'pFilter', sTargetFilter,
    'pTgtCube', pCube,
    'pMappingToNewDims','',
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
      AsciiOutput( sDebugFile, Expand('Process %sProc% Finished: ') | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
    endif;
    ProcessError();
  ENDIF;
  
  # cleaning the source view in source cube if required
  IF( pZeroSource = 1);
  
    sProc = '}bedrock.cube.data.clear';
    nRet = ExecuteProcess( sProc,
    'pLogOutput', pDebug,
    'pStrictErrorHandling',1,
    'pCube', pCube,
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
    'pLogOutput', pDebug,
    'pCube', sClonedCube,
    'pCtrlObj', 1
     );

  IF ( nRes <> ProcessExitNormal() );
    sMessage = cMsgErrorShell;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    if ( pDebug >= 1 );
      AsciiOutput( sDebugFile, Expand( cMsgErrorContent ) );
      AsciiOutput( sDebugFile, Expand( 'Process %sProc% exit code: %nRes%' ) );
      AsciiOutput( sDebugFile, Expand('Process %sProc% Finished: ') | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
    endif;
    ProcessError();
  ENDIF;

EndIf;



# Return the rule
If(pDropAndReattachRules = 1);
    
  sProc = '}bedrock.cube.rule.manage';
  nRes = EXECUTEPROCESS( sProc,
    'pLogOutput', pDebug,
    'pStrictErrorHandling',1,
    'pCube', pCube,
    'pMode', 'LOAD'
    );
    
  IF ( nRes <> ProcessExitNormal() );
    sMessage = cMsgErrorShell;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    if ( pDebug >= 1 );
      AsciiOutput( sDebugFile, Expand( cMsgErrorContent ) );
      AsciiOutput( sDebugFile, Expand( 'Process %sProc% exit code: %nRes%' ) );
      AsciiOutput( sDebugFile, Expand('Process %sProc% Finished: ') | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
    endif;
    ProcessError();
  ENDIF;
    
EndIf;





573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,5

#****Begin: Generated Statements***
#****End: Generated Statements****


575,17

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
