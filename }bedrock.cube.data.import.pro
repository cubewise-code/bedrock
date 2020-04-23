601,100
602,"}bedrock.cube.data.import"
562,"CHARACTERDELIMITED"
586,"C:\TM1\Bedrock\Data\Bedrock.Z.Cube.Placeholder.csv"
585,"C:\TM1\Bedrock\Data\Bedrock.Z.Cube.Placeholder.csv"
564,
565,"rLopyKY9XSa5crkmoda?JQUGj0JNRDa6DA:;Ad;ruL3sjUKGIrOuMRA:3CYeb0Ey?y^76LClsnpMV=^LASfl7r2EO@bBZMdHQQk[mkxVlqhsOTiAa[0dyyyPwUA\AVe>Xv?CLP:Y\gI@uE7O`k6Va2qLwWhWK3JdU=lkscJf<`o[VMF0cX?hNuwfcg^iyC7m9VZkoA]g"
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
569,2
592,0
599,1000
560,18
pLogOutput
pCube
pSrcDir
pSrcFile
pDim
pSrcEle
pTgtEle
pTitleRows
pDelim
pQuote
pCumulate
pCubeLogging
pSandbox
pZeroFilter
pMappingToNewDims
pDimDelim
pEleStartDelim
pEleDelim
561,18
1
2
2
2
2
2
2
1
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
590,18
pLogOutput,0
pCube,""
pSrcDir,""
pSrcFile,""
pDim,""
pSrcEle,""
pTgtEle,""
pTitleRows,1
pDelim,","
pQuote,""""
pCumulate,0
pCubeLogging,0
pSandbox,""
pZeroFilter,0
pMappingToNewDims,""
pDimDelim,"&"
pEleStartDelim,"¦"
pEleDelim,"+"
637,18
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pCube,"REQUIRED: Target Cube"
pSrcDir,"OPTIONAL: Source Directory (will default to error log path)"
pSrcFile,"OPTIONAL: Source File (will default to pCube_Export.csv )"
pDim,"OPTIONAL: Dimension"
pSrcEle,"OPTIONAL: Source Element ( Only required if a Dimension is used.)"
pTgtEle,"OPTIONAL: Target Element (Only required if Dimension is used.)"
pTitleRows,"REQUIRED: Number of Title Rows to Skip"
pDelim,"REQUIRED: AsciiOutput delimiter character (Default=comma, exactly 3 digits = ASCII code)"
pQuote,"REQUIRED: Quote (Accepts empty quote, exactly 3 digits = ASCII code)"
pCumulate,"REQUIRED: Accumulate Amounts (0 = Overwrite values, 1 = Accumulate values)"
pCubeLogging,"Required: Cube Logging (0 = No transaction logging, 1 = Logging of transactions, 2 = Ignore Cube Logging - No Action Taken)"
pSandbox,"OPTIONAL: To use sandbox not base data enter the sandbox name (invalid name will result in process error)"
pZeroFilter,"OPTIONAL: Source file includes Zero out filter (0=No filter line in source file, 1=Ignore filter line, 2=Perform ZeroOut using filter line)"
pMappingToNewDims,"REQUIRED IF TARGET HAS DIMS NOT IN SOURCE: DimX¦InputElementForDimX & DimY¦InputElementForDimY (specify an N level element for each new dim)"
pDimDelim,"OPTIONAL. Delimiter for start of Dimension/Element set"
pEleStartDelim,"OPTIONAL: Delimiter for start of element list"
pEleDelim,"OPTIONAL: Delimiter between elements"
577,30
v1
v2
v3
v4
v5
v6
v7
v8
v9
v10
v11
v12
v13
v14
v15
v16
v17
v18
v19
v20
v21
v22
v23
v24
v25
v26
v27
v28
v29
v30
578,30
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
579,30
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
580,30
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
581,30
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
582,30
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
572,915
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.cube.data.import', 'pLogOutput', pLogOutput,
    	'pCube', '', 'pSrcDir', '', 'pSrcFile', '',
    	'pDim', '', 'pSrcEle', '', 'pTgtEle', '',
    	'pTitleRows', 1, 'pDelim', ',', 'pQuote', '"',
    	'pCumulate', 0, 'pCubeLogging', 0, 'pSandbox', pSandbox, 'pZeroFilter', 0, 
    	'pMappingToNewDims','', 'pDimDelim', '&', 'pEleStartDelim', '¦', 'pEleDelim', '+'
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
# This process will load a csv text file to the target cube.

# Use case: Intended for development/prototyping or in Production environment.
#1/ Import data from another TM1 model.
#2/ To eliminate possibility of locking it is sometimes better to export and import when needing to copy data from one cube to another.

# Note:
# Naturally, a valid target cube name (pCube) is mandatory otherwise the process will abort.
# Element mapping for new dimensions (pMappingToNewDims ) is also required when the target cube has more dimensions than the source, otherwise the process will abort.
# The default input path is the same as the error file path if not specified.
# If the file name is left blank, the process will look for a file called pCube_Export.csv.

# Format:
# The assumed file format is as per standard CMA export:
# - v1 specIfies cube name, subsequent fields specify cube address ( individual element names ).
# - vN specIfies cell data value to load. With provision for files with header rows.
# Format of filter row for Zero out:
# - v1 specifies source cube name
# - v2 must be equal to "Filter".
# - v3 specifies the filter to be used to zero out. Please note if target cube has additional dimensions this is the final filter used if pMappingToNewDims is not speficied. All the elements in additional dimensions will be cleaned 
# - v4 specifies the dimension delimiter used in filter
# - v5 specifies the element start delimiter used in filter
# - v6 specifies the element delimiter used in filter
# Note about the Zero out:
# if pMappingToNewDims parameter is specified, it will be concatenated to the filter in the file to restict the cube slice to be zeroed out. Similarly, if pDim is specified the source element is substituted with the targed one, sould it be in the filter string
# in both cases the delimiters in the source file must match the delimiters passed in parameters of this process.
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName     = GetProcessName();
cUserName         = TM1User();
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cTempSub          = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pSrcDir:%pSrcDir%, pSrcFile:%pSrcFile%, pCube:%pCube%, pDim:%pDim%, pSrcEle:%pSrcEle%, pTgtEle:%pTgtEle%, pTitleRows:%pTitleRows%, pDelim:%pDelim%, pQuote:%pQuote%, pCumulate:%pCumulate%, pCubeLogging:%pCubeLogging%, pSandbox:%pSandbox%, pZeroFilter:%pZeroFilter%, pMappingToNewDims:%pMappingToNewDims%, pDimDelim:%pDimDelim%, pEleStartDelim:%pEleStartDelim%, pEleDelim:%pEleDelim%.';   
cLenASCIICode = 3;

pDelimiter        = TRIM(pDelim);
sDelimDim           = TRIM(pDimDelim);
sElementStartDelim  = TRIM(pElEStartDelim);
sDelimElem          = TRIM(pEleDelim);

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

nRecordProcessedCount   = 0;
nRecordPostedCount      = 0;
nErrors                 = 0;


### Validate Parameters ###
pSourceDir    = TRIM(pSrcDir);
pSourceFile   = TRIM(pSrcFile);

## check operating system
If( Scan('/', GetProcessErrorFileDirectory)>0);
#  sOS = 'Linux';
  sOSDelim = '/';
Else;
#  sOS = 'Windows';
  sOSDelim = '\';
EndIf;

# Validate source directory
If(Trim( pSourceDir ) @= '' );
    pSourceDir = GetProcessErrorFileDirectory;
ElseIf( FileExists( pSourceDir ) = 0 );
  sMessage = 'Invalid source directory specified: folder does not exist.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

If( SubSt( pSourceDir, Long( pSourceDir ) - 1, 1 ) @= sOSDelim );
  pSourceDir = SubSt( pSourceDir, 1, Long( pSourceDir ) - 1 );
EndIf;

If( pSourceFile @= '' );
    pSourceFile = Expand('%pCube%_Export.csv');
EndIf;

sFile = pSourceDir | sOSDelim | pSourceFile;
# Validate source file
If( FileExists( sFile ) = 0 );
  sMessage = 'Invalid source file specified: file does not exist in directory:' | sFile;
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate cube
If( Trim( pCube ) @= '' );
  sMessage = 'No target cube specified.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( CubeExists( pCube ) = 0 );
  sMessage = 'Invalid target cube specified: ' | pCube;
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate file delimiter & quote character
If( pDelimiter @= '' );
    pDelimiter = ',';
Else;
    # If length of pDelimiter is exactly 3 chars and each of them is decimal digit, then the pDelimiter is entered as ASCII code
    nValid = 0;
    If ( LONG(pDelimiter) = cLenASCIICode );
      nChar = 1;
      While ( nChar <= cLenASCIICode );
        If( CODE( pDelimiter, nChar )>=CODE( '0', 1 ) & CODE( pDelimiter, nChar )<=CODE( '9', 1 ) );
          nValid = 1;
        Else;
          nValid = 0;
        EndIf;
        nChar = nChar + 1;
      End;
    EndIf;
    If ( nValid<>0 );
      pDelimiter=CHAR(StringToNumber( pDelimiter ));
    Else;
      pDelimiter = SubSt( Trim( pDelimiter ), 1, 1 );
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

## Validate Dimension
pDimension      = TRIM( pDim);
pSourceElement  = TRIM(pSrcEle);
pTargetElement  = TRIM(pTgtEle);

IF( pDimension @<> '');
    
  IF( DimensionExists( pDimension ) = 0 );
    sMessage = 'Invalid dimension specified: ' | pDimension;
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  EndIf;

  # Validate Source Element
  If( pSourceElement @= '' );
    sMessage = 'Error: The Source Element parameter is blank.';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  EndIf;

  If( DIMIX( pDimension, pSourceElement ) = 0 );
    sMessage = 'Invalid source element, ' | pSourceElement | ' specified for ' | pDimension | ' dimension.';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  EndIf;
  sSourceElement = DimensionElementPrincipalName( pDimension, pSourceElement);

  # Validate Target Element
  If( pTargetElement @= '' );
    sMessage = 'Error: The Target Element parameter is blank.';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  ElseIf( DIMIX( pDimension, pTargetElement ) = 0 );
    sMessage = 'Invalid target element, ' | pTargetElement | ' specified for ' | pDimension | ' dimension.';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  EndIf;
  sTargetElement = DimensionElementPrincipalName( pDimension, pTargetElement);

ENDIF;

## Validate delimiter
pDelimiter = TRIM(pDelim);
If( pDelimiter @= '' );
  sMessage = 'Error: The file delimiter parameter is blank.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( Long( pDelimiter ) > 1 );
  sMessage = 'Invalid delimiter specified: ' | pDelimiter | ' field delimiter must be single character.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate quote character
If( pQuote @= '' );
  sMessage = 'Error: The quote charecter is blank.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( Long( pQuote ) > 1 );
  sMessage = 'Invalid string qualIfier: ' | pQuote | ' quote character must be single character.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
    ProcessBreak;
EndIf;

### Determine number of dims in target cube ###
nCount = 1;
nSubstututeDimensionIndex = 0;
While( 
TabDim( pCube, nCount ) @<> '' );
  sDimension = TabDim( pCube, nCount );
  If( sDimension @= pDimension );
    nSubstututeDimensionIndex = nCount;
  EndIf;
  nCount = nCount + 1;
End;
nDimensionCount = nCount - 1;

## Validate the dimension is part of the cube.
IF( pDimension @= '');
  ## CONTINUE;
ELSEIf( nSubstututeDimensionIndex = 0 );
    sMessage = 'Specified dimension: ' | pDimension | ' is not a component of the cube: ' | pCube;
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ENDIF;

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
        

If( nDimensionCount > 27 );
  sMessage = 'Cube has too many dimensions: ' | pCube | ' max 27 dimensions.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
    ProcessBreak;
EndIf;

### Determine dimensions in target cube, we need to know this to test cell type before loading ###
sDim1  = TabDim( pCube, 1 );
sDim2  = TabDim( pCube, 2 );
sDim3  = TabDim( pCube, 3 );
sDim4  = TabDim( pCube, 4 );
sDim5  = TabDim( pCube, 5 );
sDim6  = TabDim( pCube, 6 );
sDim7  = TabDim( pCube, 7 );
sDim8  = TabDim( pCube, 8 );
sDim9  = TabDim( pCube, 9 );
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

### Placeholders for mappped dimensions and for new dimensions

nMappedDim1 = 0;	sMappedV1 = '';		nNewDim1 = 0;	  sNewV1 = '';
nMappedDim2 = 0;	sMappedV2 = '';		nNewDim2 = 0;	  sNewV2 = '';
nMappedDim3 = 0;	sMappedV3 = '';		nNewDim3 = 0;	  sNewV3 = '';
nMappedDim4 = 0;	sMappedV4 = '';		nNewDim4 = 0;	  sNewV4 = '';
nMappedDim5 = 0;	sMappedV5 = '';		nNewDim5 = 0;	  sNewV5 = '';
nMappedDim6 = 0;	sMappedV6 = '';		nNewDim6 = 0;	  sNewV6 = '';
nMappedDim7 = 0;	sMappedV7 = '';		nNewDim7 = 0;	  sNewV7 = '';
nMappedDim8 = 0;	sMappedV8 = '';		nNewDim8 = 0;	  sNewV8 = '';
nMappedDim9 = 0;	sMappedV9 = '';		nNewDim9 = 0;	  sNewV9 = '';
nMappedDim10 = 0;	sMappedV10 = '';	nNewDim10 = 0;	sNewV10 = '';
nMappedDim11 = 0;	sMappedV11 = '';	nNewDim11 = 0;	sNewV11 = '';
nMappedDim12 = 0;	sMappedV12 = '';	nNewDim12 = 0;	sNewV12 = '';
nMappedDim13 = 0;	sMappedV13 = '';	nNewDim13 = 0;	sNewV13 = '';
nMappedDim14 = 0;	sMappedV14 = '';	nNewDim14 = 0;	sNewV14 = '';
nMappedDim15 = 0;	sMappedV15 = '';	nNewDim15 = 0;	sNewV15 = '';
nMappedDim16 = 0;	sMappedV16 = '';	nNewDim16 = 0;	sNewV16 = '';
nMappedDim17 = 0;	sMappedV17 = '';	nNewDim17 = 0;	sNewV17 = '';
nMappedDim18 = 0;	sMappedV18 = '';	nNewDim18 = 0;	sNewV18 = '';
nMappedDim19 = 0;	sMappedV19 = '';	nNewDim19 = 0;	sNewV19 = '';
nMappedDim20 = 0;	sMappedV20 = '';	nNewDim20 = 0;	sNewV20 = '';
nMappedDim21 = 0;	sMappedV21 = '';	nNewDim21 = 0;	sNewV21 = '';
nMappedDim22 = 0;	sMappedV22 = '';	nNewDim22 = 0;	sNewV22 = '';
nMappedDim23 = 0;	sMappedV23 = '';	nNewDim23 = 0;	sNewV23 = '';
nMappedDim24 = 0;	sMappedV24 = '';	nNewDim24 = 0;	sNewV24 = '';
nMappedDim25 = 0;	sMappedV25 = '';	nNewDim25 = 0;	sNewV25 = '';
nMappedDim26 = 0;	sMappedV26 = '';	nNewDim26 = 0;	sNewV26 = '';
nMappedDim27 = 0;	sMappedV27 = '';	nNewDim27 = 0;	sNewV27 = '';
                  sMappedV28 = '';

###########################################
### SPLIT MAPPING TO NEW DIMS PARAMETER ###
###########################################

nTargetCubeDimensionCount   = nDimensionCount;

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
        
        ### Determine the dimension is a member of the cube ###
        nMapCount = 1;
        nMapDimensionIndex = 0;
        While( TabDim( pCube, nMapCount ) @<> '' );
            sMapCubeDimName = TabDim( pCube, nMapCount );
            If( sDimension @= sMapCubeDimName );
                nMapDimensionIndex = nMapCount;
            EndIf;
            nMapCount = nMapCount + 1;
        End;

        If( nMapDimensionIndex = 0 );
            # The dimension does not exist in the cube. Cancel process
            sMessage = 'Dimension: ' | sDimension | ' is not a member of: '| pCube | ' cube.';
            nErrors = nErrors + 1;
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            ProcessBreak;
        EndIf;

        # Find the index of the dimension is in the Target cube
        nTargetIndexCounter = 1;

        WHILE(nTargetIndexCounter <= nTargetCubeDimensionCount );
          sNthDimension = TabDim( pCube, nTargetIndexCounter );

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
          # Move to the end of the delimter
          nAddExtra = nCount;
        EndIf;

        If( sDelim @= sDelimDim );
          nIsDelimiter = 1;
          sChar = sDelim;
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

          #Add to the Target filter - no need to manage element separators, since just one target element is possible in mapping
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


###########################################
#Region ### MAPPING Target DIMENSIONS #####
###########################################

## Source index starting from 2, since first columns holds the export cube name
nSourceIndex = 2;
nTargetIndex = 1;
WHILE(TabDim( pCube, nTargetIndex ) @<> '');
  sTargetDim = TabDim( pCube, nTargetIndex );
  
  If(nTargetIndex = 1);
    If( nNewDim1 = 0 );
      nMappedDim1 = 1;
      sMappedV1  = 'V' | NumberToString(nSourceIndex);
      nSourceIndex = nSourceIndex + 1;
    Else;
      
    EndIf;
  ElseIf(nTargetIndex = 2 & nNewDim2 = 0);
    nMappedDim2 = 1;
    sMappedV2  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 3 & nNewDim3 = 0);
    nMappedDim3 = 1;
    sMappedV3  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 4 & nNewDim4 = 0);
    nMappedDim4 = 1;
    sMappedV4  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 5 & nNewDim5 = 0);
    nMappedDim5 = 1;
    sMappedV5  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 6 & nNewDim6 = 0);
    nMappedDim6 = 1;
    sMappedV6  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 7 & nNewDim7 = 0);
      nMappedDim7 = 1;
      sMappedV7  = 'V' | NumberToString(nSourceIndex);
      nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 8 & nNewDim8 = 0);
    nMappedDim8 = 1;
    sMappedV8  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 9 & nNewDim9 = 0);
    nMappedDim9 = 1;
    sMappedV9  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 10 & nNewDim10 = 0);
    nMappedDim10 = 1;
    sMappedV10  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 11 & nNewDim11 = 0);
    nMappedDim11 = 1;
    sMappedV11  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 12 & nNewDim12 = 0 );
    nMappedDim12 = 1;
    sMappedV12  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 13 & nNewDim13 = 0 );
    nMappedDim13 = 1;
    sMappedV13  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 14 & nNewDim14 = 0 );
    nMappedDim14 = 1;
    sMappedV14  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 15 & nNewDim15 = 0 );
    nMappedDim15 = 1;
    sMappedV15  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 16 & nNewDim16 = 0 );
    nMappedDim16 = 1;
    sMappedV16  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 17 & nNewDim17 = 0 );
    nMappedDim17 = 1;
    sMappedV17  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 18 & nNewDim18 = 0 );
    nMappedDim18 = 1;
    sMappedV18  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 19 & nNewDim19 = 0 );
    nMappedDim19 = 1;
    sMappedV19  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 20 & nNewDim20 = 0 );
    nMappedDim20 = 1;
    sMappedV20  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 21 & nNewDim21 = 0 );
    nMappedDim21 = 1;
    sMappedV21  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 22 & nNewDim22 = 0 );
    nMappedDim22 = 1;
    sMappedV22  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 23 & nNewDim23 = 0 );
    nMappedDim23 = 1;
    sMappedV23  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 24 & nNewDim24 = 0 );
    nMappedDim24 = 1;
    sMappedV24  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 25 & nNewDim25 = 0 );
    nMappedDim25 = 1;
    sMappedV25  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 26 & nNewDim26 = 0 );
    nMappedDim26 = 1;
    sMappedV26  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  ElseIf(nTargetIndex = 27 & nNewDim27 = 0 );
    nMappedDim27 = 1;
    sMappedV27  = 'V' | NumberToString(nSourceIndex);
    nSourceIndex = nSourceIndex + 1;
  EndIf;

  nTargetIndex = nTargetIndex + 1;

END;

# The last variable in the data source holds the values
# which need to be mapped to the last variable in the target

If(nTargetIndex = 1 & nNewDim1 = 0);
  nMappedDim1 = 1;
  sMappedV1  = 'V' | NumberToString(nSourceIndex);
  nSourceIndex = nSourceIndex + 1;
ElseIf(nTargetIndex = 2 & nNewDim2 = 0);
  nMappedDim2 = 1;
  sMappedV2  = 'V' | NumberToString(nSourceIndex);
  nSourceIndex = nSourceIndex + 1;
ElseIf(nTargetIndex = 3 & nNewDim3 = 0);
  nMappedDim3 = 1;
  sMappedV3  = 'V' | NumberToString(nSourceIndex);
  nSourceIndex = nSourceIndex + 1;
ElseIf(nTargetIndex = 4 & nNewDim4 = 0);
  nMappedDim4 = 1;
  sMappedV4  = 'V' | NumberToString(nSourceIndex);
  nSourceIndex = nSourceIndex + 1;
ElseIf(nTargetIndex = 5 & nNewDim5 = 0);
  nMappedDim5 = 1;
  sMappedV5  = 'V' | NumberToString(nSourceIndex);
  nSourceIndex = nSourceIndex + 1;
ElseIf(nTargetIndex = 6 & nNewDim6 = 0);
  nMappedDim6 = 1;
  sMappedV6  = 'V' | NumberToString(nSourceIndex);
  nSourceIndex = nSourceIndex + 1;
ElseIf(nTargetIndex = 7 & nNewDim7 = 0);
  nMappedDim7 = 1;
  sMappedV7  = 'V' | NumberToString(nSourceIndex);
  nSourceIndex = nSourceIndex + 1;
ElseIf(nTargetIndex = 8 & nNewDim8 = 0);
  nMappedDim8 = 1;
  sMappedV8  = 'V' | NumberToString(nSourceIndex);
  nSourceIndex = nSourceIndex + 1;
ElseIf(nTargetIndex = 9 & nNewDim9 = 0);
  nMappedDim9 = 1;
  sMappedV9  = 'V' | NumberToString(nSourceIndex);
  nSourceIndex = nSourceIndex + 1;
ElseIf(nTargetIndex = 10 & nNewDim10 = 0);
  nMappedDim10 = 1;
  sMappedV10  = 'V' | NumberToString(nSourceIndex);
  nSourceIndex = nSourceIndex + 1;
ElseIf(nTargetIndex = 11 & nNewDim11 = 0);
  nMappedDim11 = 1;
  sMappedV11  = 'V' | NumberToString(nSourceIndex);
  nSourceIndex = nSourceIndex + 1;
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
            sTargetDimName  = TabDim( pCube,  nIndexInTarget );
            sMessage        = 'Dimension ' | sTargetDimName | ' is missing an input element in pMappingToNewDims';
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            ProcessBreak();
       EndIf;
       
       nIndexInTarget = nIndexInTarget + 1;
END;

#CubeLogging
If ( pCubeLogging <= 1 );
  sCubeLogging = CellGetS('}CubeProperties', pCube, 'LOGGING' );
  CubeSetLogChanges( pCube, pCubeLogging);
EndIf;

### Assign Datasource ###
DataSourceType                  = 'CHARACTERDELIMITED';
DatasourceNameForServer         = sFile;
DatasourceNameForClient         = sFile;
DatasourceASCIIHeaderRecords    = pTitleRows;
DatasourceASCIIDelimiter        = pDelimiter;
DatasourceASCIIQuoteCharacter   = pQuote;

### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,800

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

# It would be too exhaustive to error trap elements not existing in dimension for each possible number of dimensions
# If an incorrect source file is specfied for a target cube then the TI will error with standard TI error messages.
# Note: that the assumed file format is standard .cma cube export of Cube, d1, d2, dn, value
# This is equivalent to using the Bedrock.Cube.ExportToFile TI.

## Increase Record count
nRecordProcessedCount = nRecordProcessedCount + 1;

### Zero out Target view using filter in the 1st record of the data source, if requested
If( nRecordProcessedCount = 1 );
  If( pZeroFilter = 2 );
    sRowIsFilter = v2;
    sImportedFilter = v3;
    sImportedDelimDim = v4;
    sImportedElementStartDelim = v5;
    sImportedDelimElem = v6;
    ### Check Filter row
    IF(sRowIsFilter @<> 'Filter');
        sMessage = 'Filter row in source file not having the expected format.';
        nErrors = nErrors + 1;
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        ProcessBreak;
    ENDIF;
    ### Check delimiters are the same when using any mapping. This because filter from the file and mappings form the params will be concatenated / substituted
    IF((sElementMapping @<> '' % pDimension @<>'') & (sDelimDim @<> sImportedDelimDim % sElementStartDelim @<> sImportedElementStartDelim % sDelimElem @<> sImportedDelimElem));
        sMessage = 'Error zeroing out target slice corresponding to the filter plus new mapped dimensions: delimiters in source file do not match with the ones in parameters.';
        nErrors = nErrors + 1;
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        ProcessBreak;
    ENDIF;
    
    ### Check filter in source file and validate its dimensions
    sFilter = TRIM( sImportedFilter );
    nChar = 1;
    nCharCount = LONG( sFilter );
    sWord = '';
    sLastDelim = '';
    nIndex = 1;
    # Add a trailing element delimiter so that the last element is picked up
    If( nCharCount > 0 );
      sFilter = sFilter | sDelimElem;
      nCharCount = nCharCount + LONG(sDelimElem);
    EndIf;
    
    WHILE (nChar <= nCharCount);
        sChar = SUBST( sFilter, nChar, 1);
    
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
            sDelim = sDelim | SUBST( sFilter, nChar + 1, nCount);
            # Move to the end of the delimter
            nAddExtra = nCount;
          EndIf;
    
          If( sDelim @= sElementStartDelim );
    
            sChar = sDelim;
    
            If( sLastDelim @<> '' & sLastDelim @<> sDelimDim );
                sMessage = 'The name of a dimension must follow a dimension delimiter (' | sDelimDim | ')';
                nErrors = nErrors + 1;
                LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            EndIf;
    
            sDimension = sWord;
            
            If( DimensionExists( sDimension ) = 0 );
                # The dimension does not exist in the model. Cancel process
                sMessage = 'Dimension: ' | sDimension | ' does not exist';
                nErrors = nErrors + 1;
                LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            EndIf;
    
            ### Determine the dimension is a member of the cube ###
            nCount = 1;
            nDimensionIndex = 0;
            While( TabDim( pCube, nCount ) @<> '' );
                sCubeDimName = TabDim( pCube, nCount );
                If( sDimension @= sCubeDimName );
                    nDimensionIndex = nCount;
                EndIf;
                nCount = nCount + 1;
            End;
    
            If( nDimensionIndex = 0 );
                # The dimension does not exist in the cube. Cancel process
                sMessage = 'Dimension: ' | sDimension | ' is not a member of: '| pCube | ' cube.';
                nErrors = nErrors + 1;
                LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            EndIf;
    

    
            nIndex = 1;
            sLastDelim = sChar;
            # Clear the word
            sWord = '';
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
                sMessage = 'An element delimiter must follow a dimension name: ' |  sChar | ' (' | NumberToString(nChar) | ')';
                nErrors = nErrors + 1;
                LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
                #ProcessError();
              EndIf;
    
              sElement = sWord;
    
              If( DIMIX( sDimension, sElement ) = 0 );
                  # The element does not exist in the dimension. Cancel process
                  sMessage = 'Element: ' | sElement | ' in dimension ' | sDimension | ' does not exist';
                  nErrors = nErrors + 1;
                  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
                  #ProcessError();
              EndIf;
    
              nIndex = nIndex + 1;
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
      ProcessBreak;
    EndIf;
    
    IF( sTargetFilter @= '' );
      sTargetFilter = sImportedFilter;
    Else;
      sTargetFilter = sTargetFilter | sDelimDim | sImportedFilter;
    EndIf;
    ### Determine target dimension substitution in data clear filter
    IF( pDimension @<>'');
      IF( sTargetFilter @= '' );
        sTargetFilter = pDimension | sElementStartDelim | sTargetElement;
      Else;
        ### Remove spaces from the string, then remove source element from the filter if present
        sTargetFilter = UPPER( sTargetFilter );
        nSPIndex = SCAN( ' ', sTargetFilter );
        While ( nSPIndex <> 0);
          sTargetFilter = DELET( sTargetFilter, nSPIndex, 1 );
          nSPIndex = SCAN( ' ', sTargetFilter );
        End;
        sRemoveString = UPPER( sDelimDim | pDimension | sElementStartDelim | pSrcEle );
        nRemoveIndex = SCAN( sRemoveString, sTargetFilter );
        If( nRemoveIndex <> 0 );
          sTargetFilter = DELET( sTargetFilter, nRemoveIndex, Long(sRemoveString) );
        EndIf;
        sRemoveString2 = UPPER( pDimension | sElementStartDelim | pSrcEle | sDelimDim );
        nRemoveIndex = SCAN( sRemoveString2, sTargetFilter );
        If( nRemoveIndex <> 0 );
          sTargetFilter = DELET( sTargetFilter, nRemoveIndex, Long(sRemoveString2) );
        EndIf;
        sRemoveString3 = UPPER( sDelimDim | pDimension | sElementStartDelim | sSourceElement );
        nRemoveIndex = SCAN( sRemoveString3, sTargetFilter );
        If( nRemoveIndex <> 0 );
          sTargetFilter = DELET( sTargetFilter, nRemoveIndex, Long(sRemoveString3) );
        EndIf;
        sRemoveString4 = UPPER( pDimension | sElementStartDelim | sSourceElement | sDelimDim );
        nRemoveIndex = SCAN( sRemoveString4, sTargetFilter );
        If( nRemoveIndex <> 0 );
          sTargetFilter = DELET( sTargetFilter, nRemoveIndex, Long(sRemoveString4) );
        EndIf;
        ## Add target element to the filter
        sTargetFilter = sTargetFilter | sDelimDim | pDimension | sElementStartDelim | sTargetElement;
      EndIf;
    Endif;
    
    nRet = ExecuteProcess('}bedrock.cube.data.clear',
       'pLogOutput', pLogOutput,
       'pCube', pCube,
       'pView', '',
       'pFilter', sTargetFilter,
       'pFilterParallel', '',
       'pParallelThreads', 0,
       'pDimDelim', sImportedDelimDim,
       'pEleStartDelim', sImportedElementStartDelim,
       'pEleDelim', sImportedDelimElem,
       'pCubeLogging', pCubeLogging,
       'pTemp', 1,
       'pSandbox', pSandbox
      );
  
    IF(nRet <> 0);
        sMessage = 'Error zeroing out target slice corresponding to the filter.';
        nErrors = nErrors + 1;
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        ProcessBreak;
    ENDIF;
  ENDIF;
  IF( pZeroFilter > 0 );
    ItemSkip;
  ENDIF;
Endif;

### Determine target dimension SubStitution ###
IF( pDimension @<>'');
  
  IF(sSourceElement@<>Expand('%v'|numbertostring(nSubstututeDimensionIndex+1)|'%'));
   # leave variable as is
  Else; 
  
    v2 = IF(nSubstututeDimensionIndex = 1, sTargetElement, v2);
    v3 = IF(nSubstututeDimensionIndex = 2, sTargetElement, v3);
    v4 = IF(nSubstututeDimensionIndex = 3, sTargetElement, v4);
    v5 = IF(nSubstututeDimensionIndex = 4, sTargetElement, v5);
    v6 = IF(nSubstututeDimensionIndex = 5, sTargetElement, v6);
    v7 = IF(nSubstututeDimensionIndex = 6, sTargetElement, v7);
    v8 = IF(nSubstututeDimensionIndex = 7, sTargetElement, v8);
    v9 = IF(nSubstututeDimensionIndex = 8, sTargetElement, v9);
    v10 = IF(nSubstututeDimensionIndex = 9, sTargetElement, v10);
    v11 = IF(nSubstututeDimensionIndex = 10, sTargetElement, v11);
    v12 = IF(nSubstututeDimensionIndex = 11, sTargetElement, v12);
    v13 = IF(nSubstututeDimensionIndex = 12, sTargetElement, v13);
    v14 = IF(nSubstututeDimensionIndex = 13, sTargetElement, v14);
    v15 = IF(nSubstututeDimensionIndex = 14, sTargetElement, v15);
    v16 = IF(nSubstututeDimensionIndex = 15, sTargetElement, v16);
    v17 = IF(nSubstututeDimensionIndex = 16, sTargetElement, v17);
    v18 = IF(nSubstututeDimensionIndex = 17, sTargetElement, v18);
    v19 = IF(nSubstututeDimensionIndex = 18, sTargetElement, v19);
    v20 = IF(nSubstututeDimensionIndex = 19, sTargetElement, v20);
    v21 = IF(nSubstututeDimensionIndex = 20, sTargetElement, v21);
    v22 = IF(nSubstututeDimensionIndex = 21, sTargetElement, v22);
    v23 = IF(nSubstututeDimensionIndex = 22, sTargetElement, v23);
    v24 = IF(nSubstututeDimensionIndex = 23, sTargetElement, v24);
    v25 = IF(nSubstututeDimensionIndex = 24, sTargetElement, v25);
    v26 = IF(nSubstututeDimensionIndex = 25, sTargetElement, v26);
    v27 = IF(nSubstututeDimensionIndex = 26, sTargetElement, v27);
  EndIf;

Endif;

### Determine dimension Mapping SubStitution ###
sV2 =IF(nMappedDim1=1,  Expand('%'|sMappedV1|'%'), IF(nNewDim1=1, sNewV1,V1));
sV3 =IF(nMappedDim2=1,  Expand('%'|sMappedV2|'%'), IF(nNewDim2=1, sNewV2,V2));
sV4 =IF(nMappedDim3=1,  Expand('%'|sMappedV3|'%'), IF(nNewDim3=1, sNewV3,V3));
sV5 =IF(nMappedDim4=1,  Expand('%'|sMappedV4|'%'), IF(nNewDim4=1, sNewV4,V4));
sV6 =IF(nMappedDim5=1,  Expand('%'|sMappedV5|'%'), IF(nNewDim5=1, sNewV5,V5));
sV7 =IF(nMappedDim6=1,  Expand('%'|sMappedV6|'%'), IF(nNewDim6=1, sNewV6,V6));
sV8 =IF(nMappedDim7=1,  Expand('%'|sMappedV7|'%'), IF(nNewDim7=1, sNewV7,V7));
sV9 =IF(nMappedDim8=1,  Expand('%'|sMappedV8|'%'), IF(nNewDim8=1, sNewV8,V8));
sV10 =IF(nMappedDim9=1,  Expand('%'|sMappedV9|'%'), IF(nNewDim9=1, sNewV9,V9));
sV11=IF(nMappedDim10=1, Expand('%'|sMappedV10|'%'),IF(nNewDim10=1,sNewV10,V10));
sV12=IF(nMappedDim11=1, Expand('%'|sMappedV11|'%'),IF(nNewDim11=1,sNewV11,V11));
sV13=IF(nMappedDim12=1, Expand('%'|sMappedV12|'%'),IF(nNewDim12=1,sNewV12,V12));  
sV14=IF(nMappedDim13=1, Expand('%'|sMappedV13|'%'),IF(nNewDim13=1,sNewV13,V13));  
sV15=IF(nMappedDim14=1, Expand('%'|sMappedV14|'%'),IF(nNewDim14=1,sNewV14,V14));   
sV16=IF(nMappedDim15=1, Expand('%'|sMappedV15|'%'),IF(nNewDim15=1,sNewV15,V15));  
sV17=IF(nMappedDim16=1, Expand('%'|sMappedV16|'%'),IF(nNewDim16=1,sNewV16,V16));  
sV18=IF(nMappedDim17=1, Expand('%'|sMappedV17|'%'),IF(nNewDim17=1,sNewV17,V17));  
sV19=IF(nMappedDim18=1, Expand('%'|sMappedV18|'%'),IF(nNewDim18=1,sNewV18,V18));  
sV20=IF(nMappedDim19=1, Expand('%'|sMappedV19|'%'),IF(nNewDim19=1,sNewV19,V19));  
sV21=IF(nMappedDim20=1, Expand('%'|sMappedV20|'%'),IF(nNewDim20=1,sNewV20,V20));  
sV22=IF(nMappedDim21=1, Expand('%'|sMappedV21|'%'),IF(nNewDim21=1,sNewV21,V21));  
sV23=IF(nMappedDim22=1, Expand('%'|sMappedV22|'%'),IF(nNewDim22=1,sNewV22,V22));  
sV24=IF(nMappedDim23=1, Expand('%'|sMappedV23|'%'),IF(nNewDim23=1,sNewV23,V23));  
sV25=IF(nMappedDim24=1, Expand('%'|sMappedV24|'%'),IF(nNewDim24=1,sNewV24,V24));  
sV26=IF(nMappedDim25=1, Expand('%'|sMappedV25|'%'),IF(nNewDim25=1,sNewV25,V25));  
sV27=IF(nMappedDim26=1, Expand('%'|sMappedV26|'%'),IF(nNewDim26=1,sNewV26,V26));  
sV28=IF(nMappedDim27=1, Expand('%'|sMappedV27|'%'),IF(nNewDim27=1,sNewV27,V27));
sV29=IF(nMappedDim28=1, Expand('%'|sMappedV28|'%'),V28);  
  
V1 = V1;
V2 = sV2; 
V3 = sV3; 
V4 = sV4; 
V5 = sV5; 
V6 = sV6; 
V7 = sV7; 
V8 = sV8; 
V9 = sV9; 
V10= sV10;
V11= sV11;
V12= sV12;
V13= sV13;
V14= sV14;
V15= sV15;
V16= sV16;
V17= sV17;
V18= sV18;
V19= sV19;
V20= sV20;
V21= sV21;
V22= sV22;
V23= sV23;
V24= sV24;
V25= sV25;
V26= sV26;
V27= sV27;
V28= sV28;
V29= sV29;
 
### Write data from source file to target cube ###

If( nDimensionCount = 2 );
    If( CellIsUpdateable( pCube, v2, v3 ) = 1 );
        sElType = DType( sDim2, v3 );
        sDim = SubST ( sDim2, LONG('}ElementAttributes_')+1, 9999);

        IF( sElType @= 'AS');
            AttrPutS( v4, sDim, v2, v3, 1 );
        ELSEIF( sElType @= 'AA');
            AttrPutS( v4, sDim, v2, v3 );
        ELSEIF( sElType @= 'AN');
            AttrPutN( NUMBR(v4), sDim, v2, v3 );
        ELSEIF( sElType @= 'S');
            CellPutS( v4, pCube, v2, v3 );
        ElseIF( DimIx( sDim2, v3 ) <> 0 );
            IF(pCumulate = 1);
                nObal = CellGetN( pCube, v2, v3 );
                nCbal = nObal + Numbr( v4 );
            ELSE;
                nCbal = Numbr( v4 );
            Endif;
            CellPutN( nCbal, pCube, v2, v3 );
        EndIf;
    EndIf;
ElseIf( nDimensionCount = 3 );
    If( CellIsUpdateable( pCube, v2, v3, v4 ) = 1 );
        sElType = DType( sDim3, v4 );
        If( sElType @<> 'S' );
            IF(pCumulate = 1);
                nObal = CellGetN( pCube, v2, v3, v4 );
                nCbal = nObal + Numbr( v5 );
            ELSE;
                nCbal = Numbr( v5 );
            Endif;
            CellPutN( nCbal, pCube, v2, v3, v4 );
        Else;
            CellPutS( v5, pCube, v2, v3, v4 );
        EndIf;
    EndIf;
ElseIf( nDimensionCount = 4 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5 ) = 1 );
        sElType = DType( sDim4, v5 );
        If( sElType @<> 'S' );
            IF(pCumulate = 1);
                nObal = CellGetN( pCube, v2, v3, v4, v5 );
                nCbal = nObal + Numbr( v6 );
            ELSE;
                nCbal = Numbr( v6 );
            Endif;
            CellPutN( nCbal, pCube, v2, v3, v4, v5 );
        Else;
            CellPutS( v6, pCube, v2, v3, v4, v5 );
        EndIf;
    EndIf;
ElseIf( nDimensionCount = 5 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6 ) = 1 );
      sElType = DType( sDim5, v6 );
      If( sElType @<> 'S' );
        IF(pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6 );
          nCbal = nObal + Numbr( v7 );
        ELSE;
          nCbal = Numbr( v7 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6 );
      Else;
        CellPutS( v7, pCube, v2, v3, v4, v5, v6 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 6 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7 ) = 1 );
      sElType = DType( sDim6, v7 );
      If( sElType @<> 'S' );
        IF(pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7 );
          nCbal = nObal + Numbr( v8 );
        ELSE;
          nCbal = Numbr( v8 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7 );
      Else;
        CellPutS( v8, pCube, v2, v3, v4, v5, v6, v7 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 7 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8 ) = 1 );
      sElType = DType( sDim7, v8 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8 );
          nCbal = nObal + Numbr( v9 );
        ELSE;
          nCbal = Numbr( v9 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8 );
      Else;
        CellPutS( v9, pCube, v2, v3, v4, v5, v6, v7, v8 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 8 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9 ) = 1 );
      sElType = DType( sDim8, v9 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9 );
          nCbal = nObal + Numbr( v10 );
        ELSE;
          nCbal = Numbr( v10 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9 );
      Else;
        CellPutS( v10, pCube, v2, v3, v4, v5, v6, v7, v8, v9 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 9 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10 ) = 1 );
      sElType = DType( sDim9, v10 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10 );
          nCbal = nObal + Numbr( v11 );
        ELSE;
          nCbal = Numbr( v11 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10 );
      Else;
        CellPutS( v11, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 10 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 ) = 1 );
      sElType = DType( sDim10, v11 );
      If( sElType @<> 'S' );
        IF(pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 );
          nCbal = nObal + Numbr( v12 );
        ELSE;
          nCbal = Numbr( v12 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 );
      Else;
        CellPutS( v12, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 11 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 ) = 1 );
      sElType = DType( sDim11, v12 );
      If( sElType @<> 'S' );
        IF(pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 );
          nCbal = nObal + Numbr( v13 );
        ELSE;
          nCbal = Numbr( v13 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 );
      Else;
        CellPutS( v13, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 12 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 ) = 1 );
      sElType = DType( sDim12, v13 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 );
          nCbal = nObal + Numbr( v14 );
        ELSE;
          nCbal = Numbr( v14 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 );
      Else;
        CellPutS( v14, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 13 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 ) = 1 );
      sElType = DType( sDim13, v14 );
      If( sElType @<> 'S' );
        IF(pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 );
          nCbal = nObal + Numbr( v15 );
        ELSE;
          nCbal = Numbr( v15 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 );
      Else;
        CellPutS( v15, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 14 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 ) = 1 );
      sElType = DType( sDim14, v15 );
      If( sElType @<> 'S' );
        IF(pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 );
          nCbal = nObal + Numbr( v16 );
        ELSE;
          nCbal = Numbr( v16 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 );
      Else;
        CellPutS( v16, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 15 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 ) = 1 );
      sElType = DType( sDim15, v16 );
      If( sElType @<> 'S' );
        IF(pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 );
          nCbal = nObal + Numbr( v17 );
        ELSE;
          nCbal = Numbr( v17 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 );
      Else;
        CellPutS( v17, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 16 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 ) = 1 );
      sElType = DType( sDim16, v17 );
        IF(pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 );
          nCbal = nObal + Numbr( v18 );
        ELSE;
          nCbal = Numbr( v18 );
        Endif;
      If( sElType @<> 'S' );
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 );
      Else;
        CellPutS( v18, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 17 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 ) = 1 );
      sElType = DType( sDim17, v18 );
      If( sElType @<> 'S' );
        IF(pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 );
          nCbal = nObal + Numbr( v19 );
        ELSE;
          nCbal = Numbr( v19 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 );
      Else;
        CellPutS( v19, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 18 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 ) = 1 );
      sElType = DType( sDim18, v19 );
      If( sElType @<> 'S' );
        IF(pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 );
          nCbal = nObal + Numbr( v20 );
        ELSE;
          nCbal = Numbr( v20 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 );
      Else;
        CellPutS( v20, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 19 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 ) = 1 );
      sElType = DType( sDim19, v20 );
      If( sElType @<> 'S' );
        IF(pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 );
          nCbal = nObal + Numbr( v21 );
        ELSE;
          nCbal = Numbr( v21 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 );
      Else;
        CellPutS( v21, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 20 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 ) = 1 );
      sElType = DType( sDim20, v21 );
      If( sElType @<> 'S' );
        IF(pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 );
          nCbal = nObal + Numbr( v22 );
        ELSE;
          nCbal = Numbr( v22 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 );
      Else;
        CellPutS( v22, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 21 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 ) = 1 );
      sElType = DType( sDim21, v22 );
      If( sElType @<> 'S' );
        IF(pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 );
          nCbal = nObal + Numbr( v23 );
        ELSE;
          nCbal = Numbr( v23 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 );
      Else;
        CellPutS( v23, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 22 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 ) = 1 );
      sElType = DType( sDim22, v23 );
      If( sElType @<> 'S' );
        IF(pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 );
          nCbal = nObal + Numbr( v24 );
        ELSE;
          nCbal = Numbr( v24 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 );
      Else;
        CellPutS( v24, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 23 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
    v23, v24 ) = 1 );
      sElType = DType( sDim23, v24 );
      If( sElType @<> 'S' );
        IF(pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
            v23, v24 );
          nCbal = nObal + Numbr( v25 );
        ELSE;
          nCbal = Numbr( v25 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
          v23, v24 );
      Else;
        CellPutS( v25, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 24 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
      v23, v24, v25 ) = 1 );
      sElType = DType( sDim24, v25 );
      If( sElType @<> 'S' );
        IF(pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
            v23, v24, v25 );
          nCbal = nObal + Numbr( v26 );
        ELSE;
          nCbal = Numbr( v26 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
          v23, v24, v25 );
      Else;
        CellPutS( v26, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
          v23, v24, v25 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 25 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
      v23, v24, v25, v26 ) = 1 );
      sElType = DType( sDim25, v26 );
      If( sElType @<> 'S' );
        IF(pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
            v23, v24, v25, v26 );
          nCbal = nObal + Numbr( v27 );
        ELSE;
          nCbal = Numbr( v27 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
          v23, v24, v25, v26 );
      Else;
        CellPutS( v27, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
          v23, v24, v25, v26 );
      EndIf;
    EndIf;
ElseIf( nDimensionCount = 26 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
    v23, v24, v25, v26, v27 ) = 1 );
      sElType = DType( sDim26, v27 );
      If( sElType @<> 'S' );
        IF( pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
            v23, v24, v25, v26, v27 );
          nCbal = nObal + Numbr( v28 );
        ELSE;
          nCbal = Numbr( v28 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
        v23, v24, v25, v26, v27 );
      Else;
        CellPutS( v28, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21,
          v22, v23, v24, v25, v26, v27 );
      EndIf;
    EndIf;
ElseIf( nDimensionCount = 27 );
    If( CellIsUpdateable( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
    v23, v24, v25, v26, v27, v28 ) = 1 );
      sElType = DType( sDim27, v28 );
      If( sElType @<> 'S' );
        IF(pCumulate = 1);
          nObal = CellGetN( pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
            v23, v24, v25, v26, v27, v28 );
          nCbal = nObal + Numbr( v29 );
        ELSE;
          nCbal = Numbr( v29 );
        Endif;
        CellPutN( nCbal, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
          v23, v24, v25, v26, v27, v28 );
      Else;
        CellPutS( v29, pCube, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21,
          v22, v23, v24, v25, v26, v27, v28 );
      EndIf;
    EndIf;


  EndIf;
  
## Increase Record count
nRecordPostedCount = nRecordPostedCount + 1;
### End Data ###
575,38

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Cube Logging
If ( pCubeLogging <= 1 );
  CubeSetLogChanges( pCube, IF(sCubeLogging@='YES',1,0) );
EndIf;
    
### If errors occurred terminate process with a major error status ###
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 major error and consequently aborted. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% aborted. Check tm1server.log for details.' );
    ProcessError;
EndIf;

### Return code & final error message handling
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
Else;
    sProcessAction = Expand( 'Process:%cThisProcName% successfully imported data from file %sFile%.' );
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
