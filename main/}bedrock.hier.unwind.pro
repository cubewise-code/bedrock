601,100
602,"}bedrock.hier.unwind"
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"wG<[0r>wEzymj`d\jFLCvFXaI;s=Yw?Hi>G;YWkw=uf=V?4DLas\hYEfjUV;F5iRP?H3Skxxwbgp5\v^p\[bxyA7BlI0P;b_PPK6;77tLopNAux3L@C:[;JMJ?H[NH>g@T?5UksHer2>sbCyF750l[B[6t>1r2BV\:]ZKtKyWugt<cCKTy_`MTLsPnP:q`heF890c:wf"
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
560,7
pLogOutput
pStrictErrorHandling
pDim
pHier
pConsol
pRecursive
pDelim
561,7
1
1
2
2
2
1
2
590,7
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pHier,""
pConsol,"*"
pRecursive,0
pDelim,"&"
637,7
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"REQUIRED: Target Dimension, accepts wildcards (if = *, then all the dimensions)"
pHier,"OPTIONAL: Target Hierarchy (will use default is left blank), accepts wildcards (if = *, then all hierarchies)"
pConsol,"OPTIONAL: Target Consolidation, accepts wildcards ( * will unwind ALL)"
pRecursive,"REQUIRED: Boolean: 1 = True (break from node down not just direct children)"
pDelim,"OPTIONAL: delimiter character for element list (default value if blank = '&')"
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
572,407
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.unwind', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pDim', '', 'pHier', '', 'pConsol', '*',
    	'pRecursive', 0, 'pDelim', '&'
	);
EndIf;
#EndRegion CallThisProcess

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
#    rolling into multiple parents within the same rollup or hierarhcy
# 2. **Production** combine with }bedrock.hier.emptyconsols.delete to remove orphaned rollups
# 3. **Development** manual cleanup of dimensions during prototyping or prior to going to production
#
# Note:
# * A valid source dimension name (pDim) is mandatory otherwise the process will abort.
# * A blank pHier parameter will process _only the same named hierarchy_ for each of the dimensions processed.
# * A \* pConsol parameter will process ALL C level items in the given hierarchy (pHier).
# * A delimited list or wildcard for pDim or pHier or a delimited list of consolidations for pConsol will result in recursive calls of the process.
#
# Caution: 
# If consolidations are also used in unrelated consolidations and recursive is selected this
# will result in orphan consolidations in the other rollups.
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
cTempSubOuter   = '}OuterLoop_' | cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cTempSubInner   = '}InnerLoop_' | cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cMsgErrorLevel  = 'ERROR';
cMsgErrorContent= 'Process:%cThisProcName% ErrorMsg:%sMessage%';
cMsgInfoContent = 'User:%cUserName% Process:%cThisProcName% Message:%sMessage%';
cLogInfo        = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%, pConsol:%pConsol%, pRecursive:%pRecursive%, pDelim:%pDelim%.' ;
cHierAttr       = 'Bedrock.Descendant';
cAttrVal        = 'Descendant';

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;

If( Scan( '*', pDim ) = 0 & Scan( '?', pDim ) = 0 & Scan( pDelim, pDim ) = 0 & Scan( ':', pDim ) > 0 & pHier @= '' );
    # A hierarchy has been passed as dimension. Handle the input error by splitting dim:hier into dimension & hierarchy
    pHier       = SubSt( pDim, Scan( ':', pDim ) + 1, Long( pDim ) );
    pDim        = SubSt( pDim, 1, Scan( ':', pDim ) - 1 );
EndIf;

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

# Validate hierarchy (can only validate hierarchy up front if dimension is fixed and doesn't contain wildcards)
IF( Scan( '*', pDim ) = 0 & Scan( '?', pDim ) = 0 & Scan( pDelim, pDim ) = 0 & pHier @= '');
    pHier = pDim;
ElseIf( Scan( '*', pHier ) = 0 & Scan( '?', pHier ) = 0 & Scan( pDelim, pHier ) = 0 & pHier @<> '' & DimensionExists( pDim ) = 1 & HierarchyExists( pDim, pHier ) = 0 );
    nErrors = 1;
    sMessage = 'Invalid dimension hierarchy: ' | pHier;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
Endif;

If( Trim( pHier ) @= '' );
    ## use same name as Dimension. Since wildcards are allowed, this is managed inside the code below
EndIf;

