601,100
602,"}bedrock.cube.data.export.bymdx"
562,"VIEW"
586,"}APQ Staging TempSource"
585,"}APQ Staging TempSource"
564,
565,"hiI7uiuOa\>zSk=5[1=iiB\hYF18_qsfjiXwXm[8JKQn_;MQ3;R>7U5`H\8x1l7gWy\XsN_4BTZc`fe^aE:RC?\2uOMR:alx<FY;fyvX@@=tyZmjbO=Ij[3r\[p7I8z;d5zB7lzp[ZJ0PrNJnR6=dSoD4=DPYP?\?HVmc>IQkrL29QR@lhzYswwfTV?W9DXg_dxIUiE8"
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
588,","
589,"."
568,""""
570,}TI_Dummy_View
571,
569,0
592,0
599,1000
560,23
pLogoutput
pStrictErrorHandling
pCube
pView
pMDXExpr
pSuppressZero
pSuppressConsol
pSuppressRules
pSuppressConsolStrings
pZeroSource
pCubeLogging
pTemp
pFilePath
pFileName
pDelim
pDecimalSeparator
pThousandSeparator
pQuote
pTitleRecord
pSandbox
pSubN
pCharacterSet
pCubeNameExport
561,23
1
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
1
2
2
2
2
2
2
1
2
1
2
1
590,23
pLogoutput,0
pStrictErrorHandling,0
pCube,""
pView,""
pMDXExpr,""
pSuppressZero,1
pSuppressConsol,1
pSuppressRules,1
pSuppressConsolStrings,0
pZeroSource,0
pCubeLogging,0
pTemp,1
pFilePath,""
pFileName,""
pDelim,","
pDecimalSeparator,"."
pThousandSeparator,","
pQuote,""""
pTitleRecord,2
pSandbox,""
pSubN,0
pCharacterSet,""
pCubeNameExport,1
637,23
pLogoutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pCube,"REQUIRED: Cube name"
pView,"OPTIONAL: Temporary view name"
pMDXExpr,"REQUIRED: Valid MDX Expression"
pSuppressZero,"OPTIONAL: Suppress Zero Values (1=Suppress)"
pSuppressConsol,"OPTIONAL: Suppress Consolidated Values? (1=Suppress)"
pSuppressRules,"OPTIONAL: Suppress Rule Values? (1=Suppress)"
pSuppressConsolStrings,"OPTIONAL: Suppress Strings on Consolidations (Skip = 1) (Default = 0)"
pZeroSource,"OPTIONAL: Zero Out view AFTER Copy? (Boolean 1=True)"
pCubeLogging,"Required: Cube Logging (0 = No transaction logging, 1 = Logging of transactions, 2 = Ignore Cube Logging - No Action Taken)"
pTemp,"OPTIONAL: Retain temporary view and Subset ( 0 = retain View and Subsets 1 = use temp objects)"
pFilePath,"OPTIONAL: Export Directory (will default to error file path)"
pFileName,"OPTIONAL: Export Filename (If Left Blank Defaults to cube_export.csv)"
pDelim,"OPTIONAL: AsciiOutput delimiter character (Default = ',' exactly 3 digits = ASCII code)"
pDecimalSeparator,"OPTIONAL: Decimal separator for conversion of number to string and string to number (default = '.' exactly 3 digits = ASCII code)"
pThousandSeparator,"OPTIONAL: Thousand separator for conversion of number to string and string to number (default = ',' exactly 3 digits = ASCII code)"
pQuote,"OPTIONAL: AsciiOutput quote character (Accepts empty quote, exactly 3 digits = ASCII code)"
pTitleRecord,"OPTIONAL: Include Title Record in Export File? (Boolean 0=false, 1=title in cube order, 2=title in MDX order  Default=2)"
pSandbox,"OPTIONAL: To use sandbox not base data enter the sandbox name (invalid name will result in process error)"
pSubN,"OPTIONAL: Create N level subset for all dims not mentioned in pFilter (default=0)"
pCharacterSet,"OPTIONAL: The output character set (defaults to TM1CS_UTF8 if blank)"
pCubeNameExport,"OPTIONAL: Skip cube name from export file, including header (Skip = 0) (Default = 1)"
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
572,463
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.cube.data.export.bymdx', 'pLogoutput', pLogoutput,
      'pStrictErrorHandling', pStrictErrorHandling,
      'pCube', '', 'pView', '', 'pMDXExpr', '',
      'pSuppressZero', 1, 'pSuppressConsol', 1, 'pSuppressRules', 1, 'pSuppressConsolStrings', 1,
      'pZeroSource', 0, 'pCubeLogging', 0, 'pTemp', 1,
      'pFilePath', '', 'pFileName', '',
      'pDelim', ',', 'pDecimalSeparator', '.' ,'pThousandSeparator', ',',
      'pQuote', '"', 'pTitleRecord', 1, 'pSandbox', pSandbox, 'pSubN', pSubN, 'pCharacterSet', '', 'pCubeNameExport', pCubeNameExport
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
# This TI is designed to export data in a given cube to a flat file for a given MDX expression.
#
# Use case: Intended for development/prototyping or in Production environment.
# 1. Export data for import into another TM1 model to eliminate possibility of locking.
# 2. Export data for import into ERP system.
#
# Note:
# * The view must be guaranteed to have no alternate hierarchies
#   We rely on }bedrock.cube.view.create.bymdx to create the view for us
# * Naturally, a valid cube name (pCube) and MDX expression (pMDXExpr) are mandatory otherwise the process will abort
# * All other parameters are optional, however, the MDX should be specified to limit the size of the file and the TM1 memory limits.
# * The default output path is the same as the error file path.
# * As this TI has a view as a data source it requires the implicit variables NValue, SValue and Value_is_String
# * Parallel exports of data are not possible
# * The title record can:
#   - (pTitleRecord = 0) be skipped
#   - (pTitleRecord = 1) follow the order of the cube dimensions and we assume the MDX query is such that it conforms the order
#   - (pTitleRecord = 2) follow the order of the variables the way TM1 exports the file
# * Main differences with }bedrock.cube.data.export:
#   - No filter expression allowed (it's part of the MDX expression). Hence filter delimiters needed.
#   - No parallel exports allowed
#   - TitleRecord is different. Does not allow a filter record. But more options on the title record sequence.
#   - No option to include descendants automatically.
#   - On the plus side, this process can create files coming from asymmetric slices.
#
#EndRegion @DOC

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
StringGlobalVariable('sBedrockViewCreateParsedFilter');
NumericGlobalVariable('nDataCount');

