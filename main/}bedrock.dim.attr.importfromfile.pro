601,100
602,"}bedrock.dim.attr.importfromfile"
562,"CHARACTERDELIMITED"
586,"D:\TM1Models\Bedrock.v4\Data\Attribute.csv"
585,"D:\TM1Models\Bedrock.v4\Data\Attribute.csv"
564,
565,"ieUfkI;Wja<VHDFBtuExl\eT^<Ut\iHF1arPOwpO^kJO0jdHnNkgm0sfuSw:V8RtI3`i7Ju=w0;ER83tzZ_a9Lxu8GtZ0\>ef7T4_S9eUqkR?wIPY6rldYs@_RYTTqAXH3t6L6mw7\Zv;5td5nfrmMbdtMPa]QX57M`sr^@GgZWn_AdkU@I]Jvg:BpPEWV5EiHhoe?_x"
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
569,1
592,0
599,1000
560,8
pLogOutput
pStrictErrorHandling
pDim
pSrcDir
pSrcFile
pTitleRows
pDelim
pQuote
561,8
1
1
2
2
2
1
2
2
590,8
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pSrcDir,""
pSrcFile,""
pTitleRows,1
pDelim,","
pQuote,""""
637,8
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"REQUIRED: dimension name"
pSrcDir,"REQUIRED: Source Directory"
pSrcFile,"REQUIRED: Source File Name"
pTitleRows,"OPTIONAL: Number of Title Rows to Skip (default = 1)"
pDelim,"OPTIONAL: File Delimiter Character (Default=comma, exactly 3 digits = ASCII code)"
pQuote,"OPTIONAL: Quote Character (Accepts empty quote, exactly 3 digits = ASCII code)"
577,2
vAttr
vAttrType
578,2
2
2
579,2
1
2
580,2
0
0
581,2
0
0
582,2
VarType=32ColType=827
VarType=32ColType=827
603,0
572,159
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.dim.attr.importfromfile', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pDim', '', 'pSrcDir', '', 'pSrcFile', '',
    	'pTitleRows', 1, 'pDelim', ',', 'pQuote', '"'
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
# This process will create Attributes of the dimension from a file.

# Use case: Intended for development/prototyping. 
#1/ Add multiple dimension attributes of different types.

# Note:
# The file format is as per the dimension export file applied to an }ElementsAttributes dimension.
# Naturally, a valid diension name (pDim) is mandatory otherwise the process will abort.
# Also, valid path (pSrcDir) & file name (pSrcFile) are mandatory otherwise the process will abort.
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName     = GetProcessName();
cUserName         = TM1User();
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pSrcDir:%pSrcDir%, pSrcFile:%pSrcFile%, pTitleRows:%pTitleRows%, pDelim:%pDelim%, pQuote:%pQuote%.'; 
cLenASCIICode = 3;

pDelimiter        = TRIM(pDelim);


## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

nMetaDataCount = 0;

### Validate Parameters ###

nErrors = 0;

# Validate source dir
If( FileExists( pSrcDir ) = 0 );
    nErrors = 1;
    sMessage = 'Invalid source directory specified: folder does not exist.';
    DataSourceType = 'NULL';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;
If( SubSt( pSrcDir, Long( pSrcDir ), 1 ) @<> '\' );
    pSrcDir = pSrcDir | '\';
EndIf;

# Validate source file
sFile = pSrcDir | pSrcFile;
IF ( Trim ( pSrcFile ) @= '' );
    nErrors = 1;
    sMessage = 'No source file specified.';
    DataSourceType = 'NULL';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( FileExists( sFile ) = 0 );
    nErrors = 1;
    sMessage = 'Invalid path/source file specified: It does not exist in directory.';
    DataSourceType = 'NULL';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate dimension
If( Trim( pDim ) @= '' );
    nErrors = 1;
    sMessage = 'No dimension specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( DimensionExists( pDim ) = 0 );
    nErrors = 1;
    sMessage = 'Dimension: ' | pDim | ' does not exist on server.';
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

### Check for errors before continuing
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

### Assign Datasource ###

DataSourceType              = 'CHARACTERDELIMITED';
DatasourceNameForServer     = sFile;
DatasourceNameForClient     = sFile;
DatasourceASCIIHeaderRecords= pTitleRows;
DatasourceASCIIDelimiter    = pDelimiter;
DatasourceASCIIQuoteCharacter= pQuote;

### End Prolog ###
573,28

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

## Metatdata Count
nMetaDataCount = nMetaDataCount + 1;

### Write data from source file to target dimension ###
sAttrType = Upper(SubSt( vAttrType, 1, 1 ));

### Validate Record ###
IF(
  sAttrType @= 'A' %
  sAttrType @= 'N' %
  sAttrType @= 'S' );
  ## Continute
ELSE;
  sMessage = 'Invalid attribute type.';
     ITEMSKIP;
ENDIF;

AttrInsert( pDim, '', vAttr, sAttrType );

### End Metadata ###
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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully created attributes in %pDim% from file %pSrcFile%.' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogoutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );   
    EndIf;
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
