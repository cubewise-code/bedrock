601,100
602,"Bedrock.Cube.Dimension.Replace"
562,"NULL"
586,
585,
564,
565,"qk]6=X]0cI@k4[\HJyD8Oafs`l<C:]GLQUvYRy:sQrZ[NRywAAaN^8?f:djW?f0DB2UQa:mqS<z76lHAxlr007B2ozujA3hY69t2MbGqKYWg`F<2fpGzzws00;G8iq>WNr{gu01eIyviTseWLg<]U[LRXmEI0Qz4WNiFhb2GL^B?fqbSB;w4Hj>h]<BmDR0`S3z^1sX"
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
pCube
pSourceDim
pTargetDim
pCtrlObjOverwrite
pDebug
561,5
2
2
2
1
1
590,5
pCube,""
pSourceDim,""
pTargetDim,""
pCtrlObjOverwrite,0
pDebug,0
637,5
pCube,"Cube"
pSourceDim,"Dimension to be replaced"
pTargetDim,"Replacement Dimension"
pCtrlObjOverwrite,"Allow overwrite control cubes"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,454

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process selects the cube and replaces
# the source dimensions from a specified target dimensions.
# This process should only be run on an EMPTY cube or a cube that
# has already had all data exported to a text file

# Note:
# - This process does not preserve any cube rules as they would likely no longer be
#   valid if a dimension is replaced

### Constants ###

cProcess = 'Bedrock.Cube.Dimension.Replace' ;
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
  AsciiOutput( sDebugFile, 'Parameters: pCube      : ' | pCube );
  AsciiOutput( sDebugFile, '            pSourceDim : ' | pSourceDim );
  AsciiOutput( sDebugFile, '            pTargetDim : ' | pTargetDim );

EndIf;


### Validate Parameters ###

nErrors = 0;

# If no cube has been specified then terminate process
If( Trim( pCube ) @= '' );
  nErrors = 1;
  sMessage = 'No cube specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# If specified cube does not exist then terminate process
If( CubeExists( pCube ) = 0 );
  nErrors = 1;
  sMessage = 'Cube: ' | pCube | ' does not exist';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Don't allow system cubes to be modified
If( SubSt( pCube, 1, 1 ) @= '}' & pCtrlObjOverwrite <= 0 );
  nErrors = 1;
  sMessage = 'Do not modify system cubes: ' | pCube;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# If no source dimension has been specified then terminate process
If( Trim( pSourceDim ) @= '' );
  nErrors = 1;
  sMessage = 'No source dimension specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Check that the source dimension exists
If( DimensionExists( pSourceDim ) = 0 );
  nErrors = 1;
  sMessage = 'Source dimension: ' | pSourceDim | ' does not exist';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# If no target dimension has been specified then terminate process
If( Trim( pTargetDim ) @= '' );
  nErrors = 1;
  sMessage = 'No target dimension specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Check that the target dimension exists
If( DimensionExists( pTargetDim ) = 0 );
  nErrors = 1;
  sMessage = 'Target dimension: ' | pTargetDim | ' does not exist';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Check that the source and target dimensions are different
If( pSourceDim @= pTargetDim );
  nErrors = 1;
  sMessage = 'Source and target dimensions are the same';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

### Count the dimensions and confirm that source dimension exists in cube and that the target dimension doesn't ###

nSourceDimExists = 0;
nTargetDimExists = 0;

nDimensionCount = 0;
sDimension = TabDim( pCube, nDimensionCount + 1);

While( sDimension @<> '' );
  nDimensionCount = nDimensionCount + 1;
  If( sDimension @= pSourceDim );
    nSourceDimExists = 1;
  EndIf;
  If( sDimension @= pTargetDim );
    nTargetDimExists = 1;
  EndIf;
  sDimension = TabDim( pCube, nDimensionCount + 1);
End;


### Validate Dimensions ###

# Check that source dimension exists in cube
If( nSourceDimExists = 0 );
  nErrors = 1;
  sMessage = 'The source dimension: ' | pSourceDim | ' does not exist in the cube: ' | pCube;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Check that target dimension doesn't already exist in cube
If( nTargetDimExists = 1 );
  nErrors = 1;
  sMessage = 'The target dimension: ' | pTargetDim | ' already exists in the cube: ' | pCube;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Check if cube exceeds current max dimenions
If( nDimensionCount > 27 );
  nErrors = 1;
  sMessage = 'Process needs to be modified to handle cubes with more than 27 dimensions';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# All paramaeters should be OK if this point has been reached
If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'All parameters OK' );
EndIf;


### Work out dimensions and substitute source and target dimensions ###

sDim1 = TabDim( pCube, 1 );
If( sDim1 @= pSourceDim );
  sDim1 = pTargetDim;
EndIf;

sDim2 = TabDim( pCube, 2 );
If( sDim2 @= pSourceDim );
  sDim2 = pTargetDim;
EndIf;

