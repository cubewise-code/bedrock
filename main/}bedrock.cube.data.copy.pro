601,100
602,"}bedrock.cube.data.copy"
562,"VIEW"
586,"zzSYS 50 Dim Cube"
585,"zzSYS 50 Dim Cube"
564,
565,"sJ;s>64<SFMmyZLVHaQy]>kfCKC`K`p;AgBHS4Z=g4AvafY1p@;5rPtHn3FqUCBKRsk?qU`AE^`1mchfReEF^MTNWuJPv089g]5}4SlqAJ9OYqWXDDVZgooX33<Bm^vIA{ZGJ>\4M1}fGhP42o3m2sG7xhEVc@>eA7h?wkHIDavOju=z<x@lB}9ImcUdy`nBm_Gg?Qm"
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
570,Temp
571,
569,0
592,0
599,1000
560,33
pLogOutput
pStrictErrorHandling
pCube
pSrcView
pTgtView
pFilter
pFilterParallel
pParallelThreads
pEleMapping
pMappingDelim
pDimDelim
pEleStartDelim
pEleDelim
pFactor
pSuppressConsol
pSuppressConsolStrings
pSuppressRules
pSuppressZero
pCumulate
pZeroTarget
pZeroSource
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
pThreadControlFile
pMaxWaitSeconds
561,33
1
1
2
2
2
2
2
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
1
1
1
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
2
1
590,33
pLogOutput,0
pStrictErrorHandling,0
pCube,""
pSrcView,""
pTgtView,""
pFilter,""
pFilterParallel,""
pParallelThreads,0
pEleMapping,""
pMappingDelim,"->"
pDimDelim,"&"
pEleStartDelim,"¦"
pEleDelim,"+"
pFactor,1
pSuppressConsol,1
pSuppressConsolStrings,0
pSuppressRules,1
pSuppressZero,1
pCumulate,0
pZeroTarget,1
pZeroSource,0
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
pThreadControlFile,""
pMaxWaitSeconds,1800
637,33
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pCube,"REQUIRED: Cube"
pSrcView,"OPTIONAL: Temporary view name for source"
pTgtView,"OPTIONAL: Temporary view name for target"
pFilter,"OPTIONAL: Filter Unmapped Dimensions using format: Year¦ 2006 + 2007 & Scenario¦ Actual + Budget etc"
pFilterParallel,"OPTIONAL: Parallelization Filter: Month:Q1+Q2+Q3+Q4 (Blank=run single threaded). Single dimension parallel slices. Will be added to filter single element at a time. Dimension must not be part of filter"
pParallelThreads,"Maximum number of threads to run when parallel processing is enabled ( if <2 will execute one thread, but parallel filter is still applied )"
pEleMapping,"REQUIRED: Map source elements to target elements using format Dim1ToCopy¦SourceElement->TargetElement & Dim2ToCopy¦Source Element->TargetElement etc"
pMappingDelim,"OPTIONAL: Delimiter between source element and target element in pEleMapping  (default value if blank = '->')"
pDimDelim,"OPTIONAL: Delimiter for start of Dimension/Element set  (default value if blank = '&')"
pEleStartDelim,"OPTIONAL: Delimiter for start of element list  (default value if blank = '¦')"
pEleDelim,"OPTIONAL: Delimiter between elements (default value if blank = '+')"
pFactor,"OPTIONAL: Multiply source value by factor (1 keeps the value as is). To modify existing values make the target element the same as the source with pZeroTarget = 0"
pSuppressConsol,"OPTIONAL: Suppress Consolidated Cells (Skip = 1)"
pSuppressConsolStrings,"OPTIONAL: Suppress Consolidated String Cells (Skip = 1)"
pSuppressRules,"OPTIONAL: Suppress Rules (Skip = 1)"
pSuppressZero,"OPTIONAL: Suppress Null Cells (Skip = 1)"
pCumulate,"OPTIONAL: 1 = Add source to existing value in target (if zero out target = 0 False). 0 = Replace target with source."
pZeroTarget,"OPTIONAL: Zero out Target Element PRIOR to Copy? (Boolean 1=True)"
pZeroSource,"OPTIONAL: Zero out Source Element AFTER Copy? (Boolean 1=True)"
pTemp,"OPTIONAL: Delete temporary view and Subset ( 0 = Retain View and Subsets 1 = Delete View and Subsets 2 = Delete View only )"
pCubeLogging,"Required: Cube Logging (0 = No transaction logging, 1 = Logging of transactions, 2 = Ignore Cube Logging - No Action Taken, parameter does not work with Parallel thread))"
pSandbox,"OPTIONAL: To use sandbox not base data enter the sandbox name (invalid name will result in process error)"
pFile,"OPTIONAL: Copy via file export and import. Reduces locks (0 = no, 1= use file and delete it 2= use file and retain it)"
pDelim,"OPTIONAL: For pFile > 0. AsciiOutput delimiter character (Default = ',' exactly 3 digits = ASCII code)"
pQuote,"OPTIONAL: For pFile > 0. AsciiOutput quote character (Default = '""' exactly 3 digits = ASCII code)"
pDecimalSeparator,"OPTIONAL: For pFile > 0. Decimal separator for conversion of NumberToStringEx and StringToNumberEx (default = '.' exactly 3 digits = ASCII code)"
pThousandSeparator,"OPTIONAL: For pFile > 0. Thousand separator for conversion of NumberToStringEx and StringToNumberEx (default = ',' exactly 3 digits = ASCII code)"
pSubN,"OPTIONAL: Create N level subset for all dims not mentioned in pFilter"
pThreadMode,"DO NOT USE: Internal parameter only, please do not use"
pThreadControlFile,"DO NOT USE: Internal parameter only, please do not use"
pMaxWaitSeconds,"OPTIONAL: Used with parallel to define wait time"
577,51
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
Value
578,51
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
1
579,51
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
580,51
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
581,51
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
582,51
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
VarType=33ColType=827
603,0
572,1095
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.

IF( 1 = 0 );
	ExecuteProcess( '}bedrock.cube.data.copy', 
		'pLogOutput', pLogOutput, 
		'pStrictErrorHandling', pStrictErrorHandling, 
		'pCube', '', 
		'pSrcView', '', 
		'pTgtView', '', 
		'pFilter', '', 
		'pFilterParallel', '', 
		'pParallelThreads', 0, 
		'pEleMapping', '', 
		'pMappingDelim', '->', 
		'pDimDelim', '&', 
		'pEleStartDelim', '¦', 
		'pEleDelim', '+', 
		'pFactor', 1, 
		'pSuppressConsol', 1, 
		'pSuppressConsolStrings', 0, 
		'pSuppressRules', 1, 
		'pSuppressZero', 1, 
		'pCumulate', 0, 
		'pZeroTarget', 1, 
		'pZeroSource', 0, 
		'pTemp', 1, 
		'pCubeLogging', 0, 
		'pSandbox', '', 
		'pFile', 0, 
		'pDelim', ',', 
		'pQuote', '"', 
		'pDecimalSeparator', '.', 
		'pThousandSeparator', ',', 
		'pSubN', 0 );
ENDIF;

#EndRegion CallThisProcess
#****Begin: Generated Statements***
#****End: Generated Statements****

