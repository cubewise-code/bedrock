601,100
602,"Bedrock.Security.Object.Assign"
562,"NULL"
586,
585,
564,
565,"h>w^ymf`ay15[<=Maxih=4RO80ynP1SR]tFVAi1TtbVQREM83sYH@jn0>tWsrh\MKyuSK?z^\:TE_[61UW1mnnVh\ql@x=e:yC]\AW\lAAWd`JX1`qN0I=4B7D[U9rAL5CiiE?C5hq:gC6?nLewEKbcv5dnU7AcZ9ULRG:2x_4:a`pC4Xf`Y5NrTaehfGnEX2?GRXMZ>"
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
560,7
pGroups
pObjectType
pObjects
pSecurityLevel
pSecurityRefresh
pDelimiter
pDebug
561,7
2
2
2
2
2
2
1
590,7
pGroups,""
pObjectType,""
pObjects,""
pSecurityLevel,""
pSecurityRefresh,"No"
pDelimiter,"&"
pDebug,0
637,7
pGroups,List of Groups Seperated by Delimiter
pObjectType,Type of Object to Assign Security To (Application/Cube/Dimension/Process/Chore)
pObjects,List of Objects Seperated by Delimiter
pSecurityLevel,Security Level (Read/Write/Admin/None)
pSecurityRefresh,Refresh Security? (Default = No)
pDelimiter,Delimiter
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,237

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will assign security to specified object

# Note:
# - Before using this process, you must first initialise object security.
# - For Applications, in Server Explorer go to Applications -> Security Assignments and assign
#   an access security for an Application. For other object types follow a similar process but for that object type
# - Then from the Server Explorer go to your ServerName -> Security -> Refresh Security
# - Multiple groups can be specified seperated by delimiter
# - Multiple objects can be specified seperated by delimiter
# - If groups and/or objects that don't exist are specified, then they will be skipped but
#   valid groups and ojects will still be processed


### Constants ###

cProcess = 'Bedrock.Security.Object.Assign';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;
cSecurityCube = '}' | pObjectType | 'Security';


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pGroups          : ' | pGroups );
  AsciiOutput( sDebugFile, '            pObjectType      : ' | pObjectType );
  AsciiOutput( sDebugFile, '            pObjects         : ' | pObjects );
  AsciiOutput( sDebugFile, '            pSecurityLevel   : ' | pSecurityLevel );
  AsciiOutput( sDebugFile, '            pSecurityRefresh : ' | pSecurityRefresh );
  AsciiOutput( sDebugFile, '            pDelimiter       : ' | pDelimiter );

EndIf;


### Validate Parameters ###

nErrors = 0;

# If no groups have been specified then terminate process
If( Trim( pGroups ) @= '' );
  nErrors = 1;
  sMessage = 'No groups specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Validate Object Type
If( pObjectType @<> 'Application' & pObjectType @<> 'Cube' & pObjectType @<> 'Dimension' & pObjectType @<> 'Process' & pObjectType @<> 'Chore' );
  nErrors = 1;
  sMessage = 'Invalid object type specified: ' | pObjectType | '. Valid object types are: Application, Cube, Dimension, Process and Chore';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# If no objects have been specified then terminate process
If( Trim( pObjects ) @= '' );
  nErrors = 1;
  sMessage = 'No objects specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Validate that object type has object security enabled
If( CubeExists( cSecurityCube ) = 0 );
  sObjectTypePlural = pObjectType;
  If( pObjectType @= 'Process');
    sObjectTypePlural = sObjectTypePlural | 'es';
  Else;
    sObjectTypePlural = sObjectTypePlural | 's';
  EndIf;
  If( pDebug >= 1 );
    nErrors = 1;
    sMessage = 'You must first initialise ' | pObjectType | ' Security. In the Server Explorer go to ' |
               sObjectTypePlural | ' -> Security Assignments, and assign an access security to a ' |
               pObjectType | '. Then from the Server Explorer go to your ServerName -> Security -> Refresh Security';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Set Object Type Dimension
