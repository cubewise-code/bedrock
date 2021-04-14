601,100
602,"}bedrock.hier.export.script"
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"zr9=1nv7R[og<ncfQCF1PN]EGvaVz^Emy5zKLaH@8\YOz`QF7qPrKHt3ta1LZZ9uiAoDD`w5XTV0`bIviM[=QnzUw\>x[4z`WPa052L=]cE:xWx5Emssxtj[v5hCPg46dd>dP?d0yRH<DyzS774tZHQlY91ODZtZdsP^B6lhbX46yFnW]rr;ZUS400POt`j2w4YZ:Xh8"
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
571,All
569,0
592,0
599,1000
560,13
pLogOutput
pStrictErrorHandling
pDim
pEle
pDelim
pTgtDir
pTgtFile
pTitleRecord
pDimInfo
pAttr
pSub
pAttrVal
pCharacterSet
561,13
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
2
590,13
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pEle,""
pDelim,"&"
pTgtDir,""
pTgtFile,""
pTitleRecord,1
pDimInfo,1
pAttr,1
pSub,0
pAttrVal,1
pCharacterSet,""
637,13
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"REQUIRED: Target Dimension or Hierarchy (as dim:hier), accepts wildcards (if = *, then all the dimensions)"
pEle,"OPTIONAL: Target Element(s), accepts wildcards ( * will include ALL)"
pDelim,"OPTIONAL: Delimiter character if list used for pDim, pHier or pEle"
pTgtDir,"OPTIONAL: Target Directory Path (defaults to Error File Directory if blank)"
pTgtFile,"OPTIONAL: Root file name without file extension. If blank ""bedrock_dimension_script"" will be used"
pTitleRecord,"REQUIRED: Boolean 1 = Yes - Include header row"
pDimInfo,"OPTIONAL: Include dimension info section (SortOrder, HierarchyProperties, etc.)"
pAttr,"OPTIONAL: Include creation of attributes"
pSub,"OPTIONAL: Include subset definitions"
pAttrVal,"OPTIONAL: Include attribute values (for selected elements in pEle)"
pCharacterSet,"OPTIONAL: The output character set (defaults to TM1CS_UTF8 if blank)"
577,1
vDim
578,1
2
579,1
1
580,1
0
581,1
0
582,1
VarType=32ColType=827
603,0
572,232
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.export.script', 'pLogOutput', pLogOutput,
         'pStrictErrorHandling', pStrictErrorHandling,
         'pDim', '', 'pEle', '', 'pDelim', '&', 
         'pTgtDir', '', 'pTitleRecord', 1,
         'pDimInfo', 1, 'pAttr', 1, 'pAttrVal', 1, 'pSub', 0
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
# This process exports a dimension hierarchies as _TurboIntegrator script_. This is rather than creating a CSV which can be read by a generic 
# TurboIntegrator process this process creates a _**hardcoded**_ TurboIntegrator process to create a dimension/hierarchy complete with rollup 
# structure, attribute values, subsets and metadata information such as sort order, MDX hierarchy names and levels and captions.
#
# Use case:
# The specific use case where this process will be useful is to automate the creation of TurboIntegrator script for promotion/migration purposes
# as 100% stand-alone without need for data source o any parameters for the process. This can be useful in situations where DevOps has no file system access
# to an environment and for manually defined dimensions such as measures.
#
# Note:
# Several parameters control the scope of what is exported.
# * pDim accepts wildcard and lists of dimensions and/or hierarchies to filter the **}Dimensions** dimension. There is no separate **pHier** parameter for this process
# * pEle accepts wildcard and lists of _elements_. This can be used to limit the scope of the export of dimension structure and attribute values to a subset of elements
# * pDimInfo 1/0 numeric Boolean whether to include metadata relevant to the dimensions/hierarchies defined in pDim from }DimensionProperties, }HierarchyProperties and }DimensionAttributes
# * pAttr 1/0 numeric Boolean whether to include attribute creation
# * pAttrVal 1/0 numeric Boolean whether to include attribute values (for the elements defined in pEle )
# * pSub 1/0 numeric Boolean whether to include subset definitions for dynamic and static subsets
# * There is no Boolean for exporting dimension structure, this is determined by pEle. To export all elements use pEle="*". To suppress export of rollup structure (and attribute values) use pEle=""
# * 2 scripts are produced. One to copy/paste into prolog and one for epilog as Direct functions are not used for creation of elements and parent-child relationships
#
# Caution: 
# This process is designed for _**smaller (typically manually defined) dimensions**_. No check is implemented for upper limit of the set of elements defined by pEle if run on a large 
# dimension then the export script will be correspondingly large. 
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName   = GetProcessName();
cUserName       = TM1User();
cTimeStamp      = TimSt( Now, '\Y\m\d\h\i\s' );
cTimeStampPrint = TimSt( Now, '\Y-\m-\d \h:\i:\s' );
cRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
cTempSub        = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cMsgErrorLevel  = 'ERROR';
cMsgErrorContent= 'Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo        = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pEle:%pEle%, pDelim:%pDelim%, pTgtDir:%pTgtDir%, pTgtFile:%pTgtFile%, pTitleRecord:%pTitleRecord%, pDimInfo:%pDimInfo%, pAttr:%pAttr%, pAttrVal:%pAttrVal%, pSub:%pSub%';
cCubeS1         = '}DimensionProperties';
pDelim          = Trim( pDelim );
cLenASCIICode   = 3;
cHashLine       = '#################################################################################################';
sAttrDone       = '';

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Initialise ###
nRecordCount = 0;