#################################################################################################
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
#################################################################################################
#Region @DOC
# Description:
# This TI is intended to copy data from one element of a dimension to another in the same cube.
# Use case: Mainly used in production environments.
# 1/ Typically, this would be used to archive a Budget or Forecast element of a version dimension.
# 2/ Could also be used to prepopulate a version from a prior year.
# Note:
# Naturally, a valid cube name (pCube) is required. otherwise the process will abort.
# Element mapping (pEleMapping) is also required, otherwise the process will abort.
# A filter parameter (pFilter) can also be used to filter dimensions that have not been mapped.
# Source (pSrcView) & target (pTgtView) views will be assigned temporary names if left blank.
# All other parameters may be left as is but be sure to use them appropriately when specifying pEleMapping & pFilter parameters.
# - Since this TI has a view as a data source, it requires the implicit variables NValue, SValue and Value_is_String.
# - To edit this TI in Architect a tmp cube with minimum 24 dims is needed as the preview data source or set the data
#   source to ASCII and manually edit the TI in notepad after saving to add back the required implicit view variables.
# - If using the pFilterParallel parameter the **single dimension** used as the "parallelization slicer" cannot appear in
#   the pFilter and pEleMapping parameters.
# - When using parallelization via the *RunProcess* function the elements listed in pFilterParallel will be split one_at_a_time
#   and passed to a recursive call of the process being added to pFilter.
#EndRegion @DOC

IF( pThreadControlFile @<> '' );
	LogOutput( 'INFO', 'Executed as subTI with Thread Control File: ' | pThreadControlFile );
ENDIF;

##Global Variables

StringGlobalVariable( 'sProcessReturnCode' );
NumericGlobalVariable( 'nProcessReturnCode' );
nProcessReturnCode = 0;

# Target Filter Variable for shell processes

StringGlobalVariable( 'sTargetFilter' );

### Constants ###

cThisProcName = GetProcessName(  );
cUserName = Tm1User(  );
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt = NumberToString( Int( Rand(  ) * 1000 ));
cTempSub = cThisProcName | '_' | cTimeStamp | '_' | cRandomInt;
cMsgErrorLevel = 'ERROR';
cMsgErrorContent = 'Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo = 'Process:%cThisProcName% run with parameters pCube:%pCube%, pSrcView:%pSrcView%, pTgtView:%pTgtView%, pFilter:%pFilter%, pFilterParallel:%pFilterParallel%, pParallelThreads:%pParallelThreads%, pEleMapping:%pEleMapping%, pMappingDelim:%pMappingDelim%, pDimDelim:%pDimDelim%, pEleStartDelim:%pEleStartDelim%, pEleDelim:%pEleDelim%, pFactor:%pFactor%, pSuppressConsol:%pSuppressConsol%, pSuppressConsolStrings:%pSuppressConsolStrings%, pSuppressRules:%pSuppressRules%, pSuppressZero:%pSuppressZero%, pCumulate:%pCumulate%, pZeroTarget:%pZeroTarget%, pZeroSource:%pZeroSource%, pTemp:%pTemp%, pCubeLogging:%pCubeLogging%, pSandbox:%pSandbox%, pFile:%pFile%.';
cDefaultView = Expand( '%cThisProcName%_%cTimeStamp%_%cRandomInt%' );

## LogOutput parameters

IF( pLogoutput = 1 );
	LogOutput( 'INFO', Expand( cLogInfo ));
ENDIF;

#Disable logic for pCubeLogic for prararrel thread

IF( pParallelThreads > 0 );
	pCubeLogging = 2;
ENDIF;

# Variables

nDataCount = 0;
nExistingSourceFlag = 0;
nAttrCubeFlag = 0;
cSuffixSource = 'S';
cSuffixTarget = 'T';
cPrefixElementAttributes = '}ElementAttributes_';
cDimCountMax = 27;
sDimCountMax = NumberToString( cDimCountMax );
nFactor = IF( pFactor = 0, 1, pFactor );
cLenASCIICode = 3;

## check operating system

IF( SubSt( GetProcessErrorFileDirectory, 2, 1 ) @= ':' );
	sOS = 'Windows';
	sOSDelim = '\';
ELSEIF( Scan( '/', GetProcessErrorFileDirectory ) > 0 );
	sOS = 'Linux';
	sOSDelim = '/';
ELSE;
	sOS = 'Windows';
	sOSDelim = '\';
ENDIF;

# Validate file delimiter & quote character

IF( pDelim @= '' );
	pDelim = ',';
ELSE;

	# If length of pDelim is exactly 3 chars and each of them is decimal digit, then the pDelim is entered as ASCII code

	nValid = 0;
	IF( Long( pDelim ) = cLenASCIICode );
		nChar = 1;
		WHILE( nChar <= cLenASCIICode );
			IF( Code( pDelim, nChar ) >= Code( '0', 1 ) & Code( pDelim, nChar ) <= Code( '9', 1 ));
				nValid = 1;
			ELSE;
				nValid = 0;
				BREAK;
			ENDIF;
			nChar = nChar + 1;
		END;
	ENDIF;
	IF( nValid <> 0 );
		pDelim = Char( StringToNumber( pDelim ));
	ELSE;
		pDelim = SubSt( Trim( pDelim ), 1, 1 );
	ENDIF;
ENDIF;
IF( pQuote @= '' );

	## Use no quote character

ELSE;

	# If length of pQuote is exactly 3 chars and each of them is decimal digit, then the pQuote is entered as ASCII code

	nValid = 0;
	IF( Long( pQuote ) = cLenASCIICode );
		nChar = 1;
		WHILE( nChar <= cLenASCIICode );
			IF( Code( pQuote, nChar ) >= Code( '0', 1 ) & Code( pQuote, nChar ) <= Code( '9', 1 ));
				nValid = 1;
			ELSE;
				nValid = 0;
				BREAK;
			ENDIF;
			nChar = nChar + 1;
		END;
	ENDIF;
	IF( nValid <> 0 );
		pQuote = Char( StringToNumber( pQuote ));
	ELSE;
		pQuote = SubSt( Trim( pQuote ), 1, 1 );
	ENDIF;
ENDIF;

## File location for indirect data copy

cDir = GetProcessErrorFileDirectory;
cFileName = Lower( pCube ) | cTimeStamp | cRandomInt | '.csv';
cFile = cDir | cFileName;
cTitleRows = 1;
cDelimiter = pDelim;
cQuote = pQuote;

# nMappedDimX is a binary switch used to keep track of which dimensions have been mapped from the source to the target

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

### Determine dimensions in target cube - we need to know this to test the cell type before loading ###

sDim1 = TabDim( pCube, 1 );
sDim2 = TabDim( pCube, 2 );
sDim3 = TabDim( pCube, 3 );
sDim4 = TabDim( pCube, 4 );
sDim5 = TabDim( pCube, 5 );
sDim6 = TabDim( pCube, 6 );
sDim7 = TabDim( pCube, 7 );
sDim8 = TabDim( pCube, 8 );
sDim9 = TabDim( pCube, 9 );
sDim10 = TabDim( pCube, 10 );
sDim11 = TabDim( pCube, 11 );
sDim12 = TabDim( pCube, 12 );
sDim13 = TabDim( pCube, 13 );
sDim14 = TabDim( pCube, 14 );
sDim15 = TabDim( pCube, 15 );
sDim16 = TabDim( pCube, 16 );
sDim17 = TabDim( pCube, 17 );
sDim18 = TabDim( pCube, 18 );
sDim19 = TabDim( pCube, 19 );
sDim20 = TabDim( pCube, 20 );
sDim21 = TabDim( pCube, 21 );
sDim22 = TabDim( pCube, 22 );
sDim23 = TabDim( pCube, 23 );
sDim24 = TabDim( pCube, 24 );
sDim25 = TabDim( pCube, 25 );
sDim26 = TabDim( pCube, 26 );
sDim27 = TabDim( pCube, 27 );

###########################
### Validate Parameters ###
###########################

nErrors = 0;

## Default filter delimiters

IF( pDimDelim @= '' );
	pDimDelim = '&';
ENDIF;
IF( pEleStartDelim @= '' );
	pEleStartDelim = '¦';
ENDIF;
IF( pEleDelim @= '' );
	pEleDelim = '+';
ENDIF;
IF( pMappingDelim @= '' );
	pMappingDelim = '->';
ENDIF;
IF( pDecimalSeparator @= '' );
	pDecimalSeparator = '.';
