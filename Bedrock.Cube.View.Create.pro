601,100
602,"Bedrock.Cube.View.Create"
562,"NULL"
586,"Variables"
585,"Variables"
564,
565,"o107s_0x?UNE^@5agv_4z1@f3wY;abMh41uxkn]5`>P<WUliPngCwIdQ_dAqLYXCOYC@?ae21jRbc0BcD>BOPY2:kW1prPGzy>_;QSd00nvqRkRoc^7ENwQ4Nz9rCA3R3VrB[q2yBD>\<KhgLuWmdc8g\ctyh@:JOrm:DRxEKItueNXCuf?oyYc`D8^zBfZ]quZSuH_S"
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
570,All
571,
569,0
592,0
599,1000
560,10
pCube
pView
pFilter
pSuppressZero
pSuppressConsol
pSuppressRules
pDimensionDelim
pElementStartDelim
pElementDelim
pDebug
561,10
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
590,10
pCube,""
pView,""
pFilter,""
pSuppressZero,1
pSuppressConsol,1
pSuppressRules,1
pDimensionDelim,"&"
pElementStartDelim,":"
pElementDelim,"+"
pDebug,0
637,10
pCube,Cube Name
pView,Name of the View
pFilter,Filter: Year: 2006 + 2007 & Scenario: Actual + Budget & Organization: North America Operations
pSuppressZero,Suppress Zero Data (Skip = 1)
pSuppressConsol,Suppress Consolidations (Skip = 1)
pSuppressRules,Suppress Rules (Skip = 1)
pDimensionDelim,Delimiter for start of Dimension/Element set
pElementStartDelim,Delimiter for start of element list
pElementDelim,Delimiter between elements
pDebug,Debug: 0
577,0
578,0
579,0
580,0
581,0
582,0
572,402

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process automatically creates a view that can be used for exporting, copying and zeroing out numbers.

# Note:
# - The pFilter parameter contains the dimenson and elements to be used for filtering.
# - The format of the pFilter parameter is as follows delimiters of :, & and +:
#     Dim1: Elem1 + Elem2 & Dim2: Elem3 + Elem4
# - The dimension parameters do not need to be given in the index order of dimensions in the cube.
# - The dimension name is specified as the first member of the delimited string of elements.
# - If consols are skipped the N level children of any consolidated filter elements will be used
# - Spaces are ignored so use them to make your filter more readable


### Constants ###

cProcess = 'Bedrock.Cube.View.Create';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;
sSubset = pView;
sDelimDim = TRIM(pDimensionDelim);
sElementStartDelim = TRIM(pElementStartDelim);
sDelimElem = TRIM(pElementDelim);
nErrors = 0;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCube:              ' | pCube );
  AsciiOutput( sDebugFile, '            pView:              ' | pView );
  AsciiOutput( sDebugFile, '            pFilter:            ' | pFilter );
  AsciiOutput( sDebugFile, '            pSuppressZero:      ' | NumberToString( pSuppressZero) );
  AsciiOutput( sDebugFile, '            pSuppressConsol:    ' | NumberToString( pSuppressConsol) );
  AsciiOutput( sDebugFile, '            pSuppressRules:     ' | NumberToString( pSuppressRules) );
  AsciiOutput( sDebugFile, '            pDimensionDelim:    ' | pDimensionDelim );
  AsciiOutput( sDebugFile, '            pElementStartDelim: ' | pElementStartDelim );
  AsciiOutput( sDebugFile, '            pElementDelim:      ' | pElementDelim );

EndIf;

# If specified cube does not exist then terminate process
If( CubeExists(   pCube   ) = 0 );
  sMessage = 'Cube: ' | pCube | ' does not exist';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  nErrors = nErrors + 1;
  ProcessQuit;
EndIf;

## Validate the View parameter
If( TRIM(pView) @= '' );
  sMessage = 'A view name must be provided';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  nErrors = nErrors + 1;
  ProcessQuit;
EndIf;

# Check the delimiters
If( sDelimDim @= '' );
  sMessage = 'The dimension delimiter is blank';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

If( sElementStartDelim @= '' );
  sMessage = 'The dimension name delimiter is blank';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

If( sDelimElem @= '' );
  sMessage = 'The element delimiter is blank';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

If( sDelimDim @= sElementStartDelim % sDelimDim @= sDelimElem % sElementStartDelim @= sDelimElem );
  sMessage = 'The delimiters cannot me the same';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;  
EndIf;

### Create View ###
If ( pDebug >= 1 );
     AsciiOutput( sDebugFile, 'Creating view ' | pView | ' on cube ' | pCube );
EndIf;
If( pDebug <= 1 );
    If( ViewExists( pCube, pView ) = 1 );
        # Clear all of the subsets that may be attached to the view
        nCount = 1;
        While( TabDim( pCube, nCount ) @<> '' );
          sCubeDimName = TabDim( pCube, nCount );
          # Subset is the same name as the view
          If( SubsetExists( sCubeDimName, pView ) = 1 );
            # Clear the elements
            SubsetDeleteAllElements( sCubeDimName, pView );
            # Add all elements
            If( SubsetIsAllSet(sCubeDimName, pView, 1) <> 1 );
              If( pDebug >= 1 );
                AsciiOutput( sDebugFile, 'Unable to add all elements on subset ' | pView | ' on dimension ' | sCubeDimName );
              EndIf;
              ProcessQuit;
            EndIf;
          ENDIF;
          nCount = nCount + 1;
        End;
    Else;
        ViewCreate( pCube, pView );
    EndIf;

    ViewExtractSkipCalcsSet( pCube, pView, pSuppressConsol );
    ViewExtractSkipZeroesSet( pCube, pView, pSuppressZero );
    ViewExtractSkipRuleValuesSet( pCube, pView, pSuppressRules );
