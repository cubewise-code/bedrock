601,100
602,"}bedrock.cube.view.create"
562,"NULL"
586,
585,
564,
565,"myk=GKcG3CauSaG:>To6WI>_Vqbpbo7IWFR3TG^MI`he9rDR?_;L8LvI\FDnzqp14wV_UUA`Nm=>NoOaF\Q;<enNfD]WmLRS=3EDPFwPd>_uOk@L3xDc1SU>_FgA0P_Xu<WwY5l3XFqjA@5jbmOe9g6s7o\C]pc:3[9ESn_isLvXrQkdR\_rrnv7jU0adtrg9=b_wVaI"
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
560,13
pLogOutput
pCube
pView
pFilter
pSuppressZero
pSuppressConsol
pSuppressRules
pDimDelim
pEleStartDelim
pEleDelim
pTemp
pSubN
pSuppressConsolStrings
561,13
1
2
2
2
1
1
1
2
2
2
1
1
1
590,13
pLogOutput,0
pCube,""
pView,""
pFilter,""
pSuppressZero,1
pSuppressConsol,1
pSuppressRules,1
pDimDelim,"&"
pEleStartDelim,"¦"
pEleDelim,"+"
pTemp,1
pSubN,0
pSuppressConsolStrings,0
637,13
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pCube,"REQUIRED: Cube Name"
pView,"REQUIRED: Name of the View"
pFilter,"OPTIONAL: Filter: Year¦ 2006 + 2007 & Scenario¦ Actual + Budget & Organization¦ North America Operations"
pSuppressZero,"REQUIRED: Suppress Zero Data (Skip = 1)"
pSuppressConsol,"REQUIRED: Suppress Consolidations (Skip = 1)"
pSuppressRules,"REQUIRED: Suppress Rules (Skip = 1)"
pDimDelim,"REQUIRED: Delimiter for start of Dimension/Element set"
pEleStartDelim,"REQUIRED: Delimiter for start of element list"
pEleDelim,"REQUIRED: Delimiter between elements"
pTemp,"OPTIONAL: Make View Temporary (1=Temporary)"
pSubN,"OPTIONAL: Create N level subset for all dims not mentioned in pFilter"
pSuppressConsolStrings,"REQUIRED: Suppress Strings on Consolidations (Skip = 1) (Default = 0)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,433
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.cube.view.create', 'pLogOutput', pLogOutput,
    	'pCube', '', 'pView', '', 'pFilter', '',
    	'pSuppressZero', 1, 'pSuppressConsol', 1, 'pSuppressRules', 1,
    	'pDimDelim', '&', 'pEleStartDelim', '¦', 'pEleDelim', '+',
    	'pTemp', 1, 'pSubN', 0, 'pSuppressConsolStrings', 0
    );
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***s
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This process creates a view that can be used for exporting, copying or zeroing out numbers.

# Use case: Intended for development/prototyping or production.
# 1/ Create a view to zero out data.
# 2/ Create a view to use as a source for exporting or copying.

# Note:
# Naturally, a valid cube name (pCube) is mandatory otherwise the process will abort.
# The pFilter parameter contains the dimenson and elements to be used for filtering:
# - The format of the pFilter parameter is as follows delimiters of :, & and +: Dim1: Elem1 + Elem2 & Dim2: Elem3 + Elem4.
# - The dimension parameters do not need to be given in the index order of dimensions in the cube.
# - The dimension name is specified as the first member of the delimited string of elements.
# - If consols are skipped the N level children of any consolidated filter elements will be used.
# - Spaces are ignored so use them to make your filter more readable.
# - pTemp: This parameter will control whether to make the view temporary (value 1) or if the
#   view will be permanently retained (value 0).
#EndRegion @DOC

