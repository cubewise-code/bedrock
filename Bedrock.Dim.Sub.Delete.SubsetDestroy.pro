601,100
602,"Bedrock.Dim.Sub.Delete.SubsetDestroy"
562,"NULL"
586,
585,
564,
565,"cKnyBtDx>E;Zqn]VxmfT=iLoo^5^\6A~p`19sgP[:7PP5N:OuDuHR1RQNfTAd18BW>3sJ3CDPzoamtUIO;8Zw^Oti2IL=iHAF`e0MDo1f:lIEtDsQ>2K_?INpC4GLO62Hhr?pBN7Kx3pRDVbV4>8mYAh`6dDzy:gN=iuQ;91F8affy5TOFviBJ;dKkxW4sV0Fx`[vO[m"
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
pSubset
pMode
pDebug
561,4
2
2
1
1
590,4
pDimension,""
pSubset,""
pMode,0
pDebug,0
637,4
pDimension,"Dimension"
pSubset,"Subset"
pMode,"<=1 destroy subset 2 delete all elements<=1 destroy subset 2 delete all elements"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,92

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process deletes public subsets

# Notes:
# - This process can work on ONLY a single dimension
# - This process can work on ONLY a single subset 
# - This process exists only to be called from Bedrock.Dim.Sub.Delete rather than calling the SubsetDestroy function directly in order to avoid the calling process aborting 
# -  in case unable to delete a subset due to still being used by a view (or TM1 erroneously thinking subset still used by view even when it isn't) 

# Parameters:
# - pDimension:
# - pSubset:

### Constants ###

cProcess = 'Bedrock.Dim.Sub.Delete.subsetDestroy';
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
  AsciiOutput( sDebugFile, '            pSubset    : ' | pSubset );
  AsciiOutput( sDebugFile, '            pMode      : ' | NumberToString(pMode) );

EndIf;


### Validate Parameters ###

nErrors = 0;

# Validate dimension
If( Trim( pDimension ) @= '' );
  nErrors = 1;
  sMessage = 'No dim specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
ElseIf( DimensionExists( pDimension ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dim:' | pDimension;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Validate subsets
If( Trim( pSubset ) @= '' );
  nErrors = 1;
  sMessage = 'No subset specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
ElseIf( SubsetExists( pDimension, pSubset ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid subset:' | pSubset;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

### Destroy Subset ###
If( pMode <= 1 );
  SubsetDestroy( pDimension, pSubset );
Else;
  SubsetDeleteAllElements( pDimension, pSubset );
EndIF;

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
