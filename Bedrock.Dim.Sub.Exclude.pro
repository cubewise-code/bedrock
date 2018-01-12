601,100
602,"Bedrock.Dim.Sub.Exclude"
562,"NULL"
586,
585,
564,
565,"fJ3BVSaQnIuLu5ylEJ4FAb0]ul<`OytyZfhagBB<SSja]5Cvd5<``7VJZQQQsCl5Nj3xzQJ`JAE6YYO7;ha3QZ<AOKRS\]^3lt_KtqM3VpdE5dHiN@6_xLKc4HU@cM1MmSoS9sFEa<esC<RMjqDEqbbj>RjRyOg6Aq<aICmlweAxeYdOgripGo8ujL`nS^YTwVM[=E_G"
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
pDimension
pSubset
pElements
pDelimiter
pDebug
561,5
2
2
2
2
1
590,5
pDimension,""
pSubset,""
pElements,""
pDelimiter,"&"
pDebug,0
637,5
pDimension,Dimension
pSubset,Subset
pElements,Elements to be Excluded (Seperated by Delimiter)
pDelimiter,Delimiter
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,141

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will remove specified elements from a subset
# If a leaf level element is specified it will be removed
# If a consolidated element is specified it will be removed as well as its descendants


### Constants ###

cProcess = 'Bedrock.Dim.Sub.Exclude';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension   : ' | pDimension );
  AsciiOutput( sDebugFile, '            pSubset      : ' | pSubset );
  AsciiOutput( sDebugFile, '            pElements  : ' | pElements );
  AsciiOutput( sDebugFile, '            pDelimiter   : ' | pDelimiter );

EndIf;


### Validate Parameters ###

nErrors = 0;

# Validate dimension
If( Trim( pDimension ) @= '' );
  nErrors = 1;
  sMessage = 'No dimension specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;
If( DimensionExists( pDimension ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dimension: ' | pDimension;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Validate subset
If( Trim( pSubset ) @= '' );
  nErrors = 1;
  sMessage = 'No subset specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;
If( SubsetExists( pDimension, pSubset ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid subset: ' | pSubset | ' in dimension: ' | pDimension;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Validate Elements
If( Trim( pElements ) @= '' );
  nErrors = 1;
  sMessage = 'No Elements specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Validate delimiter
If( pElements @<> '' & pDelimiter @= '' );
  pDelimiter = '&';
EndIf;


### Process Elements ###

If( pDebug <= 1 );

  nDelimIndex = 1;
  sExclusions = pElements;

  While( nDelimIndex <> 0 & Long( sExclusions ) > 0 );

    nDelimIndex = Scan( pDelimiter, sExclusions );
    If( nDelimIndex <> 0 );
      sExclusion = Trim( SubSt( sExclusions, 1, nDelimIndex - 1 ) );
      sExclusions = Trim( SubSt( sExclusions, nDelimIndex + Long( pDelimiter ), Long( sExclusions ) ) );
    Else;
      sExclusion = Trim( sExclusions );
    EndIf;

    # Check that Element is present in the dimension
    If( DimIx( pDimension, sExclusion ) <> 0 );
      sExclusion = DimensionElementPrincipalName( pDimension, sExclusion );
      # Work through subset and remove Element
      nSubsetIndex = 1;
      nSubsetSize = SubsetGetSize( pDimension, pSubset );
      While( nSubsetIndex <= nSubsetSize );
        sElement = SubsetGetElementName( pDimension, pSubset, nSubsetIndex );
        # If Element is found or a descendant of the Element is found the remove from subset
        If( pDebug <= 1 & sElement @= sExclusion % ElIsAnc( pDimension, sExclusion, sElement ) = 1 );
          SubsetElementDelete( pDimension, pSubset, nSubsetIndex );
          nSubsetSize = nSubsetSize - 1;
        Else;
          nSubsetIndex = nSubsetIndex + 1;
        EndIf;
      End;
    Else;
      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, 'Element: ' | sExclusion | ' does not exist in dimension: ' | pDimension );
      EndIf;
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

575,35

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