ENDIF;
IF( Long( pDecimalSeparator ) = cLenASCIICode );
	nValid = 0;
	nChar = 1;
	WHILE( nChar <= cLenASCIICode );
		IF( Code( pDecimalSeparator, nChar ) >= Code( '0', 1 ) & Code( pDecimalSeparator, nChar ) <= Code( '9', 1 ));
			nValid = 1;
		ELSE;
			nValid = 0;
			BREAK;
		ENDIF;
		nChar = nChar + 1;
	END;
	IF( nValid <> 0 );
		pDecimalSeparator = Char( StringToNumber( pDecimalSeparator ));
	ELSE;
		pDecimalSeparator = SubSt( Trim( pDecimalSeparator ), 1, 1 );
	ENDIF;
ENDIF;
sDecimalSeparator = pDecimalSeparator;
IF( pThousandSeparator @= '' );
	pThousandSeparator = ',';
ENDIF;
IF( Long( pThousandSeparator ) = cLenASCIICode );
	nValid = 0;
	nChar = 1;
	WHILE( nChar <= cLenASCIICode );
		IF( Code( pThousandSeparator, nChar ) >= Code( '0', 1 ) & Code( pThousandSeparator, nChar ) <= Code( '9', 1 ));
			nValid = 1;
		ELSE;
			nValid = 0;
			BREAK;
		ENDIF;
		nChar = nChar + 1;
	END;
	IF( nValid <> 0 );
		pThousandSeparator = Char( StringToNumber( pThousandSeparator ));
	ELSE;
		pThousandSeparator = SubSt( Trim( pThousandSeparator ), 1, 1 );
	ENDIF;
ENDIF;
sThousandSeparator = pThousandSeparator;

# Validate cube

IF( Trim( pCube ) @= '' );
	nErrors = 1;
	sMessage = 'No cube specified.';
	LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));
ELSEIF( CubeExists( pCube ) = 0 );
	nErrors = nErrors + 1;
	sMessage = Expand( 'Invalid source cube specified: %pCube%.' );
	LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));
ENDIF;

### Determine number of dims in target cube ###

nCount = 1;
WHILE( TabDim( pCube, nCount ) @<> '' );
	sDimension = TabDim( pCube, nCount );
	nCount = nCount + 1;
END;
nDimensionCount = nCount - 1;

## If dimension count exceeds the current maximum then terminate process

IF( nDimensionCount > cDimCountMax );
	nErrors = nErrors + 1;
	sMessage = 'Cube has too many dimensions: %pCube%. Max %sDimCountMax% dims catered for, TI must be altered to accommodate.';
	LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));
ENDIF;

## Validate the View parameter

IF( Trim( pSrcView ) @<> '' & Trim( pSrcView ) @= Trim( pTgtView ));
	nErrors = nErrors + 1;
	sMessage = Expand( 'Source and Target Views can not be the same: %pSrcView%.' );
	LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));
ENDIF;

## Validate the View parameter

IF( Trim( pSrcView ) @= '' );
	cViewSource = Expand( '%cDefaultView%_%cSuffixSource%' );
ELSE;
	cViewSource = pSrcView;
	nExistingSourceFlag = 1;
ENDIF;

## Validate the View parameter

IF( Trim( pTgtView ) @= '' );
	cViewTarget = Expand( '%cDefaultView%_%cSuffixTarget%' );
ELSE;
	cViewTarget = pTgtView;
ENDIF;

# Validate parallelization filter

IF( Scan( pEleStartDelim, pFilterParallel ) > 0 );
	sDimParallel = SubSt( pFilterParallel, 1, Scan( pEleStartDelim, pFilterParallel ) - 1 );
	IF( Scan( Lower( sDimParallel ) | pEleStartDelim, Lower( pFilter )) > 0 );
		sMessage = 'Parallelization dimension %sDimParallel% cannot exist in filter.';
		nErrors = nErrors + 1;
		LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));
	ENDIF;
	IF( Scan( Lower( sDimParallel ) | pEleStartDelim, Lower( pEleMapping )) > 0 );
		sMessage = 'Parallelization dimension %sDimParallel% cannot exist in element mapping.';
		nErrors = nErrors + 1;
		LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));
	ENDIF;
ENDIF;

# Validate Max Threads

IF( pParallelThreads > 0 );
	nMaxThreads = pParallelThreads;
ELSE;
	nMaxThreads = 1;
ENDIF;

# Validate Mapping parameter

IF( pDimDelim @= pEleStartDelim % pDimDelim @= pEleDelim % pEleStartDelim @= pEleDelim );
	sMessage = 'The delimiters cannot me the same.';
	nErrors = nErrors + 1;
	LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));
ENDIF;

# Validate Mapping parameter

IF( Trim( pEleMapping ) @<> '' & Trim( pMappingDelim ) @= '' );
	nErrors = nErrors + 1;
	sMessage = 'Mapping Delimiter & Element Mapping can not both be empty.';
	LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));
ENDIF;

# Validate Sandbox

IF( Trim( pSandbox ) @<> '' );
	IF( ServerSandboxExists( pSandbox ) = 0 );
		SetUseActiveSandboxProperty( 0 );
		nErrors = nErrors + 1;
		sMessage = Expand( 'Sandbox %pSandbox% is invalid for the current user.' );
		LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));
	ELSE;
		ServerActiveSandboxSet( pSandbox );
		SetUseActiveSandboxProperty( 1 );
	ENDIF;
ELSE;
	SetUseActiveSandboxProperty( 0 );
ENDIF;

### Check for errors before continuing

IF( nErrors <> 0 );
	IF( pStrictErrorHandling = 1 );
		ProcessQuit;
	ELSE;
		ProcessBreak;
	ENDIF;
ENDIF;

########## pEleMapping ######################################################
### Split ElementMapping parameter and create variables to be substituted ###
################################################################################################# #############

sElementMapping = Trim( pEleMapping );
sMappingDelimiter = Trim( pMappingDelim );
sElementStartDelim = Trim( pEleStartDelim );
sDelimDim = Trim( pDimDelim );
sDecimalSeparator = Trim( pDecimalSeparator );
sThousandSeparator = Trim( pThousandSeparator );
sFilter = Trim( pFilter );
sTargetFilter = '';
nSuppressConsol = pSuppressConsol;
nChar = 1;
nCharCount = Long( sElementMapping );

# If there's no element mapping then the process can be used to multiply existing value by a factor

