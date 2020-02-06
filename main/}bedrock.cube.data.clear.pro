601,100
602,"}bedrock.cube.data.clear"
562,"NULL"
586,
585,
564,
565,"qZEEu@^wOX>zfr7d9aUJ?clB_TUgdMZtta8Kv8YQq=3C>iuk64?w7kbfkr8p=4hr>rQZwl61GYR>zZjqbY@SgAYT<pKKC<KNj>Z83bI`S:itpa[?w^?`rzSIG_T5^tE__TxBj6;Osg3n?bi\Hx]@rO=]J=CV6D725dhDIy@x`>kBrj=pal=@GI7BbgWCl?_9gX_3i=F8"
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
560,12
pLogOutput
pCube
pView
pFilter
pFilterParallel
pParallelThreads
pDimDelim
pEleStartDelim
pEleDelim
pCubeLogging
pTemp
pSandbox
561,12
1
2
2
2
2
1
2
2
2
1
1
2
590,12
pLogOutput,0
pCube,""
pView,""
pFilter,""
pFilterParallel,""
pParallelThreads,0
pDimDelim,"&"
pEleStartDelim,"¦"
pEleDelim,"+"
pCubeLogging,0
pTemp,1
pSandbox,""
637,12
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pCube,"REQUIRED: Cube Name (wildcard * and/or cube1 & cube2 list)"
pView,"OPTIONAL: View name to be cleared (uses pFilter if pView not specified else clears entire cube)"
pFilter,"Optional but ignored if view is specified: Year¦ 2006 + 2007 & Scenario¦ Actual + Budget & Organization¦ North America Operations"
pFilterParallel,"OPTIONAL: Parallelization Filter: Month:Q1+Q2+Q3+Q4 (Blank=run single threaded). Single dimension parallel slices. Will be added to filter single element at a time. Dimension must not be part of filter"
pParallelThreads,"OPTIONAL: Ignored if pFilterParallel is empty. Maximum number of threads to run when parallel processing is enabled ( if <2 will execute one thread, but parallel filter is still applied )"
pDimDelim,"OPTIONAL: Delimiter for start of Dimension/Element set  (default value if blank = '&')"
pEleStartDelim,"OPTIONAL: Delimiter for start of element list  (default value if blank = '¦')"
pEleDelim,"OPTIONAL: Delimiter between elements (default value if blank = '+')"
pCubeLogging,"Required: Cube Logging (0 = No transaction logging, 1 = Logging of transactions, 2 = Ignore Cube Logging - No Action Taken)"
pTemp,"OPTIONAL: Make Views and subsets Temporary (1=Temporary)"
pSandbox,"OPTIONAL: To use sandbox not base data enter the sandbox name (invalid name will result in process error)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,470
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.cube.data.clear', 'pLogOutput', pLogOutput,
    	'pCube', '', 'pView', '', 'pFilter', '',
    	'pFilterParallel', '', 'pParallelThreads', 0,
    	'pDimDelim', '&', 'pEleStartDelim', '¦', 'pEleDelim', '+',
    	'pCubeLogging', 0, 'pTemp', 1, 'pSandbox', pSandbox
	);
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This process could be used extensively by custom TIs in production to clear certain data out of a cube before copying data to that cube.

# Use case: Primarily for production systems.
# 1/ In production system this is a "workhorse" process called from the prolog of most custom processes prior to querying a data source to refresh cube data.
# 2/ During development/prototyping can be run manually to clear out a portion of a cube.

