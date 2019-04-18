﻿601,100
602,"}bedrock.hier.element.delete"
562,"NULL"
586,
585,
564,
565,"d[@:aJ]wLWFLbMxjwSi:9DJV<7P3f5S<VZB9Q4>q=s6zbVZm;VL8B5i<uwv1B7S[mq`Y2yfS=jK<mW=e^zUnWELuUSRBR[g^lYCzCCIy_wuC6Tcln1lZ4KX`zZw?dzpdnWF9n_3FwU7@KZTbKDl0e>i_7oATvAEau5rCdz\nbOzfflWnn`_hL]^;gDMZJ;P`1r7K<c\e"
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
571,
569,0
592,0
599,1000
560,5
pLogOutput
pDim
pHier
pEle
pDelim
561,5
1
2
2
2
2
590,5
pLogOutput,0
pDim,""
pHier,""
pEle,""
pDelim,"&"
637,5
pLogOutput,"Optional: write parameters and action summary to server message log (Boolean True = 1)"
pDim,"Required: dimension name, accepts wildcards (if = *, then all the dimensions)"
pHier,"Optional: hierarchy name (if blank then same named hierarchy as dimension is assumed), accepts wildcards (if = *, then all hierarchies)"
pEle,"Optional: filter on elements (delimiter separated list of elements, accepts wildcards (if = *, then all the elements in hierarchy get deleted))"
pDelim,"Optional: delimiter character for element list (required if pEle parameter is used)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,250

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This process will delete specified or all elements from a dimension Hierarchy. Elements might be
# specified as a delimited list of elements. Each member in the list might be specified exactly or
# by a wildcard pattern. Wildcards `*` and `?` are accepted.

# Note:
# Valid dimension name (pDim) otherwise the process will abort.

# Caution: When pEle is empty, __all__ elements in pHier will be deleted!
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
cMsgInfoContent   = 'User:%cUserName% Process:%cThisProcName% Message:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%, pEle:%pEle%, pDelim:%pDelim%.'; 

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

# Validate Dimension
If( Trim( pDim ) @= '' );
    nErrors = 1;
    sMessage = 'No dimension specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate Element filter
If( Trim( pEle ) @= '' );
    nErrors = 1;
    sMessage = 'No element filter specified. User * to include all elements';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate Hierarchy
If( Trim( pHier ) @= '' );
    ## use same name as Dimension. Since wildcards are allowed this is managed inside the code below
ElseIf(pHier @= 'Leaves' );
    nErrors = 1;
    sMessage = 'Invalid  Hierarchy: ' | pDim |':'|pHier;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# If blank delimiter specified then convert to default
If( pDelim @= '' );
    pDelim = '&';
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
    ProcessBreak;
EndIf;

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
        sMessage = Expand( 'Dimension %sDim% does not exist.' );
        LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
    Else;
        If( pLogOutput = 1 );
          sMessage = Expand( 'Dimension %sDim% being processed....' );
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
        sHierDim            = '}Hierarchies_'|sDim ;
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
            sHierExp = '"'|sDim|':'|sHierarchy|'"';
            sMdxHierPart = '{TM1FILTERBYPATTERN( {TM1SUBSETALL([ ' |sHierDim| '])},'| sHierExp | ')}';
            IF( sMdxHier @= ''); 
              sMdxHier = sMdxHierPart; 
            ELSE;
              sMdxHier = sMdxHier | ' + ' | sMdxHierPart;
            ENDIF;
        End;

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
                sMessage = Expand('The %sCurrHier% hierarchy does NOT exist in the %sDim% dimension.');
                LogOutput( 'INFO' , Expand( cMsgInfoContent ) );
            ElseIf( sCurrHierName @= 'Leaves' );
                sMessage = 'Invalid  Hierarchy: ' | sCurrHier | ' will be skipped....';
                LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            Else;
              If( pLogOutput = 1 );
                sMessage = Expand( 'Hierarchy %sCurrHierName% in Dimension %sDim% being processed....' );
                LogOutput( 'INFO', Expand( cMsgInfoContent ) );
              EndIf;
              # Loop through hierarchy elements in pEle
              sEles = pEle;
               nDelimiterIndexB = 1;
              While( nDelimiterIndexB <> 0 );
                  
                  nDelimiterIndexB = Scan( pDelim, sEles );
                  If( nDelimiterIndexB = 0 );
                      sEle = sEles;
                  Else;
                      sEle = Trim( SubSt( sEles, 1, nDelimiterIndexB - 1 ) );
                      sEles = Trim( Subst( sEles, nDelimiterIndexB + Long(pDelim), Long( sEles ) ) );
                  EndIf;
                  
                  # Check if a wildcard has been used to specify the Element name.
                  # If it hasn't then just delete the Element if it exists
                  If(sEle @= '*');
                          HierarchyDeleteAllElements(sDim, sCurrHierName);
                  ElseIf( Scan( '*', sEle ) = 0 & Scan( '?', sEle ) = 0);
                      If( HierarchyElementExists( sDim,sCurrHierName, sEle ) = 1 );
                          HierarchyElementDelete( sDim, sCurrHierName,sEle );
                      Else;
                          nErrors = 1;
                          sMessage = 'The Hierarchy ' | sCurrHier | ' does not have element ' | sEle;
                          LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
                      Endif;
                  Else;
                      # Wildcard search string
                      sEle = '"'|sEle|'"';
                      sProc = '}bedrock.hier.sub.create.bymdx';
                      sMdxEle = '{TM1FILTERBYPATTERN( {TM1SUBSETALL([ ' | sCurrHier |' ])},'| sEle| ')}';

                      If( HierarchySubsetExists( sDim, sCurrHierName, cTempSub ) = 1 );
                          # If a delimited list of dim names includes wildcards then we may have to re-use the subset multiple times
                          HierarchySubsetMDXSet( sDim, sCurrHierName, cTempSub, sMDXEle );
                      Else;
                          # temp subset, therefore no need to destroy in epilog
                          SubsetCreatebyMDX( cTempSub, sMDXEle, sCurrHier, 1 );
                      EndIf;

                      # Loop through subset of hierarchy elements created based on wildcard
                      nCountElems = HierarchySubsetGetSize(sDim, sCurrHierName, cTempSub);
                      While( nCountElems >= 1 );
                          sElement = HierarchySubsetGetElementName(sDim, sCurrHierName, cTempSub, nCountElems);
                          HierarchyElementDelete( sDim, sCurrHierName,sElement );
                          If( pLogOutput = 1 );
                            LogOutput( 'INFO', Expand( 'Element "%sElement%" deleted from hierarchy %sCurrHierName% in dimension %sDim%.' ) );
                          EndIf;
                          nCountElems = nCountElems - 1;
                      End;
                  EndIf;
              
              End;
          Endif;
          
            nCountHier = nCountHier - 1;
        End;
            
    EndIf;
    
    nCountDim = nCountDim - 1;
End;



### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,37

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

### Remove any temporary objects
If( HierarchySubsetExists( pDim, pHier, cTempSub ) = 1 );
    ExecuteProcess( '}bedrock.hier.sub.delete',
        'pLogOutput', pLogOutput,
    	'pDim', pDim,
    	'pHier', pHier,
    	'pSub', cTempSub,
    	'pDelim', pDelim,
    	'pMode', 0
    );
EndIf;


### Return code & final error message handling
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
Else;
    sProcessAction      = Expand( 'Process:%cThisProcName% successfully deleted the appropriate elements in hierarchy %pDim%:%pHier%.' );
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
