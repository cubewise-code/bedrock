601,100
602,"Bedrock.Cube.View.Publish"
562,"NULL"
586,
585,
564,
565,"t2hQ9V1k1XJitG>;Nt=ha5_Iv]RVg[SNPqw1LvF\7j08cBUC0v1Ifu=]iappr?K^L3t[9[ALq4c]K]eRSjHdXPYIm`KoYYlXsT:jFMNeIOm\tEuBDt?PJGrliEx:Hn9B7m8wsTvPKh4wE<k@OGDNsv^OHGqJpRJN44s@ljkLRCMXS_9VOtzM:YLR?N7U>_>FEBCA9RRw"
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
560,6
pClient
pCube
pView
pSubPublish
pOverwrite
pDebug
561,6
2
2
2
1
1
1
590,6
pClient,""
pCube,""
pView,""
pSubPublish,1
pOverwrite,0
pDebug,0
637,6
pClient,"Client Name"
pCube,"Cube Name"
pView,"Private View Name"
pSubPublish,"Publish Private Subsets? (Boolean 1=Yes)"
pOverwrite,"Overwrite Existing Named View? (Boolean 1=Yes)"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,149

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process converts a private view to a public view for the named client.
# If the view contains private subsets they must also be made public or the
# view publish will fail.

# Note:
# - This process must be run by the user publishing the private view, it canot be run by another user


### Constants ###

cProcess = 'Bedrock.Cube.View.Publish';
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
  AsciiOutput( sDebugFile, 'Parameters: pClient     : ' | pClient );
  AsciiOutput( sDebugFile, '            pCube       : ' | pCube );
  AsciiOutput( sDebugFile, '            pView       : ' | pView );
  AsciiOutput( sDebugFile, '            pSubPublish : ' | NumberToString( pSubPublish ) );
  AsciiOutput( sDebugFile, '            pOverwrite  : ' | NumberToString( pOverwrite ) );

EndIf;


### Validate Parameters ###

nErrors = 0;

# Validate Client
If( Trim( pClient ) @= '' );
  nErrors = 1;
  sMessage = 'No client specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

If( DimIx( '}Clients', pClient ) = 0 );
  nErrors = 1;
  sMessage = 'Client ' | pClient | ' does not exist on server';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Check that client running process is same as parameter
sClient = TM1User( );
If( sClient @<> DimensionElementPrincipalName( '}Clients', pClient ) );
  nErrors = 1;
  sMessage = 'Cannot continue, process must be executed by the view owner ( ' | pClient | ' )';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Validate Cube
If( Trim( pCube ) @= '' );
  nErrors = 1;
  sMessage = 'No cube specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

If( CubeExists( pCube ) = 0 );
  nErrors = 1;
  sMessage = 'Cube ' | pCube | ' does not exist on server';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Validate view
If( Trim( pView ) @= '' );
  nErrors = 1;
  sMessage = 'No view specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# No way to check if private view exists except via file system.
# Could include data directory param and concatenate with user, cube and view to check
# if private view exists to handle error inthe case that private view does not exist

# Check for valid view name, subset publish and overwrite parameters
If( pSubPublish <> 0 & pSubPublish <> 1 );
  nErrors = 1;
  sMessage = 'Invalid publish private subsets selection: ' | NumberToString( pSubPublish );
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

If( pOverwrite <> 0 & pOverwrite <> 1 );
  nErrors = 1;
  sMessage = 'Invalid overwrite existing public view selection: ' | NumberToString( pOverwrite );
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

If( pOverwrite = 0 & ViewExists( pCube, pView ) = 1 );
  # If NOT overwriting current public view AND view of the same name exists then cause minor error ( major error if not handled )
  nErrors = 1;
  sMessage = 'Public view of same name already exists and Overwrite=No specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;


### Publish the view ( and any private subsets ) ###

If( pDebug <= 1 );
  PublishView( pCube, pView, pSubPublish, pOverwrite );
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
