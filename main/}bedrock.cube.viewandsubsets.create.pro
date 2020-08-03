601,100
602,"}bedrock.cube.viewandsubsets.create"
562,"NULL"
586,
585,
564,
565,"ui^SoCAb61X\^mYuAmjj^a0yyEzfyt<uGU:n6R?c>A1lgawz4?<kPM1qPgysr:u<i1v;m8ilFfav?JnjB0ux0Mm>f`c]z9r]cX]Em6L`5>`9ym8?8b\@CRZhi@c5my8<DVTOTwQ@XXNoLlY7c66RTkF0o>opazK3@6y[\RZKQaqc:@y8bzgV\IWaz]XJR6kCBqna^?kd"
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
pStrictErrorHandling
pCube
pView
pSub
pDim
pDelim
pSuppressZero
pSuppressConsol
pSuppressRules
pTemp
pSubN
561,12
1
1
2
2
2
2
2
1
1
1
1
1
590,12
pLogOutput,1
pStrictErrorHandling,0
pCube,""
pView,""
pSub,""
pDim,"*"
pDelim,"&"
pSuppressZero,1
pSuppressConsol,1
pSuppressRules,1
pTemp,1
pSubN,0
637,12
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pCube,"REQUIRED: List of Cubes (Separated by Delimiter, Accepts Wild card)"
pView,"OPTIONAL: View (will default to pSubset if left blank)"
pSub,"OPTIONAL: Subset (will default to pView if left blank)"
pDim,"REQUIRED: Dimension(s) to create empty processing subsets for (separated by delimiter), * = all"
pDelim,"OPTIONAL: List Delimiter (default value if blank = '&')"
pSuppressZero,"OPTIONAL: Suppress Zeros (Boolean Yes = 1)"
pSuppressConsol,"OPTIONAL: Suppress Calcs (Boolean Yes = 1)"
pSuppressRules,"OPTIONAL: Suppress Rules (Boolean Yes = 1)"
pTemp,"OPTIONAL: Make View Temporary (1=Temporary)"
pSubN,"OPTIONAL: Create N level subset for all dims not mentioned in pDim"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,302
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.cube.viewandsubsets.create', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pCube', '', 'pView', '', 'pSub', '', 
    	'pDim', '*', 'pDelim', '&',
    	'pSuppressZero', 1, 'pSuppressConsol', 1, 'pSuppressRules', 1,
    	'pTemp', 1, 'pSubN', 0
	);
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This process creates a processing view for the cube and for specified dimensions of the cube. 

# Use case: Intended for development/prototyping or in Production environment.
# 1. Create a view with subsets of the same name that are empty.

# Note:
# Creates empty subsets and assigns the empty subsets to the view. 
# A subsequent process is required to insert elements into subsets otherwise the views will not contain any data.
# Naturally, a valid cube name (pCube) is mandatory otherwise the process will abort.
#EndRegion @DOC

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;


### Constants ###
cThisProcName     = GetProcessName();
cUserName         = TM1User();
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = '%cThisProcName% : %sMessage% : %cUserName%';
cMsgInfoLevel     =  'INFO';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pCube:%pCube%, pView:%pView%, pSubset:%pSub%, pDim:%pDim%, pDelim:%pDelim%, pSuppressZero:%pSuppressZero%, pSuppressConsol:%pSuppressConsol%, pSuppressRules:%pSuppressRules%.'; 
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cTempSubset       = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
sMessage          = '';
cDimCubes         = '}Cubes';
cDimDimensions    = '}Dimensions';
cAll              = 'ALL';
cTemp             = If( pTemp >= 1, 1, 0 );

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###

nErrors = 0;

# Validate cube
If( Trim( pCube ) @= '' );
    sMessage    = 'No cube specified.';
    nErrors     = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate dimensions
If( Trim( pDim ) @= '' );
    sMessage    = 'No dimensions specified.';
    nErrors     = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate suppression parameters
If( pSuppressZero <> 0 & pSuppressZero <> 1 );
    sMessage    = 'Invalid value for suppress zero parameter.';
    nErrors     = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

If( pSuppressConsol <> 0 & pSuppressConsol <> 1 );
    sMessage    = 'Invalid value for suppress consol parameter.';
    nErrors     = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

If( pSuppressRules <> 0 & pSuppressRules <> 1 );
    sMessage    = 'Invalid value for suppress rules parameter.';
    nErrors     = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate view and subsets
If( pView @= '' & pSub @= '' );
    ## Use standard view name.
    cView       = cTempSubset;
    cSubset     = cView;