IF( nCharCount > 0 );
	sWord = '';
	sLastDelim = '';

	# Add a trailing element delimiter so that the last element is picked up

	IF( nCharCount > 0 );
		sElementMapping = sElementMapping | sMappingDelimiter;
		nCharCount = nCharCount + Long( sMappingDelimiter );
	ENDIF;
	WHILE( nChar <= nCharCount );
		sChar = SubSt( sElementMapping, nChar, 1 );

		# Used for delimiters, required for multiple character delimiters

		sDelim = '';
		nAddExtra = 0;

		# Ignore spaces

		IF( Trim( sChar ) @<> '' );

			### Dimension Name ###
			# If the delimiter is more than 1 character peek ahead the same amount
			# Ignore the first character

			sDelim = sChar;
			nCount = Long( sElementStartDelim ) - 1;
			IF( nCount > 0 & nChar + nCount <= nCharCount );

				# Add the extra characters

				sDelim = sDelim | SubSt( sElementMapping, nChar + 1, nCount );

				# Move to the end of the delimter

				nAddExtra = nCount;
			ENDIF;
			IF( sDelim @= sElementStartDelim );
				sChar = sDelim;
				IF( sLastDelim @<> '' & sLastDelim @<> sDelimDim );
					sMessage = Expand( 'The name of a dimension must follow a dimension delimiter %sDelimDim%' );
					nErrors = nErrors + 1;
					LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));

					#ProcessError();

				ENDIF;
				sDimension = sWord;
				IF( DimensionExists( sDimension ) = 0 );

					# The dimension does not exist in the model. Cancel process

					sMessage = Expand( 'Dimension: %sDimension% does not exist' );
					nErrors = nErrors + 1;
					LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));

					#ProcessError();

				ENDIF;

				# Check that the dimension is in the cube

				i = 1;
				iMax = 30;
				sDimInCube = 'No';
				WHILE( i <= iMax );
					sDimensionOfCube = TabDim( pCube, i );
					IF( sDimension @= sDimensionOfCube );
						sDimInCube = 'Yes';

						# record where the loop stops

						nIndex = i;
						i = 100;
					ELSE;
						i = i + 1;
					ENDIF;
				END;
				IF( sDimInCube @<> 'Yes' );

					# The dimension does not exist in the cube. Cancel process

					sMessage = Expand( 'Dimension %sDimension% does not exist in this cube' );
					nErrors = nErrors + 1;
					LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));

					#ProcessError();

				ENDIF;

				### Dimension exists so add it to the filters

				IF( Long( sFilter ) > 0 & sLastDelim @= '' );
					sTargetFilter = sFilter | sDelimDim | sDimension | sElementStartDelim;
					sFilter = sFilter | sDelimDim | sDimension | sElementStartDelim;
				ELSEIF( Long( sFilter ) > 0 & sLastDelim @<> '' );
					sFilter = sFilter | sDelimDim | sDimension | sElementStartDelim;
					sTargetFilter = sTargetFilter | sDelimDim | sDimension | sElementStartDelim;
				ELSE;
					sFilter = sDimension | sElementStartDelim;
					sTargetFilter = sDimension | sElementStartDelim;
				ENDIF;

				#Reset the source and target elements

				sSource = '';
				sTarget = '';

				# The variable nElementCount is used to keep track of how many elements there are per dimension
				# the first element is the source
				# the second element is the target
				# There shouldn't be any more than 2 elements per dimension
				# A new dimension has been found so reset the element count so
				# the code can tell how many elements have been specified for each dimension
				# There should just be 2

				nElementCount = 1;
				sLastDelim = sChar;

				# Clear the word

				sWord = '';
			ELSE;

				# Reset extra chars

				nAddExtra = 0;

				### Check both dim delimiter and element delimiter ###

				nIsDelimiter = 0;

				# Check dim delim
				# If the delimiter is more than 1 character peek ahead the same amount
				# Ignore the first character

				sDelim = sChar;
				nCount = Long( sDelimDim ) - 1;
				IF( nCount > 0 & nChar + nCount <= nCharCount );

					# Add the extra characters

					sDelim = sDelim | SubSt( sElementMapping, nChar + 1, nCount );

					# Move to the end of the delimter

					nAddExtra = nCount;
				ENDIF;
				IF( sDelim @= sDelimDim );
					nIsDelimiter = 1;
					sChar = sDelim;
				ELSE;

					# Reset extra chars

					nAddExtra = 0;

					## Check element delimiter
					# If the delimiter is more than 1 character peek ahead the same amount
					# Ignore the first character

					sDelim = sChar;
					nCount = Long( sMappingDelimiter ) - 1;
					IF( nCount > 0 & nChar + nCount <= nCharCount );

						# Add the extra characters

						sDelim = sDelim | SubSt( sElementMapping, nChar + 1, nCount );

						# Move to the end of the delimter

						nAddExtra = nCount;
					ENDIF;
					IF( sDelim @= sMappingDelimiter );
						nIsDelimiter = 1;
						sChar = sDelim;
					ELSE;

						# Reset extra chars

						nAddExtra = 0;
					ENDIF;
				ENDIF;
				IF( nIsDelimiter = 1 );
					IF( sLastDelim @= '' % sLastDelim @= sDelimDim );
						sMessage = 'An element start delimiter must follow a dimension name: ' | sChar | ' (' | NumberToString( nChar ) | ')';
						nErrors = nErrors + 1;
						LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));

						#ProcessError();

					ENDIF;

					# an element has been found!

					sElement = sWord;
					IF( DimIx( sDimension, sElement ) = 0 );

						# The element does not exist in the dimension. Cancel process

						sMessage = Expand( 'Element: %sElement% does not exist in dimension %sDimension%' );
						nErrors = nErrors + 1;
						LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));
					ENDIF;

					# Allow consolidations only if pSuppressConsol is not set to 1
					# Consolidations may be made allowable
					# so that you can copy strings between c levels
					# or copy from a consolidated source element to an n level target element

					### Check for errors before continuing

					IF( nErrors <> 0 );
						IF( pStrictErrorHandling = 1 );
							ProcessQuit;
						ELSE;
							ProcessBreak;
						ENDIF;
					ENDIF;
					IF( DType( sDimension, sElement ) @= 'C' );
						IF( nElementCount = 1 );
							IF( pSuppressConsol <> 1 );
								nSuppressConsol = 0;
							ENDIF;
							pSubN = 1;
						ELSE;
							sMessage = Expand( 'Target element: %sElement% for dimension %sDimension% is consolidated' );
							nErrors = nErrors + 1;
							LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));

							#ProcessBreak;

						ENDIF;
					ENDIF;

					# Add the element to the source or target depending on whether it's the first or the second element
					# Get principal name
					# in case source element and this element are using different aliases

					sElement = DimensionElementPrincipalName( sDimension, sElement );

					# first element

					IF( nElementCount = 1 );
						sSource = sElement;
						sFilter = sFilter | sElement;

						# second element

					ELSEIF( nElementCount = 2 );
						sTarget = sElement;
						sTargetFilter = sTargetFilter | sElement;
					ELSE;
						sMessage = Expand( 'There should only be 2 elements per dimension: %sDimension% , a source and a target' );
						nErrors = nErrors + 1;
						LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));

						#ProcessError();

					ENDIF;
					IF( nIndex = 1 );
						nMappedDim1 = 1;
						sSourceDim1 = sSource;
						sTargetDim1 = sTarget;
					ELSEIF( nIndex = 2 );
						nMappedDim2 = 1;
						sSourceDim2 = sSource;
						sTargetDim2 = sTarget;
					ELSEIF( nIndex = 3 );
						nMappedDim3 = 1;
						sSourceDim3 = sSource;
						sTargetDim3 = sTarget;
					ELSEIF( nIndex = 4 );
						nMappedDim4 = 1;
						sSourceDim4 = sSource;
						sTargetDim4 = sTarget;
					ELSEIF( nIndex = 5 );
						nMappedDim5 = 1;
						sSourceDim5 = sSource;
						sTargetDim5 = sTarget;
					ELSEIF( nIndex = 6 );
						nMappedDim6 = 1;
						sSourceDim6 = sSource;
						sTargetDim6 = sTarget;
					ELSEIF( nIndex = 7 );
						nMappedDim7 = 1;
						sSourceDim7 = sSource;
						sTargetDim7 = sTarget;
					ELSEIF( nIndex = 8 );
						nMappedDim8 = 1;
						sSourceDim8 = sSource;
						sTargetDim8 = sTarget;
					ELSEIF( nIndex = 9 );
						nMappedDim9 = 1;
						sSourceDim9 = sSource;
						sTargetDim9 = sTarget;
					ELSEIF( nIndex = 10 );
						nMappedDim10 = 1;
						sSourceDim10 = sSource;
						sTargetDim10 = sTarget;
					ELSEIF( nIndex = 11 );
						nMappedDim11 = 1;
						sSourceDim11 = sSource;
						sTargetDim11 = sTarget;
					ELSEIF( nIndex = 12 );
						nMappedDim12 = 1;
						sSourceDim12 = sSource;
						sTargetDim12 = sTarget;
					ELSEIF( nIndex = 13 );
						nMappedDim13 = 1;
						sSourceDim13 = sSource;
						sTargetDim13 = sTarget;
					ELSEIF( nIndex = 14 );
						nMappedDim14 = 1;
						sSourceDim14 = sSource;
						sTargetDim14 = sTarget;
					ELSEIF( nIndex = 15 );
						nMappedDim15 = 1;
						sSourceDim15 = sSource;
						sTargetDim15 = sTarget;
					ELSEIF( nIndex = 16 );
						nMappedDim16 = 1;
						sSourceDim16 = sSource;
						sTargetDim16 = sTarget;
					ELSEIF( nIndex = 17 );
						nMappedDim17 = 1;
						sSourceDim17 = sSource;
						sTargetDim17 = sTarget;
					ELSEIF( nIndex = 18 );
						nMappedDim18 = 1;
						sSourceDim18 = sSource;
						sTargetDim18 = sTarget;
					ELSEIF( nIndex = 19 );
						nMappedDim19 = 1;
						sSourceDim19 = sSource;
						sTargetDim19 = sTarget;
					ELSEIF( nIndex = 20 );
						nMappedDim20 = 1;
						sSourceDim20 = sSource;
						sTargetDim20 = sTarget;
					ELSEIF( nIndex = 21 );
						nMappedDim21 = 1;
						sSourceDim21 = sSource;
						sTargetDim21 = sTarget;
					ELSEIF( nIndex = 22 );
						nMappedDim22 = 1;
						sSourceDim22 = sSource;
						sTargetDim22 = sTarget;
					ELSEIF( nIndex = 23 );
						nMappedDim23 = 1;
						sSourceDim23 = sSource;
						sTargetDim23 = sTarget;
					ELSEIF( nIndex = 24 );
						nMappedDim24 = 1;
						sSourceDim24 = sSource;
						sTargetDim24 = sTarget;
					ELSEIF( nIndex = 25 );
						nMappedDim25 = 1;
						sSourceDim25 = sSource;
						sTargetDim25 = sTarget;
					ELSEIF( nIndex = 26 );
						nMappedDim26 = 1;
						sSourceDim26 = sSource;
						sTargetDim26 = sTarget;
					ELSEIF( nIndex = 27 );
						nMappedDim27 = 1;
						sSourceDim27 = sSource;
						sTargetDim27 = sTarget;
					ENDIF;
					sLastDelim = sChar;

					# Clear the word

					sWord = '';
					nElementCount = nElementCount + 1;
				ELSE;
					sWord = sWord | sChar;
				ENDIF;
			ENDIF;
		ENDIF;
		nChar = nChar + nAddExtra + 1;
	END;
