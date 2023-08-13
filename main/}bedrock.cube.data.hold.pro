601,100
602,"}bedrock.cube.data.hold"
562,"NULL"
586,
585,
564,
565,"aaf7I1NuRU1<cmF1<lO44@W43vz`\0vZ[cobcdu=3gDUHz8<bhCd7K1?3EsBQBXY?3?q5R\f>CHP0IG@tvLQBhEYeeRWMXQ;4OFQ0fSxDJD_@N<QcH_]Sk[fc15RMe^f90mk?MW08kcRGqT1dk7q1;14e1b3x<c_Xi[nj;4?eoLc[BJxmHM7i=TfQWy5C6rmZarVi3;A"
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
560,9
pLogOutput
pStrictErrorHandling
pMode
pCube
pClient
pGroup
pDelim
pDir
pSkipNonExistentHoldsCubes
561,9
1
1
2
2
2
2
2
2
1
590,9
pLogOutput,0
pStrictErrorHandling,0
pMode,""
pCube,""
pClient,""
pGroup,""
pDelim,"&"
pDir,""
pSkipNonExistentHoldsCubes,0
637,9
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pMode,"REQUIRED: Use C / D / R / X / M. See inside process for information. Supported operations for holds cubes: Create, Destroy, Release, Export, Import."
pCube,"REQUIRED: Treat which Holds cube(s) ? Supports a list and wildcards * and ? This should be the base cube name."
pClient,"REQUIRED or used in conjunction with pGroup. Treat the Holds cube(s) of which client(s) ? Supports a list and wildcards * and ?"
pGroup,"REQUIRED or used in conjunction with pGroup. Treat the Holds cube(s) of which client(s) in which group(s) ? Supports a list and wildcards * and ?"
pDelim,"OPTIONAL: delimiter character for the different lists. (default value if blank = '&')"
pDir,"OPTIONAL: Directory (will default to error file path)"
pSkipNonExistentHoldsCubes,"OPTIONAL: When using lists and wildcards, it can lead to non-existent holds cubes. 1=Silently ignore these. Default=0."
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,586

# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.cube.data.hold', 'pLogOutput', pLogOutput, 'pStrictErrorHandling', pStrictErrorHandling, 
    'pMode', 'C / D / R / X / M', 'pCube', '', 'pClient', '', 'pGroup', '', 'pDelim', '&', 'pDir', '', 'pSkipNonExistentHoldsCubes', 1 );
EndIf;

#################################################################################################
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
#################################################################################################

# Description:
# This TI process can manage TM1 cube holds. Holds are a personal tool for a TM1 user in any TM1 client.
# A hold by client A does not restrict data entry by client B.
# A client needs write access to a cell in order to apply a hold to the cell.
# Existing Bedrock processes are leveraged including their default parameter values.
#
# Use case: Intended for development/prototyping or in Production environment.
# - When a user has applied holds and logs off (or is forced to log off), the holds are lost (even though the Holds cube still exists)
# - When the TM1 model is restarted, all holds are lost (even though the Holds cube still exists)
# - The customer could provide a set of holds to be applied, in several cubes and to several clients and even data entry groups of clients. Applying the holds manually would be tedious.
# - A regular clean up of Holds cubes that are out of date could be wise
#
# Parameters:
# - pLogOutput (standard Bedrock parameter, Boolean True = 1)
# - pStrictErrorHandling (standard Bedrock parameter, Boolean True = 1)
# - pMode (several options, see below)
# - pCube (mandatory, could be multiple cubes and supports wildcards * and ?)
# - pClient (mandatory or use in conjunction with pGroup, could be multiple clients and supports wildcards * and ?)
# - pGroup (mandatory or use in conjunction with pClient, could be multiple groups and supports wildcards * and ?)
# - pDelim (standard Bedrock parameter to manage above lists, default value if blank = '&')
# - pDir (only used when exporting or importing flat files. If empty, the error file directory is used. If not existing, an error is returned.)
# - pSkipNonExistentHoldsCubes (not used for mode C) (When using lists and wildcards, it can lead to non-existent holds cubes. Use 1 to skip silently.
#
# Supported functionality related to holds:
# - pMode = C: create a holds cube
# - pMode = D: destroy a holds cube
# - pMode = R: release all holds
# - pMode = X: export applied holds to text files
# - pMode = M: import holds from text files (either to be set, either exported earlier)
#
# Note:
# - When exporting holds, the file format will respect the default values of the Bedrock process to export data. The file name is '}Hold_ClientName_}}_%CubeName%.csv so it matches the cubename.
# - To import holds, the file format needs to respect the default values of the Bedrock process to import data. The file name is '}Hold_ClientName_}}_%CubeName%.csv so it matches the cubename.
# - When importing holds, the cell value needs to be either H or C
#   * A value of C is to be put in a consolidated cell of the Holds cube
#   * A value of H is to be put in a level 0 cell of the Holds cube
#   * Any other combination will not lead to an error but TM1 will not apply the hold as intended
# - When importing holds, an additional zeroout should be done with a call to this process with mode 'R'
# - The selections for pClient and pGroup will lead to a list of unique clients, to which the selected mode is applied
#   For a group, the members in the group are retrieved, and added to the selected client(s).
# - At least 1 client should be returned from the provided parameter values, if not the process will abort
# - No support for PAW alternate hierarchies
#
###########################################################

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode = 0;

