601,100
602,"}bedrock.hier.clone"
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"wleeZe@zs7:tX9hx?u8=<0FaW__6<f1[8>oO_IW\i]GERwH5<CKC8MK:DxAhiO02`qR6];6X4ttLeDRQoRBwuVJqM3ci>`Hw`6q9e0r_mjF4dnqAvM0p`FzSI9dbQewiAIAJZ:9z]onUjR5yxbZv@p]FnptevOM8bUkkO_:U`O0w2PB^a5Co7ez`=R<qM4KckFPCuRxl"
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
560,8
pLogOutput
pStrictErrorHandling
pSrcDim
pSrcHier
pTgtDim
pTgtHier
pAttr
pUnwind
561,8
1
1
2
2
2
2
1
1
590,8
pLogOutput,0
pStrictErrorHandling,0
pSrcDim,""
pSrcHier,""
pTgtDim,""
pTgtHier,""
pAttr,0
pUnwind,0
637,8
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pSrcDim,"REQUIRED: Source Dimension"
pSrcHier,"REQUIRED: Source Hierarchy"
pTgtDim,"REQUIRED: Target Dimension (can be the same as source)"
pTgtHier,"OPTIONAL: Target Hierarchy (will default to SrcHier_Clone if the dimensions are the same)"
pAttr,"OPTIONAL: Include Attributes? (Boolean 1=True)"
pUnwind,"REQUIRED:  Unwind? (0 = Delete all Elements, 1 = Unwind Existing Elements, 2 = Do not change Existing Elements (Only relevant if target hierarchy exists) )"
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
572,227
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.clone', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pSrcDim', '', 'pSrcHier', '',
    	'pTgtDim', '', 'pTgtHier', '',
    	'pAttr', 0, 'pUnwind', 0
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
# This process will clone the source dimension Hierarchy.

# Use case: Mostly in Development.
# 1/ Create a duplicate of an existing hierarchy for testing.

# Note:
# Valid source dimension name (pSrcDim) and target dimension (pTgtDim) names are mandatory otherwise the process will abort.
# Valid source hierarchy name (pSrcHier) is mandatory otherwise the process will abort.

# Caution:
# - Target hierarchy cannot be `Leaves`.
# - If the target dimension Hierarchy exists then it will be overwritten.
#EndRegion @DOC

