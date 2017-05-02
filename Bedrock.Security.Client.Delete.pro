601,100
562,"NULL"
586,
585,
564,
565,"tW5@k0t94wgkdbINOLf5aWTs3qu^:wuRvabBZB4KrtUDZV9]`4R@HL@4fJhbwB;XfH\FGU:AvIE4fj;?>cd_[Uqj`k6RMbAwQx8TXUyte3ScY;q43`_H=U1hLW444^zS5[t;OYuiF5]zw\yp@F\YgEv_KXGt^<GZo3\ev]cd>jVy1cnWvsHjloI=HwyWGunjXuruuIoG"
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
pClients
pDelimiter
pDebug
561,3
2
2
1
590,3
pClients,""
pDelimiter,"&"
pDebug,0.
637,3
pClients,Clients seperated by delimiter (e.g. Client1&Client2)
pDelimiter,Delimiter
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,96

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################

# This process will delete clients

# Notes:
# - Multiple clients can be specified seperated by a delimiter
# - If client does not exist then it will be skipped.
# - If multiple clients are specified and some don't exist and some do, then the ones that do exist will still be deleted


### Constants ###

cProcess = 'Bedrock.Security.Client.Delete';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.';


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pClients: ' | pClients );
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


### Split pClients into individual clients and delete ###

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
  # Don't attempt to delete a blank client
  If( sClient @<> '' );
    If( DimIx( '}Clients', sClient ) <> 0 );
      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, 'Client: ' | sClient | ' OK' );
      EndIf;
      If( pDebug <= 1 );
        DeleteClient( sClient );
      EndIf;
    Else;
      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, 'Client: ' | sClient | ' does not exist' );
      EndIf;
    EndIf;
  EndIf;
End;

If( pDebug <= 1 );
  DimensionSortOrder( '}Clients', 'ByName', 'Ascending', 'ByName' , 'Ascending' );
EndIf;


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
