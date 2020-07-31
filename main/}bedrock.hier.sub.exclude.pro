601,100
602,"}bedrock.hier.sub.exclude"
562,"NULL"
586,
585,
564,
565,"ol7cyo3LPn^DV2Na[:hNRaMxzZDaJbj[^nR2nz5A=h0US[jMl8g?LZfz`[H9S\2TTjd2o^WsKpsvQ_u@8vxGJo:nx_x^I9s@=w\FC:^F:Bm`9kRuu1jTlV_`u\j\qfzE4]w>IEDQ=t<4^2Eaobg8\YZq<Z1^z<2jdtW\x;bc`f]xFyHdxcvpz1dL1SsFuqjnxINq=pcS"
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
560,8
pLogOutput
pStrictErrorHandling
pDim
pHier
pSub
pExclusions
pDelim
pTemp
561,8
1
1
2
2
2
2
2
1
590,8
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pHier,""
pSub,""
pExclusions,""
pDelim,"&"
pTemp,1
637,8
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"REQUIRED: Dimension name"
pHier,"OPTIONAL: Hierarchy name (default if blank = same named hierarchy)"
pSub,"REQUIRED: Subset name"
pExclusions,"OPTIONAL: Elements to Exclude From Subset (Separated by Delimiter, Accepts Wild card)"
pDelim,"OPTIONAL: Delimiter character"
pTemp,"OPTIONAL: Use temporary objects? (Boolean 1=True)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,208
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.sub.exclude', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pDim', '', 'pHier', '', 'pSub', '',
    	'pExclusions', '', 'pDelim', '&', 'pTemp', 1
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
# This process will remove specified elements from a subset in a Hierarchy of target Dimension.
# Wildcard characters `*`and `?` are accepted in list of elements to be excluded.

# Note:
# - If a leaf level element is specified, it will be removed on its own.
# - If a consolidated element is specified it will be removed as well as its descendants.