ENDIF;

### Check that there if a dimension is used, there is a source element and a target element

cSourceVariableStem = 'sSourceDim';
cTargetVariableStem = 'sTargetDim';
cMappedDimVariableStem = 'nMappedDim';
nCounter = 1;
WHILE( nCounter <= nDimensionCount );
	sMappedDimVariable = 'nMappedDim ' | NumberToString( nCounter );
	sDimensionUsedPadded = Expand( '%' | sMappedDimVariable | '%' );
	nMappedDim = StringToNumber( Trim( sDimensionUsedPadded ));
	IF( nMappedDim = 1 );
		sDim = TabDim( pCube, nCounter );
		sSourceVariable = cSourceVariableStem | NumberToString( nCounter );
		sSourcePadded = Expand( '%' | sSourceVariable | '%' );
		sSource = Trim( sSourcePadded );
		sTargetVariable = cTargetVariableStem | NumberToString( nCounter );
		sTargetPadded = Expand( '%' | sTargetVariable | '%' );
		sTarget = Trim( sTargetPadded );
		IF( sSource @= '' % sTarget @= '' );
			sMessage = 'Source and/or target element is blank for dimension ' | sDim;
			nErrors = nErrors + 1;
			LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));

			#ProcessError();

		ENDIF;
	ENDIF;
	nCounter = nCounter + 1;
END;

### Check for errors before continuing

IF( nErrors <> 0 );
	DataSourceType = 'NULL';
	IF( pStrictErrorHandling = 1 );
		ProcessQuit;
	ELSE;
		ProcessBreak;
	ENDIF;
ENDIF;

# Branch depending on whether to do recursive calls to self on independent threads or run all in this thread

IF( Scan( pEleStartDelim, pFilterParallel ) > 0 );
	sDimParallel = SubSt( pFilterParallel, 1, Scan( pEleStartDelim, pFilterParallel ) - 1 );
	sElementList = SubSt( pFilterParallel, Scan( pEleStartDelim, pFilterParallel ) + Long( pEleStartDelim ), 
		Long( pFilterParallel ));
	IF( SubSt( sElementList, Long( sElementList ), 1 ) @<> pEleDelim );
		sElementList = sElementList | pEleDelim;
	ENDIF;

	## Counting elements in element list

	sElementListCount = sElementList;
	nElements = 0;
	WHILE( Scan( pEleDelim, sElementListCount ) > 0 );
		nElements = nElements + 1;
		sElementListCount = SubSt( sElementListCount, Scan( pEleDelim, sElementListCount ) + Long( pEleDelim ), Long( sElementListCount ));
	END;
	IF( Mod( nElements, nMaxThreads ) = 0 );
		nElemsPerThread = Int( nElements / nMaxThreads );
	ELSE;
		nElemsPerThread = Int( nElements / nMaxThreads ) + 1;
	ENDIF;
	nThreadElCounter = 0;
	nThreads = 0;
	WHILE( Scan( pEleDelim, sElementList ) > 0 );
		sSlicerEle = SubSt( sElementList, 1, Scan( pEleDelim, sElementList ) - 1 );
		sElementList = SubSt( sElementList, Scan( pEleDelim, sElementList ) + Long( pEleDelim ), Long( sElementList ));

		# Do recursive process call with new RunProcess function

		nThreadElCounter = nThreadElCounter + 1;
		sDimDelim = IF( pFilter @= '', '', pDimDelim );
		IF( nThreadElCounter = 1 );
			sFilter = Expand( '%pFilter%%sDimDelim%%sDimParallel%%pEleStartDelim%%sSlicerEle%' );
		ELSE;
			sFilter = Expand( '%sFilter%%pEleDelim%%sSlicerEle%' );
		ENDIF;
		IF( nThreadElCounter >= nElemsPerThread );
			nThreadID = Int( Rand(  ) * 10000 + 1 ) + Numbr( cTimeStamp );
			sThreadControlFile = Lower( GetProcessName(  ) | '_ThreadControlFile_' | cRandomInt | '_' | NumberToString( nThreadID ) | '_' | cTimeStamp );
			LogOutput( 'INFO', 'Executing subTI with Thread ID: ' | NumberToString( nThreadID ));
			RunProcess( cThisProcName, 'pLogoutput', pLogoutput, 'pCube', pCube, 'pSrcView', pSrcView, 
				'pTgtView', pTgtView, 'pFilter', sFilter, 'pFilterParallel', '', 'pEleMapping', pEleMapping, 
				'pMappingDelim', pMappingDelim, 'pDimDelim', pDimDelim, 'pEleStartDelim', pEleStartDelim, 
				'pEleDelim', pEleDelim, 'pFactor', pFactor, 'pSuppressConsol', pSuppressConsol, 'pSuppressConsolStrings', 
				pSuppressConsolStrings, 'pSuppressRules', pSuppressRules, 'pSuppressZero', pSuppressZero, 
				'pCumulate', pCumulate, 'pZeroTarget', pZeroTarget, 'pZeroSource', pZeroSource, 'pTemp', 
				pTemp, 'pCubeLogging', pCubeLogging, 'pSandbox', pSandbox, 'pFile', pFile, 'pDecimalSeparator', 
				pDecimalSeparator, 'pThousandSeparator', pThousandSeparator, 'pThreadMode', 1, 'pThreadControlFile', 
				sThreadControlFile );
			nThreadElCounter = 0;
			sFilter = '';
			nThreads = nThreads + 1;
		ENDIF;
	END;

	## Process last elements - only when filter is not empty (there are still elements)

	IF( sFilter @<> '' );
		RunProcess( cThisProcName, 'pLogoutput', pLogoutput, 'pCube', pCube, 'pSrcView', pSrcView, 
			'pTgtView', pTgtView, 'pFilter', sFilter, 'pFilterParallel', '', 'pEleMapping', pEleMapping, 
			'pMappingDelim', pMappingDelim, 'pDimDelim', pDimDelim, 'pEleStartDelim', pEleStartDelim, 
			'pEleDelim', pEleDelim, 'pFactor', pFactor, 'pSuppressConsol', pSuppressConsol, 'pSuppressConsolStrings', 
			pSuppressConsolStrings, 'pSuppressRules', pSuppressRules, 'pSuppressZero', pSuppressZero, 
			'pCumulate', pCumulate, 'pZeroTarget', pZeroTarget, 'pZeroSource', pZeroSource, 'pTemp', 
			pTemp, 'pCubeLogging', pCubeLogging, 'pSandbox', pSandbox, 'pFile', pFile, 'pDecimalSeparator', 
			pDecimalSeparator, 'pThousandSeparator', pThousandSeparator, 'pThreadMode', 1, 'pThreadControlFile', 
			sThreadControlFile );
	ENDIF;
	DataSourceType = 'NULL';
	Sleep( 1000 );
