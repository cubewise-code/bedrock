601,100
602,"Bedrock.Dim.Sub.Clone"
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"oOeqlT\3fXJx@Ofa^YSxY7a`7dQPgsYvSZRJKAD7<g?l6fq3^MWcQ?47HEC`r?olQ9w42Fz@P8KSG]yaLNgH=CIJ?]U;;=?WuJmaa[xOJJ;PF3kgde6pUyjjp?NpErqT9aRS1_8xrAXOXt=d8eKd0_4PjJEXaf@9WSnDBkwGNBqTSdoH=A;?uc=CD5>lIj_yn1K6RCP;"
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
560,5
pDimension
pTargetDim
pSourceSub
pTargetSub
pDebug
561,5
2
2
2
2
1
590,5
pDimension,""
pTargetDim,""
pSourceSub,""
pTargetSub," "
pDebug,0
637,5
pDimension,"Mandatory: Dimension where the subset exists"
pTargetDim,"Optional: Target dimension (blank = same as source)"
pSourceSub,"Mandatory: Source Subset"
pTargetSub,"Mandatory: Target Subset"
pDebug,"Optional: Debug Mode"
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
572,109

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################
##~~Copyright bedrocktm1.org 2013 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
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
  AsciiOutput( sDebugFile, '            pTargetDim         : ' | pTargetDim );
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

# Validate target dimension
If( Trim( pTargetDim ) @= '' );
  pTargetDim = pDimension;
EndIf;
If( DimensionExists( pTargetDim ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dimension: ' | pTargetDim;
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

If( SubsetExists( pTargetDim, pTargetSub ) = 1 );
  SubsetDeleteAllElements( pTargetDim, pTargetSub );
Else;
   SubsetCreate( pTargetDim, pTargetSub );
EndIf;

nElementPosition = 0;

### Set data source for process ###

DatasourceType = 'SUBSET';
DatasourceNameForServer = pDimension;
DatasourceDimensionSubset = pSourceSub;

573,19

#****Begin: Generated Statements***
#****End: Generated Statements****


################################################################
##~~Copyright bedrocktm1.org 2013 www.bedrocktm1.org/how-to-licence.php Ver 3.0.2~~##
################################################################


IF( pTargetDim @= pDimension );
  nElementPosition = nElementPosition + 1;
ElseIF( DimIx( pTargetDim, vElement ) > 0 );
  nElementPosition = nElementPosition + 1;
Else;
  ItemReject( Expand( 'Cannot insert into subset. Element  %vElement% does not exist in target dimension %pTargetDim%.' ) );
EndIF;

SubsetElementInsert( pTargetDim , pTargetSub , vElement , nElementPosition );
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
