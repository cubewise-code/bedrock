601,100
602,"}bedrock.hier.unwind"
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"qeJ`[g^iKRQ;j>@_:akGe[g4=lg8;s5]8k@S91Aagpw@_t`C03Dj0urRi8UMG>u\IJegIVPtJg8CPLNIYKCg^Ccx_R>ghw9M=nGI=vkHtkS5w[vePUk0eQ\R<1BxV?1]A>fLP?1?HVG8dowaB9tO52RaVMczKL2_F<Nv8>6ng^RRJy@fjB;OO_2Y>K=:kslFtN[YChoS"
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
pLogOutput
pDim
pHier
pConsol
pRecursive
pDelim
561,6
1
2
2
2
1
2
590,6
pLogOutput,0
pDim,""
pHier,""
pConsol,"*"
pRecursive,0
pDelim,"&"
637,6
pLogOutput,"Optional: write parameters and action summary to server message log (Boolean True = 1)"
pDim,"Required: Target Dimension, accepts wildcards (if = *, then all the dimensions)"
pHier,"Optional: Target Hierarchy (will use default is left blank), accepts wildcards (if = *, then all hierarchies)"
pConsol,"Optional: Target Consolidation, accepts wildcards ( * will unwind ALL)"
pRecursive,"Required: Boolean: 1 = True (break from node down not just direct children)"
pDelim,"Optional: delimiter character for element list (required if pEle parameter is used)"
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
572,345

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4~~##
################################################################################################# 

#Region @DOC
# Description:
# This process will remove all children from a specific target consolidation (pConsol) in a Hierarchy
# in target Dimension. If recursive (pRecursive=1), it will also unwind all consolidations that are 
# descendants of the target regardless of depth. If not recursive (pRecursive=0) then only immediate children
# of the target consolidation will be removed.
#
# Use case: Intended for both production and development/prototyping scenarios.
# 1. **Production** call prior to main dimension build process in case mapping relationships have changed to ensure no double-counting steming from leaf elements 
# rolling into multiple parents within the same rollup or hierarhcy
# 2. **Production** combine with }bedrock.hier.emptyconsols.delete to remove orphaned rollups
# 3. **Development** manual cleanup of dimensions during prototyping or prior to going to production
#
# Note:
# Valid source dimension name (pDim) is mandatory otherwise the process will abort.
# A blank pHier parameter will process the default hierarchy (i.e. of the same name as the dimension) for each of the dimensions processed.
# A * pConsol parameter will process ALL C level items in the given hierarchy (pHier).
#
# Caution: If consolidations are also used in unrelated consolidations and recursive is selected this
# will result in orphan consolidations in the other hierarchies.
#EndRegion @DOC

##Global Variables
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
cMsgInfoContent   = 'User:%cUserName% Process:%cThisProcName% Message:%sMessage%';
cLogInfo        = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%, pConsol:%pConsol%, pRecursive:%pRecursive%, pDelim:%pDelim%.' ;
cHierAttr       = 'Bedrock.Descendant';
cAttrVal        = 'Descendant';

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;

If( Scan( '*', pDim )=0 &  Scan( '?', pDim )=0 & Scan( pDelim, pDim )=0 & Scan( ':', pDim ) > 0 & pHier @= '' );
    # A hierarchy has been passed as dimension. Handle the input error by splitting dim:hier into dimension & hierarchy
    pHier       = SubSt( pDim, Scan( ':', pDim ) + 1, Long( pDim ) );
    pDim        = SubSt( pDim, 1, Scan( ':', pDim ) - 1 );
EndIf;

## Validate Source dimension
IF( Trim( pDim ) @= '' );
    nErrors = 1;
    sMessage = 'No dimension specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIF( Scan( '*', pDim )=0 &  Scan( '?', pDim )=0 & Scan( pDelim, pDim )=0 & DimensionExists( pDim )=0 );
    nErrors = 1;
    sMessage = 'Invalid dimension: ' | pDim;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate hierarchy
IF( Scan( '*', pDim )=0 &  Scan( '?', pDim )=0 & Scan( pDelim, pDim )=0 & pHier @= '');
    pHier = pDim;
ElseIf( Scan( '*', pHier )=0 &  Scan( '?', pHier )=0 & Scan( pDelim, pHier )=0 & pHier @<> '' & HierarchyExists(pDim, pHier) = 0 );
    nErrors = 1;
    sMessage = 'Invalid dimension hierarchy: ' | pHier;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
Endif;

If( Trim( pHier ) @= '' );
    ## use same name as Dimension. Since wildcards are allowed, this is managed inside the code below
EndIf;

