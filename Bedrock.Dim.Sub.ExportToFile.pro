601,100
602,"Bedrock.Dim.Sub.ExportToFile"
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"mz`GNSD6fI=5ZaOaGB4m47DZJMSN]`HLLyqh?;:1aYzBzmS\qt:l:BIW1@52wN]4OoAr5VY<Vlsf<Fp>1U3c;lat3>y4Rr5f2FuezT\_6x:gSeYM^cc0wE;BORk\nyY4IX_Dv:B>bnef[n]o@m?P@1J8V:bz\MGvvG`uiqTAi@ipJ1xjPX;^3cY]sGRj\EyqRttF4sI9"
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
570,
571,All
569,0
592,0
599,1000
560,6
pDimension
pSubset
pExportPath
pExportFile
pTitleRecord
pDebug
561,6
2
2
2
2
1
1
590,6
pDimension,""
pSubset,""
pExportPath,""
pExportFile,""
pTitleRecord,1
pDebug,0
637,6
pDimension,Dimension
pSubset,Subset
pExportPath,Export File Path
pExportFile,Export File Name (Default Extension .csv)
pTitleRecord,Boolean: 1 = Yes include header row
pDebug,Debug Mode
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
572,143

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will Export a dimension subset to a file.


### Constants ###

cProcess = 'Bedrock.Dim.Sub.ExportToFile';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension   : ' | pDimension );
  AsciiOutput( sDebugFile, '            pSubset      : ' | pSubset );
  AsciiOutput( sDebugFile, '            pExportPath  : ' | pExportPath );
  AsciiOutput( sDebugFile, '            pExportFile  : ' | pExportFile );
  AsciiOutput( sDebugFile, '            pTitleRecord : ' | NumberToString( pTitleRecord ) );

EndIf;


### Validate Parameters ###

nErrors = 0;

# Validate dimension
If( Trim( pDimension ) @= '' );
  nErrors = 1;
  sMessage = 'No dimension specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;
If( DimensionExists( pDimension ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dimension: ' | pDimension;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate subset
If( Trim( pSubset ) @= '' );
  nErrors = 1;
  sMessage = 'No subset specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;
If( SubsetExists( pDimension, pSubset ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid subset: ' | pSubset | ' in dimension: ' | pDimension;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate file path
# Strip off trailing backslash (if present)
If( SubSt( pExportPath, Long( pExportPath ), 1 ) @= '\' );
  pExportPath = SubSt( pExportPath, 1, Long( pExportPath ) - 1 );
EndIf;
If( FileExists( pExportPath ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid export path specified. Folder does not exist.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate filename
# If no file name then default to Dimension.Subset.Export.csv
If( pExportFile @= '' );
  pExportFile = pDimension |'.'| pSubset |'.Export.csv';
Else;
  If( Scan( '.', pExportFile ) = 0 );
    # No file extension specified
    pExportFile = pExportFile | '.csv';
  EndIf;
EndIf;
sFile = pExportPath | '\' | pExportFile;


### Initialise & declare variables ###

nRecordCount = 0;


### Determine if alias exists ###

sAttributeDim = '}ElementAttributes_' | pDimension;
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


### Assign Data Source ###

DatasourceNameForServer = pDimension;
DatasourceNameForClient = pDimension;
DataSourceType = 'SUBSET';
DatasourceDimensionSubset = pSubset;


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,106

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################


### Check for error in prolog ###

If( nErrors <> 0 );
  ProcessBreak;
EndIf;


### Check whether to write title records ###

nRecordCount = nRecordCount + 1;

If( pDebug <= 1 & nRecordCount = 1 & pTitleRecord = 1 );

  nSubsetSize = SubSetGetSize( pDimension, pSubset );

  # Write params
  AsciiOutput(
    sFile,
    'Export from dimension: ' | pDimension | ', Subset: ' | pSubset |
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

sElement = DimensionElementPrincipalName( pDimension, vElement );
sSubix = NumberToString( nRecordCount );
sIndex = NumberToString( DimIx( pDimension, vElement ) );
sType = DType( pDimension, vElement );
sLevel = NumberToString( ElLev( pDimension, vElement ) );
sChild = NumberToString( ElCompN( pDimension, vElement ) );
sParent1 = ElPar( pDimension, vElement, 1 );
sParent2 = ElPar( pDimension, vElement, 2 );
sParent3 = ElPar( pDimension, vElement, 3 );
sParent4 = ElPar( pDimension, vElement, 4 );
sParent5 = ElPar( pDimension, vElement, 5 );
sWeight1 = NumberToString( ElWeight( pDimension, sParent1, vElement ) );
sWeight2 = NumberToString( ElWeight( pDimension, sParent2, vElement ) );
sWeight3 = NumberToString( ElWeight( pDimension, sParent3, vElement ) );
sWeight4 = NumberToString( ElWeight( pDimension, sParent4, vElement ) );
sWeight5 = NumberToString( ElWeight( pDimension, sParent5, vElement ) );

If( sAlias @<> '(no alias)' );
  sAliasValue = AttrS( pDimension, vElement, sAlias );
Else;
  sAliasValue = '';
EndIf;

If( pDebug <= 1 );
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
EndIf;


### End Data ###
575,35

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';

  # Log errors
  If( nErrors <> 0 );
    AsciiOutput( sDebugFile, 'Errors Occurred' );
  EndIf;

  # Log finish time
  AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

EndIf;


### If errors occurred terminate process with a major error status ###

If( nErrors <> 0 );
  ProcessQuit;
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
917,1
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