ElseIf( pView @<> '' & pSub @= '' );
    ## Use the nominated view name for the subset name.
    cView       = pView;
    cSubset     = pView;
ElseIf( pView @= '' & pSub @<> '' );
    ## Use the nominated subset name for the view name.
    cView       = pSub;
    cSubset     = pSub;
Else;
    cView   = pView;
    cSubset = pSub;
EndIf;


# Validate delimiter
If( pDelim @= '' );
    pDelim     = '&';
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

### Handle All cubes or a cubes list
If ( TRIM( pCube ) @= cAll );
  sMDX = Expand( '{TM1SUBSETALL([%cDimCubes%])}' );
Else;
  sCubeTokenizer = TRIM( pCube );
  sMDX = '';
  ### Loop and tokenize Cube list
  While ( sCubeTokenizer @<> '' );
    nPos = SCAN( pDelim, sCubeTokenizer );
    If ( nPos = 0 );
      nPos = LONG( sCubeTokenizer ) + 1;
    EndIf;
    sSearchCube = TRIM( SUBST( sCubeTokenizer, 1, nPos - 1 ) );
    If ( SCAN( '*', sSearchCube ) <> 0 % SCAN( '?', sSearchCube ) <> 0 );
      If( sMDX @= '' );
        sMDX = Expand( '{TM1FILTERBYPATTERN({TM1SUBSETALL([%cDimCubes%])}, "%sSearchCube%")}' );
      Else;
        sMDX = Expand( '%sMDX% + {TM1FILTERBYPATTERN({TM1SUBSETALL([%cDimCubes%])}, "%sSearchCube%")}' );
      EndIf;
    Else;
      If ( CubeExists( sSearchCube ) = 0 );
        sMessage = Expand( 'Cube: %sSearchCube% does not exist.' );
        nErrors = nErrors + 1;
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        If( pStrictErrorHandling = 1 ); 
            ProcessQuit; 
        Else;
            ProcessBreak;
        EndIf;
      Else;
        If( sMDX @= '' );
          sMDX = Expand( '{[%cDimCubes%].[%sSearchCube%]}' );
        Else;
          sMDX = Expand( '%sMDX% + {[%cDimCubes%].[%sSearchCube%]}' );
        EndIf;
      EndIf;
    EndIf;
    ### Consume dimension and delimiter
    sCubeTokenizer = TRIM( DELET( sCubeTokenizer, 1, nPos + LONG( pDelim ) - 1 ) );
  End;
  sMDX = Expand( '{%sMDX%}' );
EndIf;

If (SubsetExists( cDimCubes, cTempSubset ) = 1 );
  SubsetDestroy( cDimCubes, cTempSubset );
EndIf;
SubsetCreateByMDX( cTempSubset, sMDX, cDimCubes, 1 );

### Handle All dimensions or a dimension list
### We must exclude hierarchies
If ( TRIM( pDim ) @= cAll );
  sMDX = Expand( '{FILTER(TM1SUBSETALL([%cDimDimensions%]), INSTR([%cDimDimensions%].CurrentMember.Name, '':'' ) = 0 )}' );
Else;
  sDimTokenizer = TRIM( pDim );
  sMDX = '';
  ### Loop and tokenize dimension list
  While ( sDimTokenizer @<> '' );
    nPos = SCAN( pDelim, sDimTokenizer );
    If ( nPos = 0 );
      nPos = LONG( sDimTokenizer ) + 1;
    EndIf;
    sSearchDim = TRIM( SUBST( sDimTokenizer, 1, nPos - 1 ) );
    If ( SCAN( ':', sSearchDim ) <> 0 );
      sMessage    = Expand( 'Dimension: The process is not accepting hierarchies: %sSearchDim%' );
      nErrors     = nErrors + 1;
      LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    ElseIf ( SCAN( '*', sSearchDim ) <> 0 % SCAN( '?', sSearchDim ) <> 0 );
      If( sMDX @= '' );
        sMDX = Expand( '{TM1FILTERBYPATTERN({FILTER(TM1SUBSETALL([%cDimDimensions%]), INSTR([%cDimDimensions%].CurrentMember.Name, '':'' ) = 0 )}, "%sSearchDim%")}' );
      Else;
        sMDX = Expand( '%sMDX% + {TM1FILTERBYPATTERN({FILTER(TM1SUBSETALL([%cDimDimensions%]), INSTR([%cDimDimensions%].CurrentMember.Name, '':'' ) = 0 )}, "%sSearchDim%")}' );
      EndIf;
    Else;
      If ( DimensionExists( sSearchDim ) = 0 );
        sMessage    = Expand( 'Dimension: %sSearchDim% does not exist.' );
        nErrors     = nErrors + 1;
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        If( pStrictErrorHandling = 1 ); 
            ProcessQuit; 
        Else;
            ProcessBreak;
        EndIf;
      Else;
        If( sMDX @= '' );
          sMDX = Expand( '{[%cDimDimensions%].[%sSearchDim%]}' );
        Else;
          sMDX = Expand( '%sMDX% + {[%cDimDimensions%].[%sSearchDim%]}' );
        EndIf;
      EndIf;
    EndIf;
    ### Consume dimension and delimiter
    sDimTokenizer = TRIM( DELET( sDimTokenizer, 1, nPos + LONG( pDelim ) - 1 ) );
  End;
  sMDX = Expand( '{%sMDX%}' );