ELSE;
	IF( pThreadControlFile @<> '' );
		LogOutput( 'info', 'creating thread file ' | cDir | pThreadControlFile | '.txt' );
		AsciiOutput( cDir | pThreadControlFile | '.txt', '' );
	ENDIF;

	### Create View of target to zero out
	### Check that there's something in sTargetFilter so the cube doesn't accidentally get wiped out

	IF( pZeroTarget = 1 & Long( sTargetFilter ) > 0 );
		sProc = '}bedrock.cube.data.clear';
		nRet = ExecuteProcess( sProc, 
			'pLogOutput', pLogOutput, 
			'pStrictErrorHandling', pStrictErrorHandling, 
			'pCube', pCube, 
			'pView', cViewTarget, 
			'pFilter', sTargetFilter, 
			'pDimDelim', pDimDelim, 
			'pEleStartDelim', pEleStartDelim, 
			'pEleDelim', pEleDelim, 
			'pCubeLogging', pCubeLogging, 
			'pTemp', pTemp, 
			'pSandbox', pSandbox );
		IF( nRet <> 0 );
			sMessage = 'Error clearing the target view.';
			nErrors = nErrors + 1;
			LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));
			IF( pStrictErrorHandling = 1 );
				ProcessQuit;
			ELSE;
				ProcessBreak;
			ENDIF;
		ENDIF;
	ENDIF;
	IF( pCubeLogging <= 1 );
		sCubeLogging = CellGetS( '}CubeProperties', pCube, 'LOGGING' );
		CubeSetLogChanges( pCube, pCubeLogging );
	ENDIF;
	IF( pFile = 0 );

		### Create View of Source ###

		nRet = ExecuteProcess( '}bedrock.cube.view.create', 
			'pLogOutput', pLogOutput, 
			'pStrictErrorHandling', pStrictErrorHandling, 
			'pCube', pCube, 
			'pView', cViewSource, 
			'pFilter', sFilter, 
			'pSuppressZero', pSuppressZero, 
			'pSuppressConsol', nSuppressConsol, 
			'pSuppressRules', pSuppressRules, 
			'pSuppressConsolStrings', pSuppressConsolStrings, 
			'pDimDelim', pDimDelim, 
			'pEleStartDelim', pEleStartDelim, 
			'pEleDelim', pEleDelim, 
			'pTemp', pTemp, 
			'pSubN', pSubN );
		IF( nRet <> 0 );
			sMessage = 'Error creating the view from the filter.';
			nErrors = nErrors + 1;
			LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));
			IF( pStrictErrorHandling = 1 );
				ProcessQuit;
			ELSE;
				ProcessBreak;
			ENDIF;
		ENDIF;

		### Assign Datasource ###

		DataSourceType = 'VIEW';
		DataSourceNameForServer = pCube;
		DataSourceNameForClient = pCube;
		DataSourceCubeView = cViewSource;
		nThreadMode = 1;
	ELSE;

		### Export Data to file ###

		nRet = ExecuteProcess( '}bedrock.cube.data.export', 
			'pLogoutput', pLogOutput, 
			'pStrictErrorHandling', pStrictErrorHandling, 
			'pCube', pCube, 
			'pView', cViewSource, 
			'pFilter', sFilter, 
			'pFilterParallel', '', 
			'pParallelThreads', 0, 
			'pDimDelim', pDimDelim, 
			'pEleStartDelim', pEleStartDelim, 
			'pEleDelim', pEleDelim, 
			'pSuppressZero', pSuppressZero, 
			'pSuppressConsol', nSuppressConsol, 
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
			'pSandbox', pSandbox );
		IF( nRet <> 0 );
			sMessage = 'Error exporting data to file.';
			nErrors = nErrors + 1;
			LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));
			IF( pStrictErrorHandling = 1 );
				ProcessQuit;
			ELSE;
				ProcessBreak;
			ENDIF;
		ENDIF;
		IF( FileExists( cFile ) = 0 );

			# If the file does not exist, it means that nothing got exported, so there is nothing to import

			IF( pLogoutput = 1 );
				LogOutput( 'INFO', Expand( 'Process:%cThisProcName% is skipping import as export file %cFile% was not found.' ));
			ENDIF;
			DataSourceType = 'NULL';
		ELSE;

			### Assign Datasource ###

			DataSourceType = 'CHARACTERDELIMITED';
			DataSourceNameForServer = cFile;
			DataSourceNameForClient = cFile;
			DataSourceAsciiHeaderRecords = cTitleRows;
			DataSourceAsciiDelimiter = cDelimiter;
			DataSourceAsciiQuoteCharacter = cQuote;
		ENDIF;
		nThreadMode = 1;
	ENDIF;
ENDIF;

### End Prolog ###


573,3
#****Begin: Generated Statements***
#****End: Generated Statements****

574,456
#****Begin: Generated Statements***
#****End: Generated Statements****


#################################################################################################
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
#################################################################################################

If( pFile > 0 );
  v0 = v1; v1 = v2; v2 = v3;  v3 = v4; v4 = v5; v5 = v6; v6 = v7; v7 = v8; v8 = v9; v9 = v10; v10 = v11; v11 = v12; v12 = v13; v13 = v14; v14 = v15;
  v15 = v16; v16 = v17; v17 = v18; v18 = v19; v19 = v20; v20 = v21; v21 = v22; v22 = v23; v23 = v24; v24 = v25; v25 = v26; v26 = v27; v27 = v28;  v28 = v29;
EndIf;

