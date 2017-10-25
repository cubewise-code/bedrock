601,100
602,"Bedrock.Security.Cube.CellSecurity.Create"
562,"NULL"
586,
585,
564,
565,"vO:Mn2Oa^M`UD;mvVons2Rzspn7CtVGr2>1y8pvIKif@e[e?4BN_iP8]S\i~fK<EOK6svfK4AnPa:_AUa<S<rF^aD7hcne=S4SQqmaGG?r8s]{uYZfVxGt[U@RhPgtg52PECizKmlSN[wo:GMe^6=Q[hvw4y[o^XbODnq]Aea2Yj8Jy7evwfNN^x8I1D^vJI1PYfroXvO:Mn2Oa^M`UD;mvVons2Rtspn7CtVG28>1y8pvIKif@e[h?4BN_iP8]S,oufKlBOK6SqfK4An`m:?DUa<S<rF^aD7xbne=S4SQoxmaGG?r8s]K4UZfVxGt[U@Rh`zvg5bVeMizKmlSnVwoJKMen1=Q[hvw4y[o^XbEnq=Mea2Y*;Jy7evwf^@^x8I1D^zJC1PYfroX"
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
pCube
pDimensions
pDebug
561,3
2
2
1
590,3
pCube,""
pDimensions,""
pDebug,0
637,3
pCube,"Cube to create cell security for"
pDimensions,"Map of dimensions to include in cell security as a array of 1:0 colon delimited e.g. ""1:0:0:1:0"""
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,153

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2015 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will create a cell security cube for the specified cube for the specified list of dimensions

# Notes:
# - Some checks performed based on dimension map matching the number of dimensions in the cube


### Constants ###

cProcess = 'Bedrock.Security.Cube.CellSecurity.Create';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt;
pDelimiter = ':';
DatasourceASCIIQuoteCharacter = '';

### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCube: ' | pCube );
  AsciiOutput( sDebugFile, '            pDimensions: ' | pDimensions );
  AsciiOutput( sDebugFile, '' );

EndIf;


### Validate Parameters ###

nErrors = 0;

# If blank delimiter specified then convert to default
If( pDelimiter @= '' );
  pDelimiter = ':';
EndIf;

# If no cube has been specified then terminate process
If( Trim( pCube ) @= '' );
  nErrors = 1;
  sMessage = 'No cube specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;
If( CubeExists( pCube ) = 0 );
  nErrors = 1;
  sMessage = 'Cube does not exist';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
Else;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, 'Cube: ' | pCube | ' exists' );
  EndIf;
EndIf;

# Check if cell security cube already exists
If( CubeExists(  '}CellSecurity_' | pCube ) = 1 );
  nErrors = 1;
  sMessage = 'Cell Security cube already exists';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
Else;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, 'Cube: ' |  '}CellSecurity_' | pCube | ' does not already exist. Proceeding ...' );
  EndIf;
EndIf;

### Count dimensions in cube ###

nDims = 0;
iDim = 1;
While( TabDim( pCube, iDim ) @<> '' );
   nDims = iDim;
   iDim = iDim + 1;
End;

### Split pDimensions dimension map  ###

If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'Dimension map for cube: ' | pCube );
EndIf;

sDimensions = pDimensions;
nDelimiterIndex = 1;

nMapDims = 0;
iDim = 1;
While( nDelimiterIndex <> 0 );
  nMapDims = iDim;
  nDelimiterIndex = Scan( pDelimiter, sDimensions );
  If( nDelimiterIndex = 0 );
    sDimension = sDimensions;
  Else;
    sDimension = Trim( SubSt( sDimensions, 1, nDelimiterIndex - 1 ) );
    sDimensions = Trim( Subst( sDimensions, nDelimiterIndex + Long(pDelimiter), Long( sDimensions ) ) );
  EndIf;
  If( sDimension @= '1' );
    sMsg = ' INCLUDE in cell security cube';
  ElseIf( sDimension @= '0' );
    sMsg = ' EXCLUDE from cell security cube';
  Else;
    sMsg = ' INVALID map parameter: ' | sDimension;
  EndIF;
  # List dimensions in cube & whether to include in cell security cube
  If( pDebug >= 1 );
     AsciiOutput( sDebugFile, NumberToString( iDim ) |' '| TabDim( pCube, iDim ) | sMsg );
  EndIf;

  iDim = iDim + 1;
End;

### Check dimension count of dimension map vs. dimensions in cube ###

If( nDims <> nMapDims );
  nErrors = 1;
  sMessage = 'Parameter count of dimension map does not match dimension count of cube!';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
Else;
  nRet = CellSecurityCubeCreate ( pCube, pDimensions );
  If( nRet = 1 );
     sMsg = '}CellSecurity_' | pCube | ' successfully created';
  Else;
     sMsg = 'Error. Could not create }CellSecurity_' | pCube;
  EndIf;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMsg );
  EndIf;
  If( nRet = 0 ); ItemReject( sMsg ); EndIf;
EndIf;

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