# Caution: Target hierarchy cannot be `Leaves`.
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
cLogInfo            = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%, pSub:%pSub%, pExclusions:%pExclusions%, pDelim:%pDelim%, pTemp:%pTemp%.'; 
cAttributeDim       = '}ElementAttributes_' | pDim;

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
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;
If( DimensionExists( pDim ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dimension: ' | pDim;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate Hierarchy

IF(pHier @= 'Leaves' );
  nErrors = 1;
  sMessage = 'Invalid  Hierarchy: ' | pDim |':'|pHier;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

If( Trim( pHier ) @= '' );
  sHier = pDim;
Else;
  sHier = pHier;
EndIf;

If( HierarchyExists( pDim, sHier ) = 0 );
  nErrors = 1;
  sMessage = 'The Hierachy ' | sHier | ' does not exists.';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate subset
If( Trim( pSub ) @= '' );
  nErrors = 1;
  sMessage = 'No subset specified';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;
If( HierarchySubsetExists( pDim,sHier, pSub ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid subset: ' | pSub | ' in dimension:Hierarchy ' | pDim |':' | sHier;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate Elements
If( Trim( pExclusions ) @= '' );
  nErrors = 1;
  sMessage = 'No Elements specified';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate delimiter
If( pExclusions @<> '' & pDelim @= '' );
  pDelim = '&';
EndIf;

## Validate pTemp
IF( pTemp <> 0 & pTemp <> 1 );
    nErrors = 1;
    sMessage = 'Wrong parameter pTemp value (only 0 or 1 accepted).';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Process Elements ###
If(nErrors = 0);
  nDelimIndex = 1;
  sExclusions = pExclusions;

  While( nDelimIndex <> 0 & Long( sExclusions ) > 0 );

    nDelimIndex = Scan( pDelim, sExclusions );
    If( nDelimIndex <> 0 );
      sExclusion = Trim( SubSt( sExclusions, 1, nDelimIndex - 1 ) );
      sExclusions = Trim( SubSt( sExclusions, nDelimIndex + Long( pDelim ), Long( sExclusions ) ) );
    Else;
      sExclusion = Trim( sExclusions );
    EndIf;
    If(Scan('*',sExclusion) = 0 & Scan('?',sExclusion) = 0);
      # Check that Element is present in the dimension
      If( ElementIndex ( pDim, sHier, sExclusion ) <> 0 );
        sExclusion = HierarchyElementPrincipalName( pDim, sHier, sExclusion );
        # Work through subset and remove Element
        nSubsetIndex = 1;
        nSubsetSize = HierarchySubsetGetSize( pDim, sHier, pSub );
        While( nSubsetIndex <= nSubsetSize );
          sTemp = HierarchySubsetElementGetIndex (pDim, sHier, pSub, '', nSubsetIndex);
          sElement = HierarchySubsetGetElementName( pDim, sHier, pSub, nSubsetIndex );
          # If Element is found or a descendant of the Element is found the remove from subset
          If( sElement @= sExclusion % ElementIsAncestor( pDim, sHier, sExclusion, sElement ) = 1 );
            sTemp = HierarchySubsetElementGetIndex (pDim, sHier, pSub, '', nSubsetIndex);
            HierarchySubsetElementDelete ( pDim, sHier, pSub, nSubsetIndex );
            nSubsetSize = nSubsetSize - 1;
          Else;
            nSubsetIndex = nSubsetIndex + 1;
          EndIf;
        End;
      
      EndIf;
    Else;
      # Wildcard search string
        sExclusion = '"'|sExclusion|'"';
        stempSub = cThisProcName| cRandomInt;
        sProc = '}bedrock.hier.sub.create.bymdx';
        sMdx = '{TM1FILTERBYPATTERN( {TM1SUBSETALL([ ' |pDim|':'|sHier |' ])},'| sExclusion| ')}';
        ExecuteProcess(sProc,
                      'pStrictErrorHandling', pStrictErrorHandling,
                    	'pDim',pDim,
                    	'pHier',sHier,
                    	'pSub',stempSub,
                    	'pMDXExpr',sMdx,
                    	'pConvertToStatic',1,
                    	'pTemp', pTemp);
        nSubsetindex = 1;
        nSubsetSize = HierarchySubsetGetSize(pDim, sHier, stempSub);
        While (nSubsetindex <= nSubsetSize);
          sTemp = HierarchySubsetElementGetIndex (pDim, sHier, stempSub, '', nSubsetIndex);
          sElement = HierarchySubsetGetElementName(pDim, sHier, stempSub, nSubsetindex);
          HierarchySubsetElementDelete( pDim, sHier,stempSub,nSubsetindex );
          nSubsetSize = nSubsetSize -1;
          ## Delete Element from main subset
          If(HierarchySubsetElementExists(pDim, sHier, pSub, sElement)>0);
            nSearchIndex = 1;
            nSearchSize = HierarchySubsetGetSize(pDim, sHier, pSub);
            While( nSearchIndex <= nSearchSize  );
              sSearchElement = HierarchySubsetGetElementName( pDim, sHier, pSub, nSearchIndex );
               # If Element is found or a descendant of the Element is found the remove from subset
                If( sElement @= sSearchElement % ElementIsAncestor( pDim, sHier, sElement, sSearchElement ) = 1 );
                  sTemp = HierarchySubsetElementGetIndex (pDim, sHier, pSub, '', nSearchIndex);
                  HierarchySubsetElementDelete ( pDim, sHier, pSub, nSearchIndex );
                  nSearchSize = 0;
                Else;
                  nSearchIndex = nSearchIndex + 1;
                EndIf;
            End;
          Endif;
          ######
        End;
        HierarchySubsetDestroy(pDim, sHier,stempSub);
    EndIf;

  End;

EndIf;


### End Prolog ###
573,4

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully excluded elements from subset %pSub% from dimension %pDim%.' );
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