### Validate Parameters ###
nErrors = 0;

## Validate Source dimension
IF( Trim( pDim ) @= '' );
    nErrors = 1;
    sMessage = 'No dimension specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIF( Scan( '*', pDim ) = 0 & Scan( '?', pDim ) = 0 & Scan( pDelim, pDim ) = 0 & DimensionExists( pDim ) = 0 );
    nErrors = 1;
    sMessage = 'Invalid dimension: ' | pDim;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate element
If( pEle @<> '');
    If( Scan( '*', pEle ) = 0 & Scan( '?', pEle ) = 0 & Scan( pDelim, pEle ) = 0 & DimIx( pDim, pEle ) = 0 );
        nErrors = 1;
        sMessage = 'Item ' | pEle | ' does NOT exist. Please enter a valid element in the ' |pDim| ' dimension.';  
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    Endif;
Endif;

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

# Validate export path
If( Trim( pTgtDir ) @= '' );
    pTgtDir     = GetProcessErrorFileDirectory;
    sMessage    = 'Target folder defaulted to error file directory.';
    LogOutput( 'INFO', Expand( cMsgErrorContent ) );
EndIf;
If( SubSt( pTgtDir, Long( pTgtDir ), 1 ) @= sOSDelim );
    pTgtDir     = SubSt( pTgtDir, 1, Long( pTgtDir ) -1 );
EndIf;
If( FileExists( pTgtDir ) = 0 );
    nErrors     = 1;
    sMessage    = 'Invalid export path specified. Folder does not exist.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;
pTgtDir         = pTgtDir | sOSDelim;

# Validate export filename
If( pTgtFile    @= '' );
    pTgtFile1   = 'bedrock_dimension_script_prolog.txt';
    pTgtFile2   = 'bedrock_dimension_script_epilog.txt';
Else;
    If( SubSt( pTgtFile, Long( pTgtFile ) - 4, 1 ) @= '.' );
        pTgtFile = SubSt( pTgtFile, 1, Long( pTgtFile ) - 5 );
    EndIf;
    If( SubSt( pTgtFile, Long( pTgtFile ), 1 ) @= '_' );
        pTgtFile = SubSt( pTgtFile, 1, Long( pTgtFile ) - 1 );
    EndIf;
    pTgtFile1   = pTgtFile | '_prolog.txt';
    pTgtFile2   = pTgtFile | '_epilog.txt';

EndIf;

# Validate file delimiter & quote character
If( pDelim @= '' );
    pDelim      = '&';
Else;
    # If length of pDelim is exactly 3 chars and each of them is decimal digit, then the pDelim is entered as ASCII code
    nValid      = 0;
    If ( LONG(pDelim) = cLenASCIICode );
      nChar     = 1;
      While ( nChar <= cLenASCIICode );
        If( CODE( pDelim, nChar )>=CODE( '0', 1 ) & CODE( pDelim, nChar )<=CODE( '9', 1 ) );
          nValid = 1;
        Else;
          nValid = 0;
        EndIf;
        nChar   = nChar + 1;
      End;
    EndIf;
    If ( nValid<>0 );
      pDelim    = Char( StringToNumber( pDelim ) );
    Else;
      pDelim    = SubSt( Trim( pDelim ), 1, 1 );
    EndIf;
EndIf;

# Validate Character Set
If(Trim( pCharacterSet ) @= '' );
  pCharacterSet = 'TM1CS_UTF8';
EndIf;

# Use no quote character 
pQuote          = '';

# Construct full export filename including path
sFileName       = pTgtDir | pTgtFile1;
sFileName2      = pTgtDir | pTgtFile2;

# If blank delimiter specified then convert to default
If( pDelim @= '' );
    pDelim = '&';
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

# Loop through dimensions in pDim
sDims = pDim;
nDimDelimiterIndex = 1;
sMdx = '';
# Get 1st dimension
While( nDimDelimiterIndex <> 0 );
    # Extract 1st dimension > sDim
    nDimDelimiterIndex = Scan( pDelim, sDims );
    If( nDimDelimiterIndex = 0 );
        sDim = sDims;
    Else;
        sDim = Trim( SubSt( sDims, 1, nDimDelimiterIndex - 1 ) );
        sDims = Trim( Subst( sDims, nDimDelimiterIndex + Long(pDelim), Long( sDims ) ) );
    EndIf;
    
    # Create subset of dimensions using Wildcard to loop through dimensions in pDim with wildcard
    sDimExp = '"'|sDim|'"';
    sMdxPart = Expand('{TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions].[}Dimensions] ), %sDimExp% )}');
    If( sMdx @= ''); 
        sMdx = sMdxPart; 
    Else;
        sMdx = sMdx | ' + ' | sMdxPart;
    EndIf;