EndIf;

### Split filter and create subsets ###
sFilter = TRIM( pFilter );
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
    If( pDebug >= 1 );
      sMessage = 'Next character is: ' | sChar | ' at ' | NumberToString(nChar);
      AsciiOutput( sDebugFile, sMessage );
    EndIf;

    # Used for delimiters, required for multiple character dilimiters
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
            If( pDebug >= 1 );
              AsciiOutput( sDebugFile, sMessage );
            EndIf;
            ProcessQuit;
        EndIf;

        sDimension = sWord;

        If( pDebug >= 1 );
          sMessage = 'Found dimension name: ' | sDimension | ' at ' | NumberToString(nChar);
          AsciiOutput( sDebugFile, sMessage );
        EndIf;

        If( DimensionExists( sDimension ) = 0 );
            # The dimension does not exist in the model. Cancel process
            sMessage = 'Dimension: ' | sDimension | ' does not exist';
            If( pDebug >= 1 );
              AsciiOutput( sDebugFile, sMessage );
            EndIf;
            nErrors = nErrors + 1;
            ProcessQuit;
        EndIf;

        ### Determine the dimension is a member of the cube ###
        nCount = 1;
        nDimensionIndex = 0;
        While( TabDim( pCube, nCount ) @<> '' );
          sCubeDimName = TabDim( pCube, nCount );
          IF(
          sDimension @= sCubeDimName);
            nDimensionIndex = nCount;
          ENDIF;
          nCount = nCount + 1;
        End;

        If( nDimensionIndex = 0 );
            # The dimension does not exist in the cube. Cancel process
            sMessage = 'Dimension: ' | sDimension | ' is not a member of: '| pCube | 'cube.';
            If( pDebug >= 1 );
              AsciiOutput( sDebugFile, sMessage );
            EndIf;
            nErrors = nErrors + 1;
            ProcessQuit;
        EndIf;

        # Create the subset
        If( SubsetExists( sDimension, sSubset ) = 1 );
            If ( pDebug >= 1 );
                 AsciiOutput( sDebugFile, 'Subset ' | sSubset | ' exists on dimension ' | sDimension | '. Deleting all elements' );
            EndIf;
            If( pDebug <= 1 );
                SubsetDeleteAllElements( sDimension, sSubset );
            EndIf;
        Else;
            If ( pDebug >= 1 );
                 AsciiOutput( sDebugFile, 'Creating subset ' | sSubset | ' on dimension ' | sDimension );
            EndIf;
            If( pDebug <= 1 );
                SubsetCreate( sDimension, sSubset );
            EndIf;
        EndIf;

        # Attach to the view
        If ( pDebug >= 1 );
             AsciiOutput( sDebugFile, 'Assigning subset ' | sSubset | ' to view ' | pView );
        EndIf;
        If( pDebug <= 1 );
            ViewSubsetAssign(pCube, pView, sDimension, sSubset);
        EndIf;

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
            If( pDebug >= 1 );
              AsciiOutput( sDebugFile, sMessage );
            EndIf;
            ProcessQuit;
          EndIf;

          sElement = sWord;

          If( pDebug >= 1 );
            sMessage = 'Inserting element: ' | sElement | ' at ' | NumberToString(nChar);
            AsciiOutput( sDebugFile, sMessage );
          EndIf;

          If( DIMIX( sDimension, sElement ) = 0 );
              # The element does not exist in the dimension. Cancel process
              sMessage = 'Element: ' | sElement | ' in dimension ' | sDimension | ' does not exist';
              If( pDebug >= 1 );
                AsciiOutput( sDebugFile, sMessage );
              EndIf;
              nErrors = nErrors + 1;
              ProcessQuit;
          EndIf;


          If ( pSuppressConsol = 1 & DTYPE( sDimension, sElement) @= 'C'  );
              # Add all N level elements to the subset
              # Loop through all elements and check if it is an ancestor
              If ( pDebug >= 1 );
                  AsciiOutput( sDebugFile, 'Element ' | sElement | ' is consolidated' );
              EndIf;
              nElCount = DIMSIZ ( sDimension );
              n = 1;
              WHILE ( n <= nElCount );
                  sEl = DIMNM( sDimension, n );
                  IF( DTYPE( sDimension, sEl) @<> 'C' & ELISANC( sDimension, sElement, sEl ) = 1 );

                      If ( pDebug >= 1 );
                          AsciiOutput( sDebugFile, 'Inserting element ' | sEl | ' into subset ' | sSubset | ' on dimension ' | sDimension);
                      EndIf;
                      If( pDebug <= 1 );
                          SubsetElementInsert( sDimension, sSubset, sEl, nIndex );
                      EndIf;
                  EndIf;
                  n = n + 1;
              END;

          Else;
              # Add the element to the subset
              If ( pDebug >= 1 );
                  AsciiOutput( sDebugFile, 'Inserting element ' | sElement | ' into subset ' | sSubset | ' on dimension ' | sDimension);
              EndIf;
              If( pDebug <= 1 );
                  SubsetElementInsert( sDimension, sSubset, sElement, nIndex );
              EndIf;
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

    If( pDebug >= 1 );
      sMessage = 'Current word is: ' | sWord | ' at ' | NumberToString(nChar - 1);
      AsciiOutput( sDebugFile, sMessage );
    EndIf;


END;





573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,40

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';

  # Log errors
  If( nErrors <> 0 );
    AsciiOutput( sDebugFile, 'Errors Occurred' );
  EndIf;

  # Log finish time
  AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

EndIf;


### If errors occurred terminate process with a major error status ###

If( nErrors <> 0 );
  ProcessQuit;
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