EndIf;

If (SubsetExists( cDimDimensions, cTempSubset ) = 1 );
  SubsetDestroy( cDimDimensions, cTempSubset );
EndIf;
SubsetCreateByMDX( cTempSubset, sMDX, cDimDimensions, 1 );

### Build Subsets and assign to View ###
nCube = 1;
While ( nCube <= SubsetGetSize( cDimCubes, cTempSubset ) );
  sCube = SubsetGetElementName( cDimCubes, cTempSubset, nCube );
  ### Build View ###
  If( ViewExists( sCube, cView ) = 1 );
    ViewDestroy( sCube, cView );
  EndIf;
  nDim = 1;
  sDim = TABDIM( sCube, nDim );
  While ( sDim @<> '' );
   # filter selection has non-empty intersect with current cube dimensions
   #If ( SubsetElementExists( cDimDimensions, cTempSubset, sDim ) = 1 ); - bug does not work
   IF( SubsetElementGetIndex( cDimDimensions, cTempSubset, sDim, 1 ) > 0 );
      # create view if and only if there is at least one match with dimensions
      If( ViewExists( sCube, cView ) = 0 );
        ViewCreate( sCube, cView, cTemp );
        ViewExtractSkipZeroesSet( sCube, cView, pSuppressZero );
        ViewExtractSkipCalcsSet( sCube, cView, pSuppressConsol );
        ViewExtractSkipRuleValuesSet( sCube, cView, pSuppressRules );
      EndIf;
      If ( SubsetExists ( sDim, cSubset ) = 1 );
        If ( SubsetGetSize( sDim, cSubset ) > 0 );
          SubsetDeleteAllElements( sDim, cSubset );
        EndIf;
      Else;
        SubsetCreate( sDim, cSubset, cTemp );
      EndIf;
      ViewSubsetAssign( sCube, cView, sDim, cSubset );
    EndIf;
    nDim = nDim + 1;
    sDim = TABDIM( sCube, nDim );
  End;
  
  # creating N level subset for all dim not included in pDim for the cube
  If(pSubN = 1);
    nCountDimC = 1;
    While( TabDim( sCube, nCountDimC ) @<> '' );
    sDimC = TabDim( sCube, nCountDimC );
    If ( ViewExists( sCube, cView ) = 1 & SubsetElementGetIndex( cDimDimensions, cTempSubset, sDimC, 1 ) = 0 );
      If ( SubsetExists ( sDimC, cSubset ) = 1 );
        If ( SubsetGetSize( sDimC, cSubset ) > 0 );
          SubsetDeleteAllElements( sDimC, cSubset );
        EndIf;
      Else;
        SubsetCreate( sDimC, cSubset, cTemp );
      Endif;  
      nElCount = DIMSIZ ( sDimC );
      nElC = 1;
      WHILE ( nElC <= nElCount );
        sEl = DIMNM( sDimC, nElC );
        IF(ElementLevel( sDimC, sDimC, sEl )= 0 );
          SubsetElementInsert( sDimC, cSubset, sEl, 0 );
        EndIf;
        nElC = nElC + 1;
      END;
      ViewSubsetAssign( sCube, cView, sDimC, cSubset );
    Endif;
    nCountDimC = nCountDimC + 1;
    End;
  Endif;


  nCube = nCube + 1;
End;


### End Prolog ###


573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,27

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
    If( pStrictErrorHandling = 1 ); 
        ProcessQuit; 
    EndIf;
Else;
    sProcessAction = Expand( 'Process:%cThisProcName% successfully created views and subsets for cube  %pCube%.' );
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
