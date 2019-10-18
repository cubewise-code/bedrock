﻿601,100
602,"}bedrock.hier.export"
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"pK@uC<=\lKw:1\5raHtLls5wlTL1YAW87DL8vRu2eRzX0DLdysgSwc`5FMDuPG`p5jsg07PSgbO3[^3Cg:B^7DHhI;hLFgGUK;Lj0<VYE>]3;qv^X9pn9X`6q]qX`t=ZkueXkfIE<85epmsabLX[d4sYkZfConJMLaER^zKL?rs@21L[ZDuC?Gb^vs5;\RVy^D5<A5tp"
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
560,9
pLogOutput
pDim
pHier
pTgtDir
pTgtFile
pTitleRecord
pDelim
pQuote
pLegacy
561,9
1
2
2
2
2
1
2
2
1
590,9
pLogOutput,0
pDim,""
pHier,""
pTgtDir,""
pTgtFile,""
pTitleRecord,1
pDelim,","
pQuote,""""
pLegacy,0
637,9
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pDim,"REQUIRED: Dimension"
pHier,"OPTIONAL: Hierarchy (defaults to dimension name if blank)"
pTgtDir,"OPTIONAL: Target Directory Path (defaults to Error File Directory)"
pTgtFile,"OPTIONAL: Target File Name (defaults to Dimension Hierarchy_Export.csv if blank)"
pTitleRecord,"REQUIRED: Boolean 1 = Yes - Include header row"
pDelim,"OPTIONAL: AsciiOutput delimiter character (Default=comma, exactly 3 digits = ASCII code)"
pQuote,"OPTIONAL: AsciiOutput quote character (Accepts empty quote, exactly 3 digits = ASCII code)"
pLegacy,"REQUIRED: Boolean 1 = Legacy format"
577,1
vEle
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
572,207
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.export', 'pLogOutput', pLogOutput,
    	'pDim', '', 'pHier', '',
    	'pTgtDir', '', 'pTgtFile', '',
    	'pTitleRecord', 1, 'pDelim', ',', 'pQuote', '"',
    	'pLegacy', 0
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
# This process will Export all Dimension elements in a Hierarchy to a File. Export file maintains
# all data that can be used to completely reconstruct the dimension. Custom record delimiter
# (specified by a character or its ASCII code) can be used.
# __Format of the file:__  
# - 1st line: File metadata contains summary information about the dimension, hierarchy, number of
#   elements and date/time when file was generated.
# - 2nd line: Source dimension and hierarchy.
# - 3rd line: Dimension sort order.
# - 4th and 5th line: Reserved for future development.
# - 6th line: Header for elements export.
# - 7th line and forth: Elements export data.

# Use case:
# 1. Backup of dimension before changes in productive environment.
# 2. Quick replication of a large dimension.

# Note:
# Valid dimension name (pDim), inclusion of header (pTitleRecord) and legacy export format (pLegacy)
# are mandatory otherwise the process will abort.
# If needed, custom delimiter might be used by specifying parameter pDelim value as either exactly one
# character or as a 3-digit (decimal) ASCII code. For example to use TAB as a delimiter, use 009.

# Caution: Process was redesigned in Bedrock4 but is able to process dimension extracts from prior
# versions of Bedrock in legacy mode (pLegacy = 1).
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName   = GetProcessName();
cUserName       = TM1User();
cTimeStamp      = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
cTempSub        = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cMsgErrorLevel  = 'ERROR';
cMsgErrorContent= 'Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo        = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%, pTgtDir:%pTgtDir%, pTgtFile:%pTgtFile%, pTitleRecord:%pTitleRecord%, pDelim:%pDelim%, pQuote:%pQuote%, pLegacy:%pLegacy%.';
cCubeS1         = '}DimensionProperties';
cType           = 'Type-';
cParent         = 'Parent-';
cIndex          = 'Index-';
cWeight         = 'Weight-';
cAttrName       = 'Attr Name-';
cAttrValue      = 'Attr Value-';
cLenASCIICode = 3;

pDelim  = TRIM(pDelim);

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Initialise ###
nRecordCount = 0;

### Validate Parameters ###
nErrors = 0;

If( Scan( ':', pDim ) > 0 & pHier @= '' );
    # A hierarchy has been passed as dimension. Handle the input error by splitting dim:hier into dimension & hierarchy
    pHier       = SubSt( pDim, Scan( ':', pDim ) + 1, Long( pDim ) );
    pDim        = SubSt( pDim, 1, Scan( ':', pDim ) - 1 );
EndIf;

# Validate dimension
If( Trim( pDim ) @= '' );
  nErrors = 1;
  sMessage = 'No dimension specified.';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( DimensionExists( pDim ) = 0 );
  nErrors = 1;
  sMessage = 'Dimension: ' | pDim | ' does not exist.';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate Hierarchy
If( Trim( pHier ) @= '' );
  sHier = pDim;
Else;
  sHier = pHier;
EndIf;

If( HierarchyExists( pDim, sHier ) = 0 );
  nErrors = 1;
  sMessage = 'The Hierachy ' | sHier | ' does not exist.';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## check operating system
If( Scan('/', GetProcessErrorFileDirectory)>0);
#  sOS = 'Linux';
  sOSDelim = '/';
Else;
#  sOS = 'Windows';
  sOSDelim = '\';
EndIf;

# Validate export path
If( Trim( pTgtDir ) @= '' );
    pTgtDir     = GetProcessErrorFileDirectory;
    sMessage    = 'Target folder defaulted to error file directory.';
    LogOutput( 'INFO', Expand( cMsgErrorContent ) );
ElseIf( FileExists( pTgtDir ) = 0 );
    nErrors     = 1;
    sMessage    = 'Invalid export path specified. Folder does not exist.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( SubSt( pTgtDir, Long( pTgtDir ), 1 ) @<> sOSDelim );
    pTgtDir     = pTgtDir | sOSDelim;
EndIf;

# Validate export filename
If( pTgtFile @= '' );
    pTgtFile        = pDim | If( pLegacy = 1,'',' '|sHier ) | '_Export.csv';
ElseIf( Scan( '.', pTgtFile ) = 0 );
    # No file extension specified
    pTgtFile        = pTgtFile | '.csv';
EndIf;

# Validate file delimiter & quote character
If( pDelim @= '' );
    pDelim = ',';
Else;
    # If length of pDelim is exactly 3 chars and each of them is decimal digit, then the pDelim is entered as ASCII code
    nValid = 0;
    If ( LONG(pDelim) = cLenASCIICode );
      nChar = 1;
      While ( nChar <= cLenASCIICode );
        If( CODE( pDelim, nChar )>=CODE( '0', 1 ) & CODE( pDelim, nChar )<=CODE( '9', 1 ) );
          nValid = 1;
        Else;
          nValid = 0;
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

# Construct full export filename including path
sFilename       = pTgtDir | pTgtFile;
sAttrDimName    = '}ElementAttributes_' | pDim ;

### Check for errors before continuing
If( nErrors <> 0 );
  ProcessBreak;
EndIf;

### Assign Data Source ###
DatasourceNameForServer     = pDim | IF(pHier@='','',':'|pHier) ;
DatasourceNameForClient     = DatasourceNameForServer ;
DataSourceType              = 'SUBSET';
DatasourceDimensionSubset   = 'ALL';
DatasourceAsciiDelimiter= pDelim;
DatasourceAsciiQuoteCharacter = pQuote;

### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,93

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

### Record Count
nRecordCount = nRecordCount + 1;

### Export Header Information
## Line 1: File Metadata information
If( nRecordCount = 1 & pTitleRecord = 1 );
    AsciiOutput( sFilename, 'Export from dimension Hierarchy: ' | pDim|':'|sHier | ', all elements in index order. Total elements=' |
                 NumberToString( ElementCount( pDim, sHier ) ) | '. On ' | Date( Now, 1 ) | ' at ' | Time );

## Line 2: Source Dimension
    AsciiOutput( sFilename, pDim, sHier  );

## Line 3: Sort Order Information
    sSortElementType    = CELLGETS( cCubeS1, pDim, 'SORTELEMENTSTYPE' );
    sSortComponentType  = CELLGETS( cCubeS1, pDim, 'SORTCOMPONENTSTYPE' );
    sSortElementSense   = CELLGETS( cCubeS1, pDim, 'SORTELEMENTSSENSE' );
    sSortComponentSense = CELLGETS( cCubeS1, pDim, 'SORTCOMPONENTSSENSE' );
    If( pLegacy = 1 );
        AsciiOutput( sFilename, sSortElementType , sSortComponentType , sSortElementSense , sSortComponentSense  );
    Else;
        AsciiOutput( sFilename, 'Sort parameters :', sSortElementType , sSortComponentType , sSortElementSense , sSortComponentSense  );
    EndIf;
    
## Line 4 (and 5?): Header Information
    If( pLegacy = 1 );
            AsciiOutput( sFilename, 'Reserved' );
    EndIf;
    AsciiOutput( sFilename, 'Reserved' );
    
## Line 5 or 6: Header Information
    AsciiOutput( sFilename, 'Line_Type', 'Element', 'Value_1', 'Value_2', 'Value_3' );

### Attribute Information 
    If( DimensionExists( sAttrDimName ) = 1 );
        nIndex = 1;
        nLimit = DIMSIZ ( sAttrDimName );
        WHILE( nIndex <= nLimit );
            sElName   = DIMNM( sAttrDimName, nIndex );
            sElType   = DTYPE( sAttrDimName, sElName);
            AsciiOutput( sFilename, 'A', sElName, sElType );
            nIndex = nIndex + 1;
        END; 
    EndIf;
#    AsciiOutput( sFilename, '' );
EndIf;

### Element Information
nElIndex        = ElementIndex( pDim, sHier, vEle );
sElType         = ElementTYPE(  pDim, sHier, vEle );
AsciiOutput( sFilename,'E', vEle, If( pLegacy = 1,'', cType ) | sElType, If( pLegacy = 1,'', cIndex ) | NumberToString( nElIndex ) );

### Element Parents
nElPar          = ElementParentCount( pDim, sHier, vEle );
IF( nElPar > 0 );
    nIndex = 1;
    nLimit = nElPar;
    WHILE( nIndex <= nLimit );
        sElPar  = ElementParent( pDim, sHier, vEle, nIndex );
        sElType = ElementTYPE( pDim, sHier, sElPar );
        nElWgt  = ElementWeight( pDim, sHier, sElPar, vEle );
        AsciiOutput( sFilename, 'P', vEle, If( pLegacy = 1,'', cParent ) | sElPar, If( pLegacy = 1,'', cType ) | sElType, If( pLegacy = 1,'', cWeight ) | NumberToString( nElWgt ) );
        nIndex = nIndex + 1;
    END;
ENDIF;

### Attribute Value 
IF( DimensionExists( sAttrDimName ) = 1 );
    nIndex = 1;
    nLimit = DIMSIZ ( sAttrDimName );
    WHILE( nIndex <= nLimit );
        sElName   = DIMNM( sAttrDimName, nIndex );
        sElType   = DTYPE( sAttrDimName, sElName);
        IF( sElType @= 'AN' );
            sAttrValue = NumberToString( ElementAttrN( pDim , sHier , vEle , sElName ) );
        ELSE;
            sAttrValue = ElementAttrS( pDim , sHier , vEle , sElName );
        ENDIF;
        IF( sAttrValue @<>'' & sAttrValue @<>'0' );
            AsciiOutput( sFilename, 'V', vEle, If( pLegacy = 1,'', cAttrName ) | sElName, If( pLegacy = 1,'', cAttrValue ) | sAttrValue );
        EndIf;
        nIndex = nIndex + 1;
    END;
ENDIF;


575,28

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
    ProcessError;
EndIf;

### Return Code
sProcessAction      = Expand( 'Process:%cThisProcName% successfully exported the %pDim%:%pHier% dimension:hierarchy to %sFileName%.' );
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
920,0
921,""
922,""
923,0
924,""
925,""
926,""
927,""
