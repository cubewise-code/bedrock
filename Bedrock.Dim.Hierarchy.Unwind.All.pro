601,100
602,"Bedrock.Dim.Hierarchy.Unwind.All"
562,"SUBSET"
586,"}Cubes"
585,"}Cubes"
564,
565,"pW7c]L7w4S_jL<^MaW0M\3rzwhqJCiO9[LvZ5J\:<Mj4gIjhE^A\EB43?H=`KJ]<[3^GL<JBgsDg4?;_qf366U4XrZuHJUc]j\0h_`HlBt<EiSV`A_IhCe5V3`<yY_7a;YWEN8?vkTTg6?BW[h0p6i2AR;7\pH;aPp7vnjh3GS?k<4Uli2PrF^mBn=:rhzpukQIyis8w"
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
571,All
569,0
592,0
599,1000
560,2
pDimension
pDebug
561,2
2
1
590,2
pDimension,""
pDebug,0
637,2
pDimension,Dimension
pDebug,Debug Mode
577,1
vElement
578,1
2
579,1
1
580,1
0
581,1
0
582,1
VarType=32ColType=827
572,69

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will remove all children from all consolidations in the target dimension


### Constants ###

cProcess = 'Bedrock.Dim.Hierarchy.Unwind.All';
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
  AsciiOutput( sDebugFile, 'Parameters: pDimension : ' | pDimension );

EndIf;


### Validate Parameters ###

nErrors = 0;

# Validate dimension
If( Trim( pDimension ) @= '' );
  nErrors = 1;
  sMessage = 'No dimension specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;
If( DimensionExists( pDimension ) = 0 );
  nErrors = 1;
  sMessage = 'Dimension: ' | pDimension | ' does not exist';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;


### Assign data source ###

DataSourceType = 'SUBSET';
DatasourceNameForServer = pDimension;
DatasourceNameForClient = pDimension;
DatasourceDimensionSubset = 'ALL';


### End Prolog ###
573,33

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################


### Check for errors in prolog ###

If( nErrors <> 0 );
  ProcessBreak;
EndIf;


### Break all parent/child links ###

If( ElLev( pDimension, vElement ) = 0 % ElCompN( pDimension, vElement ) = 0 % DType( pDimension, vElement ) @<> 'C');
  ItemSkip;
EndIf;

nChildren = ElCompN( pDimension, vElement );
While( nChildren > 0 );
  sChild = ElComp( pDimension, vElement, nChildren );
  If( pDebug <= 1 );
    DimensionElementComponentDelete( pDimension, vElement, sChild );
  EndIf;
  nChildren = nChildren - 1;
End;


### End Metadata ###
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
917,0
918,0
919,0
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
