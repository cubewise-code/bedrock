601,100
602,"Bedrock.Security.Cube.CellSecurity.Destroy"
562,"NULL"
586,
585,
564,
565,"mUYrKs^:OZki2z]vYflQFuq55KoYpPKursuI=81^CPrrqZeVc0gYYnSRhWin@H:U9r@{V@RV3dY1X[aVZ;2NS<r]uGe3^2fVVm<saCtwytyOoG{uY_1\JU`B3eSfSgTee?@JcFFhR6iLKwm0GwcRviq84ezh\@MOP3G4k6TA0w=Jo8m=bM@xQ@^A\K_9cXFIyY52`CzxmUYrKs^:OZki2t]vYflQFuq55KoYpPK5xsuI=81^CPrrqZhVc0gYYnSRh'O`@HjR9r@[Q@RV3di=X;dVZ;2NS<r]uGu2^2fVVm<3mCtwytyOoGK4U_1\JU`B3eSfSnXeeoFjmFFhR6ilFwm@Iwcrxiq84ezh\@MOP3w5k64M0w=J/;m=bM@xQPPA\K_9cXJIsY52`Czx"
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
560,3
pCubes
pDelimiter
pDebug
561,3
2
2
1
590,3
pCubes,""
pDelimiter,"&"
pDebug,0
637,3
pCubes,"List of cubes separated by delimiter"
pDelimiter,"Delimiter"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,110

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2015 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will destroy cell security cubes for the specified list of cubes

# Notes:
# - Multiple cubes can be specified seperated by a delimiter


### Constants ###

cProcess = 'Bedrock.Security.Cube.CellSecurity.Destroy';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;
DatasourceASCIIQuoteCharacter = '';


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCubes: ' | pCubes );
  AsciiOutput( sDebugFile, '            pDelimiter: ' | pDelimiter );
  AsciiOutput( sDebugFile, '' );

EndIf;


### Validate Parameters ###

nErrors = 0;

# If blank delimiter specified then convert to default
If( pDelimiter @= '' );
  pDelimiter = '&';
EndIf;

# If no cubes have been specified then terminate process
If( Trim( pCubes ) @= '' );
  nErrors = 1;
  sMessage = 'No cubes specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;


### Split pCubes into individual Cubes  ###

sCubes = pCubes;
nDelimiterIndex = 1;

While( nDelimiterIndex <> 0 );
  nDelimiterIndex = Scan( pDelimiter, sCubes );
  If( nDelimiterIndex = 0 );
    sCube = sCubes;
  Else;
    sCube = Trim( SubSt( sCubes, 1, nDelimiterIndex - 1 ) );
    sCubes = Trim( Subst( sCubes, nDelimiterIndex + Long(pDelimiter), Long( sCubes ) ) );
  EndIf;
  # Don't attempt to destroy a cube where none specified
  If( sCube @<> '' );
    If( CubeExists( sCube ) = 1 );
      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, 'Cube: ' | sCube | ' exists' );
      EndIf;
      If( CubeExists( '}CellSecurity_' | sCube ) = 1 );
         If( pDebug >= 1 );
            AsciiOutput( sDebugFile, 'Cube: ' |  '}CellSecurity_' | sCube | ' exists' );
         EndIf;
         If( pDebug <= 1 );
            nRet = CellSecurityCubeDestroy( sCube );
            If( nRet = 1 );
               sMsg = '}CellSecurity_' | sCube | ' successfully destroyed';
            Else;
               sMsg = 'Error. Could not destroy }CellSecurity_' | sCube;
            EndIf;
            If( pDebug >= 1 );
               AsciiOutput( sDebugFile, sMsg );
            EndIf;
         EndIf;
      Else;
         If( pDebug >= 1 );
            AsciiOutput( sDebugFile, 'Cube: ' |  '}CellSecurity_' | sCube | ' does not exist' );
         EndIf;
      EndIf;
    Else;
      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, 'Cube: ' | sCube | ' does not exist' );
      EndIf;
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

575,42

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2015 www.bedrocktm1.org/how-to-licence.php Ver 3.0.2~~##
#####################################################################################


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