End;

If( SubsetExists( '}Dimensions' , cTempSub ) = 1 );
    # If a delimited list of dim names includes wildcards then we may have to re-use the subset multiple times
    SubsetMDXSet( '}Dimensions' , cTempSub, sMDX );
Else;
    # temp subset, therefore no need to destroy in epilog
    SubsetCreatebyMDX( cTempSub, sMDX, '}Dimensions' , 1 );
EndIf;

# Assign Data Source
DataSourceType                  = 'SUBSET';
DatasourceNameForServer         = '}Dimensions';
DatasourceDimensionSubset       = cTempSub;
DatasourceASCIIQuoteCharacter   = pQuote;

### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,544

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

# Set the output character set
SetOutputCharacterSet( sFileName, pCharacterSet );

### Record Count
nRecordCount = nRecordCount + 1;

### Set dimension & hierarchy variables
If( Scan( ':', vDim ) = 0 );
    sDim    = vDim;
    sHier   = vDim;
Else;
    sDim    = SubSt( vDim, 1, Scan( ':', vDim ) - 1 );
    sHier   = SubSt( vDim, Scan( ':', vDim ) + 1, Long( vDim ) - ( Long( sDim ) + 1 ) );
EndIf;
sDimAttr    = '}ElementAttributes_' | sDim;
sDimSub     = '}Subsets_' | sDim;

### Export Header Information
If( nRecordCount = 1 & pTitleRecord = 1 );
    sHeader = Expand('# Export dimensions as script pDim=%pDim% pEle=%pEle% On %cTimeStampPrint%');
    TextOutput( sFileName, sHeader );
    If( ( pAttrVal = 1 & DimensionExists( sDimAttr ) = 1 & pEle @<> '' ) % ( pSub = 1 & DimensionExists( sDimSub ) = 1 ) );
        sHeader = Expand('# Export dimensions as script pDim=%pDim% pEle=%pEle% On %cTimeStampPrint%');
        TextOutput( sFileName2, sHeader );
    EndIf;
EndIf;

### Dimension write open
TextOutput( sFileName, '' );
TextOutput( sFileName, cHashLine );
TextOutput( sFileName, Expand('#Region Dimension/Hierarchy: %vDim%') );
If( ( pAttrVal = 1 & DimensionExists( sDimAttr ) = 1 & pEle @<> '' ) % ( pSub = 1 & DimensionExists( sDimSub ) = 1 ) );
    TextOutput( sFileName2, '' );
    TextOutput( sFileName2, cHashLine );
    TextOutput( sFileName2, Expand('#Region Dimension/Hierarchy: %vDim% (EPILOG)') );
EndIf;

#################################################################################################
#Region Create Dimension (PROLOG)
TextOutput( sFileName, '' );
TextOutput( sFileName, Expand('sDimHier = ''%vDim%'';') );
TextOutput( sFileName, Expand('sDim     = ''%sDim%'';') );
TextOutput( sFileName, Expand('sHier    = ''%sHier%'';') );
TextOutput( sFileName, Expand('sDimAttr = ''%sDimAttr%'';') );
TextOutput( sFileName, 'If( DimensionExists( sDim ) = 0 );');
TextOutput( sFileName, '    DimensionCreate( sDim );');
TextOutput( sFileName, '    If( sDim @<> sHier );');
TextOutput( sFileName, '        HierarchyCreate( sDim, sHier );');
TextOutput( sFileName, '    EndIf;' );
TextOutput( sFileName, 'ElseIf( sDim @<> sHier );');
TextOutput( sFileName, '    If( HierarchyExists( sDim, sHier ) = 0 );');
TextOutput( sFileName, '        HierarchyCreate( sDim, sHier );');
TextOutput( sFileName, '    EndIf;' );
TextOutput( sFileName, 'EndIf;' );
#EndRegion Create Dimension
#################################################################################################