# Validate consol
If(pConsol @<> '');
    If( Scan( '*', pConsol )=0 &  Scan( '?', pConsol )=0 & Scan( pDelim, pConsol )=0 & ElementIndex( pDim, pHier, pConsol ) = 0 );
        nErrors = 1;
        sMessage = 'Item ' | pConsol | ' does NOT exist. Please enter a valid consolidation element in the ' |pDim| ':' |pHier| ' dimension:hierarchy.';  
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    ElseIf( Scan( '*', pConsol )=0 &  Scan( '?', pConsol )=0 & Scan( pDelim, pConsol )=0 & ElementType( pDim, pHier, pConsol ) @<> 'C');
        nErrors = 1;
        sMessage = 'Item ' | pConsol | ' is NOT a consolidated item. Please enter a valid consolidation element in the ' |pDim| ':' |pHier| ' dimension:hierarchy.';  
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    ElseIf( Scan( '*', pConsol )=0 &  Scan( '?', pConsol )=0 & Scan( pDelim, pConsol )=0 & ElementComponentCount( pDim, pHier, pConsol ) = 0 );
        nErrors = 1;
        sMessage = 'Invalid consolidation: ' | pConsol | ' has no children.';
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    Endif;
ElseIf( Trim( pConsol ) @= '' );
    nErrors = 1;
    sMessage = 'No consolidated element specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
Endif;


# If blank delimiter specified then convert to default
If( pDelim @= '' );
    pDelim = '&';
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
    ProcessBreak;
EndIf;


### If there is no separator and wildcard in the parameters, execute the unwind of the element
IF( Scan( '*', pDim )=0 &  Scan( '?', pDim )=0 & Scan( pDelim, pDim )=0 & Scan( '*', pHier )=0 &  Scan( '?', pHier )=0 & Scan( pDelim, pHier )=0 & Scan( '*', pConsol )=0 &  Scan( '?', pConsol )=0 & Scan( pDelim, pConsol )=0 );

  ### Turn-off Logging in the Attribute cube
  sAttrCube = '}ElementAttributes_' | pDim ;
  IF(CubeExists( sAttrCube ) = 1 );
      sOLogging = CELLGETS( '}CubeProperties', sAttrCube, 'Logging' );
      CELLPUTS( 'No', '}CubeProperties', sAttrCube, 'Logging' );
  ENDIF;
  
  ### Set Descendent attribute value
  AttrDelete( pDim, cHierAttr );
  AttrInsert( pDim, '', cHierAttr, 'S' );
  
  nElementIndex = 1;
  nElementCount = ElementCount( pDim , pHier );
  While( nElementIndex <= nElementCount );
      sElement = ElementName( pDim, pHier, nElementIndex );
      If( ElementIsAncestor( pDim, pHier, pConsol, sElement ) = 1 );
          ElementAttrPutS( cAttrVal, pDim, pHier, sElement, cHierAttr );
      EndIf;
      nElementIndex = nElementIndex + 1;
  End;
  
  ### Remove direct children from the target consol ###
  nChildren = ElementComponentCount( pDim, pHier, pConsol );
  While( nChildren > 0 );
      # Unwind direct children of target hierarchy only
      sChild = ElementComponent( pDim, pHier, pConsol, nChildren );
      HierarchyElementComponentDelete( pDim, pHier, pConsol, sChild );
      If( pLogOutput = 1 );
        LogOutput( 'INFO', Expand( 'Deleting component "%sChild%" from consolidation %pConsol% in hierarchy "%pHier%" of "%pDim%" dimension.' ) );
      EndIf;
      nChildren = nChildren - 1;
  End;
  
  ### Assign data source ###
  If( pRecursive = 1);
      # Assign Data Source
      DataSourceType            = 'SUBSET';
      DatasourceNameForServer   = pDim|':'|pHier;
      DatasourceNameForClient   = pDim|':'|pHier;
      DatasourceDimensionSubset = 'ALL';
  Else;
      # No data source, straight to Epilog
      DataSourceType = 'NULL';
  EndIf;