### Constants ###
cThisProcName      = GetProcessName();
cUserName          = TM1User();
cTimeStamp         = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt         = NumberToString( INT( RAND( ) * 1000 ));
cMsgErrorLevel     = 'ERROR';
cMsgErrorContent   = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo           = 'Process:%cThisProcName% run with parameters pCube:%pCube%, pView:%pView%, pMDXExpr:%pMDXExpr%, pSuppressZero:%pSuppressZero%, pSuppressConsol:%pSuppressConsol%, pSuppressRules:%pSuppressRules%, pZeroSource:%pZeroSource%, pCubeLogging:%pCubeLogging%, pTemp:%pTemp%, pFilePath:%pFilePath%, pFileName:%pFileName%, pDelim:%pDelim%, pQuote:%pQuote%, pTitleRecord:%pTitleRecord%, pSandbox:%pSandbox%, pSuppressConsolStrings:%pSuppressConsolStrings%.';
cDefaultView       = Expand( '%cThisProcName%_%cTimeStamp%_%cRandomInt%' );
cTempObject        = cDefaultView;
cLenASCIICode      = 3;

pFieldDelim        = TRIM(pDelim);
pDecimalSeparator  = TRIM(pDecimalSeparator);
pThousandSeparator = TRIM(pThousandSeparator);
nDataCount         = 0;
nErrors            = 0;

## Capture current transaction logging state
If( CubeExists(pCube) = 1 );
  sCubeLogging = CellGetS('}CubeProperties', pCube, 'LOGGING' );
EndIf;

## Default separators
If( pDecimalSeparator @= '' );
    pDecimalSeparator = '.';
EndIf;
If( pThousandSeparator @= '' );
    pThousandSeparator = ',';
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
nDimensionCount = CubeDimensionCountGet( pCube );

# If no MDX expression has been specified then terminate process
If( pMDXExpr @= '' );
    sMessage = 'No MDX expression specified.';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate that the MDX does not use alternate hierarchies
