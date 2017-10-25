601,100
602,"Bedrock.Cube.ViewAndSubsets.Create"
562,"NULL"
586,
585,
564,
565,"r]HwyX=boeGfquYSElaQXVbI8QOTi@gLx[SF5qqk>]o\i?Wavspi\fSiNHyZRC_Z8X6FnVRSQE3kMBiBt9189dVs803qiyQK=Sf^KliIopuRT8]VfAC<G5FcaNEMqIyo2eSeV6QPbB`pL^gn_j:q]Kh<_E=4UIHv?G?>_=r3\rrtwF7dRmaK[HV5iWk2iteVm5E7k?2c"
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
560,9
pCube
pSuppressZero
pSuppressConsol
pSuppressRules
pDimensions
pDelimiter
pView
pSubset
pDebug
561,9
2
1
1
1
2
2
2
2
1
590,9
pCube,""
pSuppressZero,1
pSuppressConsol,1
pSuppressRules,1
pDimensions,""
pDelimiter,"&"
pView,""
pSubset,""
pDebug,0
637,9
pCube,Cube
pSuppressZero,Suppress Zeros (Boolean Yes = 1)
pSuppressConsol,Suppress Calcs (Boolean Yes = 1)
pSuppressRules,Suppress Rules (Boolean Yes = 1)
pDimensions,Dimension(s) to create empty processing subsets for
pDelimiter,Delimiter
pView,View
pSubset,Subset
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,194

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process creates a processing view for the cube and for specified dimensions of the cube
# It creates empty subsets and assigns the empty subsets to the view.

# Note:
# - A subsequent process is required to insert elements into subsets otherwise the
#   views will not contain any data!


### Constants ###

cProcess = 'Bedrock.Cube.ViewAndSubsets.Create' ;
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
  AsciiOutput( sDebugFile, 'Parameters: pCube           : ' | pCube );
  AsciiOutput( sDebugFile, '            pSuppressZero   : ' | NumberToString( pSuppressZero ) );
  AsciiOutput( sDebugFile, '            pSuppressConsol : ' | NumberToString( pSuppressConsol ) );
  AsciiOutput( sDebugFile, '            pSuppressRules  : ' | NumberToString( pSuppressRules ) );
  AsciiOutput( sDebugFile, '            pDimensions     : ' | pDimensions );
  AsciiOutput( sDebugFile, '            pDelimiter      : ' | pDelimiter );
  AsciiOutput( sDebugFile, '            pView           : ' | pView );
  AsciiOutput( sDebugFile, '            pSubset         : ' | pSubset );

EndIf;


### Validate Parameters ###

nErrors = 0;

# Validate cube
If( Trim( pCube ) @= '' );
  nErrors = 1;
  sMessage = 'No cube specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;
If( CubeExists( pCube ) = 0 );
  nErrors = 1;
  sMessage = 'Cube: ' | pCube | ' does not exist';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

# Validate suppression parameters
If( pSuppressZero <> 0 & pSuppressZero <> 1 );
  nErrors = 1;
  sMessage = 'Invalid value for suppress zero parameter';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

If( pSuppressConsol <> 0 & pSuppressConsol <> 1 );
  nErrors = 1;
  sMessage = 'Invalid value for suppress consol parameter';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

If( pSuppressRules <> 0 & pSuppressRules <> 1 );
  nErrors = 1;
  sMessage = 'Invalid value for suppress rules parameter';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

# Validate view and subsets
If( pView @= '' & pSubset @= '' );
  ## Use standard view name.
  cView = '}' | pCube;
  cSubset = cView;
ElseIf( pView @<> '' & pSubset @= '' );
  ## Use the nominated view name for the subset name.
  cView = pView;
  cSubset = pView;
ElseIf( pView @= '' & pSubset @<> '' );
  ## Use the nominated subset name for the view name.
  cView = pSubset;
  cSubset = pSubset;
Else;
  cView = pView;
  cSubset = pSubset;
EndIf;

# Validate delimiter
If( pDelimiter @= '' );
  pDelimiter = '&';
EndIf;

### Build View ###

If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'Cube: ' | pCube |', View: ' | cView | ', Subset: ' | cSubset );
EndIf;

If( pDebug <= 1 );

  If( ViewExists( pCube, cView ) = 1);
    ViewDestroy( pCube, cView );
  EndIf;
  ViewCreate( pCube, cView );

  ViewExtractSkipZeroesSet( pCube, cView, pSuppressZero );
  ViewExtractSkipCalcsSet( pCube, cView, pSuppressConsol );
  ViewExtractSkipRuleValuesSet( pCube, cView, pSuppressRules );

  ### Build Subsets and assign to View ###

  # Create subsets for all dimensions if pDimension is set to Every
  If( Upper( Trim( pDimensions ) ) @= 'EVERY' );

    # Create an empty subset in every dimension of the cube.
    nDimensionIndex = 1;
    sDimension = TabDim( pCube, nDimensionIndex );

    While( sDimension @<> '' );
      If( SubsetExists( sDimension, cSubset ) = 1 );
        SubsetDeleteAllElements( sDimension, cSubset );
      Else;
        SubsetCreate( sDimension, cSubset );
      EndIf;
      ViewSubsetAssign( pCube, cView, sDimension, cSubset );

      nDimensionIndex = nDimensionIndex + 1;
      sDimension = TabDim( pCube, nDimensionIndex );
    End;

  # Create subsets for specified dimensions only
  Else;

    nDelimiterIndex = 1;
    sDimensions = pDimensions;

    While( nDelimiterIndex <> 0 & sDimensions @<> '' );
      nDelimiterIndex = Scan( pDelimiter, sDimensions  );
      If( nDelimiterIndex = 0 );
        sDimension = sDimensions;
      Else;
        sDimension = Trim( SubSt( sDimensions, 1, nDelimiterIndex - 1 ) );
        sDimensions = Trim( SubSt( sDimensions, nDelimiterIndex + Long( pDelimiter ), Long( sDimensions ) ) );
      EndIf;

      If( DimensionExists( sDimension ) = 1 );
        If( SubsetExists ( sDimension, cSubset ) = 1 );
          SubsetDeleteAllElements( sDimension, cSubset );
        Else;
          SubsetCreate( sDimension, cSubset );
        EndIf;
        ViewSubsetAssign( pCube, cView, sDimension, cSubset );
      Else;
        If( pDebug >= 1 );
          AsciiOutput( sDebugFile, 'Dimension: ' | sDimension | ' does not exist, skipping' );
        EndIf;
      EndIf;
    End;

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