### Global Variables
StringGlobalVariable ('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
StringGlobalVariable('sBedrockViewCreateParsedFilter');
sProcessReturnCode = '';
nProcessReturnCode = 0;

### Constants ###
cThisProcName     = GetProcessName();
cUserName         = TM1User();
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cTempSubset       = cThisProcName | '_' | cTimeStamp | '_' | cRandomInt;
cTempFile         = GetProcessErrorFileDirectory | cTempSubset | '.csv';
sMessage          = '';
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cMsgInfoLevel     =  'INFO';
cMsgInfoContent   = '%cThisProcName% : %sMessage% : %cUserName%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pCube:%pCube%, pView:%pView%, pFilter:%pFilter%, pSuppressZero:%pSuppressZero%, pSuppressConsol:%pSuppressConsol%, pSuppressRules:%pSuppressRules%, pDimDelim:%pDimDelim%, pEleStartDelim:%pEleStartDelim%, pEleDelim:%pEleDelim%, pTemp:%pTemp%, pSuppressConsolStrings:%pSuppressConsolStrings%.' ;  


sSubset           = pView;
sDelimDim         = TRIM(pDimDelim);
sElementStartDelim= TRIM(pEleStartDelim);
sDelimElem        = TRIM(pEleDelim);

## LogOutput parameters
IF ( pLogoutput = 1 );
  LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

nErrors = 0;

### Validate Parameters ###

## Default filter delimiters
If( pDimDelim     @= '' );
    pDimDelim     = '&';
EndIf;
If( pEleStartDelim@= '' );
    pEleStartDelim= '¦';
EndIf;
If( pEleDelim     @= '' );
    pEleDelim     = '+';
EndIf;

# If specified cube does not exist then terminate process
If( Trim( pCube ) @= '' );
  sMessage = 'A cube name must be provided.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( CubeExists( pCube ) = 0 );
  sMessage = 'Cube: ' | pCube | ' does not exist.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate the View parameter
If( Trim( pView ) @= '' );
  sMessage = 'A view name must be provided.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Check the delimiters
If( sDelimDim @= sElementStartDelim % sDelimDim @= sDelimElem % sElementStartDelim @= sDelimElem );
  sMessage = 'The delimiters cannot be the same';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate pTemp
IF( pTemp<> 0 & pTemp<> 1 );
    nErrors = 1;
    sMessage = 'Invalid value for pTemp' | NumberToString( pTemp ) | '. Valid values are 0 and 1';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### If errors occurred terminate process with a major error status ###
If( nErrors <> 0 );
  ProcessBreak;
EndIf;
  
# Reset all of the subsets that may be attached to the view in the case that dimensions not in the filter
If( ViewExists( pCube, pView ) = 1 );
    ### Reset View ###
    sMessage = 'Resetting view ' | pView | ' on cube ' | pCube;
    IF ( pLogoutput = 1 );
       LogOutput( cMsgInfoLevel, Expand( cMsgInfoContent ) );
    EndIf;
    nCount = 1;
    While( TabDim( pCube, nCount ) @<> '' );
        sCubeDimName = TabDim( pCube, nCount );
        # Subset is the same name as the view (no way to test if subset assigned, assume it is if same name)
        If( SubsetExists( sCubeDimName, sSubset ) = 1 );
            # Add all elements
            If( SubsetIsAllSet(sCubeDimName, sSubset, 1) <> 1 );
                sMessage = Expand('Unable to add all elements on subset %sSubset% in dimension %sCubeDimName%');
                nErrors = nErrors + 1;
                LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            EndIf;
        EndIf;
        nCount = nCount + 1;
    End;
Else;
    ### Create View ###
    sMessage = Expand('Creating view %pView% in cube %pCube%');
    IF ( pLogoutput = 1 );
       LogOutput( cMsgInfoLevel, Expand( cMsgInfoContent ) );
    EndIf;
    ViewCreate( pCube, pView, pTemp );
EndIf;

ViewExtractSkipCalcsSet( pCube, pView, pSuppressConsol );
ViewExtractSkipZeroesSet( pCube, pView, pSuppressZero );
ViewExtractSkipRuleValuesSet( pCube, pView, pSuppressRules );
ViewExtractSkipConsolidatedStringsSet( pCube, pView, pSuppressConsolStrings );


### Split filter and create subsets ###
sFilter = TRIM( pFilter );
sParsedFilter = '';
nChar = 1;
nCharCount = LONG( sFilter );
sWord = '';
sLastDelim = '';
nIndex = 1;
# Add a trailing element delimiter so that the last element is picked up
If( nCharCount > 0 );
  sFilter = sFilter | sDelimElem;
  nCharCount = nCharCount + LONG(sDelimElem);
EndIf;

WHILE (nChar <= nCharCount);
    sChar = SUBST( sFilter, nChar, 1);

    # Used for delimiters, required for multiple character delimiters
    sDelim = '';
    nAddExtra = 0;

    # Ignore spaces
    IF (TRIM(sChar) @<> '' );

      ### Dimension Name ###

      # If the delimiter is more than 1 character peek ahead the same amount
      # Ignore the first character
      sDelim = sChar;
      nCount = LONG(sElementStartDelim) - 1;
      If( nCount > 0 & nChar + nCount <= nCharCount );
        # Add the extra characters
        sDelim = sDelim | SUBST( sFilter, nChar + 1, nCount);
        # Move to the end of the delimter
        nAddExtra = nCount;
      EndIf;

      If( sDelim @= sElementStartDelim );

        sChar = sDelim;

        If( sLastDelim @<> '' & sLastDelim @<> sDelimDim );
            sMessage = 'The name of a dimension must follow a dimension delimiter (' | sDelimDim | ')';
            nErrors = nErrors + 1;
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        EndIf;

        sDimension = sWord;
        nOneDimEleAdded = 0;
        
        If( DimensionExists( sDimension ) = 0 );
            # The dimension does not exist in the model. Cancel process
            sMessage = 'Dimension: ' | sDimension | ' does not exist';
            nErrors = nErrors + 1;
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        EndIf;

        ### Determine the dimension is a member of the cube ###
        nCount = 1;
        nDimensionIndex = 0;
        While( TabDim( pCube, nCount ) @<> '' );
            sCubeDimName = TabDim( pCube, nCount );
            If( sDimension @= sCubeDimName );
                nDimensionIndex = nCount;
            EndIf;
            nCount = nCount + 1;
        End;

        If( nDimensionIndex = 0 );
            # The dimension does not exist in the cube. Cancel process
            sMessage = 'Dimension: ' | sDimension | ' is not a member of: '| pCube | 'cube.';
            nErrors = nErrors + 1;
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        EndIf;

        # Create the subset
        If( SubsetExists( sDimension, sSubset ) = 1 );
            SubsetDeleteAllElements( sDimension, sSubset );
        Else;
            SubsetCreate( sDimension, sSubset, pTemp );            
        EndIf;

        # Attach to the view
        ViewSubsetAssign( pCube, pView, sDimension, sSubset );
        
        #Add to the Parsed filter
        IF(sParsedFilter@='');
          sParsedFilter=sDimension;          
        Else;
          sParsedFilter=sParsedFilter|sDelimDim|sDimension;
        Endif;  

        nIndex = 1;
        sLastDelim = sChar;
        # Clear the word
        sWord = '';
      Else;

        # Reset extra chars
        nAddExtra = 0;

        ### Check both both dim delimiter and element delimiter ###
        nIsDelimiter = 0;

        ## Check dimension delimiter first
        # If the delimiter is more than 1 character peek ahead the same amount
        # Ignore the first character
        sDelim = sChar;
        nCount = LONG(sDelimDim) - 1;
        If( nCount > 0 & nChar + nCount <= nCharCount );
          # Add the extra characters
          sDelim = sDelim | SUBST( sFilter, nChar + 1, nCount);
          # Move to the end of the delimter
          nAddExtra = nCount;
        EndIf;

        If( sDelim @= sDelimDim );
          nIsDelimiter = 1;
          sChar = sDelim;
        Else;
          # Reset extra chars
          nAddExtra = 0;

          ## Check element delimiter

          # If the delimiter is more than 1 character peek ahead the same amount
          # Ignore the first character
          sDelim = sChar;
          nCount = LONG(sDelimElem) - 1;
          If( nCount > 0 & nChar + nCount <= nCharCount );
            # Add the extra characters
            sDelim = sDelim | SUBST( sFilter, nChar + 1, nCount);
            # Move to the end of the delimter
            nAddExtra = nCount;
          EndIf;

          If( sDelim @= sDelimElem );
            nIsDelimiter = 1;
            sChar = sDelim;
          Else;
            # Reset extra chars
            nAddExtra = 0;
          EndIf;

        EndIf;

        If ( nIsDelimiter = 1 );

          If( sLastDelim @= '' % sLastDelim @= sDelimDim );
            sMessage = 'An element delimiter must follow a dimension name: ' |  sChar | ' (' | NumberToString(nChar) | ')';
            nErrors = nErrors + 1;
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            #ProcessError();
          EndIf;

          sElement = sWord;

          If( DIMIX( sDimension, sElement ) = 0 );
              # The element does not exist in the dimension. Cancel process
              sMessage = 'Element: ' | sElement | ' in dimension ' | sDimension | ' does not exist';
              nErrors = nErrors + 1;
              LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
              #ProcessError();
          EndIf;
          
          sElement = DimensionElementPrincipalName(sDimension,sElement);

          If ( pSuppressConsol = 1 & DTYPE( sDimension, sElement) @= 'C'  );
              # Add all N level elements to the subset
              # Loop through all elements and check if it is an ancestor
              sMessage = 'Element ' | sElement | ' is consolidated' ;
              IF ( pLogoutput = 1 );
                LogOutput( cMsgInfoLevel, Expand( cMsgInfoContent ) );
              EndIf;
              nElCount = DIMSIZ ( sDimension );
              n = 1;
              WHILE ( n <= nElCount );
                  sEl = DIMNM( sDimension, n );
                  IF( DTYPE( sDimension, sEl) @<> 'C' & ELISANC( sDimension, sElement, sEl ) = 1 );
                      SubsetElementInsert( sDimension, sSubset, sEl, 0 );
                  EndIf;
                  n = n + 1;
              END;
              
              # Add the consolidated element to the subset as well to export strings, if necessary
              If ( pSuppressConsolStrings = 0 );
                SubsetElementInsert( sDimension, sSubset, sElement, 0 );
              EndIf;

          Else;
              # Add the element to the subset
              SubsetElementInsert( sDimension, sSubset, sElement, 0 );
          EndIf;
          
          #Add to the Parsed filter
          If( nOneDimEleAdded = 0 );
            sParsedFilter=sParsedFilter|pEleStartDelim|sElement;
            nOneDimEleAdded = nOneDimEleAdded + 1;
          Else;
            sParsedFilter=sParsedFilter|sDelimElem|sElement;
          EndIf;

          nIndex = nIndex + 1;
          sLastDelim = sChar;

          # Clear the word
          sWord = '';
        Else;
          sWord = sWord | sChar;
        EndIf;

      EndIf;

    EndIf;

    nChar = nChar + nAddExtra + 1;

END;
sBedrockViewCreateParsedFilter = sParsedFilter;

# creating N level subset for all dim not included in pFilter 
# useful when suppress consolidation is not on
If(pSubN = 1);
    
    nCountDimC = 1;
    While( TabDim( pCube, nCountDimC ) @<> '' );
        sDimC = TabDim( pCube, nCountDimC );
        sDimString = sDimC;
        
        # filters created by other bedrock processes skip spaces from dim names and between separators
        While(Scan(' ',sDimString)>0);
            sDimString = subst(sDimString, 1, Scan(' ',sDimString)-1)|subst(sDimString,Scan(' ',sDimString)+1,long(sDimString));
        End; 
        sTFilter = sFilter;
        While(Scan(' ',sTFilter)>0);
            sTFilter = subst(sTFilter, 1, Scan(' ',sTFilter)-1)|subst(sTFilter,Scan(' ',sTFilter)+1,long(sTFilter));
        End;
        
        # to make sure that the name of the dim is not part of the name of another dim
        If(Scan(pDimDelim|sDimString|pEleStartDelim, sTFilter)=0 & Scan(sDimString|pEleStartDelim, sTFilter)<>1);
            sProc   = '}bedrock.hier.sub.create';
            nRet    = ExecuteProcess( sProc,
                'pLogOutput', pLogOutput,
                'pDim', sDimC,
                'pHier', '',
                'pSub', sSubset,
                'pConsol', '',
                'pAttr', '',
                'pAttrValue', '',
                'pLevelFrom', 0,
                'pLevelTo', 0,
                'pExclusions', '',
                'pDelim', pEleDelim,
                'pAddToSubset', 0,
                'pAlias', '',
                'pTemp', pTemp
            );
            
            IF(nRet <> 0);
                sMessage = 'Error creating the view from the filter.';
                nErrors = nErrors + 1;
                LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
                ProcessBreak;
            ENDIF;
            
            ViewSubsetAssign( pCube, pView, sDimC, sSubset );
        
        EndIf;
        
        nCountDimC = nCountDimC + 1;
    End;

  EndIf;  
  
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,26

#****Begin: Generated Statements***
#****End: Generated Statements****


################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

### Return code & final error message handling ###
If( nErrors <> 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( 'ERROR' , Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
Else; 

    sProcessAction      = Expand( 'Process:%cThisProcName% successfully created View %pView% in Cube %pCube%.' );
    sProcessReturnCode  = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode  = 1;
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
