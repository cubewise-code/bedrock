601,100
602,"Bedrock.Server.DataDir.ListContents"
562,"NULL"
586,
585,
564,
565,"xesXHH_?7a?9UlC=RGisO9zaahmMoT``d5BQI5?_2O5CoO;y;89kOgYYpxoMxQ2hPp?Veyc<ONC@HOnK2OZ>S\kZMlGrS2?rtQjlPH1bx_d@M=R^FwKE6TQDFFwWef@IBfh7dx@>9vfda<1VXjn1RMI5Xk@>kbztU0d];duj9N<b>rE<z@Kmr2_`1Bi9H_H[[r07e`PL"
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
pDataDir
pDebug
561,2
2
1
590,2
pDataDir,""
pDebug,1
637,2
pDataDir,Data Directory (Leave Blank to use TM1 Settings)
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,82

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will list all files and processes in the data directory
# as text file output in the data directory itself
# In some cases the path to the batch file (in the data directory) must be fully qualified


### Constants ###

cProcess = 'Bedrock.Server.DataDir.ListContents';
cUser = TM1User();
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;
cBatchFile = cProcess | '.bat';


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  AsciiOutput( sDebugFile, 'TM1 User:        ' | cUser );
  AsciiOutput( sDebugFile, '' );
  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDataDir: ' | pDataDir );
  AsciiOutput( sDebugFile, '' );
EndIf;


### Build Command ###
nErrors = 0;

If( pDataDir @= '' );
  # If no data directory provided then use current directory
  sCommand = cBatchFile;
Else;
  # Trim off trailing backslash if present
  If( SubSt( pDataDir, Long( pDataDir ), 1 ) @= '\' );
    pDataDir = SubSt( pDataDir, 1, Long( pDataDir ) - 1 );
  EndIf;
  # Check that data directory exists
  If( FileExists( pDataDir ) = 0 );
    nErrors = 1;
    If( pDebug >= 1 );
      sMessage = 'Data directory does not exist: ' | pDataDir;
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    ItemReject( sMessage );
  Else;
    sCommand = pDataDir | '\' | cBatchFile;
  EndIf;
EndIf;

### Create Batch File ###
DatasourceASCIIQuoteCharacter='';

ASCIIOUTPUT( sCommand, 'dir /b /s *.* > List_All_Data_Directory_Files.txt');
ASCIIOUTPUT( sCommand, 'dir /b /s }*.* > List_All_Control_Objects.txt');
ASCIIOUTPUT( sCommand, 'dir /b *.cub > List_All_Cubes.txt');

ASCIIOUTPUT( sCommand, 'dir /b *.dim > List_All_Dimensions.txt');
ASCIIOUTPUT( sCommand, 'dir /b *.pro > List_All_Processes.txt');
ASCIIOUTPUT( sCommand, 'dir /b *Bedrock*.* > List_All_Bedrock_Files.txt');

ASCIIOUTPUT( sCommand, 'dir /b /s *.vue > List_All_Views.txt');
ASCIIOUTPUT( sCommand, 'dir /b /s *.sub > List_All_Subsets.txt');




### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,65

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

### Initialise Debug ###
If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';
ENDIF;

### VALIDATION ###
# Check that batch file exists
If(
FileExists( sCommand ) = 0 );
  nErrors = 1;
  sMessage = 'Batch file not found: ' | sCommand;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

### Execute Batch File ###
If(
pDebug <= 1 &
nErrors = 0 );
  ExecuteCommand ( sCommand, 1 );
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, 'Command: ' | sCommand );
  EndIf;
EndIf;

### Delete temporary batch file
If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'Delete: ' | sCommand );
EndIf;
ASCIIDelete ( sCommand );


### Initialise Debug ###
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
