601,100
602,"}bedrock.hier.sub.clone"
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"h?xUE6jla03l[sX:q<TZ\bw8<8[0wK`;BxprVHG[uB3v7=DP6D_D0DlV>FDaavv1jaNd36O;7\^xQtZJuNHmVTmVh[`v\g5JJn^AIshT0@09l94hNw3:=`hoF@JxS0=BPn6Q:<6Y^hW`DL?GU4W6s`f3\8?TZavt_<K9Qe>w?2LOb6]5>OIv2C@6W24G5w[20fM\NmM3"
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
pSrcDim
pSrcHier
pSrcSub
pTgtDim
pTgtHier
pTgtSub
pTemp
pAlias
561,9
1
2
2
2
2
2
2
1
2
590,9
pLogOutput,0
pSrcDim,""
pSrcHier,""
pSrcSub,""
pTgtDim,""
pTgtHier,""
pTgtSub,""
pTemp,1
pAlias,""
637,9
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pSrcDim,"REQUIRED: Dimension where the subset exists"
pSrcHier,"OPTIONAL: Source Hierarchy (blank = same as source)"
pSrcSub,"REQUIRED: Source Subset"
pTgtDim,"OPTIONAL: Target dimension (blank = same as source)"
pTgtHier,"OPTIONAL: Target Hierarchy (blank = same as Target Dimension)"
pTgtSub,"REQUIRED: Target Subset"
pTemp,"OPTIONAL: Use temporary objects? (Boolean 1=True)"
pAlias,"Optional: Set Alias for Subset"
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
572,166
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.sub.clone', 'pLogOutput', pLogOutput,
    	'pSrcDim', '', 'pSrcHier', '', 'pSrcSub', '',
    	'pTgtDim', '', 'pTgtHier', '', 'pTgtSub', '',
    	'pTemp', 1
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
# This process will copy a subset from a Hierarchy in source Dimension to a Hierarchy in target
# Dimension.

# Note:
# Valid source dimension name (pSrcDim), source (pSrcSub) and target subset (pTgtSub) are 
# mandatory otherwise the process will abort.

# Caution:
# - Target hierarchy cannot be `Leaves`.
# - If the target dimension Hierarchy exists then it will be overwritten.
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
cLogInfo        = 'Process:%cThisProcName% run with parameters pSrcDim:%pSrcDim%, pSrcHier:%pSrcHier%, pSrcSub:%pSrcSub%, pTgtDim:%pTgtDim%, pTgtHier:%pTgtHier%, pTgtSub:%pTgtSub%, pTemp:%pTemp%, pAlias:%pAlias%.' ; 

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;

If( Scan( ':', pSrcDim ) > 0 & pSrcHier @= '' );
    # A hierarchy has been passed as dimension. Handle the input error by splitting dim:hier into dimension & hierarchy
    pSrcHier       = SubSt( pSrcDim, Scan( ':', pSrcDim ) + 1, Long( pSrcDim ) );
    pSrcDim        = SubSt( pSrcDim, 1, Scan( ':', pSrcDim ) - 1 );
EndIf;

# Validate Source dimension
If( Trim( pSrcDim ) @= '' );
    nErrors = 1;
    sMessage = 'No source dimension specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( DimensionExists( pSrcDim ) = 0 );
    nErrors = 1;
    sMessage = 'Dimension ' | pSrcDim | ' does not exist.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate Source Hierarchy
If( Trim( pSrcHier ) @= '' );
    pSrcHier = Trim( pSrcDim );
EndIf;

If( HierarchyExists( pSrcDim , pSrcHier ) = 0 );
    nErrors = 1;
    sMessage = 'The Hierachy ' | pSrcHier | ' does not exist.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate Source subset
If( Trim( pSrcsub ) @= '' );
    nErrors = 1;
    sMessage = 'No source subset specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( HierarchySubsetExists( pSrcDim , pSrcHier, pSrcsub ) = 0 );
    nErrors = 1;
    sMessage = 'Invalid source subset : ' | pSrcDim |':'| pSrcHier |':'| pSrcSub;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

