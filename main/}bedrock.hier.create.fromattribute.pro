601,100
602,"}bedrock.hier.create.fromattribute"
562,"VIEW"
586,"}ElementAttributes_}Clients"
585,"}ElementAttributes_}Clients"
564,
565,"hR44[B=<aAN?hokC4R;39TPZ@5^i4K;g2skW]2Jz77wW:3Hpr7;hp^pyyvsz>l9PiPh1ihSa41fl8@GFZF@HH1q@27=7;f=SjRRc@ZWT31hpnefu\;QR1lieFFuD>Hp7;yNXtsx<AEnjrcP<Mak83hzD?THrn6=[RDK7mH_\Ab9Ub5C5d4aPwZlt]Ryzaox^dKk1oP9c"
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
570,Temp
571,
569,0
592,0
599,1000
560,10
pLogOutput
pDim
pSrcHier
pTgtHier
pAttr
pTopNode
pPrefix
pSuffix
pSkipBlank
pUnallocated
561,10
1
2
2
2
2
2
2
2
1
2
590,10
pLogOutput,1
pDim,""
pSrcHier,""
pTgtHier,""
pAttr,""
pTopNode,"Total <pAttr>"
pPrefix,""
pSuffix,""
pSkipBlank,0
pUnallocated,"Undefined <pAttr>"
637,10
pLogOutput,"Optional: write parameters and action summary to server message log (Boolean True = 1)"
pDim,"Required: Dimension"
pSrcHier,"Optional: Source Hierarchy, If not specified takes the default Hierarchy"
pTgtHier,"Optional: Target Hierarchy, If not specified, takes the same name as attribute."
pAttr,"Required: Attribute"
pTopNode,"Optional: The name of the Target Hierarchy top element (will default to 'All ' attribute name )"
pPrefix,"Optional: Prefix before the attribute value"
pSuffix,"Optional: Suffix after the attribute value"
pSkipBlank,"Optional: To manage empty attribute: 0= Skip,  1=Send to unallocated node (by default blank attribute values are skipped)"
pUnallocated,"Optional: Naming convention for rollup if attribute is empty (eg. Unallocated <pAttr>, No <pAttr>, Undefined <pAttr>)"
577,3
vEle
vAttr
Value
578,3
2
2
2
579,3
1
2
3
580,3
0
0
0
581,3
0
0
0
582,3
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
603,0
572,178

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This process will create a new dimension hierarchy from attribute values.

# Note:
# Valid dimension name (pDim) and attribute name (pAttr) are mandatory, otherwise the
# process will abort.

# Caution: It is assumed each element exists __only once__ within the hierarchy. This should hold true except in exceptional circumstances.
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
cSubset           = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pSrcHier:%pSrcHier%, pTgtHier:%pTgtHier%, pAttr:%pAttr%, pTopNode:%pTopNode%, pPrefix:%pPrefix%, pSuffix:%pSuffix%, pSkipBlank:%pSkipBlank%, pUnallocated:%pUnallocated%.';
cAttributeDim     = '}ElementAttributes_' | pDim;

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;

If( Scan( ':', pDim ) > 0 & pSrcHier @= '' );
    # A hierarchy has been passed as dimension. Handle the input error by splitting dim:hier into dimension & hierarchy
    pSrcHier       = SubSt( pDim, Scan( ':', pDim ) + 1, Long( pDim ) );
    pDim        = SubSt( pDim, 1, Scan( ':', pDim ) - 1 );
EndIf;

## Validate dimension
If( Trim( pDim ) @= '' );
    nErrors = 1;
    sMessage = 'No dimension specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( DimensionExists( pDim ) = 0 );
    nErrors = 1;
    sMessage = 'Dimension: ' | pDim | ' does not exist.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;


### Check for errors before continuing
If( nErrors <> 0 );
    ProcessBreak;
EndIf;

## Validate Hierarchy
IF( Trim( pSrcHier  ) @= '' );
    pSrcHier = Trim( pDim );
EndIf;

IF( HierarchyExists( pDim, pSrcHier ) = 0 );
    nErrors = 1;
    sMessage = 'Invalid dimension Hierarchy: ' | pDim |':'|pSrcHier;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

pnew =DType( cAttributeDim, pAttr );
## Validate attribute
If( Trim( pAttr ) @= '' );
    nErrors = 1;
    sMessage = 'No attribute specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( DimIx( cAttributeDim, pAttr ) = 0 );
    nErrors = 1;
    sMessage = 'Attribute: ' | pAttr | ' does not exists in dimension: ' | pDim;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( DType( cAttributeDim, pAttr ) @<> 'AS' );
    nErrors = 1;
    sMessage = 'Only string attributes may be used for this process.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

##  Validate Top node name
IF( Trim( pTopNode  ) @= '' );
    sTopNode = 'All ' | pAttr;
ElseIF( Subst(Trim( pTopNode ),1,7 ) @= '<pAttr>'  );
    sTopNode = pAttr | ' ' | Subst( pTopNode, 8, Long( pTopNode ) );
