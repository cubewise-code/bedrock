601,100
602,"}bedrock.cube.data.export"
562,"VIEW"
586,"}APQ Staging TempSource"
585,"}APQ Staging TempSource"
564,
565,"x8ADveb8lYG:Gf26oDs<3h>maJBBd@d6p0IMte1YZ0ps1u?XukhT;;Am]30BfnpGi5msaTgUhR69>J?L<mGeOb[dfzVfRdB`Obda;T5K?oo?]EPJwN3tyKYBT8Em^=4TvG0CSQ2TOm@mE4OwCJaxweJ?cwwFnVn\roo2g8\@iMl7YWf]:N9^XFZXORV8^EYSc2?P0GwN"
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
570,}TI_Dummy_View
571,
569,0
592,0
599,1000
560,20
pLogoutput
pCube
pView
pFilter
pFilterParallel
pParallelThreads
pDimDelim
pEleStartDelim
pEleDelim
pSuppressZero
pSuppressConsol
pSuppressRules
pZeroSource
pCubeLogging
pTemp
pFilePath
pFileName
pDelim
pQuote
pTitleRecord
561,20
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
1
1
1
1
2
2
2
2
1
590,20
pLogoutput,0
pCube,""
pView,""
pFilter,""
pFilterParallel,""
pParallelThreads,1
pDimDelim,"&"
pEleStartDelim,"¦"
pEleDelim,"+"
pSuppressZero,1
pSuppressConsol,1
pSuppressRules,1
pZeroSource,0
pCubeLogging,0
pTemp,1
pFilePath,""
pFileName,""
pDelim,","
pQuote,""""
pTitleRecord,1
637,20
pLogoutput,"Optional: write parameters and action summary to server message log (Boolean True = 1)"
pCube,"Required: cube name"
pView,"Optional: Temporary view name"
pFilter,"Optional: Filter: Year: 2006 + 2007 & Scenario: Actual + Budget & Organization: North America Operations (Blank=whole cube)"
pFilterParallel,"Optional: Parallelization Filter: Month:Q1+Q2+Q3+Q4 (Blank=run single threaded). Single dimension parallel slices. Will be added to filter single element at a time. Dimension must not be part of filter"
pParallelThreads,"Maximum number of threads to run when parallel processing is enabled ( if <2 will execute one thread, but parallel filter is still applied )"
pDimDelim,"Optional: Delimiter between dimensions"
pEleStartDelim,"Optional: Delimiter for start of element list"
pEleDelim,"Optional: Delimiter between elements"
pSuppressZero,"Optional: Suppress Zero Values (1=Suppress)"
pSuppressConsol,"Optional: Suppress Consolidated Values? (1=Suppress)"
pSuppressRules,"Optional: Suppress Rule Values? (1=Suppress)"
pZeroSource,"Optional: Zero Out view AFTER Copy? (Boolean 1=True)"
pCubeLogging,"Optional: Cube Logging (0 = No transaction logging, 1 = Logging of transactions)"
pTemp,"Optional: Retain temporary view and Subset ( 0 = retain View and Subsets 1 = use temp objects)"
pFilePath,"Optional: Export Directory (will default to error file path)"
pFileName,"Optional: Export Filename (If Left Blank Defaults to cube_export.csv)"
pDelim,"Optional: AsciiOutput delimiter character (Default=comma, exactly 3 digits = ASCII code)"
pQuote,"Optional: AsciiOutput quote character (Accepts empty quote, exactly 3 digits = ASCII code)"
pTitleRecord,"Optional: Include Title Record in Export File? (Boolean 0=false, 1=true, Default=1)"
577,101
V1
V2
V3
V4
V5
V6
V7
V8
V9
V10
V11
V12
V13
V14
V15
V16
V17
V18
V19
V20
V21
V22
V23
V24
V25
V26
V27
V28
V29
V30
V31
V32
V33
V34
V35
V36
V37
V38
V39
V40
V41
V42
V43
V44
V45
V46
V47
V48
V49
V50
V51
V52
V53
V54
V55
V56
V57
V58
V59
V60
V61
V62
V63
V64
V65
V66
V67
V68
V69
V70
V71
V72
V73
V74
V75
V76
V77
V78
V79
V80
V81
V82
V83
V84
V85
V86
V87
V88
V89
V90
V91
V92
V93
V94
V95
V96
V97
V98
V99
V100
Value
578,101
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
579,101
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
98
99
100
101
580,101
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
581,101
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
582,101
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
603,0
572,317

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This TI is designed to export data in a given cube to a flat file for a given "slice" (any dimension/element combination).
#
# Use case: Intended for development/prototyping or in Production environment.
# 1. Export data for import into another TM1 model to eliminate possibility of locking.
# 2. Export data for import into ERP system.
#
# Note:
# * Naturally, a valid cube name (pCube) is mandatory otherwise the process will abort.
# * All other parameters are optional, however, the filter (pFilter) should be specified to limit the size of the file.
# * The default output path is the same as the error file path.
# * As this TI has a view as a data source it requires the implicit variables NValue, SValue and Value_is_String
# * To edit this TI in Architect a tmp cube with minimum 24 dims is needed as the preview data source or set the data
#   source to ASCII and manually edit the TI in notepad after saving to add back the required implicit view variables
# * If using the pFilterParallel parameter the **single dimension** used as the "parallelization slicer" cannot appear in
#   the pFilter parameter
# * When using parallelization via the *RunProcess* function the elements listed in pFilterParallel will be split one_at_a_time
#   and passed to a recursive call of the process being added to pFilter. Each element name will also be appended to the filename
#
# Warning:
# As the *RunProcess* function currently has no mechanism to check for the state of the called process if more processes are 
# released than available CPU cores on the server then this could lead to TM1 consuming all available server resources and a
# associated performance issue. Be careful that the number of slicer elements listed in pFilterParallel should not exceed the 
# number of available cores.
#EndRegion @DOC

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');

### Constants ###
cThisProcName     = GetProcessName();
cUserName         = TM1User();
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pCube:%pCube%, pView:%pView%, pFilter:%pFilter%, pFilterParallel:%pFilterParallel%, pParallelThreads:%pParallelThreads%, pDimDelim:%pDimDelim%, pEleStartDelim:%pEleStartDelim%, pEleDelim:%pEleDelim%, pSuppressZero:%pSuppressZero%, pSuppressConsol:%pSuppressConsol%, pSuppressRules:%pSuppressRules%, pZeroSource:%pZeroSource%, pCubeLogging:%pCubeLogging%, pTemp:%pTemp%, pFilePath:%pFilePath%, pFileName:%pFileName%, pDelim:%pDelim%, pQuote:%pQuote%, pTitleRecord:%pTitleRecord%.'; 
cDefaultView      = Expand( '%cThisProcName%_%cTimeStamp%_%cRandomInt%' );
cLenASCIICode     = 3;

pFieldDelim       = TRIM(pDelim);
pDimDelim         = TRIM(pDimDelim);
pEleStartDelim    = TRIM(pEleStartDelim);
pEleDelim         = TRIM(pEleDelim);
nDataCount        = 0;
nErrors           = 0;

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

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###

# If no cube has been specified then terminate process
If( Trim( pCube ) @= '' );
    sMessage = 'No cube specified.';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( CubeExists( pCube ) = 0 );
    sMessage = Expand( 'Cube: %pCube% does not exist.' );
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate the View parameter
If( TRIM(pView) @= '' );
    cView = cDefaultView ;
Else ;
    cView = pView ;
EndIf;
cSubset = cView;

# Validate file path
If(Trim( pFilePath ) @= '' );
    pFilePath = GetProcessErrorFileDirectory;
Else;
    If( SubSt( pFilePath, Long( pFilePath ), 1 ) @= '\' );
        pFilePath = SubSt( pFilePath, 1, Long( pFilePath ) -1 );
    EndIf;
    If(  FileExists( pFilePath ) = 0 );
        sMessage = Expand('Invalid export directory: %pFilePath%');
        nErrors = nErrors + 1;
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    EndIf;
    pFilePath = pFilePath | '\';
EndIf;

# Validate file name
If( pFileName @= '' );
    sBaseFileName = Expand('%pCube%_Export');
    sExt = '.csv';
    pFileName = sBaseFileName | '.csv';
Else;
    # determine file extension. If no file extension entered then use .csv as default
    If( Scan( '.', pFileName ) = 0 );
        sExt = '.csv';
        sBaseFileName = pFileName;
    Else;
        sExt = SubSt( pFileName, Scan( '.', pFileName ), Long( pFileName ) );
        sBaseFileName = SubSt( pFileName, 1, Scan( '.', pFileName ) - 1 );
    EndIf;
    pFileName = sBaseFileName | sExt;
EndIf;
cExportFile = pFilePath | pFileName;

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
If( pParallelThreads > 0 );
  nMaxThreads = pParallelThreads;
Else;
  nMaxThreads = 1;
EndIf;

# Validate file delimiter & quote character
If( pFieldDelim @= '' );
    pFieldDelim = ',';
Else;
    # If length of pFieldDelim is exactly 3 chars and each of them is decimal digit, then the pFieldDelim is entered as ASCII code
    nValid = 0;
    If ( LONG(pFieldDelim) = cLenASCIICode );
      nChar = 1;
      While ( nChar <= cLenASCIICode );
        If( CODE( pFieldDelim, nChar ) >= CODE( '0', 1 ) & CODE( pFieldDelim, nChar ) <= CODE( '9', 1 ) );
          nValid = 1;
        Else;
          nValid = 0;
        EndIf;
        nChar = nChar + 1;
      End;
    EndIf;
    If ( nValid<>0 );
      pFieldDelim=CHAR(StringToNumber( pFieldDelim ));
    Else;
      pFieldDelim = SubSt( Trim( pFieldDelim ), 1, 1 );
    EndIf;
EndIf;
If( pQuote @= '' );
    ## Use no quote character 
Else;
    # If length of pQuote is exactly 3 chars and each of them is decimal digit, then the pQuote is entered as ASCII code
    nValid = 0;
    If ( LONG(pQuote) = cLenASCIICode );
      nChar = 1;
      While ( nChar <= cLenASCIICode );
        If( CODE( pQuote, nChar ) >= CODE( '0', 1 ) & CODE( pQuote, nChar ) <= CODE( '9', 1 ) );
          nValid = 1;
        Else;
          nValid = 0;
        EndIf;
        nChar = nChar + 1;
      End;
    EndIf;
    If ( nValid<>0 );
      pQuote=CHAR(StringToNumber( pQuote ));
    Else;
      pQuote = SubSt( Trim( pQuote ), 1, 1 );
    EndIf;
EndIf;

# Jump to Epilog if any errors so far
IF ( nErrors > 0 );
    DataSourceType = 'NULL';
    ProcessBreak;
ENDIF;

# Branch depending on whether to do recursive calls to self on independent threads or run all in this thread
If( Scan( pEleStartDelim, pFilterParallel ) > 0 );
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
        sFileName = Expand('%sBaseFileName%_%sDimParallel%_%sSlicerEle%');
      ELSE;
        sFilter = Expand('%sFilter%%pEleDelim%%sSlicerEle%');
        sFileName = Expand('%sFileName%+%sSlicerEle%');
      ENDIF;
      IF( nThreadElCounter >= nElemsPerThread );
        sFileName = Expand('%sFileName%%sExt%');
        RunProcess( cThisProcName, 'pLogoutput', pLogoutput,
        	'pCube', pCube, 'pView', '',
        	'pFilter', sFilter, 'pFilterParallel', '', 
        	'pDimDelim', pDimDelim, 'pEleStartDelim', pEleStartDelim, 'pEleDelim', pEleDelim,
        	'pSuppressZero', pSuppressZero, 'pSuppressConsol', pSuppressConsol, 'pSuppressRules', pSuppressRules,
        	'pZeroSource', pZeroSource, 'pCubeLogging', pCubeLogging,
        	'pTemp', pTemp, 'pFilePath', pFilePath, 'pFileName', sFileName,
        	'pDelim', pFieldDelim, 'pQuote', pQuote, 'pTitleRecord', pTitleRecord
        );
    	  nThreadElCounter = 0;
    	  sFilter = '';
    	  sFileName = '';
    	 ENDIF;
  End;
  ## Process last elements - only when filter is not empty (there are still elements)
  IF( sFilter @<> '' );
    sFileName = Expand('%sFileName%%sExt%');
    RunProcess( cThisProcName, 'pLogoutput', pLogoutput,
    	'pCube', pCube, 'pView', '',
    	'pFilter', sFilter, 'pFilterParallel', '', 
    	'pDimDelim', pDimDelim, 'pEleStartDelim', pEleStartDelim, 'pEleDelim', pEleDelim,
    	'pSuppressZero', pSuppressZero, 'pSuppressConsol', pSuppressConsol, 'pSuppressRules', pSuppressRules,
    	'pZeroSource', pZeroSource, 'pCubeLogging', pCubeLogging,
    	'pTemp', pTemp, 'pFilePath', pFilePath, 'pFileName', sFileName,
    	'pDelim', pFieldDelim, 'pQuote', pQuote, 'pTitleRecord', pTitleRecord
    );
  ENDIF;
  DataSourceType = 'NULL';
  nParallelRun = 1;
Else;
  # No parallelization is being used. Proceed as normal and do everything internally
  
  # Determine number of dims in source cube & create strings to expand on title and rows 
  nCount = 1;
  nDimensionIndex = 0;
  sTitle = '%pQuote%Cube%pQuote%';
  sRow = '%pQuote%%pCube%%pQuote%';
  While( TabDim( pCube, nCount ) @<> '' );
      sDimension = TabDim( pCube, nCount );
      
      ## Determine title string for the source cube
      sTitle = sTitle|'%pFieldDelim%%pQuote%'|sDimension|'%pQuote%';
      # Determine row string for the source cube
      sRow = sRow|'%pFieldDelim%%pQuote%%V'| numbertostring(nCount) |'%%pQuote%';
      
      nCount = nCount + 1;
  End;
  nDimensionCount = nCount - 1;
  
  # Finish off the strings
  sTitle = sTitle|'%pFieldDelim%%pQuote%Value%pQuote%';
  sRow = sRow|'%pFieldDelim%%pQuote%%sValue%%pQuote%';
  
  # Create Processing View for source version 
  nRet = ExecuteProcess('}bedrock.cube.view.create',
          'pLogOutput', pLogOutput,
          'pCube', pCube,
          'pView', cView,
          'pFilter', pFilter,
          'pSuppressZero', pSuppressZero,
          'pSuppressConsol', pSuppressConsol,
          'pSuppressRules', pSuppressRules,
          'pDimDelim', pDimDelim,
          'pEleStartDelim', pEleStartDelim,
          'pEleDelim', pEleDelim ,
          'pTemp', pTemp
          );
  
  IF( nRet <> ProcessExitNormal() );
      sMessage = 'Error creating the view from the filter.';
      nErrors = nErrors + 1;
      LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
      ProcessBreak();
  ENDIF;
  
  # Assign Datasource 
  DataSourceType          = 'VIEW';
  DatasourceNameForServer = pCube;
  DatasourceNameForClient = pCube;
  DatasourceCubeView      = cView;
  DatasourceAsciiDelimiter= pFieldDelim;
  DatasourceAsciiQuoteCharacter = '';
  nParallelRun = 0;
EndIf;

### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,39

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

### Data Count ###
nDataCount = nDataCount + 1;

# Output the title string
IF( nDataCount = 1 & pTitleRecord = 1 );
    AsciiOutput( cExportFile, Expand(sTitle) );
Endif; 
    
### Export data from source version to file ###

# Selects the correct AsciiOutput formula depending upon the number of dimensions in the cube
IF(SCAN( CHAR( 10 ), sValue ) > 0 );
    sValueCleaned = '';
    nNoChar = 1;
    nLimit = LONG( sValue );
    WHILE( nNoChar <= nLimit ) ;
        sChar = SUBST(  sValue, nNoChar, 1 );
        IF( CODE( sChar, 1 ) <> 10 );
            sValueCleaned = sValueCleaned | sChar ;
        ELSE;
            sValueCleaned = sValueCleaned | ' ';
        ENDIF;
        nNoChar = nNoChar + 1;
    END;
    sValue = sValueCleaned;
ENDIF;

# Output data
AsciiOutput( cExportFile, Expand(sRow) );

### End Data ###
575,34

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

### Delete source data ###
If( pZeroSource = 1 & nErrors = 0 & nParallelRun = 0 );
    sCubeLogging = CellGetS('}CubeProperties', pCube, 'LOGGING' );
    CubeSetLogChanges( pCube, pCubeLogging);
    ViewZeroOut( pCube, cView );
    CubeSetLogChanges( pCube, IF(sCubeLogging@='YES',1,0) ); 
EndIf;

### Return code & final error message handling
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
Else;
    sDataCount = NUMBERTOSTRING (nDataCount);
    sProcessAction = Expand( 'Process:%cThisProcName% exported %sDataCount% records from %pCube% based on filter %pFilter%.' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogoutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );   
    EndIf;

EndIf ;

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
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