# Validate consol
If( pConsol @<> '');
    If( Scan( '*', pConsol ) = 0 & Scan( '?', pConsol ) = 0 & Scan( pDelim, pConsol ) = 0 & ElementIndex( pDim, pHier, pConsol ) = 0 );
        nErrors = 1;
        sMessage = 'Item ' | pConsol | ' does NOT exist. Please enter a valid consolidation element in the ' |pDim| ':' |pHier| ' dimension:hierarchy.';  
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    ElseIf( Scan( '*', pConsol ) = 0 & Scan( '?', pConsol ) = 0 & Scan( pDelim, pConsol ) = 0 & ElementType( pDim, pHier, pConsol ) @<> 'C' );
        nErrors = 1;
        sMessage = 'Item ' | pConsol | ' is NOT a consolidated item. Please enter a valid consolidation element in the ' |pDim| ':' |pHier| ' dimension:hierarchy.';  
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    ElseIf( Scan( '*', pConsol ) = 0 & Scan( '?', pConsol ) = 0 & Scan( pDelim, pConsol ) = 0 & ElementComponentCount( pDim, pHier, pConsol ) = 0 );
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
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
Else;
  # If subset required will be set later
  DataSourceType = 'NULL';
EndIf;

### If there is no separator and wildcard in the parameters, execute the unwind of the specific consolidated element
If( Scan( '*', pDim ) = 0 & Scan( '?', pDim ) = 0 & Scan( pDelim, pDim ) = 0 & Scan( '*', pHier ) = 0 & Scan( '?', pHier ) = 0 & Scan( pDelim, pHier ) = 0 & Scan( '*', pConsol ) = 0 & Scan( '?', pConsol ) = 0 & Scan( pDelim, pConsol ) = 0 );

    ### In case alias used for pConsol convert to principal name 
    If( ElementIndex( pDim, pHier, pConsol ) > 0 );
        pConsol = HierarchyElementPrincipalName( pDim, pHier, pConsol );
    EndIf;

    ### Turn-off Logging in the Attribute cube
    sAttrCube = '}ElementAttributes_' | pDim;
    If( CubeExists( sAttrCube ) = 1 );
        nLogging = CubeGetLogChanges( sAttrCube );
        CubeSetLogChanges( sAttrCube, 0 );
    EndIf;
    
    ### Create Temp Descendent Attribute
    AttrDelete( pDim, cHierAttr );
    AttrInsert( pDim, '', cHierAttr, 'S' );
    
    ### Assign data source ###
    If( pRecursive      = 1);
        # Set Descendent attribute value
        nElementIndex   = 1;
        nElementCount   = ElementCount( pDim , pHier );
        While( nElementIndex <= nElementCount );
            sElement = ElementName( pDim, pHier, nElementIndex );
            If( ElementIsAncestor( pDim, pHier, pConsol, sElement ) = 1 % pConsol @= sElement );
                ElementAttrPutS( cAttrVal, pDim, pHier, sElement, cHierAttr );
            EndIf;
            nElementIndex = nElementIndex + 1;
        End;
        # Assign Data Source
        DataSourceType            = 'SUBSET';
        DatasourceNameForServer   = pDim|':'|pHier;
        DatasourceNameForClient   = pDim|':'|pHier;
        DatasourceDimensionSubset = 'ALL';
    Else;
        ### Remove direct children from the target consol ###
        If( ElementComponentCount( pDim, pHier, pConsol ) > 0 );
            If( pLogOutput = 1 );
                LogOutput( 'INFO', Expand( 'Deleting all components from consolidation %pConsol% in hierarchy "%pHier%" of "%pDim%" dimension.' ) );
            EndIf;
            nComp = ElementComponentCount( pDim, pHier, pConsol );
            While( nComp > 0 );
                sComp = ElementComponent( pDim, pHier, pConsol, nComp );
                HierarchyElementComponentDelete( pDim, pHier, pConsol, sComp );
                nComp = nComp - 1;
            End;
        EndIf;
        # No data source, straight to Epilog
        DataSourceType = 'NULL';
    EndIf;

### If pConsol is "*" and there is no separator and wildcard in the pDim & pHier parameters then unwind the whole hierarchy
ElseIf( Scan( '*', pDim ) = 0 & Scan( '?', pDim ) = 0 & Scan( pDelim, pDim ) = 0 & Scan( '*', pHier ) = 0 & Scan( '?', pHier ) = 0 & Scan( pDelim, pHier ) = 0 & Trim( pConsol ) @= '*' );

    # as pConsol is * wildcard it doesn't matter if recursive or not. We unwind everything. As speed enhancement rather than removing children delete and add back C elements to empty children in one step (not steps = count of children)
    nMaxEle = ElementCount( pDim, pHier );
    nCtrEle = 1;
    While( nCtrEle <= nMaxEle );
        sEle = ElementName( pDim, pHier, nCtrEle);
        If( ElementComponentCount( pDim, pHier, sEle ) > 0 );
            If( nCtrEle < nMaxEle );
                sEleNext = ElementName( pDim, pHier, nCtrEle + 1 );
            Else;
                sEleNext = '';
            EndIf;
            HierarchyElementDelete( pDim, pHier, sEle );
            HierarchyElementInsert( pDim, pHier, sEleNext, sEle, 'C' );
        EndIf;
        nCtrEle = nCtrEle + 1;
    End;

    # since hierarchy already fully unwound no subset; datasource = NULL
    DataSourceType = 'NULL';

