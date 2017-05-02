601,100
562,"NULL"
586,
585,
564,
565,"eejI:arAMzr[`kcAY78H6Qyk:3d?\zD2MljB[?iMpI;YiR<tAmVVB<axyXlPVU:p04y?gKJ7GxaAlpPOMUUrKUzz1Yf58elNyiZm?s^zUs_E6l=31PTLgK7y[=:BNDOE`=FNe6Cjs4@h:CJ[9vfiW2;]TpG9jBzPt`S:\@hMWa;=RMuR3OBH\Nmxv4LU\j;plWLz@nX]"
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
560,4
pDimension
pSort
pConvertStatic
pDebug
561,4
2
1
1
1
590,4
pDimension,""
pSort,0.
pConvertStatic,1.
pDebug,0.
637,4
pDimension,Dimension Name
pSort,Sort the Subset (1)
pConvertStatic,Convert the Subset to Static (1)
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,105

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################

# This process creates static subsets named "All level <nn>" for the specified
# dimension level or for all levels in the dimension


### Constants ###

cProcess = 'Bedrock.Dim.Sub.Create.ByLevel';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.';


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension     : ' | pDimension );
  AsciiOutput( sDebugFile, '            pSort          : ' | NumberToString( pSort ) );
  AsciiOutput( sDebugFile, '            pConvertStatic : ' | NumberToString( pConvertStatic ) );

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


### Build Subset ###

If( pDebug <= 1 );
  nLevel = 0;
  nLevelMax = DnLev( pDimension ) - 1;
  While( nLevel <= nLevelMax );
    # Loop through the levels of the dimension.
    sLevel = NumberToString( nLevel );
    sSubset = 'All Level ' | Fill( '0', 2 - Long( sLevel ) ) | sLevel;
    If( SubsetExists( pDimension, sSubset ) = 1 );
      # Need to destroy the subset because the subset may change from a MDX subset to a Static Subset.
      SubsetDestroy( pDimension, sSubset );
    EndIf;

    # Generate MDX
    sMDX = '{ TM1FILTERBYLEVEL( { TM1SUBSETALL( [' | pDimension | '] ) }, ' | sLevel | ' ) }';
    If( pSort = 1 );
      sMDX = '{ TM1SORT( ' | sMDX | ', ASC ) }';
    EndIf;

    ## Build Subset for the level.
    If( pConvertStatic = 1 );
      # Convert the subset to a static subset
      sSubsetMDX = '}' | cProcess | '.' | NumberToString( Int( Rand() * 100000 ) );
      If( SubsetExists( pDimension, sSubsetMDX ) = 1 );
        SubsetDestroy( pDimension, sSubsetMDX );
      EndIF;
      SubsetCreatebyMDX( sSubsetMDX, sMDX );
      nSubsetSize = SubsetGetSize( pDimension, sSubsetMDX );
      nSubsetIndex = 0;
      SubsetCreate( pDimension, sSubset );
      While( nSubsetIndex < nSubsetSize );
        nSubsetIndex = nSubsetIndex + 1;
        sElement = SubsetGetElementName( pDimension, sSubsetMDX, nSubsetIndex );
        SubsetElementInsert( pDimension, sSubset, sElement, nSubsetIndex );
      End;
    Else;
      SubsetCreatebyMDX( sSubset, sMDX );
    EndIf;
    nLevel = nLevel + 1;
  End;
EndIf;


### End Prolog ###
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,35

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
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