### Constants ###
cThisProcName     = GetProcessName();
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cTempSub          = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cUserName         = TM1User;
cHoldsCube        = '}Hold_%sClient%_}}_%sCube%';
cMsrDim           = '}Hold';
nCubes            = 0;
nDimMax           = 100;
nErrors           = 0;
sMessage          = '';
cUserName         = TM1User();
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pCube:%pCube%, pClient:%pClient%, pGroup:%pGroup%, pDelim:%pDelim%, pMode:%pMode%, pDir:%pDir%, pSkipNonExistentHoldsCubes:%pSkipNonExistentHoldsCubes%.' ;


## LogOutput parameters
IF( pLogOutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );
ENDIF;

### Validate Parameters ###
nErrors = 0;

## Validate the Cube parameter
If( TRIM(pCube) @= '' );
   sMessage = 'A cube name must be provided.';
   nErrors = nErrors + 1;
   LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# If no clients and groups have been specified then terminate process
If( Trim( pClient ) @= '' & Trim( pGroup ) @= '' );
   nErrors = 1;
   sMessage = 'No groups specified.';
   LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# The mode is a restricted list of actions
If( pMode @<> 'X'
  & pMode @<> 'M'
  & pMode @<> 'R'
  & pMode @<> 'C'
  & pMode @<> 'D' );
    nErrors = 1;
    sMessage = Expand( 'Incorrect value for pMode: %pMode%. Valid values are: X, M, R, C, D' );
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
Else;
    pMode = Upper( Trim( pMode ));
EndIf;

# If blank delimiter specified then convert to default
If( pDelim @= '' );
   pDelim = '&';
EndIf;

# Skipping non-existent holds cubes
If( pSkipNonExistentHoldsCubes <> 1 );
   pSkipNonExistentHoldsCubes = 0;
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 );
      ProcessQuit;
  Else;
      ProcessBreak;
  EndIf;
EndIf;



# # # # # # # # # #        SEARCH FOR CUBES BY INSPECTING CUBE PARAMETER

### Split parameter into individual cubes and store in a temporary subset ###
SubsetCreate( '}Cubes', 'Cubes subset', 1 );

sCubes = pCube;
nDelimiterIndex = 1;
While( nDelimiterIndex <> 0 );
   nDelimiterIndex = Scan( pDelim, sCubes );
   If( nDelimiterIndex = 0 );
      sCube = sCubes;
   Else;
      sCube = Trim( SubSt( sCubes, 1, nDelimiterIndex - 1 ) );
      sCubes = Trim( Delet( sCubes, 1, nDelimiterIndex + Long(pDelim) ) );
   EndIf;

   If( sCube @<> '' );
      # Create subset of cubes. Wildcards could be involved.
      sMDX = '{TM1FilterByPattern( TM1SubsetAll( [}Cubes] ), "' | sCube | '" )}';

      If( SubsetExists( '}Cubes', cTempSub ) = 1 );
         # If a delimited list of cube names includes wildcards then we may have to re-use the subset multiple times
         SubsetMDXSet( '}Cubes', cTempSub, sMDX );
      Else;
         # temp subset, therefore no need to destroy in the Epilog tab
         SubsetCreatebyMDX( cTempSub, sMDX, '}Cubes', 1 );
      EndIf;

      # Loop through cubes in subset created based on wildcard
      nCountCubes = 1;
      While( nCountCubes <= SubsetGetSize( '}Cubes', cTempSub ) );
         sCurrCube = SubsetGetElementName( '}Cubes', cTempSub, nCountCubes );
         # Validate cube name
         If( CubeExists( sCurrCube ) = 1 );
            If( SubsetElementExists( '}Cubes', 'Cubes subset', sCurrCube ) = 0 );
               SubsetElementInsert( '}Cubes', 'Cubes subset', sCurrCube, 0 );
            EndIf;
         EndIf;
         nCountCubes = nCountCubes + 1;
      End;
   EndIf;

