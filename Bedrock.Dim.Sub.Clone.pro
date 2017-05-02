601,100
602,"Bedrock.Dim.Sub.Clone"
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"yyGCsqzHCTu0jGRq;9q^Sfq62apzBcUJR64nXHEX29y^bCKaB1GSai6[Bfk\q9_5:eu8b5MRrZ_m9w?^7KImqyel[Lw[`5xL4rwDRvU00`MRVV[8Z;uRPbDIh2tXi3b_Qd0=4O>bmOLwEtJtK[dC8U0e8Ti7hFggE_uIQca_@x7abU3dfbgU\`=o5gLy@e5[JXSzBiw]"
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
571,All
569,0
592,0
599,1000
560,4
pDimension
pSourceSub
pTargetSub
pDebug
561,4
2
2
2
1
590,4
pDimension,""
pSourceSub,""
pTargetSub,""
pDebug,0
637,4
pDimension,"Dimension where the subset exists"
pSourceSub,"Source Subset"
pTargetSub,"Target Subset"
pDebug,"Debug Mode"
577,1
vElement
578,1
2
579,1
1
580,1
0
581,1
0
582,1
VarType=32ColType=827
603,0
572,92

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################
##~~Copyright bedrocktm1.org 2013 www.bedrocktm1.org/how-to-licence.php Ver 3.0.2~~##
################################################################

# This process will create a copy of subset

### Constants ###

cProcess = 'Bedrock.Dim.Sub.Clone';
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
  AsciiOutput( sDebugFile, 'Parameters: pDimension       : ' | pDimension );
  AsciiOutput( sDebugFile, '            pSourceSub          : ' | pSourceSub );
  AsciiOutput( sDebugFile, '            pTargetSub         : ' | pTargetSub );

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
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;
If( DimensionExists( pDimension ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dimension: ' | pDimension;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate subset
If( Trim( pSourceSub ) @= '' );
  nErrors = 1;
  sMessage = 'No source subset specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;
If( SubsetExists( pDimension , pSourceSub ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid source subset : ' | pDimension;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

### Create Target Subset ###

If( SubsetExists( pDimension, pTargetSub ) = 1 );
  SubsetDeleteAllElements( pDimension, pTargetSub );
Else;
   SubsetCreate( pDimension , pTargetSub );
EndIf;

nElementPosition = 0;

DatasourceNameForServer = pDimension;
DatasourceNameForClient = pDimension;
DatasourceType = 'SUBSET';
DatasourceDimensionSubset = pSourceSub;
573,15

#****Begin: Generated Statements***
#****End: Generated Statements****


################################################################
##~~Copyright bedrocktm1.org 2013 www.bedrocktm1.org/how-to-licence.php Ver 3.0.2~~##
################################################################



nElementPosition = nElementPosition + 1;


SubsetElementInsert( pDimension , pTargetSub , vElement , nElementPosition );
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,38

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################
##~~Copyright bedrocktm1.org 2013 www.bedrocktm1.org/how-to-licence.php Ver 3.0.2~~##
################################################################

### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';

EndIf;

### Finalise Debug ###

If( pDebug >= 1 );

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
1217,0
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