## Otherwise, if there is a separator or wildcard in the parameters, tokenize the string and self-call the process recursively.
Else;
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
        sMdxPart = Expand('{TM1FILTERBYPATTERN( EXCEPT( TM1SUBSETALL( [}Dimensions].[}Dimensions] ), TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions].[}Dimensions] ) , "*:*") ) , %sDimExp% )}');
        If( sMdx @= ''); 
            sMdx = sMdxPart; 
        Else;
            sMdx = sMdx | ' + ' | sMdxPart;
        EndIf;
    End;
  
    If( SubsetExists( '}Dimensions' , cTempSubOuter ) = 1 );
        # If a delimited list of dim names includes wildcards then we may have to re-use the subset multiple times
        SubsetMDXSet( '}Dimensions' , cTempSubOuter, sMDX );
    Else;
        # temp subset, therefore no need to destroy in epilog
        SubsetCreatebyMDX( cTempSubOuter, sMDX, '}Dimensions' , 1 );
    EndIf;
  
    # Loop through dimensions in subset created based on wildcard
    nCountDim = SubsetGetSize( '}Dimensions' , cTempSubOuter );
    While( nCountDim >= 1 );
        sDim = SubsetGetElementName( '}Dimensions' , cTempSubOuter, nCountDim );
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
                sHierarchies  = sDim;
            Else;
                sHierarchies  = pHier;
            EndIf;
            nDelimiterIndexA  = 1;
            sHierDim          = '}Dimensions' ;
            sMdxHier          = '';
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
                    sMdxHierPart = Expand('{TM1FILTERBYPATTERN( {TM1SUBSETALL([%sHierDim%].[%sHierDim%])}, %sHierExp% )}');
                If( sMdxHier @= ''); 
                    sMdxHier = sMdxHierPart; 
                Else;
                    sMdxHier = sMdxHier | ' + ' | sMdxHierPart;
                EndIf;
            End;
          
            # include the named hierarchy in case ALL hierachies
            If( Trim(pHier) @= '*' );
                sMdxHier = Expand('{[%sHierDim%].[%sHierDim%].[%sDim%]} + %sMdxHier%');
            EndIf;
  
            If( SubsetExists( sHierDim, cTempSubInner ) = 1 );
                # If a delimited list of hierarchy names includes wildcards then we may have to re-use the subset multiple times
                SubsetMDXSet( sHierDim, cTempSubInner, sMdxHier );
            Else;
                # temp subset, therefore no need to destroy in epilog
                SubsetCreatebyMDX( cTempSubInner, sMdxHier, sHierDim, 1 );
            EndIf;

            # Loop through subset of hierarchies created based on wildcard
            nCountHier = SubsetGetSize( sHierDim, cTempSubInner );
            While( nCountHier >= 1 );
                sCurrHier = SubsetGetElementName( sHierDim, cTempSubInner, nCountHier );
                sCurrHierName = Subst( sCurrHier, Scan(':', sCurrHier)+1, Long(sCurrHier) );
                # Validate hierarchy name in sHierDim
                If( Dimix( sHierDim , sCurrHier ) = 0 );
                    sMessage = Expand('The "%sCurrHier%" hierarchy does NOT exist in the "%sDim%" dimension.');
                    LogOutput( 'INFO' , Expand( cMsgInfoContent ) );
                ElseIf( sCurrHierName @= 'Leaves' );
                    sMessage = Expand('Skipping %sCurrHier% hierarchy. No need to unwind!');
                    If( pLogOutput = 1 );
                        LogOutput( 'INFO', Expand( cMsgInfoContent ) );
                    EndIf;
                Else;
                    If( pLogOutput = 1 );
                        sMessage = Expand( 'Hierarchy "%sCurrHierName%" in Dimension "%sDim%" being processed....' );
                        LogOutput( 'INFO', Expand( cMsgInfoContent ) );
                    EndIf;
                    # Loop through consolidated elements in pConsol
                    sEles = Trim( pConsol );
                    If( sEles @= '*' );
                        # no need for recursive call for ALL wildcard. We can just unwind whole hierarchy
                        nMaxEle = ElementCount( sDim, sCurrHierName );
                        nCtrEle = 1;
                        While( nCtrEle <= nMaxEle );
                            sEle = ElementName( sDim, sCurrHierName, nCtrEle);
                            If( ElementComponentCount( sDim, sCurrHierName, sEle ) > 0 );
                                If( nCtrEle < nMaxEle );
                                    sEleNext = ElementName( sDim, sCurrHierName, nCtrEle + 1 );
                                Else;
                                    sEleNext = '';
                                EndIf;
                                HierarchyElementDelete( sDim, sCurrHierName, sEle );
                                HierarchyElementInsert( sDim, sCurrHierName, sEleNext, sEle, 'C' );
                            EndIf;
                            nCtrEle = nCtrEle + 1;
                        End;
                    Else;
                        # a delimited list of consolidations is given. Handle with recursive call and temp descendents attribute
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
                            sMdxEle = Expand('{TM1FILTERBYPATTERN( {TM1SUBSETALL([%sCurrHier%])}, %sEle% )}');
      
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
                                If( DType( sCurrHier, sElement ) @= 'C' & ElementComponentCount( sDim, sCurrHierName, sElement ) > 0 );
                                    If( pLogOutput = 1 );
                                        LogOutput( 'INFO', Expand( 'Process called recursively for "%sElement%" in hierarchy "%sDim%:%sCurrHierName%".' ) );
                                    EndIf;
                                    ExecuteProcess( cThisProcName, 'pLogOutput', pLogOutput,
                                        'pStrictErrorHandling', pStrictErrorHandling,
                                        'pDim', sDim, 'pHier', sCurrHierName,
                                        'pConsol', sElement, 'pRecursive', pRecursive,
                                        'pDelim', pDelim
                                    );
                                EndIf;
                                
                                nCountElems = nCountElems - 1;
                            End;
                        End;
                    EndIf;
                Endif;
            
                nCountHier = nCountHier - 1;
            End;
              
        EndIf;
      
        nCountDim = nCountDim - 1;
    End;