End;

# If no cubes found
nFoundCubesCount = SubsetGetSize( '}Cubes', 'Cubes subset' );
If( nFoundCubesCount = 0 );
   nErrors = 1;
   sMessage = 'No cubes found after processing pCube.';
   LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
Else;
   If( pLogOutput = 1 );
      sMessage = 'Number of cubes found that match pCube: ' | NumberToString( nFoundCubesCount );
      LogOutput('INFO', Expand( sMessage ) );
   EndIf;
EndIf;




# # # # # # # # # #        SEARCH FOR CLIENTS BY INSPECTING CLIENTS AND GROUPS PARAMETERS


### Split parameter into individual clients and store in a temporary subset ###
SubsetCreate( '}Clients', 'Clients subset', 1 );

sClients = pClient;
nDelimiterIndex = 1;
While( nDelimiterIndex <> 0 );
   nDelimiterIndex = Scan( pDelim, sClients );
   If( nDelimiterIndex = 0 );
      sClient = sClients;
   Else;
      sClient = Trim( SubSt( sClients, 1, nDelimiterIndex - 1 ) );
      sClients = Trim( Delet( sClients, 1, nDelimiterIndex + Long(pDelim) ) );
   EndIf;

   If( sClient @<> '' );
      # Create subset of clients using Wildcard. Wildcards could be involved.
      sMDX = '{TM1FilterByPattern( TM1SubsetAll( [}Clients] ), "' | sClient | '" )}';

      If( SubsetExists( '}Clients', cTempSub ) = 1 );
         # If a delimited list of client names includes wildcards then we may have to re-use the subset multiple times
         SubsetMDXSet( '}Clients', cTempSub, sMDX );
      Else;
         # temp subset, therefore no need to destroy in the Epilog tab
         SubsetCreatebyMDX( cTempSub, sMDX, '}Clients', 1 );
      EndIf;

      # Loop through clients in subset created based on wildcard
      nCountClients = 1;
      While( nCountClients <= SubsetGetSize( '}Clients', cTempSub ) );
         sCurrClient = SubsetGetElementName( '}Clients', cTempSub, nCountClients );
         # Validate client name
         If( Dimix( '}Clients', sCurrClient ) > 0 );
            If( SubsetElementExists( '}Clients', 'Clients subset', sCurrClient ) = 0 );
               SubsetElementInsert( '}Clients', 'Clients subset', sCurrClient, 0 );
            EndIf;
         EndIf;
         nCountClients = nCountClients + 1;
      End;
   EndIf;

End;


### Split parameter into individual groups and store in a temporary subset ###
SubsetCreate( '}Groups', 'Groups subset', 1 );

sGroups = pGroup;
nDelimiterIndex = 1;
While( nDelimiterIndex <> 0 );
   nDelimiterIndex = Scan( pDelim, sGroups );
   If( nDelimiterIndex = 0 );
      sGroup = sGroups;
   Else;
      sGroup = Trim( SubSt( sGroups, 1, nDelimiterIndex - 1 ) );
      sGroups = Trim( Delet( sGroups, 1, nDelimiterIndex + Long(pDelim) ) );
   EndIf;

   If( sGroup @<> '' );
      # Create subset of groups. Wildcards could be involved.
      sMDX = '{TM1FilterByPattern( TM1SubsetAll( [}Groups] ), "' | sGroup | '" )}';

      If( SubsetExists( '}Groups', cTempSub ) = 1 );
         # If a delimited list of group names includes wildcards then we may have to re-use the subset multiple times
         SubsetMDXSet( '}Groups', cTempSub, sMDX );
      Else;
         # temp subset, therefore no need to destroy in the Epilog tab
         SubsetCreatebyMDX( cTempSub, sMDX, '}Groups', 1 );
      EndIf;

      # Loop through groups in subset created based on wildcard
      nCountGroups = 1;
      While( nCountGroups <= SubsetGetSize( '}Groups', cTempSub ) );
         sCurrGroup = SubsetGetElementName( '}Groups', cTempSub, nCountGroups );
         # Validate group name
         If( Dimix( '}Groups', sCurrGroup ) > 0 );
            If( SubsetElementExists( '}Groups', 'Groups subset', sCurrGroup ) = 0 );
               SubsetElementInsert( '}Groups', 'Groups subset', sCurrGroup, 0 );
            EndIf;
         EndIf;
         nCountGroups = nCountGroups + 1;
      End;
   EndIf;