ElseIF( Subst( pTopNode, Long( pTopNode )-7, 8 ) @= '<pAttr>'  );
    sTopNode = Subst( pTopNode, 1, Long( pTopNode )-8 )  | ' ' | pAttr;
ElseIF( Scan( '<pAttr>', pTopNode ) >0 );
    sTopNode = Subst( pTopNode, 1, Scan( '<pAttr>', pTopNode )-1 ) | pAttr | Subst( pTopNode, Scan( '<pAttr>', pTopNode )+7,Long(pTopNode) );
EndIf;

##  Validate Unallocated node name
IF( Trim( pUnallocated  ) @= '' );
    pUnallocated = 'Unallocated';
ElseIF( Subst(Trim( pUnallocated ),1,7 ) @= '<pAttr>'  );
    pUnallocated = pAttr | ' ' | Subst( pUnallocated, 8, Long( pUnallocated ) );
ElseIF( Subst( pUnallocated, Long( pUnallocated )-7, 8 ) @= '<pAttr>'  );
    pUnallocated = Subst( pUnallocated, 1, Long( pUnallocated )-8 )  | ' ' | pAttr;
ElseIF( Scan( '<pAttr>', pUnallocated ) >0 );
    pUnallocated = Subst( pUnallocated, 1, Scan( '<pAttr>', pUnallocated )-1 ) | pAttr | Subst( pUnallocated, Scan( '<pAttr>', pUnallocated )+7,Long(pUnallocated) );
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
  ProcessBreak;
EndIf;

## Modify attribute for hierarchy name
sAttribute = Trim(pAttr);
#If Attribute name has ":" then delete as Hierachy names are not allowed with ":" 
If(Scan(':', sAttribute) > 0);
        nStart = 0;
        WHILE ( nStart <> 1 );
            nSpecialChar = SCAN ( ':', sAttribute );
        	IF ( nSpecialChar <> 0 );
        		sAttribute  = DELET (sAttribute , nSpecialChar, 1 );
        	ELSE;
        		nStart = 1;
        	ENDIF;
        END;
EndIf;

### Create target dimension Hierarchy ###
If(pTgtHier @= '');
  sTargetHierarchy = sAttribute;
Else;
  sTargetHierarchy = pTgtHier;
EndIf;

If( HierarchyExists( pDim, sTargetHierarchy ) = 0 );
    HierarchyCreate( pDim, sTargetHierarchy );
Else;
    HierarchyDeleteAllElements( pDim, sTargetHierarchy );
EndIf;

#Target consol does not exist then add element to dimension.
If( ElementIndex(pDim, sTargetHierarchy, sTopNode) = 0);
    HierarchyElementinsert(pDim, sTargetHierarchy, '',sTopNode, 'C');
Endif;

### Format Prefix and Suffix with trailing or leading ' ' ###
IF( pPrefix @<> '' );
    IF( SUBST( pPrefix, Long( pPrefix), 1) @<> ' ' );
        sPrefix = pPrefix | ' ';
    ELSE;
        sPrefix = pPrefix;
    ENDIF;
ENDIF;

IF( pSuffix @<> '' );
    IF( SUBST( pSuffix, 1, 1) @<> ' ' );
        sSuffix = ' ' | pSuffix;
    ELSE;
        sSuffix = pSuffix;
    ENDIF;
ENDIF;


### Assign Data Source ###
DatasourceNameForServer   = pDim|':'|pSrcHier;
DatasourceNameForClient   = pDim|':'|pSrcHier;
DataSourceType            = 'SUBSET';
DatasourceDimensionSubset = 'ALL';

### End Prolog ###
573,47

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0.0~~##
################################################################################################# 


### Check for errors in prolog ###

If( nErrors <> 0 );
  ProcessBreak;
EndIf;

# Skip if the Element is not leaf element
If( ElementType(pDim, pSrcHier, vEle) @<> 'N' );
    ItemSkip;
Endif;

# Skip if top node
If( vEle @= sTopNode );
    ItemSkip;
ENDIF;

sAttrVal = ElementAttrS(pDim, pSrcHier, vEle, pAttr);
sParent = sAttrVal;

# Manage not populated attribute.
If( sParent @= '' & pSkipBlank = 0 );
    ItemSkip;
ElseIf( sParent @= '' & pSkipBlank <> 0 );  
    sParent = pUnallocated;
EndIf;

#If parent does not exist AND allow insertion of new parents is TRUE then insert new consol
## Add the attribute value to the top node.
  
  sElPar = sPrefix | sParent | sSuffix;

  HierarchyElementinsert(pDim, sTargetHierarchy, '',sElPar, 'C');
  HierarchyElementComponentAdd(pDim, sTargetHierarchy, sTopNode, sElPar, 1);
  
  HierarchyElementinsert(pDim, sTargetHierarchy, '',vEle, 'N' );
  HierarchyElementComponentAdd(pDim, sTargetHierarchy, sElPar, vEle, 1);

### End Metadata ###
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,25

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0.0~~##
################################################################################################# 


### Return code & final error message handling
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
Else;
    sProcessAction = Expand( 'Process:%cThisProcName% successfully created the %sTargetHierarchy% hierarchy in the %pDim% dimension.' );
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
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