### Global Varaibales ###
StringGlobalVariable ('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode = 0;

### Constants ###
cThisProcName     = GetProcessName();
cUserName         = TM1User();
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cTempSub          = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = '%cThisProcName% : %sMessage% : %cUserName%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pSrcDim:%pSrcDim%, pSrcHier:%pSrcHier%, pTgtDim:%pTgtDim%, pTgtHier:%pTgtHier%, pAttr:%pAttr%, pUnwind:%pUnwind%.';
cLangDim          = '}Cultures';
nNumLang          = DimSiz( cLangDim );

nProcessSameNamedHier = 0;
sEpilogTgtHier = '';

## LogOutput parameters
IF ( pLogoutput = 1 );
  LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;

If( Scan( ':', pSrcDim ) > 0 & pSrcHier @= '' );
    # A hierarchy has been passed as dimension. Handle the input error by splitting dim:hier into dimension & hierarchy
    pSrcHier       = SubSt( pSrcDim, Scan( ':', pSrcDim ) + 1, Long( pSrcDim ) );
    pSrcDim        = SubSt( pSrcDim, 1, Scan( ':', pSrcDim ) - 1 );
EndIf;

## Validate Source dimension
IF( Trim( pSrcDim ) @= '' );
    nErrors = 1;
    sMessage = 'No source dimension specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

IF( DimensionExists( pSrcDim ) = 0 );
    nErrors = 1;
    sMessage = 'Invalid source dimension: ' | pSrcDim;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate Source hierarchy
IF( Trim( pSrcHier ) @= '' );
    pSrcHier = pSrcDim;
ElseIF(HierarchyExists(pSrcDim,pSrcHier ) = 0 );
    nErrors = 1;
    sMessage = 'Invalid source hierarchy: ' | pSrcHier;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate Target dimension
IF( Trim( pTgtDim ) @= '' );
    nErrors = 1;
    sMessage = 'No target dimension specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( Scan( ':', pTgtDim ) > 0 & pTgtHier @= '' );
    # A hierarchy has been passed as dimension. Handle the input error by splitting dim:hier into dimension & hierarchy
    pTgtHier       = SubSt( pTgtDim, Scan( ':', pTgtDim ) + 1, Long( pTgtDim ) );
    pTgtDim        = SubSt( pTgtDim, 1, Scan( ':', pTgtDim ) - 1 );
EndIf;

If ( DimensionExists( pTgtDim ) = 0 );
  DimensionCreate( pTgtDim );
  ### In this case clone source hierarchy into same-named hierarchy of the new target dimension first. This will allow attributes to be processed in the data tab.
  nProcessSameNamedHier = 1;
EndIf;

# Validate target hierarchy
If( pSrcDim @= pTgtDim);
    If( pTgtHier @= '' % pTgtHier @= pSrcHier );
        pTgtHier = pSrcHier | '_Clone';
    EndIf;
ElseIf(pTgtHier @= '');
    If( nProcessSameNamedHier = 1 );
      sEpilogTgtHier = pTgtHier;
      pTgtHier = pTgtDim;
    Else;
      pTgtHier = pSrcHier;
    EndIf;
ElseIf( nProcessSameNamedHier = 1 );
    sEpilogTgtHier = pTgtHier;
    pTgtHier = pTgtDim;
Endif;

pTgtHier = Trim(pTgtHier);

IF(pTgtHier @= 'Leaves' );
  nErrors = 1;
  sMessage = 'Leaves is an invalid selection for Target Hierarchy: ' | pTgtDim |':'|pTgtHier;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

If( DimensionExists( pTgtDim ) = 0 );
    If( pUnwind >= 1 );
        pUnwind = 2;
    EndIf;
ElseIf( HierarchyExists( pTgtDim, pTgtHier ) = 0 );
    If( pUnwind >= 1 );
        pUnwind = 2;
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

### Create target dimension Hierarchy ###
If( HierarchyExists( pTgtDim, pTgtHier) = 0 );
    HierarchyCreate( pTgtDim, pTgtHier );
Else;
    IF(pUnwind = 1 );
      nRet = ExecuteProcess('}bedrock.hier.unwind',
        'pLogOutput', pLogOutput,
        'pStrictErrorHandling', pStrictErrorHandling,
        'pDim', pTgtDim,
        'pHier', pTgtHier,
        'pConsol', '*',
        'pRecursive', 1
        );
    ELSEIF(pUnwind = 2 );
      #Do nothing
    ELSEIF(pUnwind = 0 );
      HierarchyDeleteAllElements( pTgtDim, pTgtHier );
    EndIf;
EndIf;
  
If(pSrcDim @=pSrcHier);
   sDimHier = pSrcDim;
 Else;
   sDimHier =pSrcDim|':'|pSrcHier;
 Endif;
  
### Set the target Sort Order ###
sSortElementsType     = CELLGETS( '}DimensionProperties', sDimHier, 'SORTELEMENTSTYPE');
sSortElementsSense    = CELLGETS( '}DimensionProperties', sDimHier, 'SORTELEMENTSSENSE');
sSortComponentsType   = CELLGETS( '}DimensionProperties', sDimHier, 'SORTCOMPONENTSTYPE');
sSortComponentsSense  = CELLGETS( '}DimensionProperties', sDimHier, 'SORTCOMPONENTSSENSE');

HierarchySortOrder(pTgtDim, pTgtHier, sSortComponentsType, sSortComponentsSense, sSortElementsType , sSortElementsSense);

nSourceHierSize = DimSiz(pSrcDim|':'|pSrcHier);

nIndex = 1;
WHILE( nIndex <= nSourceHierSize );
  sElName = ElementName(pSrcDim, pSrcHier, nIndex);
  sElType = ElementType(pSrcDim, pSrcHier, sElName);
  HierarchyElementInsert(pTgtDim, pTgtHier, '', sElName, sElType);
  nIndex = nIndex + 1;
END;

### Assign Data Source ###

DatasourceNameForServer     = pSrcDim|':'|pSrcHier;
DataSourceType              = 'SUBSET';
DatasourceDimensionSubset   = 'ALL';

### Replicate Attributes ###

# Note: DType on Attr dim returns "AS", "AN" or "AA" need to strip off leading "A"

sAttrDim        = '}ElementAttributes_' | pSrcDim;
sAttrLoc        = '}LocalizedElementAttributes_' | pSrcDim;
sAttrTragetDim  = '}ElementAttributes_' | pTgtDim;
sAttrLocTarget  = '}LocalizedElementAttributes_' | pTgtDim;

If( pAttr = 1 & DimensionExists( sAttrDim ) = 1 );
  nNumAttrs = DimSiz( sAttrDim );
  nCount = 1;
  While( nCount <= nNumAttrs );
    sAttrName = DimNm( sAttrDim, nCount );
    sAttrType = SubSt(DType( sAttrDim, sAttrName ), 2, 1 );
      If ( DimensionExists( sAttrTragetDim ) = 0);
         AttrInsert(pTgtDim,'',sAttrName,sAttrType );
       ElseIF(DimIx(sAttrTragetDim, sAttrName) = 0);
         AttrInsert(pTgtDim,'',sAttrName,sAttrType );
      Endif;
    nCount = nCount + 1;
  End;
EndIf;

### End Prolog ###
573,35

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0.0~~##
################################################################################################# 


### Check for errors in prolog ###

If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

### Add Elements to target dimension ###

sElType = ElementType(pSrcDim, pSrcHier, vEle);

IF( sElType @= 'C' & ElementComponentCount( pSrcDim, pSrcHier, vEle  ) > 0 );
    nChildren = ElementComponentCount( pSrcDim, pSrcHier, vEle );
    nCount = 1;
    While( nCount <= nChildren );
        sChildElement = ElementComponent( pSrcDim, pSrcHier, vEle, nCount );
        sChildWeight = ElementWeight( pSrcDim,pSrcHier, vEle, sChildElement );
        HierarchyElementComponentAdd(pTgtDim, pTgtHier, vEle, sChildElement, sChildWeight);
        nCount = nCount + 1;
    End;
EndIf;

### End MetaData ###
574,90

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0.0~~##
################################################################################################# 


### Check for errors in prolog ###

If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

### Replicate Attributes ###
# Note: DTYPE on Attr dim returns "AS", "AN" or "AA" need to strip off leading "A"

If( pAttr = 1 & DimensionExists( sAttrDim ) = 1 );

    nAttr = 1;
    While( nAttr <= nNumAttrs );
        sAttrName = DimNm( sAttrDim, nAttr );
        sAttrType = SubSt( DTYPE( sAttrDim, sAttrName ), 2, 1 );
        
        If( sAttrType @= 'S' % sAttrType @= 'A' );
            sAttrVal = ElementAttrS( pSrcDim, pSrcHier, vEle, sAttrName );
            
            If( sAttrVal @<> '' );
                If( CellIsUpdateable( '}ElementAttributes_' | pTgtDim, pTgtHier:vEle, sAttrName ) = 1 );
                    If( sAttrType @= 'A' );
                        ElementAttrPutS( sAttrVal, pTgtDim, pTgtHier, vEle, sAttrName, 1 );
                    Else;
                        ElementAttrPutS( sAttrVal, pTgtDim, pTgtHier, vEle, sAttrName );
                    EndIf;
                EndIf;
            EndIf;
        Else;
            nAttrVal = ElementAttrN( pSrcDim, pSrcHier, vEle, sAttrName );
            If( nAttrVal <> 0 );
                If( CellIsUpdateable( '}ElementAttributes_' | pTgtDim, pTgtHier:vEle, sAttrName ) = 1 );
                    ElementAttrPutN( nAttrVal, pTgtDim, pTgtHier, vEle, sAttrName );
                EndIf;
            EndIf;  
        EndIf;
        # check for localized attributes
        If( CubeExists( sAttrLoc ) = 1 );
            nLang = 1;
            While( nLang <= nNumLang );
                sLang       = DimNm( cLangDim, nLang );
                If( sAttrType @= 'A' % sAttrType @= 'S' );
                    sAttrVal    = ElementAttrS( pSrcDim, pSrcHier, vEle, sAttrName );
                    sAttrValLoc = ElementAttrSL( pSrcDim, pSrcHier, vEle, sAttrName, sLang );
                    If( sAttrValLoc @= sAttrVal ); sAttrValLoc = ''; EndIf;
                Else;
                    nAttrVal    = ElementAttrN( pSrcDim, pSrcHier, vEle, sAttrName );
                    nAttrValLoc = ElementAttrNL( pSrcDim, pSrcHier, vEle, sAttrName, sLang );
                EndIf;
                If( CubeExists( sAttrLocTarget ) = 0 );
                    If( sAttrType @= 'A' );
                        ElementAttrPutS( sAttrValLoc, pTgtDim, pTgtHier, vEle, sAttrName, sLang, 1 );
                    ElseIf( sAttrType @= 'N' );
                        ElementAttrPutN( nAttrValLoc, pTgtDim, pTgtHier, vEle, sAttrName, sLang );
                    Else;
                        ElementAttrPutS( sAttrValLoc, pTgtDim, pTgtHier, vEle, sAttrName, sLang );
                    EndIf;
                ElseIf(CubeExists( sAttrLocTarget ) = 1 );
                    If( CellIsUpdateable( sAttrLocTarget, pTgtHier:vEle, sLang, sAttrName ) = 1 );
                        If( sAttrType @= 'A' );
                            ElementAttrPutS( sAttrValLoc, pTgtDim, pTgtHier, vEle, sAttrName, sLang, 1 );
                        ElseIf( sAttrType @= 'N' );
                            ElementAttrPutN( nAttrValLoc, pTgtDim, pTgtHier, vEle, sAttrName, sLang );
                        Else;
                            ElementAttrPutS( sAttrValLoc, pTgtDim, pTgtHier, vEle, sAttrName, sLang );
                        EndIf;
                    EndIf;
                EndIf;
                nLang   = nLang + 1;
            End;
        EndIf;
        nAttr = nAttr + 1;
    End;

EndIf;

### End Data ###
575,54

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 


If(pTgtDim @=pTgtHier);
    sTargetDimHier = pTgtDim;
Else;
    sTargetDimHier =pTgtDim|':'|pTgtHier;
EndIf;

### Set the target Sort Order ###
  CELLPUTS( sSortElementsType, '}DimensionProperties', sTargetDimHier, 'SORTELEMENTSTYPE');
  CELLPUTS( sSortElementsSense, '}DimensionProperties', sTargetDimHier, 'SORTELEMENTSSENSE');
  CELLPUTS( sSortComponentsType, '}DimensionProperties',sTargetDimHier, 'SORTCOMPONENTSTYPE');
  CELLPUTS( sSortComponentsSense, '}DimensionProperties', sTargetDimHier, 'SORTCOMPONENTSSENSE');
  
### If a new dimension has been created, call the process recursively to clone the alternate hierarchy, after the same named hierarchy has been processed
If( nProcessSameNamedHier = 1 );
  nRet = ExecuteProcess('}bedrock.hier.clone',
    'pLogOutput', pLogOutput,
    'pStrictErrorHandling', pStrictErrorHandling,
    'pSrcDim', pSrcDim,
    'pSrcHier',pSrcHier,
    'pTgtDim', pTgtDim,
    'pTgtHier', sEpilogTgtHier,
    'pAttr', pAttr,
    'pUnwind', pUnwind
    );
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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully cloned the %pSrcDim%:%pSrcHier% dimension:hierarchy to %pTgtDim%:%pTgtHier%' );
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