# This test is not a 100% guarantee, since alternate hierarchies could be used in lookups for instance
cube_dim = 1;
While( cube_dim <= nDimensionCount ); 
    vDimension = Tabdim( pCube, cube_dim );

    dim_idx = 1;
    While( dim_idx <= Dimsiz( '}Dimensions' )); 
        vDim_Name = Dimnm( '}Dimensions', dim_idx );
        If( Subst( vDim_Name, 1, Long( vDimension ) + 1 ) @= vDimension | ':' );
            vHier = Delet( vDim_Name, 1, Scan( ':', vDim_Name ));
            If( Scan( '[' | vDimension | '].[' | vHier | ']', pMDXExpr ) > 0 );

                sMessage = 'It seems that alternate hierarchies were used in the MDX expression (' | vDim_Name | ')';
                nErrors = nErrors + 1;
                LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
                If( pStrictErrorHandling = 1 );
                    CubeSetLogChanges( pCube, IF(sCubeLogging @= 'YES', 1, 0 ) );
                    ProcessQuit;
                Else;
                    ProcessBreak;
                EndIf;

            EndIf;
        EndIf;
        dim_idx = dim_idx + 1;
    End;

    cube_dim = cube_dim + 1;
End;

If( TRIM(pView) @= '' );
    cView = cDefaultView;
Else ;
    cView = pView;
EndIf;

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

# Validate file path
If(Trim( pFilePath ) @= '' );
    pFilePath = GetProcessErrorFileDirectory;
EndIf;
If( SubSt( pFilePath, Long( pFilePath ), 1 ) @= sOSDelim );
    pFilePath = SubSt( pFilePath, 1, Long( pFilePath ) -1 );
EndIf;
If(  FileExists( pFilePath ) = 0 );
    sMessage = Expand('Invalid export directory: %pFilePath%');
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;
pFilePath = pFilePath | sOSDelim;

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
                Break;
            EndIf;
            nChar = nChar + 1;
        End;
    EndIf;
    If ( nValid <> 0 );
        pFieldDelim = CHAR(StringToNumber( pFieldDelim ));
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
                Break;
            EndIf;
            nChar = nChar + 1;
        End;
    EndIf;
    If ( nValid <> 0 );
        pQuote = CHAR(StringToNumber( pQuote ));
    Else;
        pQuote = SubSt( Trim( pQuote ), 1, 1 );
    EndIf;
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
    If ( nValid <> 0 );
        pDecimalSeparator = CHAR(StringToNumber( pDecimalSeparator ));
    Else;
        pDecimalSeparator = SubSt( Trim( pDecimalSeparator ), 1, 1 );
    EndIf;
EndIf;
sDecimalSeparator = pDecimalSeparator;

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
    If ( nValid <> 0 );
        pThousandSeparator = CHAR(StringToNumber( pThousandSeparator ));
    Else;
        pThousandSeparator = SubSt( Trim( pThousandSeparator ), 1, 1 );
    EndIf;
EndIf;
sThousandSeparator = pThousandSeparator;

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

# Validate and set the output character set
If(Trim( pCharacterSet ) @= '' );
  pCharacterSet = 'TM1CS_UTF8';
EndIf;
SetOutputCharacterSet( cExportFile, pCharacterSet );

# Jump to Epilog if any errors so far
IF ( nErrors > 0 );
    DataSourceType = 'NULL';
    If( pStrictErrorHandling = 1 );
        If( CubeExists(pCube) = 1 );
          CubeSetLogChanges( pCube, IF(sCubeLogging @= 'YES', 1, 0 ) );
        EndIf;
        ProcessQuit;
    Else;
        ProcessBreak;
    EndIf;
ENDIF;

# Determine number of dims in source cube & create strings to expand on title and rows
nCount = 1;

# Prepare placeholder variables for the title and rows
If( pTitleRecord <= 1 );
    ## Either no title, or the title follows the cube order
    ## In any case we need a placeholder for the rows too
    If( pCubeNameExport = 0 );
        ## Skip cube name from export
        sTitle = '';
        sRow = '';

        While( nCount <= nDimensionCount );
            sDimension = Tabdim( pCube, nCount );

            ## Determine title string for the source cube
            sTitle = sTitle | '%pQuote%' | sDimension | '%pQuote%%pFieldDelim%';
            # Determine row string for the source cube
            sRow = sRow | '%pQuote%%V'| NumberToString(nCount) | '%%pQuote%%pFieldDelim%';

            nCount = nCount + 1;
        End;

        # Finish off the strings
        sTitle = sTitle | '%pQuote%Value%pQuote%';
        sRow = sRow | '%pQuote%%sValue%%pQuote%';

    Else;
        ## Include cube name in export
        sTitle = '%pQuote%Cube%pQuote%';
        sRow = '%pQuote%%pCube%%pQuote%';

        While( nCount <= nDimensionCount );
            sDimension = Tabdim( pCube, nCount );

            ## Determine title string for the source cube
            sTitle = sTitle|'%pFieldDelim%%pQuote%'|sDimension|'%pQuote%';
            # Determine row string for the source cube
            sRow = sRow|'%pFieldDelim%%pQuote%%V'| NumberToString(nCount) |'%%pQuote%';

            nCount = nCount + 1;
        End;

        # Finish off the strings
        sTitle = sTitle | '%pFieldDelim%%pQuote%Value%pQuote%';
        sRow = sRow | '%pFieldDelim%%pQuote%%sValue%%pQuote%';
    EndIf;