#################################################################################################
#Region Dimension Info (PROLOG)
If( pDimInfo = 1 );
    TextOutput( sFileName, '' );
    TextOutput( sFileName, cHashLine );
    TextOutput( sFileName, Expand('#Region Dimension Info: %vDim%') );
    sSORTELEMENTSTYPE   = CellGetS( '}DimensionProperties', vDim, 'SORTELEMENTSTYPE' );
    sSORTCOMPONENTSTYPE = CellGetS( '}DimensionProperties', vDim, 'SORTCOMPONENTSTYPE' );
    sSORTELEMENTSSENSE  = CellGetS( '}DimensionProperties', vDim, 'SORTELEMENTSSENSE' );
    sSORTCOMPONENTSSENSE= CellGetS( '}DimensionProperties', vDim, 'SORTCOMPONENTSSENSE' );
    sDefHier            = CellGetS( '}DimensionProperties', vDim, 'DEFAULT_HIERARCHY' );
    sDefMember          = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'defaultMember' );
    sHierLevels         = NumberToString( CellGetN( '}HierarchyProperties', vDim, 'hierarchy0', 'LevelsToHierarchize' ) );
    sLevel000           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level000' );
    sLevel001           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level001' );
    sLevel002           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level002' );
    sLevel003           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level003' );
    sLevel004           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level004' );
    sLevel005           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level005' );
    sLevel006           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level006' );
    sLevel007           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level007' );
    sLevel008           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level008' );
    sLevel009           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level009' );
    sLevel010           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level010' );
    sLevel011           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level011' );
    sLevel012           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level012' );
    sLevel013           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level013' );
    sLevel014           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level014' );
    sLevel015           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level015' );
    sLevel016           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level016' );
    sLevel017           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level017' );
    sLevel018           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level018' );
    sLevel019           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level019' );
    sLevel020           = CellGetS( '}HierarchyProperties', vDim, 'hierarchy0', 'level020' );
    TextOutput( sFileName, Expand('DimensionSortOrder( sDimHier, ''%sSORTCOMPONENTSTYPE%'', ''%sSORTCOMPONENTSSENSE%'', ''%sSORTELEMENTSTYPE%'', ''%sSORTELEMENTSSENSE%'' );') );
    TextOutput( sFileName, Expand('CellPutS( ''%sDefHier%'', ''}DimensionProperties'', sDimHier, ''DEFAULT_HIERARCHY'' );') );
    TextOutput( sFileName, Expand('CellPutS( ''%sDefMember%'', ''}HierarchyProperties'', sDimHier, ''hierarchy0'', ''defaultMember'' );') );
    TextOutput( sFileName, Expand('CellPutN( %sHierLevels%, ''}HierarchyProperties'', sDimHier, ''hierarchy0'', ''LevelsToHierarchize'' );') );
    nCtr                = 0;
    While( nCtr         <= 20 );
        sLvl            = 'Level0' | If( nCtr < 10, '0', '' ) | NumberToString( nCtr ); 
        sLvlVal         = Expand('%'| Expand('s%sLvl%') |'%');
        If( sLvlVal     @<> '' );
            TextOutput( sFileName, Expand('CellPutS( ''%sLvlVal%'', ''}HierarchyProperties'', sDimHier, ''hierarchy0'', ''%sLvl%'' );') );
        EndIf;
        nCtr            = nCtr + 1;
    End;
    If( CubeExists( '}DimensionAttributes' ) = 1 );
        nCtr            = 1;
        While( nCtr     <= DimSiz( '}DimensionAttributes' ) );
            sAttr       = DimNm( '}DimensionAttributes', nCtr );
            sAttrTyp    = SubSt( DType( '}DimensionAttributes', sAttr ), 2, 1 );
            sAttrVal    = If( sAttrTyp @= 'N', NumberToString( DimensionAttrN( vDim, sAttr ) ), DimensionAttrS( vDim, sAttr ) );
            TextOutput( sFileName, Expand('DimensionAttrInsert( '''', ''%sAttr%'', ''%sAttrTyp%'' );') );
            If( sAttrTyp @= 'N' );
                TextOutput( sFileName, Expand('DimensionAttrPutN( %sAttrVal%, sDimHier, ''%sAttr%'' );') );
            Else;
                TextOutput( sFileName, Expand('DimensionAttrPutS( ''%sAttrVal%'', sDimHier, ''%sAttr%'' );') );
            EndIf;
            nCtr        = nCtr + 1;
        End;
    EndIf;
    TextOutput( sFileName, Expand('#EndRegion Dimension Info: %vDim%') );
    TextOutput( sFileName, cHashLine );
EndIf;
#EndRegion Dimension Info
#################################################################################################

#################################################################################################
#Region Create Attributes (PROLOG)
If( pAttr = 1 & DimensionExists( sDimAttr ) = 1 & Scan( sDim|pDelim, sAttrDone ) = 0 );
    sAttrDone       = sAttrDone | sDim | pDelim;
    TextOutput( sFileName, '' );
    TextOutput( sFileName, cHashLine );
    TextOutput( sFileName, Expand('#Region Create Attributes: %sDim%') );
    nCtr            = 1;
    While( nCtr     <= DimSiz( sDimAttr ) );
        sAttr       = DimNm( sDimAttr, nCtr );
        sAttrTyp    = SubSt( DType( sDimAttr, sAttr ), 2, 1 );
        # Escape potential single apostrophes to avoid parsing errors in attribute names
        nChar = 1;
        nCount = 0;
        sAttrStrOut = '';
        While( nChar <= LONG( sAttr ) + 1 );
            If( nChar <= LONG( sAttr ) );
                sChar = SUBST( sAttr, nChar, 1 );
            Else;
                sChar = '';
            EndIf;
            If( sChar @= '''' );
                nCount = nCount + 1;
            ElseIf( nCount > 0 );
                If( MOD( nCount, 2 ) <> 0 );
                    sAttrStrOut = sAttrStrOut | '''';
                EndIf;
                nCount = 0;
            EndIf;
            sAttrStrOut = sAttrStrOut | sChar;
            nChar = nChar + 1;
        End;
        If( nCtr = 1 );
            TextOutput( sFileName, 'If( DimensionExists( sDimAttr ) = 0 % CubeExists( sDimAttr ) = 0 );');
            TextOutput( sFileName, Expand('    AttrInsert( sDim, '''', ''%sAttrStrOut%'', ''%sAttrTyp%'' );') );
            TextOutput( sFileName, 'EndIf;' );
        EndIf;
        TextOutput( sFileName, Expand('If( DimIx( sDimAttr, ''%sAttrStrOut%'' ) = 0 );') );
        TextOutput( sFileName, Expand('    AttrInsert( sDim, '''', ''%sAttrStrOut%'', ''%sAttrTyp%'' );') );
        TextOutput( sFileName, 'Else;' );
        TextOutput( sFileName, Expand('    If( DType( sDimAttr, ''%sAttrStrOut%'' ) @<> ''A%sAttrTyp%'' );') );
        TextOutput( sFileName, Expand('        AttrDelete( sDim, ''%sAttrStrOut%'' );') );
        TextOutput( sFileName, Expand('        AttrInsert( sDim, '''', ''%sAttrStrOut%'', ''%sAttrTyp%'' );') );
        TextOutput( sFileName, '    EndIf;' );
        TextOutput( sFileName, 'EndIf;' );
        nCtr        = nCtr + 1;
    End;
    TextOutput( sFileName, Expand('#EndRegion Create Attributes: %sDim%') );
    TextOutput( sFileName, cHashLine );
