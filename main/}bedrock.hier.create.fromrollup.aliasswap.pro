﻿601,100
602,"}bedrock.hier.create.fromrollup.aliasswap"
562,"NULL"
586,
585,
564,
565,"j^uv]3FQrAan6vS=oLHT<YjJ80q9c2w]Mgd<TZUmQnihWY3Sx^cto:\7=tN^CFP;ZhPenR<NRGJ\Tmkv5R;]usqG8Y8avr]iAnboYg7^5tyBA?9;RMRwC<as9p>?z^chwfv90=<[QA?=XaJ;BvQI6G99Ty:yrQVmlpS6lw<lQEXRd]w9jZwL9lsSg5I[K5U_gKsbHaDJ"
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
569,0
592,0
599,1000
560,10
pLogOutput
pSrcDim
pSrcHier
pConsol
pTgtDim
pTgtHier
pAttr
pUnwind
pRemove
pAliasSwap
561,10
1
2
2
2
2
2
1
1
1
2
590,10
pLogOutput,0
pSrcDim,""
pSrcHier,""
pConsol,""
pTgtDim,""
pTgtHier,""
pAttr,1
pUnwind,2
pRemove,0
pAliasSwap,""
637,10
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pSrcDim,"REQUIRED: Source Dimension"
pSrcHier,"OPTIONAL: Source Hierarchy (blank = same name as source dimension)"
pConsol,"REQUIRED: Cons element in source dim to create root element in target"
pTgtDim,"OPTIONAL: Target Dimension (blank = same name as source dimension)"
pTgtHier,"OPTIONAL: Target Hierarchy (blank = same name as target dimension)"
pAttr,"OPTIONAL: Include Attributes? (Boolean 1=True)"
pUnwind,"OPTIONAL: 0 = Delete all Elements, 1 = Unwind Existing Elements, 2 = Do not change Existing Elements"
pRemove,"OPTIONAL: Remove cons elements from source? (1 = Yes, 0 = No)"
pAliasSwap,"REQUIRED: Name of the attribute with names to be swapped"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,206
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.create.fromrollup.aliasswap', 'pLogOutput', pLogOutput,
    	'pSrcDim', '', 'pSrcHier', '', 'pConsol', '',
    	'pTgtDim', '', 'pTgtHier', '',
    	'pAttr', 1, 'pUnwind', 2, 'pRemove', 0,
    	'pAliasSwap', ''
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
# This process will make an aternative hierarchy from a consolidated element and its children in default hierarchy.

# Use case: Intended for Development but could be used in production too.
# 1/ Create a new hierarchy for testing.
# 2/ Create a new hierarchy to reflect new business needs.

# Note:
# Valid source dimension name (pSrcDim) and source subset (pSubset) are mandatory, otherwise the process will abort.
# If a source hierarchy name (pSrcHier) is specified, it needs to be valid, otherwise the process will abort.

# Caution:
# - Target hierarchy cannot be `Leaves`.
# - If the target Hierarchy already exists, then it will be overwritten.
#EndRegion @DOC

### Global Variables
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
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pSrcDim:%pSrcDim%, pSrcHier:%pSrcHier%, pConsol:%pConsol%, pTgtDim:%pTgtDim%, pTgtHier:%pTgtHier%, pAttr:%pAttr%, pUnwind:%pUnwind%, pRemove:%pRemove%, pAliasSwap:%pAliasSwap%.';
cHierAttr         = 'Bedrock.Descendant';
cAttrVal          = 'Descendant';

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

If( Scan( ':', pTgtDim ) > 0 & pTgtHier @= '' );
    # A hierarchy has been passed as dimension. Handle the input error by splitting dim:hier into dimension & hierarchy
    pTgtHier       = SubSt( pTgtDim, Scan( ':', pTgtDim ) + 1, Long( pTgtDim ) );
    pTgtDim        = SubSt( pTgtDim, 1, Scan( ':', pTgtDim ) - 1 );
EndIf;

# Validate source dimension
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

### Check for errors before continuing
If( nErrors <> 0 );
    ProcessBreak;
EndIf;

# Validate source Hierarchy
IF(pSrcHier @= '');
    pSrcHier = pSrcDim;
ElseIf(HierarchyExists(pSrcDim, pSrcHier) = 0);
    nErrors = 1;
    sMessage = 'Invalid source hierarchy: ' | pSrcHier;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
Endif;