Else;
    ## The title follows the MDX order
    ## Let's use a temporary dimension for this task
    ## In any case we need a placeholder for the rows too
    DimensionCreate( cTempObject );
    DimensionSortOrder( cTempObject, 'ByName', 'Ascending', 'ByName', 'Ascending' );

    If( pCubeNameExport = 0 );
        ## Skip cube name from export
        sTitle = '';
        sRow = '';

        While( nCount <= nDimensionCount );
            sDimension = Tabdim( pCube, nCount );

            ## Determine the title string for the source cube
            sPos_Dim = NumberToStringEx( Scan( '[' | sDimension | '].[' | sDimension | ']', pMDXExpr ), '00000000', '', '' ) | '_' | sDimension;
            DimensionElementInsert( cTempObject, '', sPos_Dim, 'N' );

            # Determine row string for the source cube
            sRow = sRow | '%pQuote%%V' | NumberToString(nCount) | '%%pQuote%%pFieldDelim%';

            nCount = nCount + 1;
        End;

        # Finish off the strings
        sRow = sRow | '%pQuote%%sValue%%pQuote%';

    Else;
        ## Include cube name in export
        sTitle = '%pQuote%Cube%pQuote%';
        sRow = '%pQuote%%pCube%%pQuote%';

        While( nCount <= nDimensionCount );
            sDimension = Tabdim( pCube, nCount );

            ## Determine the title string for the source cube
            sPos_Dim = NumberToStringEx( Scan( '[' | sDimension | '].[' | sDimension | ']', pMDXExpr ), '00000000', '', '' ) | '_' | sDimension;
            DimensionElementInsert( cTempObject, '', sPos_Dim, 'N' );

            # Determine row string for the source cube
            sRow = sRow | '%pFieldDelim%%pQuote%%V' | NumberToString(nCount) | '%%pQuote%';

            nCount = nCount + 1;
        End;

        # Finish off the strings
        sRow = sRow | '%pFieldDelim%%pQuote%%sValue%%pQuote%';
    EndIf;
EndIf;

# The variable for the next 'free' dimension (it should be free)
# Plus 1 would be the cell contents, therefore plus 2
sNext_Variable = '%V' | NumberToString( nDimensionCount + 2 ) | '%';

# Create Processing View for source data
nRet = ExecuteProcess('}bedrock.cube.view.create.bymdx',
     'pLogOutput', pLogOutput,
     'pStrictErrorHandling', pStrictErrorHandling,
     'pCube', pCube,
     'pView', cDefaultView,
     'pMDXExpr', pMDXExpr,
     'pTemp', pTemp
     );

If( nRet <> ProcessExitNormal() );
    sMessage = 'Error creating the MDX view from the MDX expression.';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    DimensionDestroy( cTempObject );
    If( pStrictErrorHandling = 1 );
        If( CubeExists(pCube) = 1 );
          CubeSetLogChanges( pCube, IF(sCubeLogging @= 'YES', 1, 0 ) );
        EndIf;
        ProcessQuit;
    Else;
        ProcessBreak;
    EndIf;

EndIf;

# Limit the data source
ViewExtractSkipCalcsSet( pCube, cView, pSuppressConsol );
ViewExtractSkipZeroesSet( pCube, cView, pSuppressZero );
ViewExtractSkipRuleValuesSet( pCube, cView, pSuppressRules );
# Fix of issue #141, https://github.com/cubewise-code/bedrock/issues/141
If( pSuppressConsolStrings <> -1 );
    ViewExtractSkipConsolidatedStringsSet( pCube, cView, pSuppressConsolStrings );
EndIf;

# Assign Datasource
DataSourceType           = 'VIEW';
DatasourceNameForServer  = pCube;
DatasourceNameForClient  = pCube;
DatasourceCubeView       = cView;
DatasourceAsciiDelimiter = pFieldDelim;
DatasourceAsciiQuoteCharacter = '';
### End Prolog ###
573,2
#****Begin: Generated Statements***
#****End: Generated Statements****
574,102
#****Begin: Generated Statements***
#****End: Generated Statements****

