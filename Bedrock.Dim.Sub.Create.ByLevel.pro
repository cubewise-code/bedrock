601,100
602,"Bedrock.Dim.Sub.Create.ByLevel"
562,"NULL"
586,
585,
564,
565,"yz38taz5?ozp;ke@RAsVN>tSAaAASyNRs:STi^A7z\m@YJ9]=<y\Ol1F6E<NBDCEVS]@V=`KIp08flQDk?6`dJOauiCi=bW;LGhAHSTOz90k7ZM8X8?1pnHMo7K>EK9wxhataELbKHvLvbM?SXrAPebEg=3vz5SBLW?K77lz\\d9RY@C:swpwy[;HMe9N@2\ix9>1;QG"
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
pSort
pConvertStatic
pAlias
pDebug
561,5
2
1
1
2
1
590,5
pDimension,""
pSort,0
pConvertStatic,1
pAlias,""
pDebug,0
637,5
pDimension,Dimension Name
pSort,Sort the Subset (1)
pConvertStatic,Convert the Subset to Static (1)
pAlias,Assign an alias to the subset
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,156

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process creates static subsets named "All level <nn>" for the specified
# dimension level or for all levels in the dimension


### Constants ###

cProcess = 'Bedrock.Dim.Sub.Create.ByLevel';
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
  AsciiOutput( sDebugFile, 'Parameters: pDimension     : ' | pDimension );
  AsciiOutput( sDebugFile, '            pSort          : ' | NumberToString( pSort ) );
  AsciiOutput( sDebugFile, '            pConvertStatic : ' | NumberToString( pConvertStatic ) );
  AsciiOutput( sDebugFile, '            pAlias : ' | pAlias );
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

## Validate Alias

IF(
pAlias @<> '' );

  sDimAttr = '}ElementAttributes_' | pDimension;
  IF(
  DimensionExists( sDimAttr ) = 0 );
    sMessage = 'No attributes exist for the dimension: ' | pDimension;
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    pAlias = '';
  EndIf;

  IF(
  DIMIX( sDimAttr, pAlias ) = 0 );
    sMessage = 'The Alias: ' | pAlias | ' does not exist in the dimension: ' | pDimension;
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    pAlias = '';
  EndIf;

  IF(
  DTYPE( sDimAttr, pAlias ) @<> 'AA' );
    sMessage = 'The Alias: ' | pAlias | ' is not an Alias in the dimension: ' | sDimAttr;
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    pAlias = '';
  EndIf;
ENDIF;


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

    ### Assign Alias to subset
    IF(
    pAlias @<> '' );
      If( pDebug <= 1 );
        SubsetAliasSet( pDimension, sSubset, pAlias );
      EndIf;

      If( pDebug >= 1 );
        sMessage = 'The Alias: ' | pAlias | ' has been set.';
        AsciiOutput( sDebugFile, sMessage );
      EndIf;
    ENDIF;

    nLevel = nLevel + 1;
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
