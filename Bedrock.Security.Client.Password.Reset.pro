601,100
562,"NULL"
586,
585,
564,
565,"eJ93Mae1mF;6=1p@Jd?^4D]5vh]pWR@v]bOtBD><7mc@KJEuRWnU\8:z^tA=[5q;RTjk48Js\e\DrU;i9VeN6e1jWMaK_KgS5fxTb6qVQ7n2tBQtF4CGfhK`UORkPR`2KFhPy4YXBxT3xbtQWgTr_[jYhS[Figmhn0P`nVtkT>xux@EAUHF[ax7s83EsS:4L;ejZ:4M0"
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
pClients
pPassword
pDelimiter
pDebug
561,4
2
2
2
1
590,4
pClients,""
pPassword,""
pDelimiter,"&"
pDebug,0.
637,4
pClients,Client Names Seperated by Delimiter
pPassword,New Password
pDelimiter,Delimiter character
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,91

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################

# This process can be used by admins to reset a client password.
# If called from a workbook/websheet in conjunction with the TM1User function
# can also be used by users to change their password


### Constants ###

cProcess = 'Bedrock.Security.Client.Create';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.';


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pClients   : ' | pClients );
  AsciiOutput( sDebugFile, '            pPassword  : *** Not logged for security reasons ***' );
  AsciiOutput( sDebugFile, '            pDelimiter : ' | pDelimiter );

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


### Split pClients into individual clients and reset password ###

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
  # Don't attempt to update a blank client
  If( sClient @<> '' );
    If( DimIx( '}Clients', sClient ) <> 0 );
      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, 'Client: ' | sClient | ' OK' );
      EndIf;
      If( pDebug <= 1 );
        sClient = DimensionElementPrincipalName( '}Clients', sClient );
        AssignClientPassword( sClient, pPassword );
      EndIf;
    Else;
      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, 'Client: ' | sClient | ' does not exist' );
      EndIf;
    EndIf;
  EndIf;
End;


### End Prolog ###
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,35

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
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
