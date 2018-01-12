601,100
602,"Bedrock.Dim.Sub.Create.TopLevelHierarchy"
562,"NULL"
586,
585,
564,
565,"dR<2arC@R43y3=fbtyAYO?PTBHnU4I=Boc4kyc<@JC25_Zc7T85VYwD<gf7OB7@TTyHi1H^wj\Z1dEC5EUDadYUGZF@Oc5xsPq4dd@wUJlxpc_Xid9@]H?F8i[eo<2k8xKYC2Mk>58rECkaOplSIOyh@xqlgHl`0jOLkgNVPz``;z1XovEPx:cB<k4MrvFF7C@q7IaDI"
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
pDimension
pSubset
pConvertToStatic
pAlias
pDebug
561,5
2
2
1
2
1
590,5
pDimension,""
pSubset,""
pConvertToStatic,1
pAlias,""
pDebug,0
637,5
pDimension,Dimension
pSubset,Subset
pConvertToStatic,Boolean: 1 = Convert to Static Subset
pAlias,Set Alias for Subset
pDebug,pDebug
577,0
578,0
579,0
580,0
581,0
582,0
572,172

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will Create a Top Level Hiearchy by N-Level Elements
# that is a subset of all "top node" elements ( Consolidated elements that have no parents )

### Constants ###

cProcess = 'Bedrock.Dim.Sub.Create.TopLevelHierarchy';
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
  AsciiOutput( sDebugFile, 'Parameters: pDimension       : ' | pDimension );
  AsciiOutput( sDebugFile, '            pSubset          : ' | pSubset );
  AsciiOutput( sDebugFile, '            pConvertToStatic : ' | NumberToString( pConvertToStatic ) );

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
  ItemReject( sMessage );
EndIf;
If( DimensionExists( pDimension ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dimension: ' | pDimension;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;
If( DnLev( pDimension ) <= 1 );
  # Create by MDX would return empty set and fail so need to abort here
  nErrors = 1;
  sMessage = 'Cannot continue dimension is flat: ' | pDimension;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIF;

# Validate subset
If( Trim( pSubset ) @= '' );
  pSubset = 'Top Level Hierarchies';
EndIf;

## Validate Alias
sDimAttr = '}ElementAttributes_' | pDimension;
IF(
pAlias @<> '' );
  IF(
  DimensionExists( sDimAttr ) = 0 );
    sMessage = 'No attributes exist for the dimension: ' | pDimension;
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    pAlias = '';
  EndIf;

  IF(
  DIMIX( sDimAttr, pAlias ) = 0 );
    sMessage = 'The Alias: ' | pAlias | ' does not exist in the dimension: ' | pDimension;
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    pAlias = '';
  EndIf;

  IF(
  DTYPE( sDimAttr, pAlias ) @<> 'AA' );
    sMessage = 'The Alias: ' | pAlias | ' is not an Alias in the dimension: ' | sDimAttr;
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    pAlias = '';
  EndIf;
ENDIF;


### MDX for creating subset ###

sMDX = '{EXCEPT( {FILTER( {TM1SUBSETALL( [' | pDimension | '] )}, MemberToStr( [' |
       pDimension | '].CurrentMember.Parent ) = "" )},' |
       '{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | pDimension | '] )},0 )} )}';


### Create Subset ###

If( pDebug <= 1 );

  # For a dynamic subset, the original subset MUST be destroyed first or the MDX will fail
  If( pConvertToStatic = 0 );
    If( SubsetExists( pDimension, pSubset ) = 1 );
      SubsetDestroy( pDimension, pSubset );
    EndIf;
    SubsetCreateByMDX( pSubset, sMDX );

  # For a static subset the subset does not need to be destroyed but its elements need to be deleted first
  Else;
    If( SubsetExists( pDimension, pSubset ) = 1 );
      SubsetDeleteAllElements( pDimension, pSubset );
    Else;
      SubsetCreate( pDimension, pSubset );
    EndIf;

    # Create a temporary MDX subset for processing
    sSubsetMDX = '}' | cProcess |'.' | NumberToString( Int( Rand() * 100000 ) );
    # It is unlikely that the subset already exists due to the random number in the subset name
    # However, it the SubsetDestroy is included in case the same random number is generated
    If( SubsetExists( pDimension, sSubsetMDX ) = 1 );
      SubsetDestroy( pDimension, sSubsetMDX );
    EndIf;
    SubsetCreateByMDX( sSubsetMDX, sMDX );

    # Transfer the elements from the MDX subset to the static subset
    nSubsetSize = SubsetGetSize( pDimension, sSubsetMDX );
    nSubsetIndex = 0;
    While( nSubsetIndex < nSubsetSize );
      nSubsetIndex = nSubsetIndex + 1;
      sElement = SubsetGetElementName( pDimension, sSubsetMDX, nSubsetIndex );
      SubsetElementInsert( pDimension, pSubset, sElement, nSubsetIndex );
    End;

    If( pDebug = 1 );
      AsciiOutput( sDebugFile, pSubset | ' Size: ', NumberToString( SubSetGetSize( pDimension, pSubset ) ) );
    EndIf;

  EndIf;

EndIf;

### Set Alias ##
IF(
pAlias @<> '' );
  If( pDebug <= 1 );
    SubsetAliasSet( pDimension, pSubset, pAlias );
  EndIf;

  If( pDebug >= 1 );
    sMessage = 'The Alias: ' | pAlias | ' has been set.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
ENDIF;

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