If( Scan( ':', pTgtDim ) > 0 & pTgtHier @= '' );
    # A hierarchy has been passed as dimension. Handle the input error by splitting dim:hier into dimension & hierarchy
    pTgtHier       = SubSt( pTgtDim, Scan( ':', pTgtDim ) + 1, Long( pTgtDim ) );
    pTgtDim        = SubSt( pTgtDim, 1, Scan( ':', pTgtDim ) - 1 );
EndIf;

# Validate target dimension
If( Trim( pTgtDim ) @= '' );
    pTgtDim = Trim( pSrcDim );
ElseIf( DimensionExists( pTgtDim ) = 0 );
    nErrors = 1;
    sMessage = 'Invalid target dimension: ' | pTgtDim;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;


# Validate Target Hierarchy
If( Trim( pTgtHier ) @= '' );
    pTgtHier = pTgtDim;
ElseIf( HierarchyExists( pTgtDim, pTgtHier ) = 0 );
    nErrors = 1;
    sMessage = 'The target Hierachy ' | pTgtHier | ' does not exist.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate subset
If( Trim( pTgtSub ) @= '' );
    nErrors = 1;
    sMessage = 'No target subset specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate pTemp
IF( pTemp <> 0 & pTemp <> 1 );
    nErrors = 1;
    sMessage = 'Wrong parameter pTemp value (only 0 or 1 accepted).';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
    ProcessBreak;
EndIf;

### Create Target Subset ###
If( HierarchySubsetExists( pTgtDim, pTgtHier, pTgtsub ) = 1 );
    HierarchySubsetDeleteAllElements( pTgtDim, pTgtHier, pTgtsub );
Else;
    HierarchySubsetCreate( pTgtDim, pTgtHier, pTgtsub, pTemp );
EndIf;

### Set Alias ###
If ( pAlias @<> '' & 
    ElementIndex ( Expand ( '}ElementAttributes_%pTgtDim%' ), Expand ( '}ElementAttributes_%pTgtHier%' ), pAlias )  > 0 & 
    ElementType ( Expand ( '}ElementAttributes_%pTgtDim%' ), Expand ( '}ElementAttributes_%pTgtHier%' ), pAlias ) @= 'AA'
);
    If ( pTgtDim @= pTgtHier );
        SubsetAliasSet( pTgtDim, pTgtsub, pAlias);
    Else;
        SubsetAliasSet( pTgtDim | ':' | pTgtHier, pTgtsub, pAlias);
    EndIf;
EndIf;

# HierarchySubsetMDXGet not returning anything. Thought it might also return alias used in source subset
sMDX = HierarchySubsetMDXGet(pSrcDim, pSrcHier, pSrcSub);

nElementPosition = 0;

### Set data source for process ###
DatasourceType              = 'SUBSET';
DatasourceNameForServer     = pSrcDim | ':' | pSrcHier;
DatasourceDimensionSubset   = pSrcsub;
573,19

#****Begin: Generated Statements***
#****End: Generated Statements****


################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 


IF( pTgtDim @= pSrcDim & pTgtHier @= pSrcHier);
    nElementPosition = nElementPosition + 1;
ElseIF( ElementIndex( pTgtDim, pTgtHier,vEle ) > 0 );
    nElementPosition = nElementPosition + 1;
Else;
    ItemReject( Expand( 'Cannot insert into subset. Element  %vEle% does not exist in target dimension:Hierarchy %pTgtDim%:%pTgtHier%.' ) );
EndIF;

HierarchySubsetElementInsert( pTgtDim , pTgtHier, pTgtSub , vEle , nElementPosition );
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully cloned the %pTgtDim%:%pTgtHier%:%pTgtSub% subset from %pSrcDim%:%pSrcHier%:%pSrcSub%.' );
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
