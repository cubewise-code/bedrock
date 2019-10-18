﻿601,100
602,"}bedrock.hier.sub.exporttofile"
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"utqM<2ooxY1kt6_bvzx6EaFYh0BtBgBCR7R<<YfTPZxY7?<98Ig1Z\DbLuTnD8;Q;B]@e5D@1rT]X>`MFvbX^]WbECN1z2vr0RLoxLB3yRN2GzJZ]wNsrF>8V:HJuG<=L`ROO@lxa<coq1UgIaBmjn<M3R;0e8UCs97\npDwGL17:YJ3i3YtMBbXysh24pwTH9c[Yj_g"
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
pSub
pTgtDir
pTgtFile
pTitleRecord
pDelim
pQuote
561,9
1
2
2
2
2
2
1
2
2
590,9
pLogOutput,0
pDim,""
pHier,""
pSub,""
pTgtDir,""
pTgtFile,""
pTitleRecord,1
pDelim,","
pQuote,""""
637,9
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pDim,"REQUIRED: Dimension name"
pHier,"OPTIONAL: Hierarchy name (default if blank = same named hierarchy)"
pSub,"REQUIRED: Subset name"
pTgtDir,"REQUIRED: Target Directory Path"
pTgtFile,"OPTIONAL: Target File Name (Default Extension .csv)"
pTitleRecord,"OPTIONAL: Boolean: 1 = Yes include header row"
pDelim,"OPTIONAL: AsciiOutput delimiter character (Default=comma, exactly 3 digits = ASCII code)"
pQuote,"OPTIONAL: AsciiOutput quote character (Accepts empty quote, exactly 3 digits = ASCII code)"
577,1
vElement
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
572,225
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.sub.exporttofile', 'pLogOutput', pLogOutput,
    	'pDim', '', 'pHier', '', 'pSub', '',
    	'pTgtDir', '', 'pTgtFile', '',
    	'pTitleRecord', 1, 'pDelim', ',', 'pQuote', '"'
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
# This process will Export a subset in a Hierarchy of a Dimension to a file. Custom record delimiter
# (specified by a character or its ASCII code) can be used.
# __Format of the file:__  
# - 1st line: File metadata contains summary information about the dimension, hierarchy, subset
#   name, number of elements and date/time when file was generated.
# - 2nd line and forth: Elements export data.

# Note:
# Valid dimension name (pDim), subset name (pSub), inclusion of header (pTitleRecord)
# are mandatory otherwise the process will abort. Target folder (pTgtDir) must exist.
# If needed, custom delimiter might be used by specifying parameter pDelim value as either exactly one
# character or as a 3-digit (decimal) ASCII code. For example to use TAB as a delimiter, use 009.
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName       = GetProcessName();
cUserName           = TM1User();
cTimeStamp          = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt          = NumberToString( INT( RAND( ) * 1000 ));
cTempSub            = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cMsgErrorLevel      = 'ERROR';
cMsgErrorContent    = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo            = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%, pSub:%pSub%, pTgtDir:%pTgtDir%, pTgtFile:%pTgtFile%, pTgtRecord:%pTgtRecord%.'; 
cAttributeDim       = '}ElementAttributes_' | pDim;
cLenASCIICode = 3;

pDelim = TRIM(pDelim);

## LogOutput parameters
IF ( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;


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
  sMessage = 'No dimension specified';
  DataSourceType = 'NULL';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;
If( DimensionExists( pDim ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dimension: ' | pDim;
  DataSourceType = 'NULL';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate hierarchy
IF( Trim(pHier) @= '' );
  pHier = pDim;
EndIf;

IF(
HierarchyExists(pDim, pHier ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid Source Hierarchy: ' | pDim |':'|pHier;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate subset
If( Trim( pSub ) @= '' );
  nErrors = 1;
  sMessage = 'No subset specified';
    DataSourceType = 'NULL';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

If( HierarchySubsetExists( pDim, pHier, pSub ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid subset: ' | pSub | ' in dimension:Hierarchy ' | pDim |':' | pHier;
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

# Validate file path
# Strip off trailing backslash (if present)
If( SubSt( pTgtDir, Long( pTgtDir ), 1 ) @= sOSDelim );
  pTgtDir = SubSt( pTgtDir, 1, Long( pTgtDir ) - 1 );
EndIf;
If( FileExists( pTgtDir ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid export path specified. Folder does not exist.';
  DataSourceType = 'NULL';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
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

# Validate filename
# If no file name then default to Dimension.Subset.Export.csv
If( pTgtFile @= '' );
  pTgtFile = pDim |'.'| pSub |'.Export.csv';
Else;
  If( Scan( '.', pTgtFile ) = 0 );
    # No file extension specified
    pTgtFile = pTgtFile | '.csv';
  EndIf;
EndIf;
sFile = pTgtDir | sOSDelim | pTgtFile;

### Initialise & declare variables ###

nRecordCount = 0;

### Determine if alias exists ###

sAttributeDim = '}ElementAttributes_' | pDim;
sAlias = '(no alias)';
If( DimensionExists( sAttributeDim ) = 1 );
  nElementIndex = 1;
  nElementCount = DimSiz( sAttributeDim );
  While( nElementIndex <= nElementCount );
    sAttribute = DimNm( sAttributeDim, nElementIndex );
    If( SubSt( DType( sAttributeDim, sAttribute ), 2, 1 ) @= 'A' );
      sAlias = sAttribute;
      nElementIndex = nElementCount;
    EndIf;
    nElementIndex = nElementIndex + 1;
  End;
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
  ProcessBreak;
EndIf;

### Assign Data Source ###

DatasourceNameForServer = pDim|':'|pHier;
DatasourceNameForClient = pDim|':'|pHier;
DataSourceType = 'SUBSET';
DatasourceDimensionSubset = pSub;
DatasourceAsciiDelimiter= pDelim;
DatasourceAsciiQuoteCharacter = pQuote;


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,105

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 


### Check for error in prolog ###

If( nErrors <> 0 );
  ProcessBreak;
EndIf;


### Check whether to write title records ###

nRecordCount = nRecordCount + 1;

If( nRecordCount = 1 & pTitleRecord = 1 );

  nSubsetSize = HierarchySubSetGetSize( pDim, pHier, pSub );

  # Write params
  AsciiOutput(
    sFile,
    'Export from dimension: ' | pDim | ',Hierarchy:'|pHier|',Subset:'|pSub|
    ', Total elements: ' | NumberToString( nSubsetSize ) |
    '. On ' | Date( Now, 1 ) | ' at ' | Time
   );
  # Write header records
  AsciiOutput(
    sFile,
    'Subix',
    'Element',
    'Alias: ' | sAlias,
    'Dimix',
    'El Type',
    'Level',
    'Num Children',
    'Parent 1',
    'Weight 1',
    'Parent 2',
    'Weight 2',
    'Parent 3',
    'Weight 3',
    'Parent 4',
    'Weight 4',
    'Parent 5',
    'Weight 5'
  );

EndIf;


### Write dimension info to flat file ###

sElement = HierarchyElementPrincipalName( pDim, PHier, vElement );
sSubix = NumberToString( nRecordCount );
sIndex = NumberToString( ElementIndex( pDim, pHier, vElement ) );
sType = ElementType( pDim, PHier, vElement );
sLevel = NumberToString( ElementLevel( pDim, pHier, vElement ) );
sChild = NumberToString( ElementComponentCount( pDim, pHier, vElement ) );
sParent1 = ElementParent( pDim,pHier,vElement, 1 );
sParent2 = ElementParent( pDim,pHier,vElement, 2 );
sParent3 = ElementParent( pDim,pHier,vElement, 3 );
sParent4 = ElementParent( pDim,pHier,vElement, 4 );
sParent5 = ElementParent( pDim,pHier,vElement, 5 );
sWeight1 = NumberToString( ElementWeight( pDim, pHier, sParent1, vElement ) );
sWeight2 = NumberToString( ElementWeight( pDim, pHier, sParent2, vElement ) );
sWeight3 = NumberToString( ElementWeight( pDim, pHier, sParent3, vElement ) );
sWeight4 = NumberToString( ElementWeight( pDim, pHier, sParent4, vElement ) );
sWeight5 = NumberToString( ElementWeight( pDim, pHier, sParent5, vElement ) );

If( sAlias @<> '(no alias)' );
  sAliasValue = AttrS( pDim, vElement, sAlias );
Else;
  sAliasValue = '';
EndIf;

  AsciiOutput(
    sFile,
    sSubix,
    sElement,
    sAliasValue,
    sIndex,
    sType,
    sLevel,
    sChild,
    sParent1,
    sWeight1,
    sParent2,
    sWeight2,
    sParent3,
    sWeight3,
    sParent4,
    sWeight4,
    sParent5,
    sWeight5
  );



### End Data ###
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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully exported subset %pSub% from dimension %pDim%.' );
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