## Otherwise, if there is a separator or wildcard in the parameters, tokenize the string and self-call the process recursively.
ELSE;
  # No data source, straight to Epilog
  DataSourceType = 'NULL';
  
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
      sMdxPart = '{TM1FILTERBYPATTERN( EXCEPT( TM1SUBSETALL( [}Dimensions] ) , TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) , "*:*") ) ,'| sDimExp | ')}';
      IF( sMdx @= ''); 
        sMdx = sMdxPart; 
      ELSE;
        sMdx = sMdx | ' + ' | sMdxPart;
      ENDIF;
  End;
  
  If( SubsetExists( '}Dimensions' , cTempSub ) = 1 );
      # If a delimited list of dim names includes wildcards then we may have to re-use the subset multiple times
      SubsetMDXSet( '}Dimensions' , cTempSub, sMDX );
  Else;
      # temp subset, therefore no need to destroy in epilog
      SubsetCreatebyMDX( cTempSub, sMDX, '}Dimensions' , 1 );
  EndIf;
  
  # Loop through dimensions in subset created based on wildcard
  nCountDim = SubsetGetSize( '}Dimensions' , cTempSub );
  While( nCountDim >= 1 );
      sDim = SubsetGetElementName( '}Dimensions' , cTempSub, nCountDim );
      # Validate dimension name
      If( DimensionExists(sDim) = 0 );
          nErrors = 1;
          sMessage = Expand( 'Dimension "%sDim%" does not exist.' );
          LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
      Else;
          If( pLogOutput = 1 );
            sMessage = Expand( 'Dimension "%sDim%" being processed....' );
            LogOutput( 'INFO', Expand( cMsgInfoContent ) );
          EndIf;
          # Loop through hierarchies in pHier
          If( Trim( pHier ) @= '' );
            ### Use main hierarchy for each dimension if pHier is empty
            sHierarchies = sDim;
          Else;
            sHierarchies              = pHier;
          EndIf;
          nDelimiterIndexA    = 1;
          #sHierDim            = '}Hierarchies_'|sDim ;
          sHierDim            = '}Dimensions' ;
          sMdxHier = '';
          While( nDelimiterIndexA <> 0 );
  
              nDelimiterIndexA = Scan( pDelim, sHierarchies );
              If( nDelimiterIndexA = 0 );
                  sHierarchy   = sHierarchies;
              Else;
                  sHierarchy   = Trim( SubSt( sHierarchies, 1, nDelimiterIndexA - 1 ) );
                  sHierarchies  = Trim( Subst( sHierarchies, nDelimiterIndexA + Long(pDelim), Long( sHierarchies ) ) );
              EndIf;
  
              # Create subset of Hierarchies using Wildcard
              If( sDim @= sHierarchy );
                sHierExp = '"'| sDim |'"';
              Else;
                sHierExp = '"'| sDim | ':' | sHierarchy|'"';
              EndIf;
              sMdxHierPart = '{TM1FILTERBYPATTERN( {TM1SUBSETALL([ ' |sHierDim| '])},'| sHierExp | ')}';
              IF( sMdxHier @= ''); 
                sMdxHier = sMdxHierPart; 
              ELSE;
                sMdxHier = sMdxHier | ' + ' | sMdxHierPart;
              ENDIF;
          End;
          
          # include the named hierarchy in case ALL hierachies
          If( Trim(pHier) @= '*' );
            sMdxHier = sMdxHier | '+{[ ' |sHierDim| '].['| sDim | ']}';
          EndIf;
  
          If( SubsetExists( sHierDim, cTempSub ) = 1 );
              # If a delimited list of attr names includes wildcards then we may have to re-use the subset multiple times
              SubsetMDXSet( sHierDim, cTempSub, sMdxHier );
          Else;
              # temp subset, therefore no need to destroy in epilog
              SubsetCreatebyMDX( cTempSub, sMdxHier, sHierDim, 1 );
          EndIf;

          # Loop through subset of hierarchies created based on wildcard
          nCountHier = SubsetGetSize( sHierDim, cTempSub );
          While( nCountHier >= 1 );
              sCurrHier = SubsetGetElementName( sHierDim, cTempSub, nCountHier );
              sCurrHierName = Subst( sCurrHier, Scan(':', sCurrHier)+1, Long(sCurrHier) );
              # Validate hierarchy name in sHierDim
              If( Dimix( sHierDim , sCurrHier ) = 0 );
                  sMessage = Expand('The "%sCurrHier%" hierarchy does NOT exist in the "%sDim%" dimension.');
                  LogOutput( 'INFO' , Expand( cMsgInfoContent ) );
              ElseIf( sCurrHierName @= 'Leaves' );
                  sMessage = 'Invalid  Hierarchy: ' | sCurrHier | ' will be skipped....';
                  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
              Else;
                If( pLogOutput = 1 );
                  sMessage = Expand( 'Hierarchy "%sCurrHierName%" in Dimension "%sDim%" being processed....' );
                  LogOutput( 'INFO', Expand( cMsgInfoContent ) );
                EndIf;
                # Loop through consolidated elements in in pConsol
                sEles = pConsol;
                nDelimiterIndexB = 1;
                While( nDelimiterIndexB <> 0 );
                    
                    nDelimiterIndexB = Scan( pDelim, sEles );
                    If( nDelimiterIndexB = 0 );
                        sEle = sEles;
                    Else;
                        sEle = Trim( SubSt( sEles, 1, nDelimiterIndexB - 1 ) );
                        sEles = Trim( Subst( sEles, nDelimiterIndexB + Long(pDelim), Long( sEles ) ) );
                    EndIf;
                    
                        # Wildcard search string
                        sEle = '"'|sEle|'"';
                        sMdxEle = '{TM1FILTERBYPATTERN( {TM1SUBSETALL([ ' | sCurrHier |' ])},'| sEle| ')}';
  
                        If( HierarchySubsetExists( sDim, sCurrHierName, cTempSub ) = 1 );
                            # If a delimited list of dim names includes wildcards then we may have to re-use the subset multiple times
                            HierarchySubsetMDXSet( sDim, sCurrHierName, cTempSub, sMDXEle );
                        Else;
                            # temp subset, therefore no need to destroy in epilog
                            SubsetCreatebyMDX( cTempSub, sMDXEle, sCurrHier, 1 );
                        EndIf;
  
                        # Loop through subset of Consolidated elements created based on wildcard
                        nCountElems = HierarchySubsetGetSize(sDim, sCurrHierName, cTempSub);
                        While( nCountElems >= 1 );
                            sElement = HierarchySubsetGetElementName(sDim, sCurrHierName, cTempSub, nCountElems);
                            ## Check that the element is consolidated and has children
                            If( DType( sCurrHier, sElement )@='C' & ElementComponentCount( sDim, sCurrHierName, sElement )>0 );
                              If( pLogOutput = 1 );
                                LogOutput( 'INFO', Expand( '    Process called recursively for "%sElement%" in hierarchy "%sDim%:%sCurrHierName%".' ) );
                              EndIf;
                              EXECUTEPROCESS('}bedrock.hier.unwind',
                                'pLogOutput', pLogOutput,
                                'pDim', sDim,
                                'pHier', sCurrHierName,
                                'pConsol', sElement,
                                'pRecursive', pRecursive
                              );
                            EndIf;
                            nCountElems = nCountElems - 1;
                        End;
                End;
            Endif;
            
              nCountHier = nCountHier - 1;
          End;
              
      EndIf;
      
      nCountDim = nCountDim - 1;
  End;
