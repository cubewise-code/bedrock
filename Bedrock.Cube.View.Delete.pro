601,100
562,"NULL"
586,
585,
564,
565,"yWdtaT\Vk7j8MMy3jHaX24_vIaRYdYQ?BH8<Jij78OjguSN_kRybeJ2qATs_JGayxTsd=1t8pts^^hHZo57@N==jkhG`0xLfY50b_]vJCZbOaSVu7t>=pWakxM[EV>?^E@L]Hnv35vs=3>tYZya6pNJE8DwP=QV^kQAcl9pNG\UrHUT[ewFaA6zzrHhVCaNr>zQ7f;GS"
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
pCubes
pViews
pDelimiter
pDebug
561,4
2
2
2
1
590,4
pCubes,""
pViews,"}Bedrock*"
pDelimiter,"&"
pDebug,0.
637,4
pCubes,List of Cubes Separated by Delimiter (Blank = All Cubes)
pViews,List of Views Separated by Delimiter. Wildcards Permitted on View Names.
pDelimiter,Delimiter Character
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,196

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process deletes public views

# Notes:
# - This process can work on a single cubes or multiple cubes
# - This process can work on a single view or multiple views
# - When specifying view names wildcards can be specified by using the * character

# Parameters:
# - pCubes:
#   - To specify which cubes to delete views from use the pCubes parameter
#   - To delete views from a single cube only just specify that cube name e.g. Sales
#   - To delete views from multiple cubes specify each cube name seperated by a delimiter e.g. Sales;Inventory;Cashflow
#   - To delete views from all cubes then leave pCubes parameter blank
#   - If any invalid cubes are specified they will be skipped but the process will continue to process the other cubes
# - pViews:
#   - To specify which views to delete use the pViews parameter
#   - This parameter must be specified, a blank value will cause the process to terminate
#   - To delete a single view only just specify that view name e.g. SalesByProduct
#   - To delete multiple views specify each view name seperated by a delimiter e.g. SalesByProduct;SalesByManager;SalesByStore
#   - When specifying view names wildcards are permitted and all views that match the wildcard search string will be deleted
#     - The wildcard search string follows the same format as windows based file wildcards
#     - To delete all views that "start" with a specific string use a trailing * e.g. Bedrock*
#     - To delete all views that "end" in a specific string use a leading * e.g. *Bedrock
#     - To delete all views that "contain" a specific string use leading and trailing *'s e.g. *Bedrock*
#     - To delete a single specific view only don't use *'s at all e.g. Bedrock
#     - To specify multiple search stings list them all seperated by a delimiter e.g. Bedrock*;*Temp;*Test*
#   - Specific view names and wildcard based names can both be used together e.g. SalesByProduct;Bedrock*
# - pDelimiter:
#   - The delimiter is used when specifying multiple cubes and/or multiple views
#   - The default delimiter is ;
#   - Any delimiter can be used by specifying a value for pDelimiter
#   - Choose a delimiter that won't be used in either the wildcard search strings or cube names


### Constants ###

cProcess = 'Bedrock.Cube.View.Delete';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;

cDimension = '}Cubes';


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCubes     : ' | pCubes );
  AsciiOutput( sDebugFile, '            pViews     : ' | pViews );
  AsciiOutput( sDebugFile, '            pDelimiter : ' | pDelimiter );

EndIf;


### Validate Parameters ###

nErrors = 0;

# Validate views
If( Trim( pViews ) @= '' );
  nErrors = 1;
  sMessage = 'No views specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Validate delimiter
If( Trim( pDelimiter ) @= '' );
  pDelimiter = '&';
EndIf;


### Iterate through cubes ###

# If no cube has been specified then process all cubes
If( Trim( pCubes ) @= '' );

  nElemTotal = DimSiz( cDimension );
  nElemIndex = 1;

  While( nElemIndex <= nElemTotal );
    # Determine cube name
    sCube = DimNm( cDimension, nElemIndex );
    # Exclude control cubes
    If( SubSt( sCube, 1, 1 ) @<> '}' );
      If( Trim( pCubes ) @= '' );
        pCubes = sCube;
      Else;
        pCubes = pCubes | pDelimiter | sCube;
      EndIf;
    EndIf;
    nElemIndex = nElemIndex + 1;
  End;

EndIf;

# Work through all cubes specified in pCubes
sCubes = pCubes;
nCubeDelimIndex = 1;

While( nCubeDelimIndex <> 0 );

  nCubeDelimIndex = Scan( pDelimiter, sCubes  );
  If( nCubeDelimIndex = 0 );
    sCube = Trim( sCubes );
  Else;
    sCube = Trim( SubSt( sCubes, 1, nCubeDelimIndex - 1 ) );
    sCubes = Trim( SubSt( sCubes, nCubeDelimIndex + Long( pDelimiter ), Long( sCubes ) ) );
  EndIf;

  # If a valid cube has been specified then delete specified views from it
  If( CubeExists( sCube ) = 1 );

    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, 'Cube: ' | sCube | ' OK' );
    EndIf;

    # Work through all views specified in pViews
    sViews = pViews;
    nViewDelimIndex = 1;

    While( nViewDelimIndex <> 0 );
      nViewDelimIndex = Scan( pDelimiter, sViews );
      If( nViewDelimIndex = 0 );
        sView = sViews;
      Else;
        sView = SubSt( sViews, 1, nViewDelimIndex - 1 );
        sViews = SubSt( sViews, nViewDelimIndex + Long( pDelimiter ), Long( sViews ) );
      EndIf;

      # Check if a wildcard has been used to specify the view name.
      # If it hasn't then just delete the view if it exists
      # If it has then search the relevant views folder to find the matches
      If( Scan( '*', sView ) = 0 );
        If( ViewExists( sCube, sView ) = 1 );
          If( pDebug >= 1 );
            AsciiOutput( sDebugFile, 'View: ' | sView | ' OK' );
          EndIf;
          If( pDebug <= 1 );
            ViewDestroy( sCube, sView );
          EndIf;
        EndIf;
      Else;
        # Wildcard search string
        sSearch = '.\' | sCube | '}vues\' | sView | '.vue';

        # Find all views that match search string
        sFilename = WildcardFileSearch( sSearch, '' );
        While( sFilename @<> '' );
          # Trim .vue off the filename
          sView = SubSt( sFilename, 1, Long( sFilename ) - 4 );
          # Delete view
          If( ViewExists( sCube, sView ) = 1 );
            If( pDebug >= 1 );
              AsciiOutput( sDebugFile, 'View: ' | sView | ' OK' );
            EndIf;
            If( pDebug <= 1 );
              ViewDestroy( sCube, sView );
            EndIf;
          EndIf;
          sFilename = WildcardFileSearch( sSearch, sFilename );
        End;
      EndIf;
    End;

  # Cube does not exist
  Else;

    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, 'Cube: ' | sCube | ' does not exist' );
    EndIf;

  EndIf;

End;


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
