601,100
602,"}bedrock.cube.create"
562,"NULL"
586,"Variables"
585,"Variables"
564,
565,"ebMLmy[wi8[XJ9@YvPUG:eLQF<OIgro|PCN?0Oamg7[K>Ejkv3N_Mso;klTqmL9B6l;uJ0p0ITg1GpUwl3lM`L1R=YG<TW3h0ze?=4`h>POrl>Es1avP72<d^gKdB_o_PiR=ppM:txF{b<BjVOa;m39NREGVY]ryxWje8x>AD@nchYsXeIWW<B;87tW9LuF2V>tE[`T="
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
589,","
568,""""
570,All
571,
569,0
592,0
599,1000
560,6
pLogOutput
pStrictErrorHandling
pCube
pDims
pRecreate
pDelim
561,6
1
1
2
2
1
2
590,6
pLogOutput,0
pStrictErrorHandling,0
pCube,""
pDims,""
pRecreate,0
pDelim,"&"
637,6
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pCube,"REQUIRED: Cube Name"
pDims,"REQUIRED: Dim1 & Dim2 & Dim3 & Dim4 & Dim5"
pRecreate,"OPTIONAL: If cube exists delete and recreate (Default=0)"
pDelim,"OPTIONAL: Delimiter for Dimension list (default value if blank = '&')"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,653
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.cube.create', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pCube', '', 'pDims', '',
    	'pRecreate', 0, 'pDelim', '&'
	);
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Region @DOC
# Description: 
# This process automatically creates a cube based on a delimited string of dimension names.

# Use case: Intended for development/prototyping.
# 1/ This can be used to quickly create a cube for a demo or development.

# Note:
# The pDims parameter contains the dimenson list and is mandatory.
# The format of the pDims parameter is as follows for delimiter of '&' (e.g. Dim1 & Dim2 & Dim3 ).
# Spaces are ignored so use them to make your filter more readable.
# The order of the dimension list specifies the initial index order of dimensions in the cube.
# pRecreate is an optional parameter for creating new cubes:
# - If a cube already exists and pRecreate is set to 0 then the process will abort.
# - If a cube already exists and pRecreate is set to 1 then the process will destroy the old cube and recreate with the specified dimensionality.
#EndRegion @DOC

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName     = GetProcessName();
cUserName         = TM1User();
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cDelimDim         = TRIM(pDelim);
nDims             = 0;
nDimMax           = 100;
nErrors           = 0;
sMessage          = '';
cUserName         = TM1User();
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pCube:%pCube%, pDims:%pDims%, pRecreate:%pRecreate%, pDelim:%pDelim%.' ;  

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

## Validate the Cube parameter
If( TRIM(pCube) @= '' );
  sMessage = 'A cube name must be provided.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# If specified cube exists and recreate option not set to true then terminate process
If( CubeExists(   pCube   ) = 1 );
  If( pRecreate <> 1 );
    sMessage = Expand( 'Cube %pCube% already exists. Aborting cube create.' );
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  EndIf;
EndIf;

# Check the delimiter
If( cDelimDim @= '' );
    cDelimDim = '&';
EndIf;

# Check the dimension list can't be empty
If( pDims @= '' );
  sMessage = 'The dimension list is blank.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Check the dimension list must contain delimiter
If( Scan( cDelimDim, pDims ) < 2 );
  sMessage = 'The dimension list must contain at least 2 dimension names separated by the delimiter.';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Initialise the dimension variables ###
sDim01 = '';
sDim02 = '';
sDim03 = '';
sDim04 = '';
sDim05 = '';
sDim06 = '';
sDim07 = '';
sDim08 = '';
sDim09 = '';
sDim10 = '';
sDim11 = '';
sDim12 = '';
sDim13 = '';
sDim14 = '';
sDim15 = '';
sDim16 = '';
sDim17 = '';
sDim18 = '';
sDim19 = '';
sDim20 = '';
sDim21 = '';
sDim22 = '';
sDim23 = '';
sDim24 = '';
sDim25 = '';
sDim26 = '';
sDim27 = '';
sDim28 = '';
sDim29 = '';
sDim30 = '';
sDim31 = '';
sDim32 = '';
sDim33 = '';
sDim34 = '';
sDim35 = '';
sDim36 = '';
sDim37 = '';
sDim38 = '';
sDim39 = '';
sDim40 = '';
sDim41 = '';
sDim42 = '';
sDim43 = '';
sDim44 = '';
sDim45 = '';
sDim46 = '';
sDim47 = '';
sDim48 = '';
sDim49 = '';
sDim50 = '';
sDim51 = '';
sDim52 = '';
sDim53 = '';
sDim54 = '';
sDim55 = '';
sDim56 = '';
sDim57 = '';
sDim58 = '';
sDim59 = '';
sDim60 = '';
sDim61 = '';
sDim62 = '';
sDim63 = '';
sDim64 = '';
sDim65 = '';
sDim66 = '';
sDim67 = '';
sDim68 = '';
sDim69 = '';
sDim70 = '';
sDim71 = '';
sDim72 = '';
sDim73 = '';
sDim74 = '';
sDim75 = '';
sDim76 = '';
sDim77 = '';
sDim78 = '';
sDim79 = '';
sDim80 = '';
sDim81 = '';
sDim82 = '';
sDim83 = '';
sDim84 = '';
sDim85 = '';
sDim86 = '';
sDim87 = '';
sDim88 = '';
sDim89 = '';
sDim90 = '';
sDim91 = '';
sDim92 = '';
sDim93 = '';
sDim94 = '';
sDim95 = '';
sDim96 = '';
sDim97 = '';
sDim98 = '';
sDim99 = '';
sDim100 = '';

### Split delimited dimension list and count number of dimensions ###
sDims = TRIM( pDims );
nDelimIndex = 1;

While( nDelimIndex > 0 & Long( sDims ) > 0 );

  nDelimIndex = Scan( cDelimDim, sDims );
  If( nDelimIndex > 0 );
    sDim = Trim( SubSt( sDims, 1, nDelimIndex - 1 ) );
    sDims = Trim( SubSt( sDims, nDelimIndex + Long( cDelimDim ), Long( sDims ) ) );
  Else;
    sDim = Trim( sDims );
  EndIf;

  If( DimensionExists( sDim ) = 1 );
    # sDim recognized as a dimension, increment the dim counter and set the dim name variable (how we wish Expand worked on the LHS of = ...)
    nDims = nDims + 1;
    If( nDims > nDimMax );
      sMessage = 'Maximum number of dimensions exceeded. Aborting';
      nErrors = nErrors + 1;
      LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    EndIf;
    If( nDims = 1 );
      sDim01 = sDim;
    ElseIf( nDims = 2 );
      sDim02 = sDim;
    ElseIf( nDims = 3 );
      sDim03 = sDim;
    ElseIf( nDims = 4 );
      sDim04 = sDim;
    ElseIf( nDims = 5 );
      sDim05 = sDim;
    ElseIf( nDims = 6 );
      sDim06 = sDim;
    ElseIf( nDims = 7 );
      sDim07 = sDim;
    ElseIf( nDims = 8 );
      sDim08 = sDim;
    ElseIf( nDims = 9 );
      sDim09 = sDim;
    ElseIf( nDims = 10 );
      sDim10 = sDim;
    ElseIf( nDims = 11 );
      sDim11 = sDim;
    ElseIf( nDims = 12 );
      sDim12 = sDim;
    ElseIf( nDims = 13 );
      sDim13 = sDim;
    ElseIf( nDims = 14 );
      sDim14 = sDim;
    ElseIf( nDims = 15 );
      sDim15 = sDim;
    ElseIf( nDims = 16 );
      sDim16 = sDim;
    ElseIf( nDims = 17 );
      sDim17 = sDim;
    ElseIf( nDims = 18 );
      sDim18 = sDim;
    ElseIf( nDims = 19 );
      sDim19 = sDim;
    ElseIf( nDims = 20 );
      sDim20 = sDim;
    ElseIf( nDims = 21 );
      sDim21 = sDim;
    ElseIf( nDims = 22 );
      sDim22 = sDim;
    ElseIf( nDims = 23 );
      sDim23 = sDim;
    ElseIf( nDims = 24 );
      sDim24 = sDim;
    ElseIf( nDims = 25 );
      sDim25 = sDim;
    ElseIf( nDims = 26 );
      sDim26 = sDim;
    ElseIf( nDims = 27 );
      sDim27 = sDim;
    ElseIf( nDims = 28 );
      sDim28 = sDim;
    ElseIf( nDims = 29 );
      sDim29 = sDim;
    ElseIf( nDims = 30 );
      sDim30 = sDim;
    ElseIf( nDims = 31 );
      sDim31 = sDim;
    ElseIf( nDims = 32 );
      sDim32 = sDim;
    ElseIf( nDims = 33 );
      sDim33 = sDim;
    ElseIf( nDims = 34 );
      sDim34 = sDim;
    ElseIf( nDims = 35 );
      sDim35 = sDim;
    ElseIf( nDims = 36 );
      sDim36 = sDim;
    ElseIf( nDims = 37 );
      sDim37 = sDim;
    ElseIf( nDims = 38 );
      sDim38 = sDim;
    ElseIf( nDims = 39 );
      sDim39 = sDim;
    ElseIf( nDims = 40 );
      sDim40 = sDim;
    ElseIf( nDims = 41 );
      sDim41 = sDim;
    ElseIf( nDims = 42 );
      sDim42 = sDim;
    ElseIf( nDims = 43 );
      sDim43 = sDim;
    ElseIf( nDims = 44 );
      sDim44 = sDim;
    ElseIf( nDims = 45 );
      sDim45 = sDim;
    ElseIf( nDims = 46 );
      sDim46 = sDim;
    ElseIf( nDims = 47 );
      sDim47 = sDim;
    ElseIf( nDims = 48 );
      sDim48 = sDim;
    ElseIf( nDims = 49 );
      sDim49 = sDim;
    ElseIf( nDims = 50 );
      sDim50 = sDim;
    ElseIf( nDims = 51 );
      sDim51 = sDim;
    ElseIf( nDims = 52 );
      sDim52 = sDim;
    ElseIf( nDims = 53 );
      sDim53 = sDim;
    ElseIf( nDims = 54 );
      sDim54 = sDim;
    ElseIf( nDims = 55 );
      sDim55 = sDim;
    ElseIf( nDims = 56 );
      sDim56 = sDim;
    ElseIf( nDims = 57 );
      sDim57 = sDim;
    ElseIf( nDims = 58 );
      sDim58 = sDim;
    ElseIf( nDims = 59 );
      sDim59 = sDim;
    ElseIf( nDims = 60 );
      sDim60 = sDim;
    ElseIf( nDims = 61 );
      sDim61 = sDim;
    ElseIf( nDims = 62 );
      sDim62 = sDim;
    ElseIf( nDims = 63 );
      sDim63 = sDim;
    ElseIf( nDims = 64 );
      sDim64 = sDim;
    ElseIf( nDims = 65 );
      sDim65 = sDim;
    ElseIf( nDims = 66 );
      sDim66 = sDim;
    ElseIf( nDims = 67 );
      sDim67 = sDim;
    ElseIf( nDims = 68 );
      sDim68 = sDim;
    ElseIf( nDims = 69 );
      sDim69 = sDim;
    ElseIf( nDims = 70 );
      sDim70 = sDim;
    ElseIf( nDims = 71 );
      sDim71 = sDim;
    ElseIf( nDims = 72 );
      sDim72 = sDim;
    ElseIf( nDims = 73 );
      sDim73 = sDim;
    ElseIf( nDims = 74 );
      sDim74 = sDim;
    ElseIf( nDims = 75 );
      sDim75 = sDim;
    ElseIf( nDims = 76 );
      sDim76 = sDim;
    ElseIf( nDims = 77 );
      sDim77 = sDim;
    ElseIf( nDims = 78 );
      sDim78 = sDim;
    ElseIf( nDims = 79 );
      sDim79 = sDim;
    ElseIf( nDims = 80 );
      sDim80 = sDim;
    ElseIf( nDims = 81 );
      sDim81 = sDim;
    ElseIf( nDims = 82 );
      sDim82 = sDim;
    ElseIf( nDims = 83 );
      sDim83 = sDim;
    ElseIf( nDims = 84 );
      sDim84 = sDim;
    ElseIf( nDims = 85 );
      sDim85 = sDim;
    ElseIf( nDims = 86 );
      sDim86 = sDim;
    ElseIf( nDims = 87 );
      sDim87 = sDim;
    ElseIf( nDims = 88 );
      sDim88 = sDim;
    ElseIf( nDims = 89 );
      sDim89 = sDim;
    ElseIf( nDims = 90 );
      sDim90 = sDim;
    ElseIf( nDims = 91 );
      sDim91 = sDim;
    ElseIf( nDims = 92 );
      sDim92 = sDim;
    ElseIf( nDims = 93 );
      sDim93 = sDim;
    ElseIf( nDims = 94 );
      sDim94 = sDim;
    ElseIf( nDims = 95 );
      sDim95 = sDim;
    ElseIf( nDims = 96 );
      sDim96 = sDim;
    ElseIf( nDims = 97 );
      sDim97 = sDim;
    ElseIf( nDims = 98 );
      sDim98 = sDim;
    ElseIf( nDims = 99 );
      sDim99 = sDim;
    ElseIf( nDims = 100 );
      sDim100 = sDim;
    EndIf;   

  Else;

    # sDim not recognized as valid dimension
    sMessage = Expand( '%sDim% not recognized as valid dimension.' );
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  EndIf;

End;

### Create the cube ###

If( nDims < 2 );
  sMessage = 'Number of dimesnions specified is less than 2';
  nErrors = nErrors + 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

If( CubeExists( pCube ) = 1 & pRecreate = 1 );
  CubeDestroy( pCube );
EndIf;

If( nDims = 2 );
  CubeCreate( Trim( pCube ), sDim01, sDim02 );
ElseIf( nDims = 3 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03 );
ElseIf( nDims = 4 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04 );
ElseIf( nDims = 5 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05 );
ElseIf( nDims = 6 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06 );
ElseIf( nDims = 7 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07 );
ElseIf( nDims = 8 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08 );
ElseIf( nDims = 9 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09 );
ElseIf( nDims = 10 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10 );
ElseIf( nDims = 11 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11 );
ElseIf( nDims = 12 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12 );
ElseIf( nDims = 13 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13 );
ElseIf( nDims = 14 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14 );
ElseIf( nDims = 15 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15 );
ElseIf( nDims = 16 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16 );
ElseIf( nDims = 17 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17 );
ElseIf( nDims = 18 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18 );
ElseIf( nDims = 19 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19 );
ElseIf( nDims = 20 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20 );
ElseIf( nDims = 21 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21 );
ElseIf( nDims = 22 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22 );
ElseIf( nDims = 23 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23 );
ElseIf( nDims = 24 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24 );
ElseIf( nDims = 25 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25 );
ElseIf( nDims = 26 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26 );
ElseIf( nDims = 27 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27 );
ElseIf( nDims = 28 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28 );
ElseIf( nDims = 29 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29 );
ElseIf( nDims = 30 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30 );
ElseIf( nDims = 31 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31 );
ElseIf( nDims = 32 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32 );
ElseIf( nDims = 33 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33 );
ElseIf( nDims = 34 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34 );
ElseIf( nDims = 35 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35 );
ElseIf( nDims = 36 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36 );
ElseIf( nDims = 37 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37 );
ElseIf( nDims = 38 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38 );
ElseIf( nDims = 39 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39 );
ElseIf( nDims = 40 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40 );
ElseIf( nDims = 41 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41 );
ElseIf( nDims = 42 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42 );
ElseIf( nDims = 43 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43 );
ElseIf( nDims = 44 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44 );
ElseIf( nDims = 45 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45 );
ElseIf( nDims = 46 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46 );
ElseIf( nDims = 47 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47 );
ElseIf( nDims = 48 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48 );
ElseIf( nDims = 49 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49 );
ElseIf( nDims = 50 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50 );
ElseIf( nDims = 51 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51 );
ElseIf( nDims = 52 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52 );
ElseIf( nDims = 53 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53 );
ElseIf( nDims = 54 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54 );
ElseIf( nDims = 55 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55 );
ElseIf( nDims = 56 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56 );
ElseIf( nDims = 57 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57 );
ElseIf( nDims = 58 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58 );
ElseIf( nDims = 59 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59 );
ElseIf( nDims = 60 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60 );
ElseIf( nDims = 61 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61 );
ElseIf( nDims = 62 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62 );
ElseIf( nDims = 63 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63 );
ElseIf( nDims = 64 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64 );
ElseIf( nDims = 65 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65 );
ElseIf( nDims = 66 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66 );
ElseIf( nDims = 67 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67 );
ElseIf( nDims = 68 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68 );
ElseIf( nDims = 69 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69 );
ElseIf( nDims = 70 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70 );
ElseIf( nDims = 71 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71 );
ElseIf( nDims = 72 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72 );
ElseIf( nDims = 73 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73 );
ElseIf( nDims = 74 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74 );
ElseIf( nDims = 75 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75 );
ElseIf( nDims = 76 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76 );
ElseIf( nDims = 77 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77 );
ElseIf( nDims = 78 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78 );
ElseIf( nDims = 79 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79 );
ElseIf( nDims = 80 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80 );
ElseIf( nDims = 81 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81 );
ElseIf( nDims = 82 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81, sDim82 );
ElseIf( nDims = 83 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81, sDim82, sDim83 );
ElseIf( nDims = 84 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81, sDim82, sDim83, sDim84 );
ElseIf( nDims = 85 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81, sDim82, sDim83, sDim84, sDim85 );
ElseIf( nDims = 86 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81, sDim82, sDim83, sDim84, sDim85, sDim86 );
ElseIf( nDims = 87 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81, sDim82, sDim83, sDim84, sDim85, sDim86, sDim87 );
ElseIf( nDims = 88 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81, sDim82, sDim83, sDim84, sDim85, sDim86, sDim87, sDim88 );
ElseIf( nDims = 89 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81, sDim82, sDim83, sDim84, sDim85, sDim86, sDim87, sDim88, sDim89 );
ElseIf( nDims = 90 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81, sDim82, sDim83, sDim84, sDim85, sDim86, sDim87, sDim88, sDim89, sDim90 );
ElseIf( nDims = 91 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81, sDim82, sDim83, sDim84, sDim85, sDim86, sDim87, sDim88, sDim89, sDim90, sDim91 );
ElseIf( nDims = 92 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81, sDim82, sDim83, sDim84, sDim85, sDim86, sDim87, sDim88, sDim89, sDim90, sDim91, sDim92 );
ElseIf( nDims = 93 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81, sDim82, sDim83, sDim84, sDim85, sDim86, sDim87, sDim88, sDim89, sDim90, sDim91, sDim92, sDim93 );
ElseIf( nDims = 94 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81, sDim82, sDim83, sDim84, sDim85, sDim86, sDim87, sDim88, sDim89, sDim90, sDim91, sDim92, sDim93, sDim94 );
ElseIf( nDims = 95 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81, sDim82, sDim83, sDim84, sDim85, sDim86, sDim87, sDim88, sDim89, sDim90, sDim91, sDim92, sDim93, sDim94, sDim95 );
ElseIf( nDims = 96 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81, sDim82, sDim83, sDim84, sDim85, sDim86, sDim87, sDim88, sDim89, sDim90, sDim91, sDim92, sDim93, sDim94, sDim95, sDim96 );
ElseIf( nDims = 97 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81, sDim82, sDim83, sDim84, sDim85, sDim86, sDim87, sDim88, sDim89, sDim90, sDim91, sDim92, sDim93, sDim94, sDim95, sDim96, sDim97 );
ElseIf( nDims = 98 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81, sDim82, sDim83, sDim84, sDim85, sDim86, sDim87, sDim88, sDim89, sDim90, sDim91, sDim92, sDim93, sDim94, sDim95, sDim96, sDim97, sDim98 );
ElseIf( nDims = 99 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81, sDim82, sDim83, sDim84, sDim85, sDim86, sDim87, sDim88, sDim89, sDim90, sDim91, sDim92, sDim93, sDim94, sDim95, sDim96, sDim97, sDim98, sDim99 );
ElseIf( nDims = 100 );
  CubeCreate( Trim( pCube ), sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60, sDim61, sDim62, sDim63, sDim64, sDim65, sDim66, sDim67, sDim68, sDim69, sDim70, sDim71, sDim72, sDim73, sDim74, sDim75, sDim76, sDim77, sDim78, sDim79, sDim80, sDim81, sDim82, sDim83, sDim84, sDim85, sDim86, sDim87, sDim88, sDim89, sDim90, sDim91, sDim92, sDim93, sDim94, sDim95, sDim96, sDim97, sDim98, sDim99, sDim100 );
EndIf;


573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,32

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

### Return code & final error message handling
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
    If( pStrictErrorHandling = 1 ); 
        ProcessQuit; 
    EndIf;
Else;
    sProcessAction = Expand( 'Process:%cThisProcName% successfully created %pCube% with %pDims%.' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogoutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );   
    EndIf;
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
917,0
918,1
919,0
920,0
921,""
922,""
923,0
924,""
925,""
926,""
927,""