EndIf;
#EndRegion Create Attributes
#################################################################################################

#################################################################################################
#Region Create Dimension/Hierarchy Structure (PROLOG)
If( pEle @<> '' );
    sMDX = '';
    If( pEle @= '*' );
        sMDX = Expand('{TM1SubsetAll([%sDim%].[%sHier%])}');
    Else;
        # Loop through elements (inc. wildcard expressions) in pEle
        sEles = pEle;
        nEleDelimiterIndex = 1;
        # Get 1st ele
        While( nEleDelimiterIndex <> 0 );
            # Extract 1st ele in sEles
            nEleDelimiterIndex = Scan( pDelim, sEles );
            If( nEleDelimiterIndex = 0 );
                sEle = sEles;
            Else;
                sEle = Trim( SubSt( sEles, 1, nEleDelimiterIndex - 1 ) );
                sEles = Trim( Subst( sEles, nEleDelimiterIndex + Long( pDelim ), Long( sEles ) ) );
            EndIf;
            If( Scan( '*', sEle ) > 0 % Scan( '?', sEle ) > 0 );
                # Create MDX for subset of eles using Wildcard Pattern filter (means pEle entry MUST use principal name)
                sEleExp = '"'|sEle|'"';
                sMdxPart = Expand('{TM1FILTERBYPATTERN( TM1SUBSETALL( [%sDim%].[%sHier%] ), %sEleExp% )}');
            Else;
                # Create MDX of single element and all descendants
                sMDXPart = Expand('{TM1DRILLDOWNMEMBER( {[%sDim%].[%sHier%].[%sEle%]}, ALL, RECURSIVE )}');
            EndIf;
            If( sMDX @= ''); 
                sMDX = sMdxPart; 
            Else;
                sMDX = sMDX | ' + ' | sMdxPart;
            EndIf;
        End;
    EndIf;
    If( SubsetExists( vDim, cTempSub ) = 1 );
        SubsetMDXSet( vDim, cTempSub, sMDX );
    Else;
        SubsetCreatebyMDX( cTempSub, sMDX, vDim, 1 );
    EndIf;
    nMax = SubsetGetSize( vDim, cTempSub );
    If( nMax >= 1 );
        TextOutput( sFileName, '' );
        TextOutput( sFileName, cHashLine );
        TextOutput( sFileName, Expand('#Region Create Elements: %vDim%') );
        nCtr = 1;
        While( nCtr <= nMax );
            # 1st insert all elements to get correct order
            sEle = SubsetGetElementName( vDim, cTempSub, nCtr );
            # Escape potential single apostrophes to avoid parsing errors in element names
            nChar = 1;
            nCount = 0;
            sEleStrOut = '';
            While( nChar <= LONG( sEle ) + 1 );
                If( nChar <= LONG( sEle ) );
                    sChar = SUBST( sEle, nChar, 1 );
                Else;
                    sChar = '';
                EndIf;
                If( sChar @= '''' );
                    nCount = nCount + 1;
                ElseIf( nCount > 0 );
                    If( MOD( nCount, 2 ) <> 0 );
                        sEleStrOut = sEleStrOut | '''';
                    EndIf;
                    nCount = 0;
                EndIf;
                sEleStrOut = sEleStrOut | sChar;
                nChar = nChar + 1;
            End;
            sEleTyp = DType( vDim, sEle );
            TextOutput( sFileName, Expand('DimensionElementInsert( sDimHier, '''', ''%sEleStrOut%'', ''%sEleTyp%'' );') );
            nCtr    = nCtr + 1;
        End;
        nCtr = 1;
        While( nCtr <= nMax );
            # 2nd loop again and create parent linkages
            sEle    = SubsetGetElementName( vDim, cTempSub, nCtr );
            # Escape potential single apostrophes to avoid parsing errors in element names
            nChar = 1;
            nCount = 0;
            sEleStrOut = '';
            While( nChar <= LONG( sEle ) + 1 );
                If( nChar <= LONG( sEle ) );
                    sChar = SUBST( sEle, nChar, 1 );
                Else;
                    sChar = '';
                EndIf;
                If( sChar @= '''' );
                    nCount = nCount + 1;
                ElseIf( nCount > 0 );
                    If( MOD( nCount, 2 ) <> 0 );
                        sEleStrOut = sEleStrOut | '''';
                    EndIf;
                    nCount = 0;
                EndIf;
                sEleStrOut = sEleStrOut | sChar;
                nChar = nChar + 1;
            End;
            nPar    = 1;
            While( nPar <= ElParN( vDim, sEle ) );
                sPar = ElPar( vDim, sEle, nPar );
                # Escape potential single apostrophes to avoid parsing errors in parent element names
                nChar = 1;
                nCount = 0;
                sParStrOut = '';
                While( nChar <= LONG( sPar ) + 1 );
                    If( nChar <= LONG( sPar ) );
                        sChar = SUBST( sPar, nChar, 1 );
                    Else;
                        sChar = '';
                    EndIf;
                    If( sChar @= '''' );
                        nCount = nCount + 1;
                    ElseIf( nCount > 0 );
                        If( MOD( nCount, 2 ) <> 0 );
                            sParStrOut = sParStrOut | '''';
                        EndIf;
                        nCount = 0;
                    EndIf;
                    sParStrOut = sParStrOut | sChar;
                    nChar = nChar + 1;
                End;
                sWht = NumberToString( ElWeight( vDim, sPar, sEle ) );
                If( pEle @<> '*' );
                    TextOutput( sFileName, Expand('DimensionElementInsert( sDimHier, '''', ''%sParStrOut%'', ''C'' );') );
                EndIf;
                TextOutput( sFileName, Expand('DimensionElementComponentAdd( sDimHier, ''%sParStrOut%'', ''%sEleStrOut%'', %sWht% );') );
                nPar = nPar + 1;
            End;
            nCtr     = nCtr + 1;
        End;
        TextOutput( sFileName, Expand('#EndRegion Create Elements: %vDim%') );
        TextOutput( sFileName, cHashLine );
    EndIf;
EndIf;
#EndRegion Create Structure
#################################################################################################

#################################################################################################
#Region Attribute Values (EPILOG)
If( pAttrVal = 1 & DimensionExists( sDimAttr ) = 1 & nMax >=1 );
    TextOutput( sFileName2, '' );
    TextOutput( sFileName2, cHashLine );
    TextOutput( sFileName2, Expand('#Region Attribute Values: %vDim%') );
    TextOutput( sFileName2, Expand('sDimHier = ''%vDim%'';') );
    TextOutput( sFileName2, Expand('sDim     = ''%sDim%'';') );
    TextOutput( sFileName2, Expand('sHier    = ''%sHier%'';') );
    TextOutput( sFileName2, Expand('sDimAttr = ''%sDimAttr%'';') );
    nCtr = 1;
    While( nCtr <= nMax );
        # loop elements again and internally loop attributes
        sEle = SubsetGetElementName( vDim, cTempSub, nCtr );
        # Escape potential single apostrophes to avoid parsing errors in element names
        nChar = 1;
        nCount = 0;
        sEleStrOut = '';
        While( nChar <= LONG( sEle ) + 1 );
            If( nChar <= LONG( sEle ) );
                sChar = SUBST( sEle, nChar, 1 );
            Else;
                sChar = '';
            EndIf;
            If( sChar @= '''' );
                nCount = nCount + 1;
            ElseIf( nCount > 0 );
                If( MOD( nCount, 2 ) <> 0 );
                    sEleStrOut = sEleStrOut | '''';
                EndIf;
                nCount = 0;
            EndIf;
            sEleStrOut = sEleStrOut | sChar;
            nChar = nChar + 1;
        End;
        sEleTyp = DType( vDim, sEle );
        nAttr   = 1;
        While( nAttr <= DimSiz( sDimAttr ) );
            sAttr       = DimNm( sDimAttr, nAttr );
            # Escape potential single apostrophes to avoid parsing errors in attribute names
            nChar = 1;
            nCount = 0;
            sAttrStrOut = '';
            While( nChar <= LONG( sAttr ) + 1 );
                If( nChar <= LONG( sAttr ) );
                    sChar = SUBST( sAttr, nChar, 1 );
                Else;
                    sChar = '';
                EndIf;
                If( sChar @= '''' );
                    nCount = nCount + 1;
                ElseIf( nCount > 0 );
                    If( MOD( nCount, 2 ) <> 0 );
                        sAttrStrOut = sAttrStrOut | '''';
                    EndIf;
                    nCount = 0;
                EndIf;
                sAttrStrOut = sAttrStrOut | sChar;
                nChar = nChar + 1;
            End;
            sAttrTyp    = SubSt( DType( sDimAttr, sAttr ), 2, 1 );
            sAttrVal    = '';
            If( ( sDim @<> sHier & sEleTyp @<> 'N' ) & sAttrTyp @= 'N' );
                sAttrVal= NumberToString( ElementAttrN( sDim, sHier, sEle, sAttr ) );
            ElseIf( sDim @<> sHier & sEleTyp @<> 'N' );
                sAttrVal= ElementAttrS( sDim, sHier, sEle, sAttr );
            ElseIf( sEleTyp @= 'N' & sAttrTyp @= 'N' & DimIx( sDim, sEle ) = 0 );
                sAttrVal= NumberToString( ElementAttrN( sDim, sHier, sEle, sAttr ) );
            ElseIf( sEleTyp @= 'N' & DimIx( sDim, sEle ) = 0 );
                sAttrVal= ElementAttrS( sDim, sHier, sEle, sAttr );
            ElseIf( sAttrTyp @= 'N' );
                sAttrVal= NumberToString( AttrN( sDim, sEle, sAttr ) );
            Else;
                sAttrVal= AttrS( sDim, sEle, sAttr );
            EndIf;
            sAttrValStrOut = '';
            If( sAttrVal @<> '' );
                If( sAttrTyp @<> 'N' );
                    # Escape potential single apostrophes to avoid parsing errors in attribute values
                    nChar = 1;
                    nCount = 0;
                    While( nChar <= LONG( sAttrVal ) + 1 );
                        If( nChar <= LONG( sAttrVal ) );
                            sChar = SUBST( sAttrVal, nChar, 1 );
                        Else;
                            sChar = '';
                        EndIf;
                        If( sChar @= '''' );
                            nCount = nCount + 1;
                        ElseIf( nCount > 0 );
                            If( MOD( nCount, 2 ) <> 0 );
                                sAttrValStrOut = sAttrValStrOut | '''';
                            EndIf;
                            nCount = 0;
                        EndIf;
                        sAttrValStrOut = sAttrValStrOut | sChar;
                        nChar = nChar + 1;
                    End;
                Else;
                    # we won't need any tratment for non-string attributes
                    sAttrValStrOut = sAttrVal;
                EndIf;
                If( ( sDim @<> sHier & sEleTyp @<> 'N' ) & sAttrTyp @= 'N' );
                    TextOutput( sFileName2, Expand('ElementAttrPutN( %sAttrValStrOut%, sDim, sHier, ''%sEleStrOut%'', ''%sAttrStrOut%'' );') );
                ElseIf( sDim @<> sHier & sEleTyp @<> 'N' );
                    TextOutput( sFileName2, Expand('ElementAttrPutS( ''%sAttrValStrOut%'', sDim, sHier, ''%sEleStrOut%'', ''%sAttrStrOut%'' );') );
                ElseIf( sEleTyp @= 'N' & sAttrTyp @= 'N' & DimIx( sDim, sEle ) = 0 );
                    TextOutput( sFileName2, Expand('ElementAttrPutN( %sAttrValStrOut%, sDim, sHier, ''%sEleStrOut%'', ''%sAttrStrOut%'' );') );
                ElseIf( sEleTyp @= 'N' & DimIx( sDim, sEle ) = 0 );
                    TextOutput( sFileName2, Expand('ElementAttrPutS( ''%sAttrValStrOut%'', sDim, sHier, ''%sEleStrOut%'', ''%sAttrStrOut%'' );') );
                ElseIf( sAttrTyp @= 'N' );
                    TextOutput( sFileName2, Expand('AttrPutN( %sAttrValStrOut%, sDim, ''%sEleStrOut%'', ''%sAttrStrOut%'' );') );
                Else;
                    TextOutput( sFileName2, Expand('AttrPutS( ''%sAttrValStrOut%'', sDim, ''%sEleStrOut%'', ''%sAttrStrOut%'' );') );
                EndIf;
            EndIf;
            nAttr = nAttr + 1;
        End;
        nCtr    = nCtr + 1;
    End;
    TextOutput( sFileName2, Expand('#EndRegion Attribute Values: %vDim%') );
    TextOutput( sFileName2, cHashLine );
EndIf;
#EndRegion Attribute Values
#################################################################################################

#################################################################################################
#Region Subsets (EPILOG)
If( pSub = 1 & DimensionExists( sDimSub ) = 1 );
    If( sDim @= vDim );
        sMDX = Expand('{Except( {TM1SubsetAll( [%sDimSub%] )}, {TM1FilterByPattern( {TM1SubsetAll( [%sDimSub%] )}, "*:*" )} )}');
    Else;
        sMDX = Expand('{TM1FilterByPattern( {TM1SubsetAll( [%sDimSub%] )}, "%sHier%:*" )}');
    EndIf;
    If( SubsetExists( sDimSub, cTempSub ) = 1 );
        SubsetMDXSet( sDimSub, cTempSub, sMDX );
    Else;
        SubsetCreatebyMDX( cTempSub, sMDX, sDimSub, 1 );
    EndIf;
    nMax = SubsetGetSize( sDimSub, cTempSub );
    If( nMax >= 1 );
        TextOutput( sFileName2, '' );
        TextOutput( sFileName2, cHashLine );
        TextOutput( sFileName2, Expand('#Region Subsets: %vDim%') );
        If( pAttrVal <> 1 % DimensionExists( sDimAttr ) = 0 % pEle @= '' );
            TextOutput( sFileName2, Expand('sDimHier = ''%vDim%'';') );
            TextOutput( sFileName2, Expand('sDim     = ''%sDim%'';') );
            TextOutput( sFileName2, Expand('sHier    = ''%sHier%'';') );
            TextOutput( sFileName2, Expand('sDimAttr = ''%sDimAttr%'';') );
        EndIf;
        nCtr = 1;
        While( nCtr <= nMax );
            sSub        = SubsetGetElementName( sDimSub, cTempSub, nCtr );
            If( Scan( ':', sSub ) > 0 );
                sSub    = SubSt( sSub, Scan( ':', sSub ) + 1, Long( sSub ) );
            EndIf;
            sMDX        = SubsetMDXGet( vDim, sSub );
            # If MDX expression contains TM1SubsetBasis function then treat it as a static subset
            If( sMDX @<> '' & Scan( 'TM1SUBSETBASIS()', Upper( sMDX ) ) = 0 );
                # create by MDX
                TextOutput( sFileName2, Expand('If( SubsetExists( sDimHier, ''%sSub%'' ) = 0 );') );
                TextOutput( sFileName2, Expand('    SubsetCreatebyMDX( ''%sSub%'', ''%sMDX%'', sDimHier, 0 );') );
                TextOutput( sFileName2, 'Else;' );
                TextOutput( sFileName2, Expand('    SubsetMDXSet( sDimHier, ''%sSub%'', ''%sMDX%'' );') );
                TextOutput( sFileName2, 'EndIf;' );
            Else;
                # loop members
                TextOutput( sFileName2, Expand('If( SubsetExists( sDimHier, ''%sSub%'' ) = 0 );') );
                TextOutput( sFileName2, Expand('    SubsetCreate( sDimHier, ''%sSub%'' );') );
                TextOutput( sFileName2, 'Else;' );
                TextOutput( sFileName2, Expand('    SubsetDeleteAllElements( sDimHier, ''%sSub%'' );') );
                TextOutput( sFileName2, 'EndIf;' );
                nEles   = SubsetGetSize( vDim, sSub );
                nEle    = 1;
                While( nEle <= nEles );
                    sEle = SubsetGetElementName( vDim, sSub, nEle );
                    # Escape potential single apostrophes to avoid parsing errors in element names
                    nChar = 1;
                    nCount = 0;
                    sEleStrOut = '';
                    While( nChar <= LONG( sEle ) + 1 );
                        If( nChar <= LONG( sEle ) );
                            sChar = SUBST( sEle, nChar, 1 );
                        Else;
                            sChar = '';
                        EndIf;
                        If( sChar @= '''' );
                            nCount = nCount + 1;
                        ElseIf( nCount > 0 );
                            If( MOD( nCount, 2 ) <> 0 );
                                sEleStrOut = sEleStrOut | '''';
                            EndIf;
                            nCount = 0;
                        EndIf;
                        sEleStrOut = sEleStrOut | sChar;
                        nChar = nChar + 1;
                    End;
                    TextOutput( sFileName2, Expand('SubsetElementInsert( sDimHier, ''%sSub%'', ''%sEleStrOut%'', 0 );') );
                    nEle = nEle + 1;
                End;
            EndIf;
            nCtr        = nCtr + 1;
        End;
        TextOutput( sFileName2, Expand('#EndRegion Subsets: %vDim%') );
        TextOutput( sFileName2, cHashLine );
    EndIf;
EndIf;
#EndRegion Subsets
#################################################################################################

### Dimension write close
TextOutput( sFileName, '' );
TextOutput( sFileName, Expand('#EndRegion Dimension/Hierarchy: %vDim%') );
TextOutput( sFileName, cHashLine );
If( ( pAttrVal = 1 & DimensionExists( sDimAttr ) = 1 & pEle @<> '' ) % ( pSub = 1 & DimensionExists( sDimSub ) = 1 ) );
    TextOutput( sFileName2, '' );
    TextOutput( sFileName2, Expand('#EndRegion Dimension/Hierarchy: %vDim%') );
    TextOutput( sFileName2, cHashLine );
EndIf;
575,29

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 


### If errors occurred terminate process with a major error status ###
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 major error and consequently aborted. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% aborted. Check tm1server.log for details.' );
    If( pStrictErrorHandling = 1 ); 
        ProcessQuit; 
    EndIf;
EndIf;

### Return Code
sProcessAction      = Expand( 'Process:%cThisProcName% successfully exported %pDim% dimension:hierarchy to %sFileName%.' );
sProcessReturnCode  = Expand( '%sProcessReturnCode% %sProcessAction%' );
nProcessReturnCode  = 1;
If ( pLogoutput = 1 );
    LogOutput('INFO', Expand( sProcessAction ) );   
EndIf;

### End Epilog ###
576,
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