EndIf;

### End Prolog ###
573,62

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

### Check for errors in prolog ###
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

### If Leaf or already unwound then skip
If( ElementComponentCount( pDim, pHier, vElement ) = 0 );
    ItemSkip;
EndIf;
    
### Break all parent/child links below target consol ###
If( pConsol @= '*' );
    sAttrVal = cAttrVal;
Else;
    sAttrVal = ElementAttrS( pDim, pHier, vElement, cHierAttr );
EndIf;

If( sAttrVal @= cAttrVal );
    bFastUnwind = 1;

    # Cannot check nPars > 1 as due to ordering of elements processes some parents may have already been removed
    nPars = ElementParentCount( pDim, pHier, vElement );
    nPar = 1;
    While( nPar <= nPars );
        sPar = ElementParent( pDim, pHier, vElement, nPar );
        If( ElementAttrS( pDim, pHier, sPar, cHierAttr ) @<> cAttrVal );
            # Parent does not belong to unwinding intersection. Cannot delete C children, must unwind.
            bFastUnwind = 0;
        EndIf;
        nPar = nPar + 1;
    End;
        
    If( bFastUnwind = 1 );
        # delete and recreate C element (Fast)
        sEleNext = ElementName( pDim, pHier, ElementIndex( pDim, pHier, vElement ) + 1 );
        HierarchyElementDelete( pDim, pHier, vElement );
        HierarchyElementInsert( pDim, pHier, sEleNext, vElement, 'C' );
    Else;
        # unwind C element without deletion (Slow for consols with many children)
        nComp = ElementComponentCount( pDim, pHier, vElement );
        While( nComp > 0 );
            sComp = ElementComponent( pDim, pHier, vElement, nComp );
            HierarchyElementComponentDelete( pDim, pHier, vElement, sComp );
            nComp = nComp - 1;
        End;
    EndIf;
    
EndIf;

### End Metadata ###
574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,50

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
    IF( Scan( '*', pDim ) = 0 &  Scan( '?', pDim ) = 0 & Scan( pDelim, pDim ) = 0 & Scan( '*', pHier ) = 0 & Scan( '?', pHier ) = 0 & Scan( pDelim, pHier ) = 0 & Scan( '*', pConsol ) = 0 & Scan( '?', pConsol ) = 0 & Scan( pDelim, pConsol ) = 0 );
      AttrDelete( pDim, cHierAttr );
    EndIf;
EndIf;

### Reset Logging in the Attribute cube
IF( Scan( '*', pDim ) = 0 & Scan( '?', pDim ) = 0 & Scan( pDelim, pDim ) = 0 & Scan( '*', pHier ) = 0 & Scan( '?', pHier ) = 0 & Scan( pDelim, pHier ) = 0 & Scan( '*', pConsol ) = 0 & Scan( '?', pConsol ) = 0 & Scan( pDelim, pConsol ) = 0 );
    If( CubeExists( sAttrCube ) = 1 );
        If( nLogging = 1 );
            CubeSetLogChanges( sAttrCube, 1 );
        EndIf;
    EndIf;
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