sObjectTypeDimension = '}' | pObjectType;
If( pObjectType @= 'Application' );
  sObjectTypeDimension = sObjectTypeDimension | 'Entries';
ElseIf( pObjectType @= 'Process' );
  sObjectTypeDimension = sObjectTypeDimension | 'es';
Else;
  sObjectTypeDimension = sObjectTypeDimension | 's';
EndIf;

# Validate Security Level
# Allowable Security Levels by Object Type (excluding RESERVE and LOCK):
#   Cube        : NONE, READ, ADMIN, WRITE
#   Dimension   : NONE, READ, ADMIN, WRITE
#   Application : NONE, READ, ADMIN
#   Process     : NONE, READ
#   Chore       : NONE, READ
pSecurityLevel = Upper( pSecurityLevel );
If(
  ( pSecurityLevel @= 'NONE' ) %
  ( pSecurityLevel @= 'READ' ) %
  ( pSecurityLevel @= 'ADMIN' & ( pObjectType @= 'Cube' % pObjectType @= 'Dimension' % pObjectType @= 'Application' ) ) %
  ( pSecurityLevel @= 'WRITE' & ( pObjectType @= 'Cube' % pObjectType @= 'Dimension' ) ) );
  # Valid Security Levels
Else;
  nErrors = 1;
  sMessage = 'Invalid security level parameter: ' | pSecurityLevel | ' for object type: ' | pObjectType;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# If pSecurityRefresh is blank then default to yes
If( Trim( pSecurityRefresh ) @= '' );
  pSecurityRefresh = 'Yes';
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


### Assign Application Security ###

# Loop through list of groups
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
  # Don't attempt to process a blank group or ADMIN
  If( sGroup @<> '' & sGroup @<> 'ADMIN' );
    # Check that Group exists
    If( DimIx( '}Groups', sGroup ) <> 0 );

      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, 'Group: ' | sGroup | ' OK' );
      EndIf;

      # Loop through list of objects
      sObjects = pObjects;
      nObjectDelimIndex = 1;

      While( nObjectDelimIndex <> 0 );
        nObjectDelimIndex = Scan( pDelimiter, sObjects );
        If( nObjectDelimIndex = 0 );
          sObject = sObjects;
        Else;
          sObject = Trim( SubSt( sObjects, 1, nObjectDelimIndex - 1 ) );
          sObjects = Trim( Subst( sObjects, nObjectDelimIndex + Long(pDelimiter), Long( sObjects ) ) );
        EndIf;
        # Don't attempt to process a blank object
        If( sObject @<> '' );
          # Check that object exists
          If( DimIx( sObjectTypeDimension, sObject ) <> 0 );
            If( pDebug >= 1 );
              AsciiOutput( sDebugFile, 'Object: ' | sObject | ' OK' );
            EndIf;

            # Assign Security
            If( CellIsUpdateable( cSecurityCube, sObject, sGroup ) = 1 );
              If( pDebug >= 1 );
                AsciiOutput( sDebugFile, 'Access to ' | pObjectType | ': ' | sObject | ' for Group: ' | sGroup | ' OK' );
              EndIf;
              If( pDebug <= 1);
                CellPutS( pSecurityLevel, cSecurityCube, sObject, sGroup );
              EndIf;
            Else;
              If( pDebug >= 1 );
                AsciiOutput( sDebugFile, 'Cannot set security, rule applies to cell: ' | cSecurityCube | ', ' | sObject | ', ' | sGroup );
              EndIf;
            EndIf;
          Else;
            If( pDebug >= 1 );
              AsciiOutput( sDebugFile, pObjectType | ': ' | sObject | ' does not exist' );
            EndIf;
          EndIf;
        EndIf;
      End;
    Else;
      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, 'Group: ' | sGroup | ' does not exist' );
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
