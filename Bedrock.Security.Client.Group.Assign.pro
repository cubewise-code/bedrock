601,100
602,"Bedrock.Security.Client.Group.Assign"
562,"NULL"
586,
585,
564,
565,"ta<jRYTAn[`uG9sPMUr3aaXh5w><GVG<]g5K_7lu6b4fURE]rt;KvueyW:MJg]ORWKln<V4;P;dVA`m[AXAmruxR^``o1g\jrDf=r>jm=eCQq4QosIO>IF?CEu[UTsHB90Q5=u16Fs1s?1p`i@[h0qv[Yq8@6e:]3rJsMHkZy3cZGktHqISkY]Cl:3sYAdrAzAJSgdN_"
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
560,6
pClients
pGroups
pDelimiter
pAddOrRemove
pSecurityRefresh
pDebug
561,6
2
2
2
2
2
1
590,6
pClients,""
pGroups,""
pDelimiter,"&"
pAddOrRemove,"Add"
pSecurityRefresh,"Yes"
pDebug,0
637,6
pClients,Client Names Seperated by Delimiter
pGroups,Group Names Seperated by Delimiter
pDelimiter,Delimiter
pAddOrRemove,Add or Remove
pSecurityRefresh,Refresh Security?
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,180

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will assign Client and Group Security

# Notes:
# - This process can either add or remove clients to groups based on pAddOrRemove
# - This process can work on a single client or multiple clients seperated by a delimiter
# - This process can work on a single group or multiple groups seperated by a delimiter
# - Therefore, it can be used to:
#   - Add/remove a single client to/from a single group
#   - Add/remove many clients to/from a single group
#   - Add/remove a single client to/from many groups
#   - Add/remove many clients to/from many groups
# - The caller can choose whether or not to refresh security at the end. Default is yes


### Constants ###

cProcess = 'Bedrock.Security.Client.Group.Assign';
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
  AsciiOutput( sDebugFile, 'Parameters: pClients         : ' | pClients );
  AsciiOutput( sDebugFile, '            pGroups          : ' | pGroups );
  AsciiOutput( sDebugFile, '            pAddOrRemove     : ' | pAddOrRemove );
  AsciiOutput( sDebugFile, '            pSecurityRefresh : ' | pSecurityRefresh );
  AsciiOutput( sDebugFile, '            pDelimiter       : ' | pDelimiter );

EndIf;


### Validate Parameters ###

nErrors = 0;

# If no clients have been specified then terminate process
If( Trim( pClients ) @= '' );
  nErrors = 1;
  sMessage = 'No clients specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# If no groups have been specified then terminate process
If( Trim( pGroups ) @= '' );
  nErrors = 1;
  sMessage = 'No groups specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# If pSecurityRefresh is blank then default to yes
If( Trim( pSecurityRefresh ) @= '' );
  pSecurityRefresh = 'Yes';
EndIf;

# If pAddOrDelete has not been specified correctly then terminate process
If( Upper( pAddOrRemove ) @<> 'ADD' & Upper( pAddOrRemove ) @<> 'REMOVE' );
  nErrors = 1;
  sMessage = 'Incorrect value for pAddOrRemove: ' | pAddOrRemove | '. Valid values are Add or Remove';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# If pSecurityRefresh has not been specified correctly then terminate process
If( Upper( pSecurityRefresh ) @<> 'YES' & Upper( pSecurityRefresh ) @<> 'NO' );
  nErrors = 1;
  sMessage = 'Incorrect value for pSecurityRefresh: ' | pSecurityRefresh | '. Valid values are Yes or No';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# If blank delimiter specified then convert to default
If( pDelimiter @= '' );
  pDelimiter = '&';
EndIf;


### Add/remove clients to/from groups ###

# Loop through list of clients
sClients = pClients;
nClientDelimIndex = 1;

While( nClientDelimIndex <> 0 );
  nClientDelimIndex = Scan( pDelimiter, sClients );
  If( nClientDelimIndex = 0 );
    sClient = sClients;
  Else;
    sClient = Trim( SubSt( sClients, 1, nClientDelimIndex - 1 ) );
    sClients = Trim( Subst( sClients, nClientDelimIndex + Long(pDelimiter), Long( sClients ) ) );
  EndIf;
  # Don't attempt to process a blank client
  If( sClient @<> '' );
    # Check that client exists
    If( DimIx( '}Clients', sClient ) <> 0 );

      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, 'Client: ' | sClient | ' OK' );
      EndIf;

      # Loop through list of Groups
      sGroups = pGroups;
      nGroupDelimIndex = 1;

      While( nGroupDelimIndex <> 0 );
        nGroupDelimIndex = Scan( pDelimiter, sGroups );
        If( nGroupDelimIndex = 0 );
          sGroup = sGroups;
        Else;
          sGroup = Trim( SubSt( sGroups, 1, nGroupDelimIndex - 1 ) );
          sGroups = Trim( Subst( sGroups, nGroupDelimIndex + Long(pDelimiter), Long( sGroups ) ) );
        EndIf;
        # Don't attempt to process a blank Group
        If( sGroup @<> '' );
          # Check that group exists
          If( DimIx( '}Groups', sGroup ) <> 0 );

            If( pDebug >= 1 );
              AsciiOutput( sDebugFile, 'Group: ' | sGroup | ' OK' );
            EndIf;

            # Add/Remove Client
            If( Upper( pAddOrRemove ) @= 'ADD' );
              AssignClientToGroup( sClient, sGroup );
            ElseIf( Upper( pAddOrRemove ) @= 'REMOVE' );
              RemoveClientFromGroup( sClient, sGroup );
            EndIf;

          Else;
            If( pDebug >= 1 );
              AsciiOutput( sDebugFile, 'Group: ' | sGroup | ' does not exist' );
            EndIf;
          EndIf;
        EndIf;
      End;
    Else;
      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, 'Client: ' | sClient | ' does not exist' );
      EndIf;
    EndIf;
  EndIf;
End;


### Refresh Security ###

If( Upper( pSecurityRefresh ) @= 'YES' );
  SecurityRefresh;
EndIf;


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
