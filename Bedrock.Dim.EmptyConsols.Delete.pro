601,100
602,"Bedrock.Dim.EmptyConsols.Delete"
562,"NULL"
586,
585,
564,
565,"gwixgd0a3st2>bz[`YJioLmqP25TGkt:Cu>:YIeO]paJpA:\e\052ufHZ?F[Ymr_LCSOw^`f5I[@?1NT>OHzvtbKQc0khJPViJGa:v86eFPUiPQwMqQ3e8lA64g1\:nCBfR08<HpSW1[YSzVq6Q5sc\FpPW@>UM:GjTOpt>eIog:SjRHKDCDUQ<4i[agEm_p>^wLwkH<"
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
pDebug,0
637,2
pDimension,Target Dimension
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,94

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will delete all consolidations with no children in the target dimension.
# Note:
# - This process works but would be more efficient with a subset all
#   as data source and making dimension changes on the meta data tab


### Constants ###

cProcess = 'Bedrock.Dim.EmptyConsols.Delete';
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
  AsciiOutput( sDebugFile, 'Parameters: pDimension : ' | pDimension );

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
  sMessage = 'Dimension: ' | pDimension | ' does not exist';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;


### Go through dimension and delete consols with no children ###

nLevelIndex = DNLEV( pDimension );
nLevelCount = 1;

WHILE( nLevelCount <= nLevelIndex );
  nElementCount = DimSiz( pDimension );
  nElementIndex = 1;

  While( nElementIndex <= nElementCount );

    sElement = DimNm( pDimension, nElementIndex );
    sElementType = DType( pDimension, sElement );

    If( sElementType @= 'C' );
      nChildCount = ElCompN( pDimension, sElement );
      If( nChildCount = 0 );
        If( pDebug <= 1 );
          DimensionElementDelete( pDimension, sElement );
          nElementCount = nElementCount - 1;
          nElementIndex = nElementIndex - 1;
        EndIf;
      EndIf;
    EndIf;

    nElementIndex = nElementIndex + 1;

  End;

  nLevelCount = nLevelCount + 1;
END;

### End Prolog ###
573,5

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