If( nDimensionCount >= 3 );
  sDim3 = TabDim( pCube, 3 );
  If( sDim3 @= pSourceDim );
    sDim3 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 4 );
  sDim4 = TabDim( pCube, 4 );
  If( sDim4 @= pSourceDim );
    sDim4 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 5 );
  sDim5 = TabDim( pCube, 5 );
  If( sDim5 @= pSourceDim );
    sDim5 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 6 );
  sDim6 = TabDim( pCube, 6 );
  If( sDim6 @= pSourceDim );
    sDim6 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 7 );
  sDim7 = TabDim( pCube, 7 );
  If( sDim7 @= pSourceDim );
    sDim7 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 8 );
  sDim8 = TabDim( pCube, 8 );
  If( sDim8 @= pSourceDim );
    sDim8 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 9 );
  sDim9 = TabDim( pCube, 9 );
  If( sDim9 @= pSourceDim );
    sDim9 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 10 );
  sDim10 = TabDim( pCube, 10 );
  If( sDim10 @= pSourceDim );
    sDim10 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 11 );
  sDim11 = TabDim( pCube, 11 );
  If( sDim11 @= pSourceDim );
    sDim11 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 12 );
  sDim12 = TabDim( pCube, 12 );
  If( sDim12 @= pSourceDim );
    sDim12 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 13 );
  sDim13 = TabDim( pCube, 13 );
  If( sDim13 @= pSourceDim );
    sDim13 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 14 );
  sDim14 = TabDim( pCube, 14 );
  If( sDim14 @= pSourceDim );
    sDim14 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 15 );
  sDim15 = TabDim( pCube, 15 );
  If( sDim15 @= pSourceDim );
    sDim15 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 16 );
  sDim16 = TabDim( pCube, 16 );
  If( sDim16 @= pSourceDim );
    sDim16 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 17 );
  sDim17 = TabDim( pCube, 17 );
  If( sDim17 @= pSourceDim );
    sDim17 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 18 );
  sDim18 = TabDim( pCube, 18 );
  If( sDim18 @= pSourceDim );
    sDim18 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 19 );
  sDim19 = TabDim( pCube, 19 );
  If( sDim19 @= pSourceDim );
    sDim19 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 20 );
  sDim20 = TabDim( pCube, 20 );
  If( sDim20 @= pSourceDim );
    sDim20 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 21 );
  sDim21 = TabDim( pCube, 21 );
  If( sDim21 @= pSourceDim );
    sDim21 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 22 );
  sDim22 = TabDim( pCube, 22 );
  If( sDim22 @= pSourceDim );
    sDim22 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 23 );
  sDim23 = TabDim( pCube, 23 );
  If( sDim23 @= pSourceDim );
    sDim23 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 24 );
  sDim24 = TabDim( pCube, 24 );
  If( sDim24 @= pSourceDim );
    sDim24 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 25 );
  sDim25 = TabDim( pCube, 25 );
  If( sDim25 @= pSourceDim );
    sDim25 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 26 );
  sDim26 = TabDim( pCube, 26 );
  If( sDim26 @= pSourceDim );
    sDim26 = pTargetDim;
  EndIf;
EndIf;

If( nDimensionCount >= 27 );
  sDim27 = TabDim( pCube, 27 );
  If( sDim27 @= pSourceDim );
    sDim27 = pTargetDim;
  EndIf;
EndIf;

### Replace dimension ###

If( pDebug <= 1 );

  # Destroy Cube
  CubeDestroy( pCube );

  # Recreate cube with new dimension
  If( nDimensionCount = 2 );
    CubeCreate( pCube, sDim1, sDim2 );
  ElseIf( nDimensionCount = 3 );
   CubeCreate( pCube, sDim1, sDim2, sDim3 );
  ElseIf( nDimensionCount = 4 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4 );
  ElseIf( nDimensionCount = 5 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5 );
  ElseIf( nDimensionCount = 6 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6 );
  ElseIf( nDimensionCount = 7 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7 );
  ElseIf( nDimensionCount = 8 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8 );
  ElseIf( nDimensionCount = 9 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9 );
  ElseIf( nDimensionCount = 10 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10 );
  ElseIf( nDimensionCount = 11 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11 );
  ElseIf( nDimensionCount = 12 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12 );
  ElseIf( nDimensionCount = 13 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13 );
  ElseIf( nDimensionCount = 14 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14 );
  ElseIf( nDimensionCount = 15 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15 );
  ElseIf( nDimensionCount = 16 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15,
    sDim16 );
  ElseIf( nDimensionCount = 17 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15,
    sDim16, sDim17 );
  ElseIf( nDimensionCount = 18 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15,
    sDim16, sDim17, sDim18 );
  ElseIf( nDimensionCount = 19 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15,
    sDim16, sDim17, sDim18, sDim19 );
  ElseIf( nDimensionCount = 20 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15,
    sDim16, sDim17, sDim18, sDim19, sDim20 );
  ElseIf( nDimensionCount = 21 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15,
    sDim16, sDim17, sDim18, sDim19, sDim20, sDim21 );
  ElseIf( nDimensionCount = 22 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15,
    sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22 );
  ElseIf( nDimensionCount = 23 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15,
    sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23 );
  ElseIf( nDimensionCount = 24 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15,
    sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24 );
  ElseIf( nDimensionCount = 25 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15,
    sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25 );
  ElseIf( nDimensionCount = 26 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15,
    sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26 );
  ElseIf( nDimensionCount = 27 );
   CubeCreate( pCube, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15,
    sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27 );
  EndIf;

Else;

  AsciiOutput( sDebugFile, 'Process valid. Dimension not replaced due to debug mode' );

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
