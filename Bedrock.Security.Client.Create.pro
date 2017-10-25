601,100
602,"Bedrock.Security.Client.Create"
562,"NULL"
586,
585,
564,
565,"cT1anpU1]Mu2:mczsHxY;Yb:Ox7IU`bAa03Z=<OuNO?_WxN28@[poc25AvS5yQoYOvO0[p^;;<vRzYVZc\<YkQIG9covAFlYPRhpBKNZ@f@z\uJy7D:_fRe>l7PBix7?`yMid5e2:Jlg<:PikULFMRG;qOrWA<uA57]niSq=2w3s`Wg?`]WVWa_i6JLjWfBZJ5X_z:PX"
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
560,5
pClients
pPassword
pMaxPorts
pDelimiter
pDebug
561,5
2
2
1
2
1
590,5
pClients,""
pPassword,""
pMaxPorts,5
pDelimiter,"&"
pDebug,0
637,5
pClients,List of Clients Seperated by Delimiter
pPassword,Initial Password
pMaxPorts,Maximum Ports
pDelimiter,Delimiter
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,98

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will create clients, assign a password and max ports

# Notes:
# - Multiple clients can be specified seperated by a delimiter
# - If client already exists then the process will not attempt to re-create it but will reset password and max ports


### Constants ###

cProcess = 'Bedrock.Security.Client.Create';
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
  AsciiOutput( sDebugFile, 'Parameters: pClients: ' | pClients );
  AsciiOutput( sDebugFile, '            pPassword: ' | pPassword );
  AsciiOutput( sDebugFile, '            pMaxPorts: ' | NumberToString( pMaxPorts ) );
  AsciiOutput( sDebugFile, '            pDelimiter: ' | pDelimiter );

EndIf;


### Validate Parameters ###

nErrors = 0;

# If blank delimiter specified then convert to default
If( pDelimiter @= '' );
  pDelimiter = '&';
EndIf;

# If no clients have been specified then terminate process
If( Trim( pClients ) @= '' );
  nErrors = 1;
  sMessage = 'No clients specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;


### Split pClients into individual Clients and add ###

sClients = pClients;
nDelimiterIndex = 1;

While( nDelimiterIndex <> 0 );
  nDelimiterIndex = Scan( pDelimiter, sClients );
  If( nDelimiterIndex = 0 );
    sClient = sClients;
  Else;
    sClient = Trim( SubSt( sClients, 1, nDelimiterIndex - 1 ) );
    sClients = Trim( Subst( sClients, nDelimiterIndex + Long(pDelimiter), Long( sClients ) ) );
  EndIf;
  # Don't attempt to add a blank client
  If( sClient @<> '' );
    If( DimIx( '}Clients', sClient ) = 0 );
      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, 'Client: ' | sClient | ' OK' );
      EndIf;
      If( pDebug <= 1 );
        AddClient( sClient );
      EndIf;
    Else;
      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, 'Client: ' | sClient | ' already exists' );
      EndIf;
    EndIf;
  EndIf;
End;

If( pDebug <= 1 );
  DimensionSortOrder( '}Clients', 'ByName', 'Ascending', 'ByName' , 'Ascending' );
EndIf;


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,66

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';

EndIf;


### Update password and max ports ###

If( pDebug <= 1 );

  sClients = pClients;
  nDelimiterIndex = 1;

  While( nDelimiterIndex <> 0 );
    nDelimiterIndex = Scan( pDelimiter, sClients );
    If( nDelimiterIndex = 0 );
      sClient = sClients;
    Else;
      sClient = Trim( SubSt( sClients, 1, nDelimiterIndex - 1 ) );
      sClients = Trim( Subst( sClients, nDelimiterIndex + Long(pDelimiter), Long( sClients ) ) );
    EndIf;
    If( DimIx( '}Clients', sClient ) <> 0 );
      AssignClientPassword( sClient, pPassword );
      CellPutN( pMaxPorts, '}ClientProperties', sClient, 'MaximumPorts' );
    EndIf;
  End;

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