v1 = IF(nMappedDim1 = 1, IF(v1 @= sSourceDim1 % elisanc(sDim1,sSourceDim1,v1)=1, sTargetDim1, v1), v1);
v2 = IF(nMappedDim2 = 1, IF(v2 @= sSourceDim2 % elisanc(sDim2,sSourceDim2,v2)=1, sTargetDim2, v2), v2);
v3 = IF(nMappedDim3 = 1, IF(v3 @= sSourceDim3 % elisanc(sDim3,sSourceDim3,v3)=1, sTargetDim3, v3), v3);
v4 = IF(nMappedDim4 = 1, IF(v4 @= sSourceDim4 % elisanc(sDim4,sSourceDim4,v4)=1, sTargetDim4, v4), v4);
v5 = IF(nMappedDim5 = 1, IF(v5 @= sSourceDim5 % elisanc(sDim5,sSourceDim5,v5)=1, sTargetDim5, v5), v5);
v6 = IF(nMappedDim6 = 1, IF(v6 @= sSourceDim6 % elisanc(sDim6,sSourceDim6,v6)=1, sTargetDim6, v6), v6);
v7 = IF(nMappedDim7 = 1, IF(v7 @= sSourceDim7 % elisanc(sDim7,sSourceDim7,v7)=1, sTargetDim7, v7), v7);
v8 = IF(nMappedDim8 = 1, IF(v8 @= sSourceDim8 % elisanc(sDim8,sSourceDim8,v8)=1, sTargetDim8, v8), v8);
v9 = IF(nMappedDim9 = 1, IF(v9 @= sSourceDim9 % elisanc(sDim9,sSourceDim9,v9)=1, sTargetDim9, v9), v9);
v10 = IF(nMappedDim10 = 1, IF(v10 @= sSourceDim10 % elisanc(sDim10,sSourceDim10,v10)=1, sTargetDim10, v10), v10);
v11 = IF(nMappedDim11 = 1, IF(v11 @= sSourceDim11 % elisanc(sDim11,sSourceDim11,v11)=1, sTargetDim11, v11), v11);
v12 = IF(nMappedDim12 = 1, IF(v12 @= sSourceDim12 % elisanc(sDim12,sSourceDim12,v12)=1, sTargetDim12, v12), v12);
v13 = IF(nMappedDim13 = 1, IF(v13 @= sSourceDim13 % elisanc(sDim13,sSourceDim13,v13)=1, sTargetDim13, v13), v13);
v14 = IF(nMappedDim14 = 1, IF(v14 @= sSourceDim14 % elisanc(sDim14,sSourceDim14,v14)=1, sTargetDim14, v14), v14);
v15 = IF(nMappedDim15 = 1, IF(v15 @= sSourceDim15 % elisanc(sDim15,sSourceDim15,v15)=1, sTargetDim15, v15), v15);
v16 = IF(nMappedDim16 = 1, IF(v16 @= sSourceDim16 % elisanc(sDim16,sSourceDim16,v16)=1, sTargetDim16, v16), v16);
v17 = IF(nMappedDim17 = 1, IF(v17 @= sSourceDim17 % elisanc(sDim17,sSourceDim17,v17)=1, sTargetDim17, v17), v17);
v18 = IF(nMappedDim18 = 1, IF(v18 @= sSourceDim18 % elisanc(sDim18,sSourceDim18,v18)=1, sTargetDim18, v18), v18);
v19 = IF(nMappedDim19 = 1, IF(v19 @= sSourceDim19 % elisanc(sDim19,sSourceDim19,v19)=1, sTargetDim19, v19), v19);
v20 = IF(nMappedDim20 = 1, IF(v20 @= sSourceDim20 % elisanc(sDim20,sSourceDim20,v20)=1, sTargetDim20, v20), v20);
v21 = IF(nMappedDim21 = 1, IF(v21 @= sSourceDim21 % elisanc(sDim21,sSourceDim21,v21)=1, sTargetDim21, v21), v21);
v22 = IF(nMappedDim22 = 1, IF(v22 @= sSourceDim22 % elisanc(sDim22,sSourceDim22,v22)=1, sTargetDim22, v22), v22);
v23 = IF(nMappedDim23 = 1, IF(v23 @= sSourceDim23 % elisanc(sDim23,sSourceDim23,v23)=1, sTargetDim23, v23), v23);
v24 = IF(nMappedDim24 = 1, IF(v24 @= sSourceDim24 % elisanc(sDim23,sSourceDim24,v24)=1, sTargetDim24, v24), v24);
v25 = IF(nMappedDim25 = 1, IF(v25 @= sSourceDim25 % elisanc(sDim25,sSourceDim25,v25)=1, sTargetDim25, v25), v25);
v26 = IF(nMappedDim26 = 1, IF(v26 @= sSourceDim26 % elisanc(sDim26,sSourceDim26,v26)=1, sTargetDim26, v26), v26);
v27 = IF(nMappedDim27 = 1, IF(v27 @= sSourceDim27 % elisanc(sDim27,sSourceDim27,v27)=1, sTargetDim27, v27), v27);


### Write data from source version to target version ###

# Selects the correct CellPut formula depending upon the number of dimensions in the cube
# and whether the value is numeric or string ( max 27 dims catered for in this code )
# value type determined by element type of last dimension in cube
# could have used Value_is_String = 1 and NValue/SValue but this works just as well


If( nDimensionCount = 2 );
    If( CellIsUpdateable( pCube, v1, v2 ) = 1 );
        sElType = DType( sDim2, v2 );
        IF( SubSt( pCube, 1, 17 ) @= '}ElementSecurity_');
            v3 = IF( v3 @= '', 'NONE', v3 );
            ElementSecurityPut( v3, sDim1, v1, v2 );
        ELSEIF( sElType @= 'AA' );
            AttrPutS( v3, sDim1, v1, v2, 1 );
        ELSEIF( sElType @= 'AS' );
            AttrPutS( v3, sDim1, v1, v2 );
        ELSEIF( sElType @= 'AN' );
            AttrPutN( StringToNumberEx( v3, sDecimalSeparator, sThousandSeparator ) * nFactor, sDim1, v1, v2 );
        ElseIf( sElType @= 'S' );
            CellPutS( v3, pCube, v1, v2 );
        Else;
            IF( pCumulate = 1);
                nObal = CellGetN( pCube, v1, v2 );
                nCbal = nObal + StringToNumberEx( v3, sDecimalSeparator, sThousandSeparator ) * nFactor;
            ELSE;
                nCbal = StringToNumberEx( v3, sDecimalSeparator, sThousandSeparator ) * nFactor;
            Endif;
            CellPutN( nCbal, pCube, v1, v2 );
        EndIf;
    EndIf;
ElseIf( nDimensionCount = 3 );
    If( CellIsUpdateable( pCube, v1, v2, v3 ) = 1 );
        sElType = DType( sDim3, v3 );
        If( sElType @<> 'S' );
            IF( pCumulate = 1);
                nObal = CellGetN( pCube, v1, v2, v3 );
                nCbal = nObal + StringToNumberEx( v4, sDecimalSeparator, sThousandSeparator ) * nFactor;
            ELSE;
                nCbal = StringToNumberEx( v4, sDecimalSeparator, sThousandSeparator ) * nFactor;
            Endif;
            CellPutN( nCbal, pCube, v1, v2, v3 );
        Else;
            CellPutS( v4, pCube, v1, v2, v3 );
        EndIf;
    EndIf;
ElseIf( nDimensionCount = 4 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4 ) = 1 );
        sElType = DType( sDim4, v4 );
        If( sElType @<> 'S' );
            IF( pCumulate = 1);
                nObal = CellGetN( pCube, v1, v2, v3, v4);
                nCbal = nObal + StringToNumberEx( v5, sDecimalSeparator, sThousandSeparator ) * nFactor;
            ELSE;
                nCbal = StringToNumberEx( v5, sDecimalSeparator, sThousandSeparator ) * nFactor;
            Endif;
            CellPutN( nCbal, pCube, v1, v2, v3, v4);
        Else;
            CellPutS( v5, pCube, v1, v2, v3, v4);
        EndIf;
    EndIf;
