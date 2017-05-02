601,100
562,"NULL"
586,
585,
564,
565,"z<fggmGudJ;VL7yk\kxxzTDaZdabtWgXfIpYQf:2Aq6MIPFF3M_;\INf0?ZtKylUqr`TjbkL=b^Wf2:]e^tBiMZ0@sfUDzU6_1d80^TrXq\n5?4seVf]:ORcX4?Abq7uiw1xv]Oe0YXxldaDAFT6pPZ9V4aYdqWaS:zXsudoP6Nenk65yWrGu8oZevUVfuDnAtn[T;W5"
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
pGroups
pDelimiter
pDebug
561,3
2
2
1
590,3
pGroups,""
pDelimiter,"&"
pDebug,0.
637,3
pGroups,Groups seperated by delimiter
pDelimiter,Delimiter character
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,95

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 2.0.2~~##
#####################################################################################

# This process will delete client groups

# Notes:
# - Multiple groups can be specified seperated by a delimiter
# - If group does not exist then it will be skipped.
# - If multiple groups are specified and some don't exist and some do, then the ones that do exist will still be deleted


### Constants ###

cProcess = 'Bedrock.Security.Group.Delete';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 100000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pGroups: ' | pGroups );
  AsciiOutput( sDebugFile, '            pDelimiter: ' | pDelimiter );

EndIf;


### Validate Parameters ###

# If blank delimiter specified then convert to default
If( pDelimiter @= '' );
  pDelimiter = '&';
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


### Split pGroups into individual groups and delete ###

sGroups = pGroups;
nDelimiterIndex = 1;

While( nDelimiterIndex <> 0 );
  nDelimiterIndex = Scan( pDelimiter, sGroups );
  If( nDelimiterIndex = 0 );
    sGroup = sGroups;
  Else;
    sGroup = Trim( SubSt( sGroups, 1, nDelimiterIndex - 1 ) );
    sGroups = Trim( Subst( sGroups, nDelimiterIndex + Long(pDelimiter), Long( sGroups ) ) );
  EndIf;
  # Don't attempt to delete a blank group
  If( sGroup @<> '' );
    If( DimIx( '}Groups', sGroup ) <> 0 );
      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, 'Group: ' | sGroup | ' OK' );
      EndIf;
      If( pDebug <= 1 );
        DeleteGroup( sGroup );
      EndIf;
    Else;
      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, 'Group: ' | sGroup | ' does not exist' );
      EndIf;
    EndIf;
  EndIf;
End;

If( pDebug <= 1 );
  DimensionSortOrder( '}Groups', 'ByName', 'Ascending', 'ByName' , 'Ascending' );
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
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 2.0.2~~##
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