#################################################################################################
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
#################################################################################################

### Data Count ###
nDataCount = nDataCount + 1;

# Test that the variable for the next dimension is empty
# If not, it could mean an MDX expression that uses alternate hierarchies
If( Expand( sNext_Variable ) @<> '' );
    sMessage = 'It seems that alternate hierarchies were used in the MDX expression.';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    DimensionDestroy( cTempObject );
    If( pStrictErrorHandling = 1 );
        If( CubeExists(pCube) = 1 );
          CubeSetLogChanges( pCube, IF(sCubeLogging @= 'YES', 1, 0 ) );
        EndIf;
        ProcessQuit;
    Else;
        ProcessBreak;
    EndIf;
EndIf;

# Output the title string
IF( nDataCount = 1 );

    If( pTitleRecord = 2 );
        nCount = 1;

        If( pCubeNameExport = 0 );

            While( nCount <= nDimensionCount );

                # Determine title string for the source cube
                sPos_Dim = Dimnm( cTempObject, nCount );
                sDimension = Delet( sPos_Dim, 1, Scan( '_', sPos_Dim ));
                sTitle = sTitle | '%pQuote%' | sDimension | '%pQuote%%pFieldDelim%';

                nCount = nCount + 1;
            End;

            # Finish off the strings
            sTitle = sTitle | '%pQuote%Value%pQuote%';

        Else;

            While( nCount <= nDimensionCount );

                # Determine title string for the source cube
                sPos_Dim = Dimnm( cTempObject, nCount );
                sDimension = Delet( sPos_Dim, 1, Scan( '_', sPos_Dim ));
                sTitle = sTitle | '%pFieldDelim%%pQuote%' | sDimension | '%pQuote%';

                nCount = nCount + 1;
            End;

            # Finish off the strings
            sTitle = sTitle | '%pFieldDelim%%pQuote%Value%pQuote%';

        EndIf;

    EndIf;

    TextOutput( cExportFile, Expand(sTitle) );
EndIf;

If( value_is_string = 0 );
    # Conver a number to a string
    sValue = NumberToStringEx( nValue, '#,0.#############', sDecimalSeparator, sThousandSeparator );
Else;
    # Remove CRs/LFs
    c = 1;
    While( c <= 2 );
        nChar = If( c = 1, 10, 16 );

        If( Scan( Char( nChar ), sValue ) > 0 );
            sValueCleaned = '';
            nNoChar = 1;
            nLimit = Long( sValue );
            While( nNoChar <= nLimit );
                sChar = Subst( sValue, nNoChar, 1 );
                If( Code( sChar, 1 ) <> nChar );
                    sValueCleaned = sValueCleaned | sChar;
                Else;
                    sValueCleaned = sValueCleaned | ' ';
                EndIf;
                nNoChar = nNoChar + 1;
            End;
            sValue = sValueCleaned;
        EndIf;
        c = c + 1;
    End;
EndIf;

# Output data
TextOutput( cExportFile, Expand(sRow) );

### End Data ###
575,46
#****Begin: Generated Statements***
#****End: Generated Statements****

#################################################################################################
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
#################################################################################################

If( pTitleRecord = 2 );
    DimensionDestroy( cTempObject );
EndIf;

### Delete source data ###
If( pZeroSource = 1 & nErrors = 0 );
    If ( pCubeLogging <= 1 );
      CubeSetLogChanges( pCube, pCubeLogging);
    EndIf;
    ViewZeroOut( pCube, cView );
    If ( pCubeLogging <= 1 );
      CubeSetLogChanges( pCube, IF(sCubeLogging @= 'YES', 1, 0 ) );
    EndIf;
EndIf;

### Return code & final error message handling
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
    If( pStrictErrorHandling = 1 );
        If( CubeExists(pCube) = 1 );
          CubeSetLogChanges( pCube, IF(sCubeLogging @= 'YES', 1, 0 ) );
        EndIf;
        ProcessQuit;
    EndIf;
Else;
    sDataCount = NumberToString( nDataCount );
    sProcessAction = Expand( 'Process:%cThisProcName% exported %sDataCount% records from %pCube% based on MDX %pMDXExpr%.' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogoutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );
    EndIf;

EndIf;

### End Epilog ###
576,CubeAction=1511DataAction=1503CubeLogChanges=0_ParameterConstraints=e30=
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
