601,100
602,"}bedrock.cube.rule.processfeeders"
562,"NULL"
586,"C:\TM1Data\Bedrock3\Data\Excel.RUX"
585,"C:\TM1Data\Bedrock3\Data\Excel.RUX"
564,
565,"iz13ydO3pyNWPxv;_ZDRUHNTdGmz=bnSCs8wD[SQouyR>TbW4@>Mfu>4nKmG>fk]idlFzBx3V]Jd`kG?5Ncaw\0<`W6CO0JtwGA==1;Q[LnvggL/{Csa9f`RMzyLg[8`MRam[xNgATuF]cYz2cH:=PM4Mhf6qml[K?DwW7kl;Z2VGJjZfVw?FA}ZEnoQRgO$KQzB9@9F"
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
560,4
pLogOutput
pStrictErrorHandling
pCube
pDelim
561,4
1
1
2
2
590,4
pLogOutput,0
pStrictErrorHandling,0
pCube,""
pDelim,"&"
637,4
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pCube,"REQUIRED: Process feeders for this cube (Separated by Delimiter, Accepts Wild card)"
pDelim,"OPTIONAL: Delimiter (default value if blank = '&')"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,133
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.cube.rule.processfeeders', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
	    'pCube', '', 'pDelim', '&'
    );
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# ####################
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This process reprocesses feeders when consolidated totals are not adding up.

# Use case: Intended for Deveopment or production.
#1/ This process would be used any time feeders need to be reprocessed (e.g. when new elements are added to any of the dimensions).

# Note:
# Naturally, a valid  cube name (pCube) is mandatory otherwise the process will abort. Wildcards and lists are acceptable.
# This process will process feeders for a cube.
#EndRegion @DOC

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###

cThisProcName = GetProcessName();
cUserName = TM1User();
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cTempSub          = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
sMessage = 	'';
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pCube:%pCube%, pDelim:%pDelim%.' ;  

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

nErrors = 0;

### Validate Parameters ###
# If blank delimiter specified then convert to default
If( pDelim @= '' );
  pDelim = '&';
EndIf;

# If no cubes have been specified then terminate process
If( Trim( pCube ) @= '' );
  sMessage = 'No cubes specified';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;


### SET DATA SOURCE ###

DatasourceType = 'NULL';


### Split parameter into individual cubes and delete ###

sCubes = pCube;
nDelimiterIndex = 1;
sMdx = '';

While( nDelimiterIndex <> 0 );
  nDelimiterIndex = Scan( pDelim, sCubes );
  If( nDelimiterIndex = 0 );
    sCube = sCubes;
  Else;
    sCube = Trim( SubSt( sCubes, 1, nDelimiterIndex - 1 ) );
    sCubes = Trim( Subst( sCubes, nDelimiterIndex + Long(pDelim), Long( sCubes ) ) );
  EndIf;
  
  # Check if a wildcard has been used to specify the Cube name.
  # If it hasn't then just delete the Cube if it exists
      # If it has then search the relevant Cube folder to find the matches
      If( Scan( '*', sCube ) = 0 );
        If( CubeExists( sCube ) = 1 ); 
          CubeProcessFeeders( sCube );
        Endif;
      Else;
        # Create subset of cubes using Wildcard
        sCubeExp = '"'|sCube|'"';
        sMdxPart = '{TM1FILTERBYPATTERN( TM1SUBSETALL( [}Cubes] ) ,'| sCubeExp | ')}';
        IF( sMdx @= ''); 
          sMdx = sMdxPart; 
        ELSE;
          sMdx = sMdx | ' + ' | sMdxPart;
        ENDIF;
        
        If( SubsetExists( '}Cubes' , cTempSub ) = 1 );
            # If a delimited list of cube names includes wildcards then we may have to re-use the subset multiple times
            SubsetMDXSet( '}Cubes' , cTempSub, sMDX );
        Else;
            # temp subset, therefore no need to destroy in epilog
            SubsetCreatebyMDX( cTempSub, sMDX, '}Cubes' , 1 );
        EndIf;
        
        # Loop through cubes in subset created based on wildcard
        nCountCubes = SubsetGetSize( '}Cubes' , cTempSub );
        While( nCountCubes >= 1 );
          sCurrCube = SubsetGetElementName( '}Cubes' , cTempSub, nCountCubes );
          # Validate cube name
          If( CubeExists( sCurrCube ) = 1 ); 
            # Process Feeders
            CubeProcessFeeders( sCurrCube );
          Endif;
            nCountCubes = nCountCubes - 1;
        End;
      EndIf;

End;


573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,5

#****Begin: Generated Statements***
#****End: Generated Statements****


575,24

#****Begin: Generated Statements***
#****End: Generated Statements****

### Return code & final error message handling
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
    If( pStrictErrorHandling = 1 ); 
        ProcessQuit; 
    EndIf;
Else;
    sProcessAction = Expand( 'Process:%cThisProcName% successfully processed feeders for cube %pCube% .' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogoutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );   
    EndIf;
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