ElseIf( nDimensionCount = 5 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5 ) = 1 );
      sElType = DType( sDim5, v5 );
      If( sElType @<> 'S' );
        IF(pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5 );
          nCbal = nObal + StringToNumberEx( v6, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v6, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5 );
      Else;
        CellPutS( v6, pCube, v1, v2, v3, v4, v5 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 6 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6 ) = 1 );
      sElType = DType( sDim6, v6 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6 );
          nCbal = nObal + StringToNumberEx( v7, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v7, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6 );
      Else;
        CellPutS( v7, pCube, v1, v2, v3, v4, v5, v6 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 7 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7 ) = 1 );
      sElType = DType( sDim7, v7 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7 );
          nCbal = nObal + StringToNumberEx( v8, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v8, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7 );
      Else;
        CellPutS( v8, pCube, v1, v2, v3, v4, v5, v6, v7 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 8 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8 ) = 1 );
      sElType = DType( sDim8, v8 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8 );
          nCbal = nObal + StringToNumberEx( v9, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v9, sDecimalSeparator, sThousandSeparator )* nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8 );
      Else;
        CellPutS( v9, pCube, v1, v2, v3, v4, v5, v6, v7, v8 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 9 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9 ) = 1 );
      sElType = DType( sDim9, v9 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9 );
          nCbal = nObal + StringToNumberEx( v10, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v10, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9 );
      Else;
        CellPutS( v10, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 10 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 ) = 1 );
      sElType = DType( sDim10, v10 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 );
          nCbal = nObal + StringToNumberEx( v11, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v11, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 );
      Else;
        CellPutS( v11, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 11 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 ) = 1 );
      sElType = DType( sDim11, v11 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 );
          nCbal = nObal + StringToNumberEx( v12, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v12, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 );
      Else;
        CellPutS( v12, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 12 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 ) = 1 );
      sElType = DType( sDim12, v12 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 );
          nCbal = nObal + StringToNumberEx( v13, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v13, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 );
      Else;
        CellPutS( v13, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 13 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 ) = 1 );
      sElType = DType( sDim13, v13 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 );
          nCbal = nObal + StringToNumberEx( v14, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v14, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 );
      Else;
        CellPutS( v14, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 14 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 ) = 1 );
      sElType = DType( sDim14, v14 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 );
          nCbal = nObal + StringToNumberEx( v15, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v15, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 );
      Else;
        CellPutS( v15, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 15 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 ) = 1 );
      sElType = DType( sDim15, v15 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 );
          nCbal = nObal + StringToNumberEx( v16, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v16, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 );
      Else;
        CellPutS( v16, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 16 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 ) = 1 );
      sElType = DType( sDim16, v16 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 );
          nCbal = nObal + StringToNumberEx( v17, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v17, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 );
      Else;
        CellPutS( v17, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 17 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 ) = 1 );
      sElType = DType( sDim17, v17 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 );
          nCbal = nObal + StringToNumberEx( v18, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v18, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 );
      Else;
        CellPutS( v18, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 18 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 ) = 1 );
      sElType = DType( sDim18, v18 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 );
          nCbal = nObal + StringToNumberEx( v19, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v19, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 );
      Else;
        CellPutS( v19, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 19 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 ) = 1 );
      sElType = DType( sDim19, v19 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 );
          nCbal = nObal + StringToNumberEx( v20, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v20, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 );
      Else;
        CellPutS( v20, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 20 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 ) = 1 );
      sElType = DType( sDim20, v20 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 );
          nCbal = nObal + StringToNumberEx( v21, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v21, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 );
      Else;
        CellPutS( v21, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 21 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 ) = 1 );
      sElType = DType( sDim21, v21 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 );
          nCbal = nObal + StringToNumberEx( v22, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v22, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 );
      Else;
        CellPutS( v22, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 22 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 ) = 1 );
      sElType = DType( sDim22, v22 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 );
          nCbal = nObal + StringToNumberEx( v23, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v23, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 );
      Else;
        CellPutS( v23, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 23 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21,
    v22, v23 ) = 1 );
      sElType = DType( sDim23, v23 );
      If( sElType @<> 'S' );
        IF( pCumulate >= 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 );
          nCbal = nObal + StringToNumberEx( v24, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v24, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 );
      Else;
        CellPutS( v24, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 24 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24 ) = 1 );
      sElType = DType( sDim24, v24 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24 );
          nCbal = nObal + StringToNumberEx( v25, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v25, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24 );
      Else;
        CellPutS( v25, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 25 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25 ) = 1 );
      sElType = DType( sDim25, v25 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25 );
          nCbal = nObal + StringToNumberEx( v26, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v26, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25 );
      Else;
        CellPutS( v26, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25 );
      EndIf;
    EndIf;
ElseIf( nDimensionCount = 26 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21,
    v22, v23, v24, v25, v26 ) = 1 );
      sElType = DType( sDim26, v26 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26 );
          nCbal = nObal + StringToNumberEx( v27, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v27, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26 );
      Else;
        CellPutS( v27, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26 );
      EndIf;
    EndIf;
ElseIf( nDimensionCount = 27 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27 ) = 1 );
      sElType = DType( sDim27, v27 );
      If( sElType @<> 'S' );
        IF( pCumulate >= 1);
          nObal = CellGetN( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27 );
          nCbal = nObal + StringToNumberEx( v28, sDecimalSeparator, sThousandSeparator ) * nFactor;
        ELSE;
          nCbal = StringToNumberEx( v28, sDecimalSeparator, sThousandSeparator ) * nFactor;
        Endif;
        CellPutN( nCbal, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27 );
      Else;
        CellPutS( v28, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27 );
      EndIf;
    EndIf;

  EndIf;


### End Data ###
575,95
#****Begin: Generated Statements***
#****End: Generated Statements****

#################################################################################################
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
#################################################################################################
# Zero out source cube #

IF( pZeroSource = 1 & nErrors = 0 );
	sProc = '}bedrock.cube.data.clear';
	nRet = ExecuteProcess( sProc, 
		'pLogOutput', pLogOutput, 
		'pStrictErrorHandling', pStrictErrorHandling, 
		'pCube', pCube, 
		'pView', cViewSource, 
		'pFilter', sFilter, 
		'pDimDelim', pDimDelim, 
		'pEleStartDelim', pEleStartDelim, 
		'pEleDelim', pEleDelim, 
		'pTemp', pTemp, 
		'pCubeLogging', pCubeLogging, 
		'pSandbox', pSandbox );
	IF( nRet <> 0 );
		sMessage = 'Error clearing the source view.';
		nErrors = nErrors + 1;
		LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));
		ProcessError(  );
	ENDIF;
ENDIF;
IF( pCubeLogging <= 1 );
	CubeSetLogChanges( pCube, IF( sCubeLogging @= 'YES', 1, 0 ));
ENDIF;

### Delete export file if used

IF( pFile = 1 );
	IF( sOS @= 'Linux' );
		TM1RunCmd = 'rm "' | cFile | '"';
	ELSE;
		TM1RunCmd = 'CMD.EXE /C "DEL "' | cFile | '" "';
	ENDIF;
	ExecuteCommand( TM1RunCmd, 0 );
ENDIF;

### Delete thread control file if used

IF( pThreadControlFile @<> '' );
	LogOutput( 'INFO', 'Removing thread control file: ' | cDir | pThreadControlFile | '.txt' );
	IF( sOS @= 'Linux' );
		TM1RunCmd = 'rm "' | cDir | pThreadControlFile | '.txt' | '"';
	ELSE;
		TM1RunCmd = 'CMD.EXE /C "DEL "' | cDir | pThreadControlFile | '.txt' | '" "';
	ENDIF;
	ExecuteCommand( TM1RunCmd, 0 );
ENDIF;

### Wait for all parallel threads to finish if using pFilterParallel

IF( pFilterParallel @<> '' );
	sThreadFilePattern = LOWER(GetProcessName(  ) | '_ThreadControlFile_' | cRandomInt | '_' | '*.txt');
	LogOutput( 'INFO', 'Checking for: ' | sThreadFilePattern );
	i = 1;
	WHILE( i < pMaxWaitSeconds );
		sThreadCheck = WildcardFileSearch( cDir | sThreadFilePattern, '' );
		IF( sThreadCheck @<> '' );
			Sleep( 1000 );
		ELSE;
			BREAK;
		ENDIF;
		i = i + 1;
	END;
ENDIF;

### Return code & final error message handling

IF( nErrors > 0 );
	sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
	nProcessReturnCode = 0;
	LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ));
	sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
	IF( pStrictErrorHandling = 1 );
		ProcessQuit;
	ENDIF;
ELSE;
	sProcessAction = Expand( 'Process:%cThisProcName% successfully copied data from %pSrcView% view to the %pTgtView% view in the %pCube% cube.' );
	sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
	nProcessReturnCode = 1;
	IF( pLogoutput = 1 );
		LogOutput( 'INFO', Expand( sProcessAction ));
	ENDIF;
ENDIF;

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
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
