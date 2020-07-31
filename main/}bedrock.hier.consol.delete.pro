601,100
602,"}bedrock.hier.consol.delete"
562,"NULL"
586,
585,
564,
565,"sCY=QH5[bG;fpgr`lX1aew=9oE>VEL1WB`@de0N:l0hZ4:EVmYhFt>gUsgRKz2He?HZ<noIH[NO0KJieYe>jej_dz:ey@JOzayn5AnZLhTbI<rOt91r551CJEQ2qD9w?iS8wob4HJrY5EPfQDwGMw5\J;zoe^8W;3^YBHOk[9=ZvpL?H_WozL:VVYH6IWmrbAH3cm=Dz"
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
560,6
pLogOutput
pStrictErrorHandling
pDim
pHier
pEle
pDelim
561,6
1
1
2
2
2
2
590,6
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pHier,""
pEle,""
pDelim,"&"
637,6
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"REQUIRED: Dimension name"
pHier,"OPTIONAL: Hierarchy name (if blank then same named hierarchy as dimension is assumed)"
pEle,"OPTIONAL: Filter on elements (element list separated by delimiter, accepts wildcards (if * then all the consolidation elements get deleted))"
pDelim,"OPTIONAL: Delimiter character for element list (default to '&' if blank)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,177
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.consol.delete', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pDim', '', 'pHier', '', 'pEle', '',
    	'pDelim', '&'
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
# This process will delete a specified C-Level item **or** ALL consolidations in the dimension hierarchy. 

# Use case: Could be used during development or in production.
# 1/ Delete a specific or all C-Level items in a hierarchy.

# Note:
# Valid dimension name (pDim) is mandatory otherwise the process will abort. Control dimensions are excluded.
# The hierarchy (pHier) will default to pDim if not specified, otherwise it must be valid else the process will abort.
# **ALL** consoldidated items in hierarchy will be deleted if consolidated item (pEle) is specified as \*, otherwise it needs to contain valid c-level item(s). 
# Caution: Target hierarchy (pHier) cannot be `Leaves`.
#EndRegion @DOC

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName     = GetProcessName();
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cTempSub          = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cUserName         = TM1User();
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%, pEle:%pEle%, pDelim:%pDelim%.';

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;

If( Scan( ':', pDim ) > 0 & pHier @= '' );
    # A hierarchy has been passed as dimension. Handle the input error by splitting dim:hier into dimension & hierarchy
    pHier       = SubSt( pDim, Scan( ':', pDim ) + 1, Long( pDim ) );
    pDim        = SubSt( pDim, 1, Scan( ':', pDim ) - 1 );
EndIf;

## Validate Dimension
If( Trim( pDim ) @= '' );
    nErrors = 1;
    sMessage = 'No dimension specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( DimensionExists( pDim ) = 0 );
    nErrors = 1;
    sMessage = 'Dimension: ' | pDim | ' does not exist on server.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate Hierarchy
IF(pHier @= 'Leaves' );
    nErrors = 1;
    sMessage = 'Invalid  Hierarchy: ' | pDim |':'|pHier;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate Elements
IF(pEle @= '' );
    nErrors = 1;
    sMessage = 'Element cannot be empty. Use * for all elements';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;


If( Trim( pHier ) @= '' );
    sHier = pDim;
Else;
    sHier = pHier;
EndIf;

If( HierarchyExists( pDim, sHier ) = 0 );
    nErrors = 1;
    sMessage = 'The Hierarchy ' | sHier | ' does not exist.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# If blank delimiter specified then convert to default
If( pDelim @= '' );
    pDelim = '&';
EndIf;

### Check for errors before continuing
If( nErrors > 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

sEles = pEle;
nDelimiterIndex = 1;
While( nDelimiterIndex <> 0 );
    
    nDelimiterIndex = Scan( pDelim, sEles );
    If( nDelimiterIndex = 0 );
        sEle = sEles;
    Else;
        sEle = Trim( SubSt( sEles, 1, nDelimiterIndex - 1 ) );
        sEles = Trim( Subst( sEles, nDelimiterIndex + Long(pDelim), Long( sEles ) ) );
    EndIf;
  
    # Check if a wildcard has been used to specify the Element name.
    # If it hasn't then just delete the Element if it exists
    If( sEle @= '*' );
        nElementIndex = Dimsiz(pDim|':'|sHier);
        While( nElementIndex >= 1 );
            sEle = ElementName( pDim, sHier, nElementIndex );
            sElType = ElementType( pDim, sHier, sEle );
            If( sElType @= 'C' );
                HierarchyElementDelete( pDim, sHier,sEle );
            EndIf;
            nElementIndex = nElementIndex - 1;
        End;
    ElseIf( Scan( '*', sEle ) = 0);
        If( HierarchyElementExists( pDim,sHier, sEle ) = 1 );
            sElType = ElementType( pDim, sHier, sEle ); 
            If( sElType @='C' );
                HierarchyElementDelete( pDim, sHier,sEle );
            EndIf;
        Else;
            nErrors = 1;
            sMessage = 'The Hierarchy ' | sHier | ' does not have element ' | sEle;
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        EndIf;
    Else;
        # Wildcard search string
        sEle    = '"'|sEle|'"';
        sProc   = '}bedrock.hier.sub.create.bymdx';
        sMdx    = '{TM1FILTERBYPATTERN( {TM1SUBSETALL([ ' |pDim|':'|sHier |' ])},'| sEle| ')}';
        ExecuteProcess('}bedrock.hier.sub.create.bymdx',
          'pLogOutput', pLogOutput,
          'pStrictErrorHandling', pStrictErrorHandling,
        	'pDim', pDim,
        	'pHier', sHier,
        	'pSub', cTempSub,
        	'pMDXExpr', sMdx,
        	'pConvertToStatic', 1,
        	'pTemp', 1
        );
        nCount = HierarchySubsetGetSize(pDim, sHier, cTempSub);
        While( nCount >= 1 );
            sElement = HierarchySubsetGetElementName(pDim, sHier, cTempSub, nCount);
            sElType = ElementType( pDim, sHier, sElement );
            If( sElType @= 'C' );
                HierarchyElementDelete( pDim, sHier,sElement );
            EndIf;  
            nCount = nCount - 1;
        End;
    EndIf;

End;

### End Prolog ###
573,5

#****Begin: Generated Statements***
#****End: Generated Statements****


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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully deleted the appropriate consolidated elements in hierarchy %pDim%:%pHier%.' );
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