End;
nFoundGroupsCount = SubsetGetSize( '}Groups', 'Groups subset' );


# Now rework groups into their clients through the security memberships
g = 1;
While( g <= nFoundGroupsCount );

   sGroup = SubsetGetElementName( '}Groups', 'Groups subset', g );

   # Retrieve associated clients
   c = 1;
   While( c <= Dimsiz( '}Clients' ) );
      sClient = Dimnm( '}Clients', c );

      # Retrieve associated clients
      If( CellGetS( '}ClientGroups', sClient, sGroup ) @= sGroup );
         # Add client to the Client subset
         If( SubsetElementExists( '}Clients', 'Clients subset', sClient ) = 0 );
             SubsetElementInsert( '}Clients', 'Clients subset', sClient, 0 );
         EndIf;
      EndIf;
      c = c + 1;
   End;
   g = g + 1;
End;


# If no clients found
nFoundClientsCount = SubsetGetSize( '}Clients', 'Clients subset' );
If( nFoundClientsCount = 0 );
   nErrors = 1;
   sMessage = 'No clients found after processing pClient and pGroup.';
   LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
Else;
   If( pLogOutput = 1 );
      sMessage = 'Number of clients found that match pClient and pGroup: ' | NumberToString( nFoundClientsCount );
      LogOutput('INFO', Expand( sMessage ) );
   EndIf;
EndIf;


### Check for errors before continuing
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 );
      ProcessQuit;
  Else;
      ProcessBreak;
  EndIf;
EndIf;


