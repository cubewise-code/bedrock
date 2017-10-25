601,100
602,"Bedrock.Cube.Rule.ProcessFeeders"
562,"CHARACTERDELIMITED"
586,"C:\TM1Data\Bedrock3\Data\Excel.RUX"
585,"C:\TM1Data\Bedrock3\Data\Excel.RUX"
564,
565,"xyHj_x03oH6UjIzU;7Hu=aI7yGr1\p=Uc^x@eRp\p9=>CPBKy50pgcjRU@mW_5fMf;`GZzBsCUND\o7CMkkzD8Xv1b<3IIfxZA@:=<c:jn2ByQK/[`;@OC8_:[4Dm[@9`XAf;NVIn3hD}BEvBI\5MkRJj5\^WE@S=:BGc=ilx^;LNJQg27_\MBmeRoNt=eO%Kx;[9R>`"
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
589,","
568,""""
570,
571,
569,0
592,0
599,1000
560,2
pSourceCube
pDebug
561,2
2
1
590,2
pSourceCube,""
pDebug,0
637,2
pSourceCube,"Process feeders for this cube."
pDebug,"Debug Mode"
577,1
V1
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
572,64

#****Begin: Generated Statements***
#****End: Generated Statements****


####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

## This process will process feeders for a cube

### Constants ###

cProcess = 'Bedrock.Cube.Rule.ProcessFeeders';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;

nErrors = 0;


### Initialise Debug ###
If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters:    pSourceCube: ' | pSourceCube );
  AsciiOutput( sDebugFile, '' );

EndIf;


### VALIDATE PARAMETERS ###
## Check if the cube exists.
IF( CubeExists( pSourceCube ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid source cube specified: ' | pSourceCube;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
ELSE;
  cSourceCube = pSourceCube;
EndIf;


### SET DATA SOURCE ###

DatasourceType = 'NULL';


### Process Feeders ###

IF( pDebug <= 1 );
  CubeProcessFeeders( cSourceCube );
ENDIF;


573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,5

#****Begin: Generated Statements***
#****End: Generated Statements****


575,33

#****Begin: Generated Statements***
#****End: Generated Statements****


### Initialise Debug ###
If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';

EndIf;

### Finalise Debug ###

If( pDebug >= 1 );
  ## Log errors
  If( nErrors <> 0 );
    AsciiOutput( sDebugFile, 'Errors Occurred' );
  EndIf;

  ## Log finish time
  AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

EndIf;


## If errors occurred terminate process with a major error status ###
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
