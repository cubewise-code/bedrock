601,100
602,"Bedrock.Security.Client.Clone"
562,"NULL"
586,
585,
564,
565,"d2lea;pnwUs=R03HF:WJ5DmmkvpHvLbN4ZKwCne6MtuhUX4]8Dtnq\n9svI\RF\uqkzCGd2WNR^@@QNJIFd?:3y4PBlSX0N^dbCs<_:@Cjq;=A0g]qs[gX0FEQA2GNAg@vx=w2v[i\wDMCS=E@?d<K1T1zSNzddzAbZXwDeSK1xy<h7xL6zIHlYAJpQXI<pIaNsdP8`1"
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
pSourceClient
pTargetClient
pMode
pDelimiter
pDebug
561,5
2
2
2
2
1
590,5
pSourceClient,""
pTargetClient,""
pMode,"REPLACE"
pDelimiter,"&"
pDebug,0
637,5
pSourceClient,"Source Client"
pTargetClient,"List of Target Clients Seperated by Delimiter"
pMode,"Mode REPLACE or ADD (default = REPLACE)"
pDelimiter,"Delimiter (if a list of target users)"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,125

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will copy security from one user to another

# Notes:
# - Multiple clients can be specified seperated by a delimiter
# - If client doesn't already exist then Bedrock.Security.Client.Create will be called
# - The process has 2 modes REPLACE (default) clears any existing group memberships. ADD only adds new ones.


### Constants ###

cProcess = 'Bedrock.Security.Client.Clone';
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
  AsciiOutput( sDebugFile, 'Parameters: pSourceClient: ' | pSourceClient );
  AsciiOutput( sDebugFile, '            pTargetClient: ' | pTargetClient );
  AsciiOutput( sDebugFile, '            pMode: ' | pMode );
  AsciiOutput( sDebugFile, '            pDelimiter: ' | pDelimiter );

EndIf;


### Validate Parameters ###

nErrors = 0;

# If blank delimiter specified then convert to default
If( pDelimiter @= '' );
  pDelimiter = '&';
EndIf;

# If blank mode specified then convert to default
If( pMode @= '' );
  pMode = 'REPLACE';
EndIf;

# If unsupported mode specified then abort
If( pMode @= 'ADD' % pMode @= 'REPLACE' );
  # all is OK
Else; 
  nErrors = 1;
  sMessage = 'Invalid mode specified. Must be ADD or REPLACE';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# If no source client has been specified then terminate process
If( Trim( pSourceClient ) @= '' );
  nErrors = 1;
  sMessage = 'No source client specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
ElseIf( DimIx( '}Clients', pSourceCLient ) = 0 );
  nErrors = 1;
  sMessage = 'Source client does not exist';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# If no target clients have been specified then terminate process
If( Trim( pTargetClient ) @= '' );
  nErrors = 1;
  sMessage = 'No target client(s) specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

### Split pClients into individual Clients and add only if they don't exist ###

sClients = pTargetClient;
nDelimiterIndex = 1;

# loop delimited string of target clients
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
        AsciiOutput( sDebugFile, 'Adding Client: ' | sClient );
      EndIf;
      If( pDebug <= 1 );
        ExecuteProcess( 'Bedrock.Security.Client.Create', 'pClients', sClient, 'pDebug', pDebug );
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

575,79

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

### If errors occurred terminate process with a major error status ###

If( nErrors <> 0 );
  ProcessQuit;
EndIf;

### Update group memberships ###

If( pDebug <= 1 );

  sClients = pTargetClient;
  nDelimiterIndex = 1;

  # loop delimited string of target clients
  While( nDelimiterIndex <> 0 );
    nDelimiterIndex = Scan( pDelimiter, sClients );
    If( nDelimiterIndex = 0 );
      sClient = sClients;
    Else;
      sClient = Trim( SubSt( sClients, 1, nDelimiterIndex - 1 ) );
      sClients = Trim( Subst( sClients, nDelimiterIndex + Long(pDelimiter), Long( sClients ) ) );
    EndIf;
    If( DimIx( '}Clients', sClient ) >= 1 );
      # loop all security groups
      nGroupIndex = 1;
      nMaxGroups = DimSiz( '}Groups' );
      While( nGroupIndex <= nMaxGroups );
        sGroup = DimNm( '}Groups', nGroupIndex );
        If( sGroup @= CellGetS( '}ClientGroups', pSourceClient, sGroup ) );
          AssignClientToGroup( sClient, sGroup );
        Else;
          If( pMode @= 'REPLACE' );
            # don't need to check if user in group. If user not in group then no error with RemoveClientFromGroup function
            RemoveClientFromGroup( sClient, sGroup );
          EndIf;
        EndIf;
        nGroupIndex = nGroupIndex + 1;
      # exit loop of }Groups 
      End;
    EndIf;
  # exit loop of target clients 
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