# Note:
# Wildcards can be used or a list of cubes specified to clear data out of multiple cubes simultaneouly. 
# If no cube (pCube) or an invalid cube is specified, the process will abort.
# CAUTION: If no view (pView) or filter (pFilter) is specified, the entire cube(s) will be cleared out.
# If a valid view is specified the process will simply zero out that view and ignore any filter (pFilter) specified.
# If no valid view is specified then a temporary view will be built using the filter and its data deleted.
# The filter can handle specific element references for any number of dimensions and elements.
# - The pFilter parameter contains the dimension and elements to be used for filtering.
# - The dimension parameters do not need to be given in the index order of dimensions in the cube.
# - The dimension name is specified as the first member of the delimited string of elements.
# If using the pFilterParallel parameter the **single dimension** used as the "parallelization slicer" cannot appear in
# the pFilter parameters.
# When using parallelization via the *RunProcess* function the elements listed in pFilterParallel will be split one_at_a_time
# and passed to a recursive call of the process being added to pFilter.
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName   = GetProcessName();
cUserName       = TM1User();
cMsgErrorLevel  = 'ERROR';
cMsgErrorContent= 'Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo        = 'Process:%cThisProcName% run with parameters pCube:%pCube%, pView:%pView%, pFilter:%pFilter%, pFilterParallel:%pFilterParallel%, pParallelThreads:%pParallelThreads%, pDimDelim:%pDimDelim%, pEleStartDelim:%pEleStartDelim%, pEleDelim:%pEleDelim%, pCubeLogging:%pCubeLogging%, pTemp:%pTemp%, pSandbox:%pSandbox%';  
cTimeStamp      = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
cDefaultView    = Expand( '%cThisProcName%_%cTimeStamp%_%cRandomInt%' );
cTempSub        = cDefaultView | '_Temp';

## LogOutput parameters
IF( pLogoutput = 1 );
  LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

# Trim delimiters
sDelimDim           = TRIM(pDimDelim);
sElementStartDelim  = TRIM(pEleStartDelim);
sDelimElem          = TRIM(pEleDelim);

### Validate Parameters ###
nErrors = 0;

## Default filter delimiters
If( pDimDelim     @= '' );
  pDimDelim     = '&';
EndIf;
If( pEleStartDelim@= '' );
  pEleStartDelim= '¦';
EndIf;
If( pEleDelim     @= '' );
  pEleDelim     = '+';
EndIf;

# Check the delimiters
If( Trim( pFilter ) @<> '' );
 If( sDelimDim @= sElementStartDelim % sDelimDim @= sDelimElem % sElementStartDelim @= sDelimElem );
    sMessage = 'The delimiters cannot be the same.';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  EndIf;
EndIf;   

# Validate cubelogging parameter
If( pCubeLogging <> 0 & pCubeLogging <> 1 & pCubeLogging <> 2);
  sMessage = 'The cube logging parameter incorrect';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# If no cube has been specified then terminate process
If( Trim( pCube ) @= '' );
  sMessage = 'No cube(s) specified.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate parallelization filter
If( Scan( pEleStartDelim, pFilterParallel ) > 0 );
  sDimParallel = SubSt( pFilterParallel, 1, Scan( pEleStartDelim, pFilterParallel ) - 1 );
  If( Scan( Lower(sDimParallel) | pEleStartDelim, Lower(pFilter) ) > 0 );
    sMessage = 'Parallelization dimension %sDimParallel% cannot exist in filter.';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  EndIf;
EndIf;

# Validate Max Threads
If( pParallelThreads >= 1 );
  nMaxThreads = Round(pParallelThreads);
Else;
  # Single thread mode
  nMaxThreads = 1;
EndIf;

# Validate Sandbox
If( TRIM( pSandbox ) @<> '' );
    If( ServerSandboxExists( pSandbox ) = 0 );
        SetUseActiveSandboxProperty( 0 );
        nErrors = nErrors + 1;
        sMessage = Expand('Sandbox %pSandbox% is invalid for the current user.');
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    Else;
        ServerActiveSandboxSet( pSandbox );
        SetUseActiveSandboxProperty( 1 );
    EndIf;
Else;
    SetUseActiveSandboxProperty( 0 );
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
  ProcessBreak;
EndIf;

