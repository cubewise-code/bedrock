601,100
562,"NULL"
586,
585,
564,
565,"hCNVUmKlaIREnd\EPbj>HKGDzT:`hkl1m:npm;Egf]g=emSF;w_mV]1PaR]Fq5yo@hc;oOk<cDYtdv9j^LoU[7KUo8`nHNn9t?6A`Ne9gdW;JwoM?h8okYrXOLA`70^yk9E`vL7I6RnDoZXc1KG2i:T4t<nd1ohJ@WJ3glC02N4gclbuP3h^ug@7P23My:XSJl<A1m_I"
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
572,75

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################
cProcess = 'Bedrock.Dim.Destroy';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.';


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
  sMessage = 'The dimension ' | pDimension | ' does not exist.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;


### Destroy Dimension ###

If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'The dimension ' | pDimension | ' will be deleted.' );
EndIf;

If( pDebug <= 1 );

  DimensionDestroy( pDimension );

  # Check that dimension was destroyed. Dimension cannot be destroyed if it is attached to a cube

  If( DimensionExists( pDimension ) = 1 );
    nErrors = 1;
    sMessage = 'The dimension ' | pDimension | ' could not be destroyed. It may be attached to a cube';
    If( pDebug = 1 );
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    ItemReject( sMessage );
  EndIf;

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