# A double loop over cubes and clients to apply the selected action
nCountCubes = 1;
While( nCountCubes <= nFoundCubesCount );
   sCube = SubsetGetElementName( '}Cubes', 'Cubes subset', nCountCubes );
   nCubeDimCount = CubeDimensionCountGet( sCube );

   nCountClients = 1;
   While( nCountClients <= nFoundClientsCount );
      sClient = SubsetGetElementName( '}Clients', 'Clients subset', nCountClients );

      sHoldsCube = Expand( cHoldsCube );


      If( pMode @= 'D' );


         # Destroy a Holds cube
         If( CubeExists( sHoldsCube ) = 0 );
            If( pSkipNonExistentHoldsCubes = 0 );
               # nErrors = 1;
               # sMessage = Expand( 'The holds cube ''%sHoldsCube%'' does not exist so it could not be destroyed.' );
               # LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
               # If( pStrictErrorHandling = 1 );
               #     ProcessQuit;
               # Else;
               #     ProcessBreak;
               # EndIf;
               If( pLogOutput = 1 );
                  sMessage = Expand( 'The holds cube ''%sHoldsCube%'' does not exist so it could not be destroyed.' );
                  LogOutput('INFO', Expand( sMessage ) );
               EndIf;
            EndIf;
         Else;

            CubeDestroy( sHoldsCube );
            If( pLogOutput = 1 );
               sMessage = Expand( 'The holds cube ''%sHoldsCube%'' was destroyed.' );
               LogOutput('INFO', Expand( sMessage ) );
            EndIf;
         EndIf;


      ElseIf( pMode @= 'C' );


         # Create a Holds cube
         If( CubeExists( sHoldsCube ) = 1 );
            nErrors = 1;
            sMessage = Expand( 'The holds cube ''%sHoldsCube%'' already exists so it could not be created.' );
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            If( pStrictErrorHandling = 1 );
                ProcessQuit;
            Else;
                ProcessBreak;
            EndIf;
         EndIf;

         If( nCubeDimCount > nDimMax );
            nErrors = 1;
            sMessage = Expand( 'The base cube ''%sCube%'' for the holds cube ''%sHoldsCube%'' contains too many dimensions. ' | NumberToString( nCubeDimCount ) | ' instead of at most ' | NumberToString( nDimMax ) | '.' );
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            If( pStrictErrorHandling = 1 );
                ProcessQuit;
            Else;
                ProcessBreak;
            EndIf;
         EndIf;

         # Create a measures dimension
         If( DimensionExists( cMsrDim ) = 0 );
            If( pLogOutput = 1 );
               sMessage = Expand( 'The measures dimension for hold cubes (%cMsrDim%) does not exist and will be created.' );
               LogOutput('INFO', Expand( sMessage ) );
            EndIf;
            nRet = ExecuteProcess( '}bedrock.hier.create', 'pLogOutput', pLogOutput, 'pStrictErrorHandling', pStrictErrorHandling, 'pDim', cMsrDim );
            If( nRet <> 0 );
               sMessage = Expand( 'Error creating the dimension ''%cMsrDim%''.' );
               nErrors = 1;
               LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
               If( pStrictErrorHandling = 1 );
                  ProcessQuit;
               Else;
                  ProcessBreak;
               EndIf;
            EndIf;
            DimensionElementInsert( cMsrDim, '', 'HoldStatus', 'S' );
         EndIf;

         # Get the dimension names for the hold cube
         sDims = '';
         d = 1;
         While( d <= nCubeDimCount );
            sDim = Tabdim( sCube, d );
            sDims = sDims | pDelim | sDim;
            d = d + 1;
         End;
         sDims = sDims | pDelim | cMsrDim;
         sDims = Delet( sDims, 1, Long( pDelim ));

         nRet = ExecuteProcess( '}bedrock.cube.create', 'pLogOutput', pLogOutput, 'pStrictErrorHandling', pStrictErrorHandling,
              'pCube', sHoldsCube, 'pDims', sDims, 'pRecreate', 0, 'pDelim', pDelim );
         If( nRet <> 0 );
            sMessage = Expand( 'Error creating the cube ''%sHoldsCube%''.' );
            nErrors = 1;
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            If( pStrictErrorHandling = 1 );
               ProcessQuit;
            Else;
               ProcessBreak;
            EndIf;
         EndIf;
         If( pLogOutput = 1 );
            sMessage = Expand( 'The holds cube ''%sHoldsCube%'' was created.' );
            LogOutput('INFO', Expand( sMessage ) );
         EndIf;


      ElseIf( pMode @= 'R' );


         # In an existing Holds cube, delete all holds (Release)
         If( CubeExists( sHoldsCube ) = 0 );
            If( pSkipNonExistentHoldsCubes = 0 );
               nErrors = 1;
               sMessage = Expand( 'The holds cube ''%sHoldsCube%'' does not exist so all of its holds (if any) could not be released.' );
               LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
               If( pStrictErrorHandling = 1 );
                   ProcessQuit;
               Else;
                   ProcessBreak;
                EndIf;
            EndIf;
         Else;

            CubeClearData( sHoldsCube );
            # nRet = ExecuteProcess( '}bedrock.cube.data.clear', 'pLogOutput', pLogOutput, 'pStrictErrorHandling', pStrictErrorHandling,
            #    'pCube', sHoldsCube, 'pView', '', 'pFilter', '', 'pSuppressConsolStrings', 0, 'pCubeLogging', 2 );
            # If( nRet <> 0 );
            #    sMessage = 'Error releasing all the holds in the cube ''%sHoldsCube%''.';
            #    nErrors = 1;
            #    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            #    If( pStrictErrorHandling = 1 );
            #       ProcessQuit;
            #    Else;
            #       ProcessBreak;
            #    EndIf;
            # EndIf;
            If( pLogOutput = 1 );
               sMessage = Expand( 'All the holds in the cube ''%sHoldsCube%'' were released.' );
               LogOutput('INFO', Expand( sMessage ) );
            EndIf;

         EndIf;


      ElseIf( pMode @= 'X' );


         # From an existing Holds cube, export all entries
         If( CubeExists( sHoldsCube ) = 0 );
            If( pSkipNonExistentHoldsCubes = 0 );
               nErrors = 1;
               sMessage = Expand( 'The holds cube ''%sHoldsCube%'' does not exist so all of its holds (if any) could not be exported.' );
               LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
               If( pStrictErrorHandling = 1 );
                  ProcessQuit;
               Else;
                  ProcessBreak;
               EndIf;
            EndIf;
         Else;

            If( nCubeDimCount > nDimMax );
               nErrors = 1;
               sMessage = Expand( 'The base cube ''%sCube%'' for the holds cube ''%sHoldsCube%'' contains too many dimensions. ' | NumberToString( nCubeDimCount ) | ' instead of at most ' | NumberToString( nDimMax ) | '.' );
               LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
               If( pStrictErrorHandling = 1 );
                   ProcessQuit;
               Else;
                   ProcessBreak;
               EndIf;
            EndIf;

            # the file directory (If empty, the error file directory is used. If not existing, an error is returned.)
            #    this is done by the called Bedrock process
            # the file name is simply the Holds cube name with file extension csv
            sFileName = sHoldsCube | '.csv';
            nRet = ExecuteProcess( '}bedrock.cube.data.export', 'pLogOutput', pLogOutput, 'pStrictErrorHandling', pStrictErrorHandling,
               'pCube', sHoldsCube, 'pView', '', 'pFilter', '', 'pSuppressConsol', 0, 'pSuppressConsolStrings', 0,
               'pCubeLogging', 2, 'pFilePath', pDir, 'pFileName', sFileName );
            If( nRet <> 0 );
               sMessage = Expand( 'Error exporting all the holds from the cube ''%sHoldsCube%'' to a flat file.' );
               nErrors = 1;
               LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
               If( pStrictErrorHandling = 1 );
                  ProcessQuit;
               Else;
                  ProcessBreak;
               EndIf;
            EndIf;
            If( pLogOutput = 1 );
               sMessage = Expand( 'All the holds in the cube ''%sHoldsCube%'' were exported.' );
               LogOutput('INFO', Expand( sMessage ) );
            EndIf;
         EndIf;


      ElseIf( pMode @= 'M' );


         # To an existing Holds cube, import all entries
         # If the Holds cube does not exist, you need to create it first with mode C
         If( CubeExists( sHoldsCube ) = 0 );
            If( pSkipNonExistentHoldsCubes = 0 );
               nErrors = 1;
               sMessage = Expand( 'The holds cube ''%sHoldsCube%'' does not exist so holds (if any) could not be imported. You might want to create it first using mode ''C''.' );
               LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
               If( pStrictErrorHandling = 1 );
                  ProcessQuit;
               Else;
                  ProcessBreak;
               EndIf;
            EndIf;
         Else;

            # the file directory (If empty, the error file directory is used. If not existing, an error is returned.)
            #    this is done by the called Bedrock process
            # the file name is simply the Holds cube name with file extension csv
            sFileName = sHoldsCube | '.csv';
            nRet = ExecuteProcess( '}bedrock.cube.data.import', 'pLogOutput', pLogOutput, 'pStrictErrorHandling', pStrictErrorHandling,
               'pCube', sHoldsCube, 'pSrcDir', pDir, 'pSrcFile', sFileName, 'pCubeLogging', 2, 'pFileDelete', 0, 'pSkipInvalidRecords', 0 );
            If( nRet <> 0 );
               sMessage = Expand( 'Error importing all the holds to the cube ''%sHoldsCube%'' from a flat file.' );
               nErrors = 1;
               LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
               If( pStrictErrorHandling = 1 );
                  ProcessQuit;
               Else;
                  ProcessBreak;
               EndIf;
            EndIf;
            If( pLogOutput = 1 );
               sMessage = Expand( 'All the holds were imported to the cube ''%sHoldsCube%''.' );
               LogOutput('INFO', Expand( sMessage ) );
            EndIf;
         EndIf;
      EndIf;

      nCountClients = nCountClients + 1;
   End;

   nCountCubes = nCountCubes + 1;
End;
573,1

574,1

575,22

#################################################################################################
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
#################################################################################################

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
   sProcessAction = Expand( 'Process:%cThisProcName% successfully performed %pMode% for cube ''%pCube%'', with client ''%pGroup%'' and group ''%pGroup%''.' );
   sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
   nProcessReturnCode = 1;
   If( pLogOutput = 1 );
      LogOutput('INFO', Expand( sProcessAction ) );
   EndIf;
EndIf;
576,_ParameterConstraints=e30=
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