# Loop through cubes in pCube
sCubes = pCube;
nCubeDelimiterIndex = 1;
# Get 1st cube
While( nCubeDelimiterIndex <> 0 );

  # Extract 1st cube > sCube
  nCubeDelimiterIndex = Scan( pDimDelim, sCubes );
  If( nCubeDelimiterIndex = 0 );
    sCube   = sCubes;
  Else;
    sCube   = Trim( SubSt( sCubes, 1, nCubeDelimiterIndex - 1 ) );
    sCubes  = Trim( Subst( sCubes, nCubeDelimiterIndex + Long(pDimDelim), Long( sCubes ) ) );
  EndIf;
  
  bParallel = 0;
  
  # Check if sCube has wildcard
  If( Scan( '*', sCube ) = 0);
    # Validate cube
    If( CubeExists(sCube) = 0 );
      nErrors     = 1;
      sMessage    = Expand( 'Cube %sCube% does not exist.' );
      LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
      ProcessBreak;
    Else;
      If( Scan( pEleStartDelim, pFilterParallel ) > 0 );
        nDim = 1;
        sDim = TABDIM( sCube, nDim);
        While ( sDim @<> '' );
          sDim = TABDIM( sCube, nDim);
          If ( sDim @= sDimParallel );
            bParallel = 1;
            sDim = '';
          EndIf;
          nDim = nDim + 1;
        End;
      EndIf;
      If( bParallel = 1 );
        sDimParallel = SubSt( pFilterParallel, 1, Scan( pEleStartDelim, pFilterParallel ) - 1 );
        sElementList = SubSt( pFilterParallel, Scan( pEleStartDelim, pFilterParallel ) + 1, Long( pFilterParallel ) );
        If( SubSt( sElementList, Long( sElementList ), 1 ) @<> pEleDelim );
            sElementList = sElementList | pEleDelim;
        EndIf;
        ## Counting elements in element list
        sElementListCount = sElementList;
        nElements = 0;
        While( Scan( pEleDelim, sElementListCount ) > 0 );
          nElements = nElements + 1;
          sElementListCount = SubSt( sElementListCount, Scan( pEleDelim, sElementListCount ) + 1, Long( sElementListCount ) );
        End;
        IF( Mod( nElements, nMaxThreads ) = 0 );
          nElemsPerThread = INT( nElements / nMaxThreads );
        ELSE;
          nElemsPerThread = INT( nElements / nMaxThreads ) + 1;
        ENDIF;
        nThreadElCounter = 0;
        While( Scan( pEleDelim, sElementList ) > 0 );
          sSlicerEle = SubSt( sElementList, 1, Scan( pEleDelim, sElementList ) - 1 );
          sElementList = SubSt( sElementList, Scan( pEleDelim, sElementList ) + 1, Long( sElementList ) );
          # Do recursive process call with new RunProcess function
          nThreadElCounter = nThreadElCounter + 1;
          sDimDelim = If(pFilter @= '', '', pDimDelim );
          IF( nThreadElCounter = 1 );
            sFilter = Expand('%pFilter%%sDimDelim%%sDimParallel%%pEleStartDelim%%sSlicerEle%');
          ELSE;
            sFilter = Expand('%sFilter%%pEleDelim%%sSlicerEle%');
          ENDIF;
          IF( nThreadElCounter >= nElemsPerThread );
            RunProcess( cThisProcName, 'pLogoutput', pLogoutput,
        	    'pCube', pCube, 'pView', pView, 'pFilter', sFilter,
        	    'pFilterParallel', '', 'pDimDelim', pDimDelim, 'pEleStartDelim', pEleStartDelim,
        	    'pEleDelim', pEleDelim, 'pCubeLogging', pCubeLogging, 'pTemp', pTemp, 'pSandbox', pSandbox
        	  );
        	  nThreadElCounter = 0;
        	  sFilter = '';
        	 ENDIF;
        End;
        ## Process last elements - only when filter is not empty (there are still elements) otherwise the entire cube is emptied
        IF( sFilter @<> '' );
          RunProcess( cThisProcName, 'pLogoutput', pLogoutput,
      	    'pCube', pCube, 'pView', pView, 'pFilter', sFilter,
      	    'pFilterParallel', '', 'pDimDelim', pDimDelim, 'pEleStartDelim', pEleStartDelim,
      	    'pEleDelim', pEleDelim, 'pCubeLogging', pCubeLogging, 'pTemp', pTemp, 'pSandbox', pSandbox
      	  );
    	  ENDIF;
      Else;
        ## Validate the View & filter parameter
        If( Trim( pView ) @= '' & Trim( pFilter ) @= '' );
          sMessage  = Expand('No view OR filter specified so the entire %sCube% cube has been cleared.');
          LogOutput( 'INFO' , Expand( 'Process:%cThisProcName% Message:%sMessage%' ) );
          CubeClearData( sCube );
        Else;
          # Use different view/subset for different cubes
          sTimeStamp      = TimSt( Now, '\Y\m\d\h\i\s' );
          sRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
          cDefaultView    = Expand( '%cThisProcName%_%sTimeStamp%_%sRandomInt%' );
          #cTempSub        = cDefaultView;
          
          If( Trim( pView ) @= '' );
            cView   = cDefaultView ;
          Else;
            cView = Trim( pView );
          EndIf;
          
          # Clear view
          If( ViewExists( sCube , cView ) = 0 );
            ## Validate that a Filter has been provided so that a view can be created.
            If( Trim( pFilter ) @= '' );
              sMessage = Expand('View %cView% does not exist in the %sCube% cube AND no Filter has not been specified in order to create a view.');
              LogOutput( 'INFO' , Expand( cMsgErrorContent ) );
              #ProcessBreak;
            EndIf;

            ### Create View using filter (temp view, therefore no need to destroy) ###
            sProc = '}bedrock.cube.view.create';
            nRes = ExecuteProcess( sProc,
                    'pLogOutput', pLogOutput,
                    'pCube', sCube,
                    'pView', cView,
                    'pFilter', pFilter,
                    'pSuppressZero', 1,
                    'pSuppressConsol',1,
                    'pSuppressRules',1,
                    'pDimDelim', pDimDelim,
                    'pEleStartDelim', pEleStartDelim,
                    'pEleDelim', pEleDelim,
                    'pTemp', pTemp
                    );

            ### Zero Out View ###
            If ( nRes = ProcessExitNormal() );
              If ( pCubeLogging <= 1 );
                sCubeLogging = CellGetS('}CubeProperties', sCube, 'LOGGING' );
                CubeSetLogChanges( sCube, pCubeLogging);
              EndIf;
              ViewZeroOut( sCube, cView );
              sMessage = Expand( 'Succeeded in creating the %cView% view in the %sCube% cube and data has been cleared.' );
              LogOutput( 'INFO', Expand( 'Process:%cThisProcName% Message:%sMessage%' ) );
              If ( pCubeLogging <= 1 );
                CubeSetLogChanges( sCube, IF(sCubeLogging@='YES',1,0) );  
              EndIf;
            Else;
              nErrors = nErrors + 1;
              sMessage = Expand( 'Creating view by %sProc% has failed. Nothing has been cleared in the %sCube% cube.' );
              LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            EndIf;
          Else;
            If ( pCubeLogging <= 1 );
              sCubeLogging = CellGetS('}CubeProperties', sCube, 'LOGGING' );
              CubeSetLogChanges( sCube, pCubeLogging);
            EndIf;
            ViewZeroOut( sCube, cView );
            If ( pCubeLogging <= 1 );
              CubeSetLogChanges( sCube, IF(sCubeLogging@='YES',1,0) ); 
            EndIf;
          Endif;
        Endif;
      EndIf;
    Endif;
  Else;
    # Create subset of cubes using Wildcard to loop through cubes in pCube with wildcard
    sCubeExp = '"'|sCube|'"';
    sMdx = '{TM1FILTERBYPATTERN( {TM1SUBSETALL( [}Cubes] )},'|sCubeExp| ')}';
    If( SubsetExists( '}Cubes' , cTempSub ) = 1 );
      # If a delimited list of cube names includes wildcards then we may have to re-use the subset multiple times
      SubsetMDXSet( '}Cubes' , cTempSub, sMDX );
    Else;
      # temp subset, therefore no need to destroy in epilog
      SubsetCreatebyMDX( cTempSub, sMDX, '}Cubes' , 1 );
    EndIf;
    
    # Loop through cubes in subset created based on wildcard
    nCountCube = SubsetGetSize( '}Cubes' , cTempSub );
    While( nCountCube >= 1 );
      # Use different view/subset for different cubes
      sTimeStamp      = TimSt( Now, '\Y\m\d\h\i\s' );
      sRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
      cDefaultView    = Expand( '%cThisProcName%_%sTimeStamp%_%sRandomInt%' );
      sCube           = SubsetGetElementName( '}Cubes' , cTempSub, nCountCube );
      # Validate cube name  Not necessary as derived from subset of }Cubes
      If( CubeExists(sCube) = 0 );
        nErrors = 1;
        sMessage = Expand( '%sCube% does not exist.' );
        LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
      Else;
        If( Scan( pEleStartDelim, pFilterParallel ) > 0 );
          nDim = 1;
          sDim = TABDIM( sCube, nDim);
          While ( sDim @<> '' );
            sDim = TABDIM( sCube, nDim);
            If ( sDim @= sDimParallel );
              bParallel = 1;
              sDim = '';
            EndIf;
            nDim = nDim + 1;
          End;
        EndIf;
        If( bParallel = 1 );
          sDimParallel = SubSt( pFilterParallel, 1, Scan( pEleStartDelim, pFilterParallel ) - 1 );
          sElementList = SubSt( pFilterParallel, Scan( pEleStartDelim, pFilterParallel ) + 1, Long( pFilterParallel ) );
          If( SubSt( sElementList, Long( sElementList ), 1 ) @<> pEleDelim );
              sElementList = sElementList | pEleDelim;
          EndIf;
        ## Counting elements in element list
        sElementListCount = sElementList;
        nElements = 0;
        While( Scan( pEleDelim, sElementListCount ) > 0 );
          nElements = nElements + 1;
          sElementListCount = SubSt( sElementListCount, Scan( pEleDelim, sElementListCount ) + 1, Long( sElementListCount ) );
        End;
        IF( Mod( nElements, nMaxThreads ) = 0 );
          nElemsPerThread = INT( nElements / nMaxThreads );
        ELSE;
          nElemsPerThread = INT( nElements / nMaxThreads ) + 1;
        ENDIF;
        nThreadElCounter = 0;
          While( Scan( pEleDelim, sElementList ) > 0 );
            sSlicerEle = SubSt( sElementList, 1, Scan( pEleDelim, sElementList ) - 1 );
            sElementList = SubSt( sElementList, Scan( pEleDelim, sElementList ) + 1, Long( sElementList ) );
            # Do recursive process call with new RunProcess function
          nThreadElCounter = nThreadElCounter + 1;
          sDimDelim = If(pFilter @= '', '', pDimDelim );
          IF( nThreadElCounter = 1 );
            sFilter = Expand('%pFilter%%sDimDelim%%sDimParallel%%pEleStartDelim%%sSlicerEle%');
          ELSE;
            sFilter = Expand('%sFilter%%pEleDelim%%sSlicerEle%');
          ENDIF;
          IF( nThreadElCounter >= nElemsPerThread );
            RunProcess( cThisProcName, 'pLogoutput', pLogoutput,
        	    'pCube', pCube, 'pView', pView, 'pFilter', sFilter,
        	    'pFilterParallel', '', 'pDimDelim', pDimDelim, 'pEleStartDelim', pEleStartDelim,
        	    'pEleDelim', pEleDelim, 'pCubeLogging', pCubeLogging, 'pTemp', pTemp, 'pSandbox', pSandbox
        	  );
        	  nThreadElCounter = 0;
        	  sFilter = '';
        	 ENDIF;
        End;
        ## Process last elements
        IF( sFilter @<> '' );
          RunProcess( cThisProcName, 'pLogoutput', pLogoutput,
      	    'pCube', pCube, 'pView', pView, 'pFilter', sFilter,
      	    'pFilterParallel', '', 'pDimDelim', pDimDelim, 'pEleStartDelim', pEleStartDelim,
      	    'pEleDelim', pEleDelim, 'pCubeLogging', pCubeLogging, 'pTemp', pTemp, 'pSandbox', pSandbox
      	  );
    	  ENDIF;
        Else;
          ## Validate the View & filter parameter
          If( Trim( pView ) @= '' & Trim( pFilter ) @= '' );
            # Clear entire cube
            sMessage  = Expand('No view OR filter specified so the entire %sCube% cube has been cleared.');
            LogOutput( 'INFO' , Expand( 'Process:%cThisProcName% Message:%sMessage%' ) );
            CubeClearData( sCube );
          Else;
            # Clear view cView
            If( Trim( pView ) @= '' );
              cView   = cDefaultView ;
            Else;
              cView = Trim( pView );
            EndIf;
        
            If( ViewExists( sCube, cView ) = 0 );
              ## Validate that a Filter has been provided so that a view can be created.
              If( Trim( pFilter ) @= '' );
                sMessage = Expand('View %cView% does not exist for %sCube% AND no Filter has not been specified in order to create a view.');
                LogOutput( 'ERROR' , Expand( cMsgErrorContent ) );
                #ProcessBreak;
              EndIf;
  
              ### Create View using filter (temp view, therefore no need to destroy) ###
              sProc = '}bedrock.cube.view.create';
              nRes = ExecuteProcess( sProc,
                  'pLogOutput', pLogOutput,
                  'pCube', sCube,
                  'pView', cView,
                  'pFilter', pFilter,
                  'pSuppressZero', 1,
                  'pSuppressConsol',1,
                  'pSuppressRules',1,
                  'pDimDelim', pDimDelim,
                  'pEleStartDelim', pEleStartDelim,
                  'pEleDelim', pEleDelim,
                  'pTemp', pTemp
                  );
  
              ### Zero Out View ###
              IF ( nRes = ProcessExitNormal() );
                If ( pCubeLogging <= 1 );
                  sCubeLogging = CellGetS('}CubeProperties', sCube, 'LOGGING' );
                  CubeSetLogChanges( sCube, pCubeLogging);
                EndIf;
                ViewZeroOut( sCube, cView );
                sMessage = Expand( 'Succeeded in creating the %cView% view in the %sCube% cube and data has been cleared.' );
                LogOutput( 'INFO', Expand( 'Process:%cThisProcName% Message:%sMessage%' ) );
                If ( pCubeLogging <= 1 );
                  CubeSetLogChanges( sCube, IF(sCubeLogging@='YES',1,0) );  
                EndIf;
              ELSE;
                nErrors = nErrors + 1;
                sMessage = Expand( 'Creating view by %sProc% has failed. Nothing has been cleared in the %sCube% cube.' );
                LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
              ENDIF;
            Else;
              If ( pCubeLogging <= 1 );
                sCubeLogging = CellGetS('}CubeProperties', sCube, 'LOGGING' );
                CubeSetLogChanges( sCube, pCubeLogging);
              EndIf;
              ViewZeroOut( sCube, cView );
              If ( pCubeLogging <= 1 );
                CubeSetLogChanges( sCube, IF(sCubeLogging@='YES',1,0) ); 
              EndIf;
            Endif;
          EndIf;
        EndIf;
        nCountCube = nCountCube - 1;
        # Use different view/subset for different cubes
        sTimeStamp      = TimSt( Now, '\Y\m\d\h\i\s' );
        sRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
        cDefaultView    = Expand( '%cThisProcName%_%sTimeStamp%_%sRandomInt%' );
        #cTempSub        = cDefaultView; 
      EndIf;
    End;
  EndIf;
End;

### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,24

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

### Return code & final error message handling
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
Else;
    sProcessAction = Expand( 'Process:%cThisProcName% successfully cleared data out of the %pCube% cube(s).' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogoutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );   
    EndIf;
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
