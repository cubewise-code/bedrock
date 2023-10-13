601,100
602,"}bedrock.cube.data.copy.intercube"
562,"VIEW"
586,"Bedrock Source Cube"
585,"Bedrock Source Cube"
564,
565,"pG`ZNN<g]IoKu=fCavbjyjE:P7zu:UIA[_lTD;E3<jZcRkzD5;kAw>?yKH1mTC`Ji8r`_r5SpmA:ik]lEK3<ct4\4rPQKFLN@B1UPO^uYxPnTkm[yavQIWmIs@PvKMbA\ZAoQtcIme_F`0;`TlCq?4XO9eEN3WnIoVd:PO]AsiuZ0dYzkBp_tZTTkzwTwwyn9X<Z5U0b"
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
570,Default
571,
569,0
592,0
599,1000
560,28
pLogOutput
pStrictErrorHandling
pSrcCube
pFilter
pFilterParallel
pParallelThreads
pTgtCube
pMappingToNewDims
pSuppressConsol
pSuppressConsolStrings
pSuppressRules
pSuppressZero
pZeroTarget
pZeroSource
pFactor
pDimDelim
pEleStartDelim
pEleDelim
pTemp
pCubeLogging
pSandbox
pFile
pDelim
pQuote
pDecimalSeparator
pThousandSeparator
pSubN
pThreadMode
561,28
1
1
2
2
2
1
2
2
1
1
1
1
1
1
1
2
2
2
1
1
2
1
2
2
2
2
1
1
590,28
pLogOutput,0
pStrictErrorHandling,0
pSrcCube,""
pFilter,""
pFilterParallel,""
pParallelThreads,0
pTgtCube,""
pMappingToNewDims,""
pSuppressConsol,1
pSuppressConsolStrings,0
pSuppressRules,1
pSuppressZero,1
pZeroTarget,1
pZeroSource,0
pFactor,1
pDimDelim,"&"
pEleStartDelim,"¦"
pEleDelim,"+"
pTemp,1
pCubeLogging,0
pSandbox,""
pFile,0
pDelim,","
pQuote,""""
pDecimalSeparator,"."
pThousandSeparator,","
pSubN,0
pThreadMode,0
637,28
pLogOutput,"OPTIONAL: write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pSrcCube,"REQUIRED: Cube data is being copied from"
pFilter,"OPTIONAL: Filter on source cube in format Year¦ 2006 + 2007 & Scenario¦ Actual + Budget. Blank for whole cube"
pFilterParallel,"OPTIONAL: Parallelization Filter: Month¦Q1+Q2+Q3+Q4 (Blank=run single threaded). Single dimension parallel slices. Will be added to filter single element at a time. Dimension must not be part of filter"
pParallelThreads,"Maximum number of threads to run when parallel processing is enabled ( if <2 will execute one thread, but parallel filter is still applied )"
pTgtCube,"REQUIRED: Name of cube to copy the values to"
pMappingToNewDims,"REQUIRED IF TARGET HAS DIMS NOT IN SOURCE: DimX¦InputElementForDimX & DimY¦InputElementForDimY (specify an N level element for each new dim)"
pSuppressConsol,"OPTIONAL: Suppress Consolidations (Skip = 1) Only use 0 for strings"
pSuppressConsolStrings,"OPTIONAL: Suppress Consolidated String Cells (Skip = 1)"
pSuppressRules,"OPTIONAL: Suppress Rules (Skip = 1)"
pSuppressZero,"OPTIONAL: Suppress Null Cells (Skip = 1)"
pZeroTarget,"OPTIONAL: Zero out Target Element PRIOR to Copy? (Boolean 1=True) Clears combination of pFilter and pMappingToNewDims"
pZeroSource,"OPTIONAL: Zero out Source Element AFTER Copy? (Boolean 1=True). If pFilter is blank the whole source cube is cleared!"
pFactor,"OPTIONAL: Multiply source value by factor (1 keeps the value as is). To modify existing values make the target element the same as the source with pZeroTarget = 0"
pDimDelim,"OPTIONAL. Delimiter for start of Dimension/Element set"
pEleStartDelim,"OPTIONAL: Delimiter for start of element list"
pEleDelim,"OPTIONAL: Delimiter between elements"
pTemp,"OPTIONAL: Delete temporary view and Subset ( 0 = Retain View and Subsets 1 = Delete View and Subsets 2 = Delete View only )"
pCubeLogging,"Required: Cube Logging (0 = No transaction logging, 1 = Logging of transactions, 2 = Ignore Cube Logging - No Action Taken)"
pSandbox,"OPTIONAL: To use sandbox not base data enter the sandbox name (invalid name will result in process error)"
pFile,"OPTIONAL: Copy via file export and import. Reduces locks (0 = no, 1= use file and delete it 2= use file and retain it)"
pDelim,"OPTIONAL: For pFile > 0. AsciiOutput delimiter character (Default = ',' exactly 3 digits = ASCII code)"
pQuote,"OPTIONAL: For pFile > 0. AsciiOutput quote character (Default = '""' exactly 3 digits = ASCII code)"
pDecimalSeparator,"OPTIONAL: For pFile > 0. Decimal separator for conversion of NumberToStringEx and StringToNumberEx (default = '.' exactly 3 digits = ASCII code)"
pThousandSeparator,"OPTIONAL: For pFile > 0. Thousand separator for conversion of NumberToStringEx and StringToNumberEx (default = ',' exactly 3 digits = ASCII code)"
pSubN,"OPTIONAL: Create N level subset for all dims not mentioned in pFilter"
pThreadMode,"DO NOT USE: Internal parameter only, please do not use"
577,29
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
578,29
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
579,29
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
580,29
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
581,29
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
582,29
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
572,1490
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.cube.data.copy.intercube', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pSrcCube', '', 'pFilter', '',
    	'pFilterParallel', '', 'pParallelThreads', 0,
    	'pTgtCube', '', 'pMappingToNewDims', '',
    	'pSuppressConsol', 1, 'pSuppressConsolStrings', 0, 'pSuppressRules', 1, 'pSuppressZero', 1, 
    	'pZeroTarget', 1, 'pZeroSource', 0,
    	'pFactor', 1,
    	'pDimDelim', '&', 'pEleStartDelim', '¦', 'pEleDelim', '+',
    	'pTemp', 1, 'pCubeLogging', 0, 'pSandbox', pSandbox, 'pSubN', 0, 
    	'pFile', 0, 'pDelim', ',', 'pQuote', '"', 'pDecimalSeparator', '.', 'pThousandSeparator', ','
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
# This is the process used to copy data from a source cube to a different target cube.

# Use case: Mainly used in production environments.
# 1. This process could be used to populate a Reporting cube.
# 2. The process could be used to archive data from one cube to another one for any use.

# Note:
# * The target cube may have a different number of dimensions as the source cube.
# * Where the target and source cubes share the same dimensions, the process will match the dimensions even if their position in the cube is different.
# * An input element must be specified for each dimension which is in the target but not in the source using the parameter pMappingToNewDims.
# * The format of parameter pMappingToNewDims using default delimiters & and : is DimInTargetButNotSource1:ElementOfDim & DimInTargetButNotSource2:ElementOfDim.
# * The input element must be an N level unless pSuppressConsol is set to 0.
# * The maximum number of dimensions catered for in the target cube is 27. (In principle adding support for cubes with higher dimensionality is not difficult). 

# For dimensions in the source but not the target, the process will accumulate the values of all n level elements 
# (or all n level elements specified by the pFilter parameter).
# The pFilter parameter contains the dimensions and elements to be used for filtering the source cube.
# The format of the pFilter parameter is as follows, using default delimiters & + : Dim1: Elem1 + Elem2 & Dim2: Elem3 + Elem4.
# The dimension parameters do not need to be given in the index order of dimensions in the cube.
# The dimension name is specified as the first member of the delimited string of elements.
# If consolidations are skipped the N level children of any consolidated filter elements will be used.
# Spaces are ignored so use them to make your filter more readable.
# If using the pFilterParallel parameter the **single dimension** used as the "parallelization slicer" cannot appear in
# the pFilter parameters.
# When using parallelization via the *RunProcess* function the elements listed in pFilterParallel will be split one_at_a_time
# and passed to a recursive call of the process being added to pFilter.

# An example:
# To copy the 2011 Actual Sales data from the Sales cube to the General Ledger cube set pFilter to Year: 2011 & Version: Actual.
# Say the General Ledger cube has an Account dimension but the Sales cube doesn't and the Account for sales is 9999 (an n level element).
# Set the pMappingToNewDims parameter to Account:9999.
# This will copy all Actual 2011 Sales to Account 9999 in the General Ledger.
# If only sales for Company X are to be copied, set pFilter to Year: 2011 & Version: Actual & Company:X.
# If sales from other companies are already in the General Ledger set pZeroTarget to 0 to add Company X's data to the existing data.
# Setting pZeroTarget to 1 will clear our data in the target cube for the elements specified in the
# pMappingToNewDims parameter and the pFilter parameter for dimensions that are in the target.
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');

### Constants ###
cThisProcName       = GetProcessName();
cUserName           = TM1User();
cTimeStamp          = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt          = NumberToString( INT( RAND( ) * 1000 ));
cMsgErrorLevel      = 'ERROR';
cMsgErrorContent    = '%cThisProcName% : %sMessage% : %cUserName%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pSrcCube:%pSrcCube%, pFilter:%pFilter%, pFilterParallel:%pFilterParallel%, pParallelThreads:%pParallelThreads%, pTgtCube:%pTgtCube%, pMappingToNewDims:%pMappingToNewDims%, pSuppressConsol:%pSuppressConsol%, pSuppressConsolStrings:%pSuppressConsolStrings%, pSuppressRules:%pSuppressRules%, pSuppressZero:%pSuppressZero%, pZeroTarget:%pZeroTarget%, pZeroSource:%pZeroSource%, pFactor:%pFactor%, pDimDelim:%pDimDelim%, pEleStartDelim:%pEleStartDelim%, pEleDelim:%pEleDelim%, pTemp:%pTemp%, pCubeLogging:%pCubeLogging%, pSandbox:%pSandbox%, pFile:%pFile%, pThreadMode:%pThreadMode%.'; 

sDelimDim           = TRIM(pDimDelim);
sElementStartDelim  = TRIM(pElEStartDelim);
sDelimElem          = TRIM(pEleDelim);
nErrors             = 0;
cLenASCIICode       = 3;

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

# Make sure pFactor not zero
nFactor             = If( pFactor = 0, 1, pFactor );

sView               = cThisProcName | cTimeStamp | cRandomInt;
sSubset             = sView;
sTargetView         = 'Target '| sView;
sTargetSubset       = sTargetView;

## check operating system
If( SubSt( GetProcessErrorFileDirectory, 2, 1 ) @= ':' );
  sOS = 'Windows';
  sOSDelim = '\';
ElseIf( Scan( '/', GetProcessErrorFileDirectory ) > 0 );
  sOS = 'Linux';
  sOSDelim = '/';
Else;
  sOS = 'Windows';
  sOSDelim = '\';
EndIf;

## File location for indirect data copy
cDir    = GetProcessErrorFileDirectory;
cFileName = pSrcCube | cTimeStamp | cRandomInt | '.csv';
cFile   = cDir | cFileName;
cTitleRows = 1;

# Validate file delimiter & quote character
If( pDelim @= '' );
    pDelim = ',';
Else;
    # If length of pDelim is exactly 3 chars and each of them is decimal digit, then the pDelim is entered as ASCII code
    nValid = 0;
    If ( LONG(pDelim) = cLenASCIICode );
      nChar = 1;
      While ( nChar <= cLenASCIICode );
        If( CODE( pDelim, nChar ) >= CODE( '0', 1 ) & CODE( pDelim, nChar ) <= CODE( '9', 1 ) );
          nValid = 1;
        Else;
          nValid = 0;
          Break;
        EndIf;
        nChar = nChar + 1;
      End;
    EndIf;
    If ( nValid<>0 );
      pDelim=CHAR(StringToNumber( pDelim ));
    Else;
      pDelim = SubSt( Trim( pDelim ), 1, 1 );
    EndIf;
EndIf;
cDelimiter = pDelim;

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
          Break;
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
cQuote = pQuote;

#Region ## Check Parameters ###

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

If( pDecimalSeparator @= '' );
 	pDecimalSeparator = '.';
EndIf;
If ( LONG(pDecimalSeparator) = cLenASCIICode );
  nValid = 0;
  nChar = 1;
  While ( nChar <= cLenASCIICode );
    If( CODE( pDecimalSeparator, nChar ) >= CODE( '0', 1 ) & CODE( pDecimalSeparator, nChar ) <= CODE( '9', 1 ) );
      nValid = 1;
    Else;
      nValid = 0;
      Break;
    EndIf;
    nChar = nChar + 1;
  End;
  If ( nValid<>0 );
    pDecimalSeparator = CHAR(StringToNumber( pDecimalSeparator ));
  Else;
    pDecimalSeparator = SubSt( Trim( pDecimalSeparator ), 1, 1 );
  EndIf;
EndIf;
sDecimalSeparator = pDecimalSeparator;

If( pThousandSeparator @= '' );
 	pThousandSeparator = ',';
EndIf;
If ( LONG(pThousandSeparator) = cLenASCIICode );
  nValid = 0;
  nChar = 1;
  While ( nChar <= cLenASCIICode );
    If( CODE( pThousandSeparator, nChar ) >= CODE( '0', 1 ) & CODE( pThousandSeparator, nChar ) <= CODE( '9', 1 ) );
      nValid = 1;
    Else;
      nValid = 0;
      Break;
    EndIf;
    nChar = nChar + 1;
  End;
  If ( nValid<>0 );
    pThousandSeparator = CHAR(StringToNumber( pThousandSeparator ));
  Else;
    pThousandSeparator = SubSt( Trim( pThousandSeparator ), 1, 1 );
  EndIf;
EndIf;
sThousandSeparator = pThousandSeparator;

# If specified source cube doesn't exist then terminate process
If( CubeExists(   pSrcCube   ) = 0 );
    nErrors = nErrors + 1;
  sMessage = Expand( 'Invalid source cube specified: %pSrcCube%.');
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# If specified target cube doesn't exist then terminate process
If( CubeExists(   pTgtCube   ) = 0 );
  nErrors = nErrors + 1;
  sMessage = Expand( 'Invalid target cube specified: %pTgtCube%.');
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
If( pParallelThreads > 0 );
  nMaxThreads = pParallelThreads;
Else;
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
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;
#EndRegion
#Region 
## Set variables =0 or '' ################################################################################################# ########################
### Placeholders for mappped dimensions
nMappedDim1 = 0;
nMappedDim2 = 0;
nMappedDim3 = 0;
nMappedDim4 = 0;
nMappedDim5 = 0;
nMappedDim6 = 0;
nMappedDim7 = 0;
nMappedDim8 = 0;
nMappedDim9 = 0;
nMappedDim10 = 0;
nMappedDim11 = 0;
nMappedDim12 = 0;
nMappedDim13 = 0;
nMappedDim14 = 0;
nMappedDim15 = 0;
nMappedDim16 = 0;
nMappedDim17 = 0;
nMappedDim18 = 0;
nMappedDim19 = 0;
nMappedDim20 = 0;
nMappedDim21 = 0;
nMappedDim22 = 0;
nMappedDim23 = 0;
nMappedDim24 = 0;
nMappedDim25 = 0;
nMappedDim26 = 0;
nMappedDim27 = 0;

sMappedV1 = '';
sMappedV2 = '';
sMappedV3 = '';
sMappedV4 = '';
sMappedV5 = '';
sMappedV6 = '';
sMappedV7 = '';
sMappedV8 = '';
sMappedV9 = '';
sMappedV10 = '';
sMappedV11 = '';
sMappedV12 = '';
sMappedV13 = '';
sMappedV14 = '';
sMappedV15 = '';
sMappedV16 = '';
sMappedV17 = '';
sMappedV18 = '';
sMappedV19 = '';
sMappedV20 = '';
sMappedV21 = '';
sMappedV22 = '';
sMappedV23 = '';
sMappedV24 = '';
sMappedV25 = '';
sMappedV26 = '';
sMappedV27 = '';
sMappedV28 = '';

### Placeholders for new dimensions
nNewDim1 = 0;
nNewDim2 = 0;
nNewDim3 = 0;
nNewDim4 = 0;
nNewDim5 = 0;
nNewDim6 = 0;
nNewDim7 = 0;
nNewDim8 = 0;
nNewDim9 = 0;
nNewDim10 = 0;
nNewDim11 = 0;
nNewDim12 = 0;
nNewDim13 = 0;
nNewDim14 = 0;
nNewDim15 = 0;
nNewDim16 = 0;
nNewDim17 = 0;
nNewDim18 = 0;
nNewDim19 = 0;
nNewDim20 = 0;
nNewDim21 = 0;
nNewDim22 = 0;
nNewDim23 = 0;
nNewDim24 = 0;
nNewDim25 = 0;
nNewDim26 = 0;
nNewDim27 = 0;

sNewV1 = '';
sNewV2 = '';
sNewV3 = '';
sNewV4 = '';
sNewV5 = '';
sNewV6 = '';
sNewV7 = '';
sNewV8 = '';
sNewV9 = '';
sNewV10 = '';
sNewV11 = '';
sNewV12 = '';
sNewV13 = '';
sNewV14 = '';
sNewV15 = '';
sNewV16 = '';
sNewV17 = '';
sNewV18 = '';
sNewV19 = '';
sNewV20 = '';
sNewV21 = '';
sNewV22 = '';
sNewV23 = '';
sNewV24 = '';
sNewV25 = '';
sNewV26 = '';
sNewV27 = '';

### Determine dimensions in target cube, we need to know this to test cell type before loading ###
# only numbers get converted from strings to numbers
sDim1 = TabDim( pTgtCube, 1 );
sDim2 = TabDim( pTgtCube, 2 );
sDim3 = TabDim( pTgtCube, 3 );
sDim4 = TabDim( pTgtCube, 4 );
sDim5 = TabDim( pTgtCube, 5 );
sDim6 = TabDim( pTgtCube, 6 );
sDim7 = TabDim( pTgtCube, 7 );
sDim8 = TabDim( pTgtCube, 8 );
sDim9 = TabDim( pTgtCube, 9 );
sDim10 = TabDim( pTgtCube, 10 );
sDim11 = TabDim( pTgtCube, 11 );
sDim12 = TabDim( pTgtCube, 12 );
sDim13 = TabDim( pTgtCube, 13 );
sDim14 = TabDim( pTgtCube, 14 );
sDim15 = TabDim( pTgtCube, 15 );
sDim16 = TabDim( pTgtCube, 16 );
sDim17 = TabDim( pTgtCube, 17 );
sDim18 = TabDim( pTgtCube, 18 );
sDim19 = TabDim( pTgtCube, 19 );
sDim20 = TabDim( pTgtCube, 20 );
sDim21 = TabDim( pTgtCube, 21 );
sDim22 = TabDim( pTgtCube, 22 );
sDim23 = TabDim( pTgtCube, 23 );
sDim24 = TabDim( pTgtCube, 24 );
sDim25 = TabDim( pTgtCube, 25 );
sDim26 = TabDim( pTgtCube, 26 );
sDim27 = TabDim( pTgtCube, 27 );
#EndRegion
sTgtDimString = '^^'|sDim1|'^^'|sDim2|'^^'|sDim3|'^^'|sDim4|'^^'|sDim5|'^^'|sDim6|'^^'|sDim7|'^^'|sDim8|'^^'|sDim9|'^^'|sDim10|'^^'
                    |sDim11|'^^'|sDim12|'^^'|sDim13|'^^'|sDim14|'^^'|sDim15|'^^'|sDim16|'^^'|sDim17|'^^'|sDim18|'^^'|sDim19|'^^'|sDim20|'^^'
                    |sDim21|'^^'|sDim22|'^^'|sDim23|'^^'|sDim24|'^^'|sDim25|'^^'|sDim26|'^^'|sDim27|'^^';

### We have to remove spaces from the search string before going to include the string in searching loop
sTgtDimString = UPPER( sTgtDimString );
nSPIndex = SCAN( ' ', sTgtDimString );
While ( nSPIndex <> 0);
  sTgtDimString = DELET( sTgtDimString, nSPIndex, 1 );
  nSPIndex = SCAN( ' ', sTgtDimString );
End;

###########################################
#Region ### MAPPING Target DIMENSIONS #####
###########################################
nSourceIndex = 1;
While( TabDim( pSrcCube, nSourceIndex ) @<> '' );
  sSourceDim = TabDim( pSrcCube, nSourceIndex);
    # reset target index if another source dimension has been found
    nTargetIndex = 1;
    WHILE(TabDim( pTgtCube, nTargetIndex ) @<> '');
      sTargetDim = TabDim( pTgtCube, nTargetIndex );
      If(sSourceDim @= sTargetDim);
          If( pFile = 0 );
            If(nTargetIndex = 1);
              nMappedDim1 = 1;
              sMappedV1  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 2);
              nMappedDim2 = 1;
              sMappedV2  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 3);
              nMappedDim3 = 1;
              sMappedV3  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 4);
              nMappedDim4 = 1;
              sMappedV4  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 5);
              nMappedDim5 = 1;
              sMappedV5  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 6);
              nMappedDim6 = 1;
              sMappedV6  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 7);
              nMappedDim7 = 1;
              sMappedV7  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 8);
              nMappedDim8 = 1;
              sMappedV8  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 9);
              nMappedDim9 = 1;
              sMappedV9  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 10);
              nMappedDim10 = 1;
              sMappedV10  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 11);
              nMappedDim11 = 1;
              sMappedV11  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 12);
              nMappedDim12 = 1;
              sMappedV12  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 13);
              nMappedDim13 = 1;
              sMappedV13  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 14);
              nMappedDim14 = 1;
              sMappedV14  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 15);
              nMappedDim15 = 1;
              sMappedV15  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 16);
              nMappedDim16 = 1;
              sMappedV16  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 17);
              nMappedDim17 = 1;
              sMappedV17  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 18);
              nMappedDim18 = 1;
              sMappedV18  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 19);
              nMappedDim19 = 1;
              sMappedV19  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 20);
              nMappedDim20 = 1;
              sMappedV20  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 21);
              nMappedDim21 = 1;
              sMappedV21  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 22);
              nMappedDim22 = 1;
              sMappedV22  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 23);
              nMappedDim23 = 1;
              sMappedV23  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 24);
              nMappedDim24 = 1;
              sMappedV24  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 25);
              nMappedDim25 = 1;
              sMappedV25  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 26);
              nMappedDim26 = 1;
              sMappedV26  = 'V' | NumberToString(nSourceIndex);
            ElseIf(nTargetIndex = 27);
              nMappedDim27 = 1;
              sMappedV27  = 'V' | NumberToString(nSourceIndex);
            EndIf;
          ElseIf( pFile > 0 );
            ## If using source file first variable holds tha cube name, so all the other ones have the index increased by 1
            If(nTargetIndex = 1);
              nMappedDim1 = 1;
              sMappedV1  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 2);
              nMappedDim2 = 1;
              sMappedV2  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 3);
              nMappedDim3 = 1;
              sMappedV3  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 4);
              nMappedDim4 = 1;
              sMappedV4  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 5);
              nMappedDim5 = 1;
              sMappedV5  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 6);
              nMappedDim6 = 1;
              sMappedV6  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 7);
              nMappedDim7 = 1;
              sMappedV7  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 8);
              nMappedDim8 = 1;
              sMappedV8  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 9);
              nMappedDim9 = 1;
              sMappedV9  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 10);
              nMappedDim10 = 1;
              sMappedV10  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 11);
              nMappedDim11 = 1;
              sMappedV11  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 12);
              nMappedDim12 = 1;
              sMappedV12  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 13);
              nMappedDim13 = 1;
              sMappedV13  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 14);
              nMappedDim14 = 1;
              sMappedV14  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 15);
              nMappedDim15 = 1;
              sMappedV15  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 16);
              nMappedDim16 = 1;
              sMappedV16  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 17);
              nMappedDim17 = 1;
              sMappedV17  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 18);
              nMappedDim18 = 1;
              sMappedV18  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 19);
              nMappedDim19 = 1;
              sMappedV19  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 20);
              nMappedDim20 = 1;
              sMappedV20  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 21);
              nMappedDim21 = 1;
              sMappedV21  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 22);
              nMappedDim22 = 1;
              sMappedV22  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 23);
              nMappedDim23 = 1;
              sMappedV23  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 24);
              nMappedDim24 = 1;
              sMappedV24  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 25);
              nMappedDim25 = 1;
              sMappedV25  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 26);
              nMappedDim26 = 1;
              sMappedV26  = 'V' | NumberToString(nSourceIndex + 1);
            ElseIf(nTargetIndex = 27);
              nMappedDim27 = 1;
              sMappedV27  = 'V' | NumberToString(nSourceIndex + 1);
            EndIf;
          EndIf;

      EndIf;

      nTargetIndex = nTargetIndex + 1;

    END;

  nSourceIndex = nSourceIndex + 1;

END;

# The last variable in the data source holds the values
# which need to be mapped to the last variable in the target

If( pFile = 0 );
  If(nTargetIndex = 1);
    nMappedDim1 = 1;
    sMappedV1  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 2);
    nMappedDim2 = 1;
    sMappedV2  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 3);
    nMappedDim3 = 1;
    sMappedV3  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 4);
    nMappedDim4 = 1;
    sMappedV4  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 5);
    nMappedDim5 = 1;
    sMappedV5  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 6);
    nMappedDim6 = 1;
    sMappedV6  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 7);
    nMappedDim7 = 1;
    sMappedV7  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 8);
    nMappedDim8 = 1;
    sMappedV8  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 9);
    nMappedDim9 = 1;
    sMappedV9  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 10);
    nMappedDim10 = 1;
    sMappedV10  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 11);
    nMappedDim11 = 1;
    sMappedV11  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 12);
    nMappedDim12 = 1;
    sMappedV12  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 13);
    nMappedDim13 = 1;
    sMappedV13  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 14);
    nMappedDim14 = 1;
    sMappedV14  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 15);
    nMappedDim15 = 1;
    sMappedV15  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 16);
    nMappedDim16 = 1;
    sMappedV16  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 17);
    nMappedDim17 = 1;
    sMappedV17  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 18);
    nMappedDim18 = 1;
    sMappedV18  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 19);
    nMappedDim19 = 1;
    sMappedV19  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 20);
    nMappedDim20 = 1;
    sMappedV20  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 21);
    nMappedDim21 = 1;
    sMappedV21  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 22);
    nMappedDim22 = 1;
    sMappedV22  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 23);
    nMappedDim23 = 1;
    sMappedV23  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 24);
    nMappedDim24 = 1;
    sMappedV24  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 25);
    nMappedDim25 = 1;
    sMappedV25  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 26);
    nMappedDim26 = 1;
    sMappedV26  = 'V' | NumberToString(nSourceIndex);
  ElseIf(nTargetIndex = 27);
    nMappedDim27 = 1;
    sMappedV27  = 'V' | NumberToString(nSourceIndex);
  
  # a cube with 27 dimensions uses V28 to hold the values
  ElseIf(nTargetIndex = 28);
    nMappedDim28 = 1;
    sMapped28  = 'V' | NumberToString(nSourceIndex);
  EndIf;
ElseIf( pFile > 0 );
  If(nTargetIndex = 1);
    nMappedDim1 = 1;
    sMappedV1  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 2);
    nMappedDim2 = 1;
    sMappedV2  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 3);
    nMappedDim3 = 1;
    sMappedV3  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 4);
    nMappedDim4 = 1;
    sMappedV4  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 5);
    nMappedDim5 = 1;
    sMappedV5  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 6);
    nMappedDim6 = 1;
    sMappedV6  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 7);
    nMappedDim7 = 1;
    sMappedV7  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 8);
    nMappedDim8 = 1;
    sMappedV8  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 9);
    nMappedDim9 = 1;
    sMappedV9  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 10);
    nMappedDim10 = 1;
    sMappedV10  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 11);
    nMappedDim11 = 1;
    sMappedV11  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 12);
    nMappedDim12 = 1;
    sMappedV12  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 13);
    nMappedDim13 = 1;
    sMappedV13  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 14);
    nMappedDim14 = 1;
    sMappedV14  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 15);
    nMappedDim15 = 1;
    sMappedV15  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 16);
    nMappedDim16 = 1;
    sMappedV16  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 17);
    nMappedDim17 = 1;
    sMappedV17  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 18);
    nMappedDim18 = 1;
    sMappedV18  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 19);
    nMappedDim19 = 1;
    sMappedV19  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 20);
    nMappedDim20 = 1;
    sMappedV20  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 21);
    nMappedDim21 = 1;
    sMappedV21  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 22);
    nMappedDim22 = 1;
    sMappedV22  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 23);
    nMappedDim23 = 1;
    sMappedV23  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 24);
    nMappedDim24 = 1;
    sMappedV24  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 25);
    nMappedDim25 = 1;
    sMappedV25  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 26);
    nMappedDim26 = 1;
    sMappedV26  = 'V' | NumberToString(nSourceIndex + 1);
  ElseIf(nTargetIndex = 27);
    nMappedDim27 = 1;
    sMappedV27  = 'V' | NumberToString(nSourceIndex + 1);
  
  # a cube with 27 dimensions uses V29 to hold the values if export file is used as source
  ElseIf(nTargetIndex = 28);
    nMappedDim28 = 1;
    sMapped28  = 'V' | NumberToString(nSourceIndex + 1);
  EndIf;
EndIf;
#EndRegion

###########################################
### SPLIT MAPPING TO NEW DIMS PARAMETER ###
###########################################

# now deduct 1 to set these indices to the number of dimensions in each cube
nSourceDimensionCount       = nSourceIndex - 1;
nTargetCubeDimensionCount   = nTargetIndex - 1;
# default dimension count is for target
nDimensionCount = nTargetIndex - 1;

sElementMapping = TRIM( pMappingToNewDims );
nChar = 1;
nCharCount = LONG( sElementMapping );

sTargetFilter = '';
sWord = '';
sLastDelim = '';
nIndex = 1;

# Add a trailing element delimiter so that the last element is picked up
If( nCharCount > 0 );
  sElementMapping = sElementMapping | sDelimDim;
  nCharCount = nCharCount + LONG(sDelimDim);
EndIf;

WHILE (nChar <= nCharCount);
    sChar = SUBST( sElementMapping, nChar, 1);

    # Used for delimiters, required for multiple character delimiters
    sDelim = '';
    nAddExtra = 0;

    # Ignore spaces
    IF (TRIM(sChar) @<> '' );

      ### Dimension Name ###

      # If the delimiter is more than 1 character peek ahead the same amount
      # Ignore the first character
      sDelim = sChar;
      nCount = LONG(sElementStartDelim) - 1;
      If( nCount > 0 & nChar + nCount <= nCharCount );
        # Add the extra characters
        sDelim = sDelim | SUBST( sElementMapping, nChar + 1, nCount);
        # Move to the end of the delimter
        nAddExtra = nCount;
      EndIf;

      If( sDelim @= sElementStartDelim );

        sChar = sDelim;

        If( sLastDelim @<> '' & sLastDelim @<> sDelimDim );
            sMessage = 'In pMappingToNewDims the name of a dimension must follow a dimension delimiter (' | sDelimDim | ')';
            nErrors = nErrors + 1;
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            #ProcessError();
        EndIf;

        # Found a dimension
        sDimension = sWord;

        If( DimensionExists( sDimension ) = 0 );
            # The dimension does not exist in the model. Cancel process
            sMessage = 'In pMappingToNewDims - Dimension: ' | sDimension | ' does not exist';
            nErrors = nErrors + 1;
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            #ProcessError();
        EndIf;

        # Find the index of the dimension is in the Target cube
        nTargetIndexCounter = 1;

        WHILE(nTargetIndexCounter <= nTargetCubeDimensionCount );
          sNthDimension = TabDim( pTgtCube, nTargetIndexCounter );

          If(sDimension @= sNthDimension);
            nTargetIndex = nTargetIndexCounter;
            nTargetIndexCounter = 1000;
          EndIf;

          nTargetIndexCounter = nTargetIndexCounter + 1;
        END;
        
        #Add to the Target filter
        IF(sTargetFilter@='');
          sTargetFilter=sDimension;          
        Else;
          sTargetFilter=sTargetFilter|sDelimDim|sDimension;
        Endif;  
          
        sLastDelim = sChar;
        # Clear the word
        sWord = '';

      Else;

        # Reset extra chars
        nAddExtra = 0;

        ### Check both dim delimiter and element delimiter ###
        nIsDelimiter = 0;

        ## Check dimension delimiter first
        # If the delimiter is more than 1 character peek ahead the same amount
        # Ignore the first character
        sDelim = sChar;
        nCount = LONG(sDelimDim) - 1;
        If( nCount > 0 & nChar + nCount <= nCharCount );
          # Add the extra characters
          sDelim = sDelim | SUBST( sElementMapping, nChar + 1, nCount);
        EndIf;

        If( sDelim @= sDelimDim );
          nIsDelimiter = 1;
          sChar = sDelim;
          
          # Move to the end of the delimter
          nAddExtra = nCount;
        EndIf;

        If ( nIsDelimiter = 1 );

          If( sLastDelim @= '' % sLastDelim @= sDelimDim );
            sMessage = 'In pMappingToNewDims - an element delimiter must follow a dimension name: ' |  sChar | ' (' | NumberToString(nChar) | ')';
            nErrors = nErrors + 1;
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            #ProcessError();
          EndIf;

          # an element has been found
          sElement = sWord;

          If( DIMIX( sDimension, sElement ) = 0 );
              # The element does not exist in the dimension. Cancel process
              sMessage = 'In pMappingToNewDims - Element: ' | sElement | ' in dimension ' | sDimension | ' does not exist';
              nErrors = nErrors + 1;
              LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
              #ProcessError();
          EndIf;

          # Allow consolidations only if pSuppressConsol is set to 0

          If ( DTYPE( sDimension, sElement) @= 'C' );
            sMessage = Expand( 'In pMappingToNewDims - Target element: %sElement% for dimension %sDimension% is consolidated' );
            nErrors = nErrors + 1;
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            #ProcessError();
          Endif;  
          

          # Add the element to the source or target depending on whether it's the first or the second element
          # Get principal name
          # in case source element and this element are using different aliases

          sElement = DimensionElementPrincipalName(sDimension,sElement);

          ### Update the variable for InputElement Target Dim ######################################
          If(nTargetIndex = 1);
            nNewDim1 = 1;
            sNewV1 = sElement;
          ElseIf(nTargetIndex = 2);
            nNewDim2 = 1;
            sNewV2 = sElement;
          ElseIf(nTargetIndex = 3);
            nNewDim3 = 1;
            sNewV3 = sElement;
          ElseIf(nTargetIndex = 4);
            nNewDim4 = 1;
            sNewV4 = sElement;
          ElseIf(nTargetIndex = 5);
            nNewDim5 = 1;
            sNewV5 = sElement;
          ElseIf(nTargetIndex = 6);
            nNewDim6 = 1;
            sNewV6 = sElement;
          ElseIf(nTargetIndex = 7);
            nNewDim7 = 1;
            sNewV7 = sElement;
          ElseIf(nTargetIndex = 8);
            nNewDim8 = 1;
            sNewV8 = sElement;
          ElseIf(nTargetIndex = 9);
            nNewDim9 = 1;
            sNewV9 = sElement;
          ElseIf(nTargetIndex = 10);
            nNewDim10 = 1;
            sNewV10 = sElement;
          ElseIf(nTargetIndex = 11);
            nNewDim11 = 1;
            sNewV11 = sElement;
          ElseIf(nTargetIndex = 12);
            nNewDim12 = 1;
            sNewV12 = sElement;
          ElseIf(nTargetIndex = 13);
            nNewDim13 = 1;
            sNewV13 = sElement;
          ElseIf(nTargetIndex = 14);
            nNewDim14 = 1;
            sNewV14 = sElement;
          ElseIf(nTargetIndex = 15);
            nNewDim15 = 1;
            sNewV15 = sElement;
          ElseIf(nTargetIndex = 16);
            nNewDim16 = 1;
            sNewV16 = sElement;
          ElseIf(nTargetIndex = 17);
            nNewDim17 = 1;
            sNewV17 = sElement;
          ElseIf(nTargetIndex = 18);
            nNewDim18 = 1;
            sNewV18 = sElement;
          ElseIf(nTargetIndex = 19);
            nNewDim19 = 1;
            sNewV19 = sElement;
          ElseIf(nTargetIndex = 20);
            nNewDim20 = 1;
            sNewV20 = sElement;
          ElseIf(nTargetIndex = 21);
            nNewDim21 = 1;
            sNewV21 = sElement;
          ElseIf(nTargetIndex = 22);
            nNewDim22 = 1;
            sNewV22 = sElement;
          ElseIf(nTargetIndex = 23);
            nNewDim23 = 1;
            sNewV23 = sElement;
          ElseIf(nTargetIndex = 24);
            nNewDim24 = 1;
            sNewV24 = sElement;
          ElseIf(nTargetIndex = 25);
            nNewDim25 = 1;
            sNewV25 = sElement;
          ElseIf(nTargetIndex = 26);
            nNewDim26 = 1;
            sNewV26 = sElement;
          ElseIf(nTargetIndex = 27);
            nNewDim27 = 1;
            sNewV27 = sElement;
          EndIf;

          #Add to the Target filter
          sTargetFilter=sTargetFilter|sElementStartDelim|sElement;
          
          # Clear the word
          sWord = '';
          sLastDelim = sChar;
 
        Else;
          sWord = sWord | sChar;
        EndIf;

      EndIf;

    EndIf;

    nChar = nChar + nAddExtra + 1;

END;

# Check that an input element or variable has been specified for all dimensions in the target cube

nIndexInTarget = 1;
WHILE(nIndexInTarget <= nTargetCubeDimensionCount);
      
      sMapped   = Expand('%nMappedDim'| NumberToString(nIndexInTarget) |'%'); 
      sMapped   = Subst( sMapped , Scan( '.' , sMapped )-1 , 99);
      nMapped   = StringToNumber( Trim( sMapped ) );
      sNew      = Expand('%nNewDim'| NumberToString(nIndexInTarget) |'%'); 
      sNew      = Subst( sNew , Scan( '.' , sNew )-1 , 99);
      nNew      = StringToNumber( Trim( sNew ) );
      
      If(nMapped = 0 & nNew = 0 );
            # there's no input element and this dimension is not in the source
            nErrors         = nErrors + 1;
            sTargetDimName  = TabDim( pTgtCube,  nIndexInTarget );
            sMessage        = 'Dimension ' | sTargetDimName | ' is missing an input element in pMappingToNewDims';
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            If( pStrictErrorHandling = 1 ); 
                ProcessQuit; 
            Else;
                ProcessBreak;
            EndIf;
       EndIf;
       
       nIndexInTarget = nIndexInTarget + 1;
END;


############################# Clear out target ################################

# Target is cleared for the elements specified in pMappingToNewDims
# and for the parts of pFilter for dimensions in the target
# This code works through pFilter looking for the parts relating to the target cube
# the code which finds individual elements has been left in
# so that it can be changed later to deal with consolidated elements

sFilter = TRIM( pFilter );
nChar = 1;
nCharCount = LONG( sFilter );
sWord = '';
sLastDelim = '';

# Add a trailing element delimiter so that the last Dimension:Element/s clause is picked up
If( nCharCount > 0 );
  sFilter = sFilter | sDelimElem;
  nCharCount = nCharCount + LONG(sDelimElem);
EndIf;

WHILE (nChar <= nCharCount);

    sChar = SUBST( sFilter, nChar, 1);

    # Used for delimiters, required for multiple character dilimiters
    sDelim = '';
    nAddExtra = 0;

    # Ignore spaces
    IF (TRIM(sChar) @<> '' );

      ### Dimension Name ###

      # If the delimiter is more than 1 character peek ahead the same amount
      # Ignore the first character
      sDelim = sChar;
      nCount = LONG(sElementStartDelim) - 1;
      If( nCount > 0 & nChar + nCount <= nCharCount );
        # Add the extra characters
        sDelim = sDelim | SUBST( sFilter, nChar + 1, nCount);
        # Move to the end of the delimter
        nAddExtra = nCount;
      EndIf;

      If( sDelim @= sElementStartDelim );

        sChar = sDelim;

        If( sLastDelim @<> '' & sLastDelim @<> sDelimDim );
          sMessage = 'In pFilter - the name of a dimension must follow a dimension delimiter (' | sDelimDim | ')';
          nErrors = nErrors + 1;
          LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
          #ProcessError();
        EndIf;

        # Found a dimension!
        sDimension = UPPER( sWord );
        nDimInTgt=0;
        # See if the dimension is in the target cube
        IF(scan('^^'|sDimension|'^^', sTgtDimString)>0);
          If(sTargetFilter@='');
            sTargetFilter = sDimension;
          Else;  
            sTargetFilter = sTargetFilter | sDelimDim | sDimension;
          endif;
          nDimInTgt=1;
        Endif;  

        sLastDelim = sChar;
        # Clear the word
        sWord = '';
        #reset element count
        nElementCount = 1;

      Else;

        # Reset extra chars
        nAddExtra = 0;

        ### Check both both dim delimiter and element delimiter ###
        nIsDelimiter = 0;

        ## Check dimension delimiter first
        # If the delimiter is more than 1 character peek ahead the same amount
        # Ignore the first character
        sDelim = sChar;
        nCount = LONG(sDelimDim) - 1;
        If( nCount > 0 & nChar + nCount <= nCharCount );
          # Add the extra characters
          sDelim = sDelim | SUBST( sFilter, nChar + 1, nCount);
          # Move to the end of the delimter
          nAddExtra = nCount;
        EndIf;

        If( sDelim @= sDelimDim );
          nIsDelimiter = 1;
          sChar = sDelim;
        Else;
          # Reset extra chars
          nAddExtra = 0;

          ## Check element delimiter

          # If the delimiter is more than 1 character peek ahead the same amount
          # Ignore the first character
          sDelim = sChar;
          nCount = LONG(sDelimElem) - 1;
          If( nCount > 0 & nChar + nCount <= nCharCount );
            # Add the extra characters
            sDelim = sDelim | SUBST( sFilter, nChar + 1, nCount);
            # Move to the end of the delimter
            nAddExtra = nCount;
          EndIf;

          If( sDelim @= sDelimElem );
            nIsDelimiter = 1;
            sChar = sDelim;
          Else;
            # Reset extra chars
            nAddExtra = 0;
          EndIf;

        EndIf;

        If ( nIsDelimiter = 1 );

          If( sLastDelim @= '' % sLastDelim @= sDelimDim );
            sMessage = 'In pFilter - an element delimiter must follow a dimension name: ' |  sChar | ' (' | NumberToString(nChar) | ')';
            nErrors = nErrors + 1;
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            #ProcessError();
          EndIf;

          # Found an element
          sElement = sWord;

          IF(DIMIX(sDimension, sElement) > 0 & nDimInTgt=1);
              # first element
              IF(nElementCount = 1);
                sTargetFilter = sTargetFilter | sElementStartDelim | sElement;
              # later elements
              Else;
                sTargetFilter = sTargetFilter | sDelimElem | sElement;
              EndIf;
          EndIf;

          nElementCount = nElementCount + 1;
          sLastDelim = sChar;

          # Clear the word
          sWord = '';
        Else;
          sWord = sWord | sChar;
        EndIf;

      EndIf;

    EndIf;

    nChar = nChar + nAddExtra + 1;

END;

### Check for errors before continuing
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

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
      ELSE;
        sFilter = Expand('%sFilter%%pEleDelim%%sSlicerEle%');
      ENDIF;
      IF( nThreadElCounter >= nElemsPerThread );
        RunProcess( cThisProcName, 'pLogoutput', pLogoutput,
        	'pSrcCube', pSrcCube, 'pFilter', sFilter, 'pFilterParallel', '', 'pTgtCube', pTgtCube, 'pMappingToNewDims', pMappingToNewDims,
        	'pSuppressConsol', pSuppressConsol, 'pSuppressConsolStrings', pSuppressConsolStrings, 'pSuppressRules', pSuppressRules, 'pSuppressZero', pSuppressZero, 'pZeroTarget', pZeroTarget, 'pZeroSource', pZeroSource,
          'pFactor', pFactor, 'pDimDelim', pDimDelim, 'pEleStartDelim', pEleStartDelim, 'pEleDelim', pEleDelim,
          'pTemp', pTemp, 'pCubeLogging', pCubeLogging, 'pSandbox', pSandbox, 'pFile', pFile, 'pThreadMode', 1
        );
    	  nThreadElCounter = 0;
    	  sFilter = '';
    	 ENDIF;
  End;
  ## Process last elements - only when filter is not empty (there are still elements)
  IF( sFilter @<> '' );
    RunProcess( cThisProcName, 'pLogoutput', pLogoutput,
    	'pSrcCube', pSrcCube, 'pFilter', sFilter, 'pFilterParallel', '', 'pTgtCube', pTgtCube, 'pMappingToNewDims', pMappingToNewDims,
    	'pSuppressConsol', pSuppressConsol, 'pSuppressConsolStrings', pSuppressConsolStrings, 'pSuppressRules', pSuppressRules, 'pSuppressZero', pSuppressZero, 'pZeroTarget', pZeroTarget, 'pZeroSource', pZeroSource,
      'pFactor', pFactor, 'pDimDelim', pDimDelim, 'pEleStartDelim', pEleStartDelim, 'pEleDelim', pEleDelim,
      'pTemp', pTemp, 'pCubeLogging', pCubeLogging, 'pSandbox', pSandbox, 'pFile', pFile, 'pThreadMode', 1
    );
  ENDIF;      
  DataSourceType = 'NULL';
Else;
  # Clear out target view
  If(pZeroTarget = 1 & LONG(sTargetFilter)>= 0 & nErrors = 0);
      ###### Create View of target to clear out ###
      # Create View of target ###
      nRet = ExecuteProcess('}bedrock.cube.view.create',
          'pLogOutput', pLogOutput,
          'pStrictErrorHandling', pStrictErrorHandling,
          'pCube', pTgtCube,
          'pView', sTargetView ,
          'pFilter', sTargetFilter,
          'pSuppressZero', pSuppressZero,
          'pSuppressConsol', pSuppressConsol,
          'pSuppressRules', pSuppressRules,
          'pSuppressConsolStrings', pSuppressConsolStrings, 
          'pDimDelim', pDimDelim,
          'pEleStartDelim', pEleStartDelim,
          'pEleDelim', pEleDelim ,
          'pTemp', pTemp
          );
  
      IF(nRet <> 0);
          sMessage = 'Error creating the view from the filter.';
          nErrors = nErrors + 1;
          LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
          If( pStrictErrorHandling = 1 ); 
              ProcessQuit; 
          Else;
              ProcessBreak;
          EndIf;
      ENDIF;
  
      nRet = ExecuteProcess( '}bedrock.cube.data.clear',
          'pLogOutput', pLogOutput,
          'pStrictErrorHandling', pStrictErrorHandling,
          'pCube', pTgtCube,
          'pView', sTargetView,
          'pFilter', sTargetFilter,
          'pDimDelim', pDimDelim,
          'pEleStartDelim', pEleStartDelim,
          'pEleDelim', pEleDelim,
          'pTemp', pTemp,
          'pCubeLogging', pCubeLogging,
          'pSandbox', pSandbox
          );
  
      IF(nRet <> 0);
          sMessage = 'Error clearing the target view.';
          nErrors = nErrors + 1;
          LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
          If( pStrictErrorHandling = 1 ); 
              ProcessQuit; 
          Else;
              ProcessBreak;
          EndIf;
      ENDIF;
  
  Endif;
  
  If( pFile = 0 );
    ### Create View of Source ###
    IF(pSuppressConsol = 0 & pSuppressConsolStrings = 1);
      pSubN=1;
    else;
      pSubN=0;
    Endif;  
    
    nRet = ExecuteProcess('}bedrock.cube.view.create',
      'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
      'pCube', pSrcCube,
      'pView', sView,
      'pFilter', pFilter,
      'pSuppressZero', pSuppressZero,
      'pSuppressConsol', pSuppressConsol,
      'pSuppressRules', pSuppressRules,
      'pSuppressConsolStrings', pSuppressConsolStrings, 
      'pDimDelim', pDimDelim,
      'pEleStartDelim', pEleStartDelim,
      'pEleDelim', pEleDelim ,
      'pTemp', pTemp,
      'pSubN', pSubN
      );
    
    IF(nRet <> 0);
          sMessage = 'Error creating the view from the filter.';
          nErrors = nErrors + 1;
          LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
          If( pStrictErrorHandling = 1 ); 
              ProcessQuit; 
          Else;
              ProcessBreak;
          EndIf;
    ENDIF;
  
  ElseIf( pFile > 0 );
    ### Export to File in case of Copy Data Via File ###
    IF(pSuppressConsol = 0);
      pSubN=1;
    else;
      pSubN=0;
    Endif;  
    
    nRet = ExecuteProcess('}bedrock.cube.data.export',
       'pLogoutput', pLogOutput,
       'pStrictErrorHandling', pStrictErrorHandling,
       'pCube', pSrcCube,
       'pView', sView,
       'pFilter', pFilter,
       'pFilterParallel', '',
       'pParallelThreads', 0,
       'pDimDelim', pDimDelim,
       'pEleStartDelim', pEleStartDelim,
       'pEleDelim', pEleDelim,
       'pSuppressZero', pSuppressZero,
       'pSuppressConsol', pSuppressConsol,
       'pSuppressRules', pSuppressRules,
       'pSuppressConsolStrings', pSuppressConsolStrings, 
       'pZeroSource', 0,
       'pCubeLogging', pCubeLogging,
       'pTemp', pTemp,
       'pFilePath', cDir,
       'pFileName', cFileName,
       'pDelim', cDelimiter,
       'pDecimalSeparator', sDecimalSeparator,
       'pThousandSeparator', sThousandSeparator,
       'pQuote', cQuote,
       'pTitleRecord', cTitleRows,
       'pSandbox', pSandbox,
       'pSubN', pSubN
      );
    
    IF(nRet <> 0);
          sMessage = 'Error exporting data to file.';
          nErrors = nErrors + 1;
          LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
          If( pStrictErrorHandling = 1 ); 
              ProcessQuit; 
          Else;
              ProcessBreak;
          EndIf;
    ENDIF;
  ENDIF;
  
  If ( pCubeLogging <= 1 );
    sCubeLogging = CellGetS('}CubeProperties', pTgtCube, 'LOGGING' );
    CubeSetLogChanges( pTgtCube, pCubeLogging);
  EndIf;
  
  ### Assign Datasource ###
  If( pFile = 0 );
    DataSourceType          = 'VIEW';
    DatasourceNameForServer = pSrcCube;
    DatasourceNameForClient = pSrcCube;
    DatasourceCubeView      = sView;
  ElseIf( pFile > 0 );
    DataSourceType                  = 'CHARACTERDELIMITED';
    DatasourceNameForServer         = cFile;
    DatasourceNameForClient         = cFile;
    DatasourceASCIIHeaderRecords    = cTitleRows;
    DatasourceASCIIDelimiter        = cDelimiter;
    DatasourceASCIIQuoteCharacter   = cQuote;
  EndIf;
EndIf;

### End Prolog ###
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,371

#****Begin: Generated Statements***
#****End: Generated Statements****

  # The exapand function gives the value of the variable passed to it
  # So if the say the third dimension in the source cube is the first dimension in the target cube
  # the string variable Source Variable for Target varialbe V1 is set on the prolog to V3 (see Mapped part)
  # which means Expand(%V3%) gives the value of V3
  # and Target sV1 will equal V3
If( pFile = 0 );  
  sV1 =IF(nMappedDim1=1,  Expand('%'|sMappedV1|'%'), IF(nNewDim1=1, sNewV1,V1));
  sV2 =IF(nMappedDim2=1,  Expand('%'|sMappedV2|'%'), IF(nNewDim2=1, sNewV2,V2));
  sV3 =IF(nMappedDim3=1,  Expand('%'|sMappedV3|'%'), IF(nNewDim3=1, sNewV3,V3));
  sV4 =IF(nMappedDim4=1,  Expand('%'|sMappedV4|'%'), IF(nNewDim4=1, sNewV4,V4));
  sV5 =IF(nMappedDim5=1,  Expand('%'|sMappedV5|'%'), IF(nNewDim5=1, sNewV5,V5));
  sV6 =IF(nMappedDim6=1,  Expand('%'|sMappedV6|'%'), IF(nNewDim6=1, sNewV6,V6));
  sV7 =IF(nMappedDim7=1,  Expand('%'|sMappedV7|'%'), IF(nNewDim7=1, sNewV7,V7));
  sV8 =IF(nMappedDim8=1,  Expand('%'|sMappedV8|'%'), IF(nNewDim8=1, sNewV8,V8));
  sV9 =IF(nMappedDim9=1,  Expand('%'|sMappedV9|'%'), IF(nNewDim9=1, sNewV9,V9));
  sV10=IF(nMappedDim10=1, Expand('%'|sMappedV10|'%'),IF(nNewDim10=1,sNewV10,V10));
  sV11=IF(nMappedDim11=1, Expand('%'|sMappedV11|'%'),IF(nNewDim11=1,sNewV11,V11));
  sV12=IF(nMappedDim12=1, Expand('%'|sMappedV12|'%'),IF(nNewDim12=1,sNewV12,V12));  
  sV13=IF(nMappedDim13=1, Expand('%'|sMappedV13|'%'),IF(nNewDim13=1,sNewV13,V13));  
  sV14=IF(nMappedDim14=1, Expand('%'|sMappedV14|'%'),IF(nNewDim14=1,sNewV14,V14));   
  sV15=IF(nMappedDim15=1, Expand('%'|sMappedV15|'%'),IF(nNewDim15=1,sNewV15,V15));  
  sV16=IF(nMappedDim16=1, Expand('%'|sMappedV16|'%'),IF(nNewDim16=1,sNewV16,V16));  
  sV17=IF(nMappedDim17=1, Expand('%'|sMappedV17|'%'),IF(nNewDim17=1,sNewV17,V17));  
  sV18=IF(nMappedDim18=1, Expand('%'|sMappedV18|'%'),IF(nNewDim18=1,sNewV18,V18));  
  sV19=IF(nMappedDim19=1, Expand('%'|sMappedV19|'%'),IF(nNewDim19=1,sNewV19,V19));  
  sV20=IF(nMappedDim20=1, Expand('%'|sMappedV20|'%'),IF(nNewDim20=1,sNewV20,V20));  
  sV21=IF(nMappedDim21=1, Expand('%'|sMappedV21|'%'),IF(nNewDim21=1,sNewV21,V21));  
  sV22=IF(nMappedDim22=1, Expand('%'|sMappedV22|'%'),IF(nNewDim22=1,sNewV22,V22));  
  sV23=IF(nMappedDim23=1, Expand('%'|sMappedV23|'%'),IF(nNewDim23=1,sNewV23,V23));  
  sV24=IF(nMappedDim24=1, Expand('%'|sMappedV24|'%'),IF(nNewDim24=1,sNewV24,V24));  
  sV25=IF(nMappedDim25=1, Expand('%'|sMappedV25|'%'),IF(nNewDim25=1,sNewV25,V25));  
  sV26=IF(nMappedDim26=1, Expand('%'|sMappedV26|'%'),IF(nNewDim26=1,sNewV26,V26));  
  sV27=IF(nMappedDim27=1, Expand('%'|sMappedV27|'%'),IF(nNewDim27=1,sNewV27,V27));
  sV28=IF(nMappedDim28=1, Expand('%'|sMappedV28|'%'),V28);  
ElseIf( pFile > 0 );
  sV1 =IF(nMappedDim1=1,  Expand('%'|sMappedV1|'%'), IF(nNewDim1=1, sNewV1,V2));
  sV2 =IF(nMappedDim2=1,  Expand('%'|sMappedV2|'%'), IF(nNewDim2=1, sNewV2,V3));
  sV3 =IF(nMappedDim3=1,  Expand('%'|sMappedV3|'%'), IF(nNewDim3=1, sNewV3,V4));
  sV4 =IF(nMappedDim4=1,  Expand('%'|sMappedV4|'%'), IF(nNewDim4=1, sNewV4,V5));
  sV5 =IF(nMappedDim5=1,  Expand('%'|sMappedV5|'%'), IF(nNewDim5=1, sNewV5,V6));
  sV6 =IF(nMappedDim6=1,  Expand('%'|sMappedV6|'%'), IF(nNewDim6=1, sNewV6,V7));
  sV7 =IF(nMappedDim7=1,  Expand('%'|sMappedV7|'%'), IF(nNewDim7=1, sNewV7,V8));
  sV8 =IF(nMappedDim8=1,  Expand('%'|sMappedV8|'%'), IF(nNewDim8=1, sNewV8,V9));
  sV9 =IF(nMappedDim9=1,  Expand('%'|sMappedV9|'%'), IF(nNewDim9=1, sNewV9,V10));
  sV10=IF(nMappedDim10=1, Expand('%'|sMappedV10|'%'),IF(nNewDim10=1,sNewV10,V11));
  sV11=IF(nMappedDim11=1, Expand('%'|sMappedV11|'%'),IF(nNewDim11=1,sNewV11,V12));
  sV12=IF(nMappedDim12=1, Expand('%'|sMappedV12|'%'),IF(nNewDim12=1,sNewV12,V13));  
  sV13=IF(nMappedDim13=1, Expand('%'|sMappedV13|'%'),IF(nNewDim13=1,sNewV13,V14));  
  sV14=IF(nMappedDim14=1, Expand('%'|sMappedV14|'%'),IF(nNewDim14=1,sNewV14,V15));   
  sV15=IF(nMappedDim15=1, Expand('%'|sMappedV15|'%'),IF(nNewDim15=1,sNewV15,V16));  
  sV16=IF(nMappedDim16=1, Expand('%'|sMappedV16|'%'),IF(nNewDim16=1,sNewV16,V17));  
  sV17=IF(nMappedDim17=1, Expand('%'|sMappedV17|'%'),IF(nNewDim17=1,sNewV17,V18));  
  sV18=IF(nMappedDim18=1, Expand('%'|sMappedV18|'%'),IF(nNewDim18=1,sNewV18,V19));  
  sV19=IF(nMappedDim19=1, Expand('%'|sMappedV19|'%'),IF(nNewDim19=1,sNewV19,V20));  
  sV20=IF(nMappedDim20=1, Expand('%'|sMappedV20|'%'),IF(nNewDim20=1,sNewV20,V21));  
  sV21=IF(nMappedDim21=1, Expand('%'|sMappedV21|'%'),IF(nNewDim21=1,sNewV21,V22));  
  sV22=IF(nMappedDim22=1, Expand('%'|sMappedV22|'%'),IF(nNewDim22=1,sNewV22,V23));  
  sV23=IF(nMappedDim23=1, Expand('%'|sMappedV23|'%'),IF(nNewDim23=1,sNewV23,V24));  
  sV24=IF(nMappedDim24=1, Expand('%'|sMappedV24|'%'),IF(nNewDim24=1,sNewV24,V25));  
  sV25=IF(nMappedDim25=1, Expand('%'|sMappedV25|'%'),IF(nNewDim25=1,sNewV25,V26));  
  sV26=IF(nMappedDim26=1, Expand('%'|sMappedV26|'%'),IF(nNewDim26=1,sNewV26,V27));  
  sV27=IF(nMappedDim27=1, Expand('%'|sMappedV27|'%'),IF(nNewDim27=1,sNewV27,V28));
  sV28=IF(nMappedDim28=1, Expand('%'|sMappedV28|'%'),V29);
EndIf;
    
##########################################################################################################
### Write data from source file to target cube ###########################################################

  If( nDimensionCount = 2 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2 ) = 1 );
      sElType = DType( sDim2, sV2 );
      IF( SubSt( pTgtCube, 1, 17 ) @= '}ElementSecurity_');
        sV3 = IF( sV3 @= '', 'NONE', sV3 );
        ElementSecurityPut( sV3, sDim1, sV1, sV2 );
      ELSEIF( sElType @= 'AA' );
        AttrPutS( sV3, sDim1, sV1, sV2, 1 );
      ELSEIF( sElType @= 'AS' );
        AttrPutS( sV3, sDim1, sV1, sV2 );
      ELSEIF( sElType @= 'AN' );
        AttrPutN( StringToNumberEx( sV3, sDecimalSeparator, sThousandSeparator ) * nFactor, sDim1, sV1, sV2 );
      ElseIf( sElType @= 'S' );
        CellPutS( sV3, pTgtCube, sV1, sV2 );
      Else;
        nObal = CellGetN( pTgtCube, sV1, sV2 );
        nCbal = nObal + StringToNumberEx( sV3, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 3 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3 ) = 1 );
      sElType = DType( sDim3, sV3 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3 );
        nCbal = nObal + StringToNumberEx( sV4, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3 );
      Else;
        CellPutS( sV4, pTgtCube, sV1, sV2, sV3 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 4 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4 ) = 1 );
      sElType = DType( sDim4, sV4 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4);
        nCbal = nObal + StringToNumberEx( sV5, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4);
      Else;
        CellPutS( sV5, pTgtCube, sV1, sV2, sV3, sV4);
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 5 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5 ) = 1 );
      sElType = DType( sDim5, sV5 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5 );
        nCbal = nObal + StringToNumberEx( sV6, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5 );
      Else;
        CellPutS( sV6, pTgtCube, sV1, sV2, sV3, sV4, sV5 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 6 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6 ) = 1 );
      sElType = DType( sDim6, sV6 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6 );
        nCbal = nObal + StringToNumberEx( sV7, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6 );
      Else;
        CellPutS( sV7, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 7 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7 ) = 1 );
      sElType = DType( sDim7, sV7 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7 );
        nCbal = nObal + StringToNumberEx( sV8, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7 );
      Else;
        CellPutS( sV8, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 8 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8 ) = 1 );
      sElType = DType( sDim8, sV8 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8 );
        nCbal = nObal + StringToNumberEx( sV9, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8 );
      Else;
        CellPutS( sV9, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 9 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9 ) = 1 );
      sElType = DType( sDim9, sV9 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9 );
        nCbal = nObal + StringToNumberEx( sV10, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9 );
      Else;
        CellPutS( sV10, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 10 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10 ) = 1 );
      sElType = DType( sDim10, sV10 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10 );
        nCbal = nObal + StringToNumberEx( sV11, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10 );
      Else;
        CellPutS( sV11, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 11 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11 ) = 1 );
      sElType = DType( sDim11, sV11 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11 );
        nCbal = nObal + StringToNumberEx( sV12, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11 );
      Else;
        CellPutS( sV12, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 12 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12 ) = 1 );
      sElType = DType( sDim12, sV12 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12 );
        nCbal = nObal + StringToNumberEx( sV13, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12 );
      Else;
        CellPutS( sV13, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 13 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13 ) = 1 );
      sElType = DType( sDim13, sV13 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13 );
        nCbal = nObal + StringToNumberEx( sV14, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13 );
      Else;
        CellPutS( sV14, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 14 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14 ) = 1 );
      sElType = DType( sDim14, sV14 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14 );
        nCbal = nObal + StringToNumberEx( sV15, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14 );
      Else;
        CellPutS( sV15, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 15 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15 ) = 1 );
      sElType = DType( sDim15, sV15 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15 );
        nCbal = nObal + StringToNumberEx( sV16, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15 );
      Else;
        CellPutS( sV16, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 16 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16 ) = 1 );
      sElType = DType( sDim16, sV16 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16 );
        nCbal = nObal + StringToNumberEx( sV17, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16 );
      Else;
        CellPutS( sV17, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 17 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17 ) = 1 );
      sElType = DType( sDim17, sV17 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17 );
        nCbal = nObal + StringToNumberEx( sV18, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17 );
      Else;
        CellPutS( sV18, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 18 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18 ) = 1 );
      sElType = DType( sDim18, sV18 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18 );
        nCbal = nObal + StringToNumberEx( sV19, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18 );
      Else;
        CellPutS( sV19, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 19 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19 ) = 1 );
      sElType = DType( sDim19, sV19 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19 );
        nCbal = nObal + StringToNumberEx( sV20, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19 );
      Else;
        CellPutS( sV20, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 20 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20 ) = 1 );
      sElType = DType( sDim20, sV20 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20 );
        nCbal = nObal + StringToNumberEx( sV21, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20 );
      Else;
        CellPutS( sV21, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20 );
      EndIf;
    EndIf;  
  ElseIf( nDimensionCount = 21 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21 ) = 1 );
      sElType = DType( sDim21, sV21 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21 );
        nCbal = nObal + StringToNumberEx( sV22, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21 );
      Else;
        CellPutS( sV22, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21 );
      EndIf;
    EndIf;  
  ElseIf( nDimensionCount = 22 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22 ) = 1 );
      sElType = DType( sDim22, sV22 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22 );
        nCbal = nObal + StringToNumberEx( sV23, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22 );
      Else;
        CellPutS( sV23, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 23 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23 ) = 1 );
      sElType = DType( sDim23, sV23 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23 );
        nCbal = nObal + StringToNumberEx( sV24, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23 );
      Else;
        CellPutS( sV24, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23 );
      EndIf;
    EndIf; 
  ElseIf( nDimensionCount = 24 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23, sV24 ) = 1 );
      sElType = DType( sDim24, sV24 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23, sV24 );
        nCbal = nObal + StringToNumberEx( sV25, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23, sV24 );
      Else;
        CellPutS( sV25, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23, sV24 );
      EndIf;
    EndIf;     
  ElseIf( nDimensionCount = 25 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23, sV24, sV25 ) = 1 );
      sElType = DType( sDim25, sV25 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23, sV24, sV25 );
        nCbal = nObal + StringToNumberEx( sV26, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23, sV24, sV25 );
      Else;
        CellPutS( sV26, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23, sV24, sV25 );
      EndIf;
    EndIf;  
  ElseIf( nDimensionCount = 26 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23, sV24, sV25, sV26 ) = 1 );
      sElType = DType( sDim26, sV26 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23, sV24, sV25, sV26 );
        nCbal = nObal + StringToNumberEx( sV27, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23, sV24, sV25, sV26 );
      Else;
        CellPutS( sV27, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23, sV24, sV25, sV26 );
      EndIf;
    EndIf;   
  ElseIf( nDimensionCount = 27 );
    If( CellIsUpdateable( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23, sV24, sV25, sV26, sV27 ) = 1 );
      sElType = DType( sDim27, sV27 );
      If( sElType @<> 'S' );
        nObal = CellGetN( pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23, sV24, sV25, sV26, sV27 );
        nCbal = nObal + StringToNumberEx( sV28, sDecimalSeparator, sThousandSeparator ) * nFactor;
        CellPutN( nCbal, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23, sV24, sV25, sV26, sV27 );
      Else;
        CellPutS( sV28, pTgtCube, sV1, sV2, sV3, sV4, sV5, sV6, sV7, sV8, sV9, sV10, sV11, sV12, sV13, sV14, sV15, sV16, sV17, sV18, sV19, sV20, sV21, sV22, sV23, sV24, sV25, sV26, sV27 );
      EndIf;
    EndIf;     
  
  EndIf;
 
### End Data ###
575,45

#****Begin: Generated Statements***
#****End: Generated Statements****

## Zero Source
If( pZeroSource = 1 & nErrors = 0  );
    If ( pCubeLogging <= 1 );
        CubeSetLogChanges( pSrcCube, pCubeLogging);
    EndIf;
        ViewZeroOut( pSrcCube, sView );
    If ( pCubeLogging <= 1 );
        CubeSetLogChanges( pSrcCube, IF(CellGetS('}CubeProperties', pSrcCube, 'LOGGING' ) @= 'YES',1,0) );
    EndIf;
EndIf;

## Switch back logging on Tgt Cube
If ( pCubeLogging <= 1 );
    CubeSetLogChanges( pTgtCube, IF(sCubeLogging @='YES',1,0) );
EndIf;

### Delete export file if used
If( pFile = 1 );
  TM1RunCmd = 'CMD.EXE /C "DEL "' | cFile | '" "';
  EXECUTECOMMAND ( TM1RunCmd , 0 );
EndIf;

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully copied data from %pSrcCube% cube to the %pTgtCube% cube.' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogoutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );   
    EndIf;
EndIf;

### End Epilog ###
576,_ParameterConstraints=e30=
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