## Validate consolidation
pConsol = Trim( pConsol );
If( pConsol @<> '' );
    If( ElementIndex ( pSrcDim, pSrcHier, pConsol ) = 0 );
        nErrors = 1;
        sMessage = 'The ' | pConsol | ' consolidation does not exist in the '| pSrcDim |' dimension:Hierarchy ' | pSrcDim |':'| pSrcHier;
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    EndIf;
EndIf;

## Validate Attribute
If( pAliasSwap @= '' );
    nErrors = 1;
    sMessage = 'The name of the attribute to swap not specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
Endif;  

### Check for errors before continuing
If( nErrors <> 0 );
    ProcessBreak;
EndIf;

## Validate target Dimension
If(pTgtDim @= '');
    pTgtDim = pSrcDim;
Endif;

IF( DimensionExists( pTgtDim ) = 0 );
   DimensionCreate(pTgtDim);
EndIf;

### Create target dimension Hierarchy ###
IF(pTgtHier @= '');
    pTgtHier = pTgtDim;
EndIf;

##########################################
# Bedrock subprocesses


#create subset
ExecuteProcess('}bedrock.hier.sub.create',
  'pLogOutput',pLogOutput,
	'pDim',pSrcDim,
	'pHier', pSrcHier,
	'pSub', cTempSub,
	'pConsol', pConsol,
	'pTemp', 1
);

cTempDim = pSrcDim|'_'| cTimeStamp |'_'| cRandomInt;

ExecuteProcess('}bedrock.hier.create.fromsubset',
  'pLogOutput',pLogOutput,
  'pSrcDim',pSrcDim,
  'pSrcHier', pSrcHier,
  'pSubset', cTempSub,
  'pTgtDim', cTempDim,
  'pTgtHier', cTempDim,
  'pAttr', 1,
  'pUnwind', 0
);

ExecuteProcess('}bedrock.dim.attr.create',
  'pLogOutput',pLogOutput,
  'pDim',cTempDim,
  'pAttr', cTempDim,
  'pAttrType','A'
);

ExecuteProcess('}bedrock.cube.data.copy',
  'pLogOutput',pLogOutput,
  'pCube', '}ElementAttributes_'|cTempDim,
  'pEleMapping','}ElementAttributes_'|cTempDim|':'|pAliasSwap|'->'|cTempDim
);

ExecuteProcess('}bedrock.dim.attr.swapalias',
  'pLogOutput',pLogOutput,
  'pDim',cTempDim,
  'pAlias', cTempDim
);

ExecuteProcess('}bedrock.hier.sub.create',
  'pLogOutput',pLogOutput,
	'pDim', cTempDim,
	'pHier', cTempDim,
	'pSub', cTempSub,
	'pConsol', pConsol,
	'pTemp', 0
);


ExecuteProcess('}bedrock.hier.create.fromsubset',
  'pLogOutput',pLogOutput,
  'pSrcDim', cTempDim,
  'pSrcHier', cTempDim,
  'pSubset', cTempSub,
  'pTgtDim', pTgtDim,
  'pTgtHier', pTgtHier,
  'pAttr', pAttr,
  'pUnwind', pUnwind
);



### End Prolog ###
573,5

#****Begin: Generated Statements***
#****End: Generated Statements****


574,6

#****Begin: Generated Statements***
#****End: Generated Statements****



575,50

#****Begin: Generated Statements***
#****End: Generated Statements****

ExecuteProcess('}bedrock.dim.attr.delete',
  'pLogOutput',pLogOutput,
  'pDim', pTgtDim,
  'pAttr', cTempDim
);

ExecuteProcess('}bedrock.dim.delete',
  'pLogOutput',pLogOutput,
	'pDim', cTempDim
);


IF(pRemove = 1);
  ExecuteProcess('}bedrock.hier.unwind',
  'pLogOutput',pLogOutput,
	'pDim',pSrcDim,
	'pHier', pSrcHier,
	'pConsol', pConsol,
	'pRecursive', 1
);

  ExecuteProcess('}bedrock.hier.emptyconsols.delete',
  'pLogOutput',pLogOutput,
	'pDim',pSrcDim,
	'pHier', pSrcHier
);

Endif;


### Return code & final error message handling
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
Else;
    sProcessAction = Expand( 'Process:%cThisProcName% successfully cloned dimension:hierarchy %pSrcDim%:%pSrcHier% to %pTgtDim%:%pTgtHier% based on the %pConsol% consolidated element.' );
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
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
