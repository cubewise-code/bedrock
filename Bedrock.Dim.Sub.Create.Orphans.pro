601,100
562,"NULL"
586,
585,
564,
565,"nA\Xj`AoAa?pE>a`wLQs^L7zIa:GE=coRHMK0NX;H49Hc<e\]LWHC1_?c=hly\R5vqMlO@4pt[uEFA5Cv[aPTIO?H8m\:CzzoKEIaVagNCVUkMaLr\svg^RvOFvS]A?RoJtUi@rz7]?uL>wL=HHjMDpY`luHW6o4uaHShci<YoHbOPFGF;MlkD4NQO35CCK_J\@H9^h@"
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
560,2
pDimension
pDebug
561,2
2
1
590,2
pDimension,""
pDebug,0.
637,2
pDimension,Dimension
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,126

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will Create a subsets for "orphan" elements
# that is Colsols without children and Ns without parents


### Constants ###

cProcess = 'Bedrock.Dim.Sub.Create.Orphans';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 100000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;
cSubsetOrphanC = 'Orphan C Elements (no children)';
cSubsetOrphanN = 'Orphan N Elements (no parents)';


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension : ' | pDimension );

  # Log subset names
  AsciiOutput( sDebugFile, 'Orphan subsets for dimension        :', pDimension );
  AsciiOutput( sDebugFile, 'Subset for consols without children :', cSubsetOrphanC );
  AsciiOutput( sDebugFile, 'subset for level 0 without parents  :', cSubsetOrphanN );

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


### Create Subsets ###

If( pDebug <= 1 );
  If( SubsetExists( pDimension, cSubsetOrphanC ) = 1 );
    SubsetDeleteAllElements( pDimension, cSubsetOrphanC );
  Else;
    SubsetCreate( pDimension, cSubsetOrphanC );
  EndIf;
  If( SubsetExists( pDimension, cSubsetOrphanN ) = 1 );
    SubsetDeleteAllElements( pDimension, cSubsetOrphanN );
  Else;
    SubsetCreate( pDimension, cSubsetOrphanN );
  EndIf;
EndIf;


### Populate subsets ###

nElementCount = DimSiz( pDimension );
nElementIndex = 1;
nLeafCount = 0;
nConsolCount = 0;
While( nElementIndex <= nElementCount );
  sElement = DimNm( pDimension, nElementIndex );
  If( DType( pDimension, sElement ) @= 'N' & ElPar( pDimension, sElement, 1 ) @= '' );
    # N element with no parents
    nLeafCount = nLeafCount + 1;
    If( pDebug <= 1 );
      SubsetElementInsert( pDimension, cSubsetOrphanN, sElement, nLeafCount );
    EndIf;
  EndIf;
  If( DType( pDimension, sElement ) @= 'C' & ElCompN( pDimension, sElement ) = 0 );
    # C element with no children
    nConsolCount = nConsolCount + 1;
    SubsetElementInsert( pDimension, cSubsetOrphanC, sElement, nConsolCount );
  EndIf;
  nElementIndex = nElementIndex + 1;
End;

# Output element counts to debug file
If( pDebug >= 1 );
  AsciiOutput( sDebugFile, cSubsetOrphanC | ' Size: ', NumberToString( nConsolCount ) );
  AsciiOutput( sDebugFile, cSubsetOrphanN | ' Size: ', NumberToString( nLeafCount ) );
EndIf;


### Tidy up ###

# If no orphans then destroy empty subsets, in debug leave empty subsets
If( pDebug <= 1 );
  If( SubsetGetSize( pDimension, cSubsetOrphanN ) = 0 );
    SubsetDestroy( pDimension, cSubsetOrphanN );
  EndIf;
  If( SubsetGetSize( pDimension, cSubsetOrphanC ) = 0 );
    SubsetDestroy( pDimension, cSubsetOrphanC );
  EndIf;
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
917,1
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