EndIf;




### End Prolog ###
573,31

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

## Check for errors in prolog ###
If( nErrors <> 0 );
  ProcessBreak;
EndIf;

### Break all parent/child links below target consol ###
If(pConsol @= '');
    sAttrVal = cAttrVal;
Else;
    sAttrVal = ElementAttrS(pDim, pHier, vElement, cHierAttr);
EndIf;

If( sAttrVal @= cAttrVal & ElementType( pDim, pHier, vElement ) @= 'C' & ElementComponentCount( pDim, pHier, vElement ) > 0 );
    nChildren       = ElementComponentCount( pDim, pHier, vElement );
    While( nChildren > 0 );
        sChild      = ElementComponent(  pDim, pHier, vElement, nChildren );
        HierarchyElementComponentDelete( pDim, pHier , vElement, sChild );
        nChildren = nChildren - 1;
    End;
EndIf;


### End Metadata ###
574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,45

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

    ### Remove Descendent attribute
    IF( Scan( '*', pDim )=0 &  Scan( '?', pDim )=0 & Scan( pDelim, pDim )=0 & Scan( '*', pHier )=0 &  Scan( '?', pHier )=0 & Scan( pDelim, pHier )=0 & Scan( '*', pConsol )=0 &  Scan( '?', pConsol )=0 & Scan( pDelim, pConsol )=0 );
      AttrDelete( pDim, cHierAttr );
    EndIf;
EndIf;

### Reset Logging in the Attribute cube
IF( Scan( '*', pDim )=0 &  Scan( '?', pDim )=0 & Scan( pDelim, pDim )=0 & Scan( '*', pHier )=0 &  Scan( '?', pHier )=0 & Scan( pDelim, pHier )=0 & Scan( '*', pConsol )=0 &  Scan( '?', pConsol )=0 & Scan( pDelim, pConsol )=0 );
  IF(CubeExists( sAttrCube ) = 1 );
      CELLPUTS( sOLogging, '}CubeProperties', sAttrCube, 'Logging' );
  EndIf;
EndIf;

### Return code & final error message handling
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
Else;
    sProcessAction = Expand( 'Process:%cThisProcName% successfully unwound the appropriate consolidated items the %pDim%:%pHier% dimension:hierarchy.' );
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
