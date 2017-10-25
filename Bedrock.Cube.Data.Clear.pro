601,100
602,"Bedrock.Cube.Data.Clear"
562,"NULL"
586,
585,
564,
565,"wq_PnOEMZ80]<TxJ=f8wS32at:k]83>HO_uUP07Hj0HbPt;[J_IdZXcIYsy>YvZZ2neKb82ge:BHD>[pUox1gMP31:3^FFrgOklJf=MS`\rd5jUGRFr7RmNUy8uuEn7IZGoQA8iYLY>Gdw]CydzdpiSR0oGu42NIHSW;4@;oNbxnSO6[7zr;S7uhlLiF:Bs;mUv672^U"
559,0
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
560,8
pCube
pView
pFilter
pDimensionDelim
pElementStartDelim
pElementDelim
pDestroyTempObj
pDebug
561,8
2
2
2
2
2
2
1
1
590,8
pCube,""
pView,""
pFilter,""
pDimensionDelim,"&"
pElementStartDelim,":"
pElementDelim,"+"
pDestroyTempObj,1
pDebug,0
637,8
pCube,Cube Name
pView,Temp view name
pFilter,Filter: Year: 2006 + 2007 & Scenario: Actual + Budget & Organization: North America Operations
pDimensionDelim,Delimiter for start of Dimension/Element set
pElementStartDelim,Delimiter for start of element list
pElementDelim,Delimiter between elements
pDestroyTempObj,Delete temporary view and Subset ( 0 = Retain View and Subsets 1 = Delete View and Subsets 2 = Delete View only )
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,148

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process creates a view and zeros it out.
# It can handle specific element references for any number of dimensions and elements.

# Note:
# - The pFilter parameter contains the dimenson and elements to be used for filtering.
# - The dimension parameters do not need to be given in the index order of dimensions in the cube.
# - The dimension name is specified as the first member of the delimited string of elements.


### Constants ###

cProcess = 'Bedrock.Cube.Data.Clear';
cUser = TM1User();
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;
cDefaultView = 'Bedrock_' | sRandomInt ;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  AsciiOutput( sDebugFile, 'TM1 User:        ' | cUser );
  AsciiOutput( sDebugFile, '' );
  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCube:              ' | pCube );
  AsciiOutput( sDebugFile, '            pView:              ' | pView );
  AsciiOutput( sDebugFile, '            pFilter:            ' | pFilter );
  AsciiOutput( sDebugFile, '            pDimensionDelim:    ' | pDimensionDelim );
  AsciiOutput( sDebugFile, '            pElementStartDelim: ' | pElementStartDelim );
  AsciiOutput( sDebugFile, '            pElementDelim:      ' | pElementDelim );
  AsciiOutput( sDebugFile, '            pDestroyTempObj:     ' | NumberToString( pDestroyTempObj) );
  AsciiOutput( sDebugFile, '' );

  AsciiOutput( sDebugFile, 'Default Temporary View Name : ' | cDefaultView );
  AsciiOutput( sDebugFile, '' );
EndIf;


### Validate Parameters ###

nErrors = 0;

# If blank delimiter specified then convert to default
If( Trim( pDimensionDelim ) @= '' );
  pDimensionDelim = '&';
EndIf;

If( Trim( pElementStartDelim ) @= '' );
  pElementStartDelim = ':';
EndIf;

If( Trim( pElementDelim ) @= '' );
  pElementDelim = '+';
EndIf;

# If no cube has been specified then terminate process
If( Trim( pCube ) @= '' );
  If( pDebug >= 1 );
    sMessage = 'No cube specified';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

# If specified cube does not exist then terminate process
If( CubeExists( pCube ) = 0 );
  If( pDebug >= 1 );
    sMessage = 'Cube: ' | pCube | ' does not exist';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;

## Validate the View parameter
If( TRIM(pView) @= '' );
  If( pDebug >= 1 );
    sMessage = 'Using default view: ' | cDefaultView;
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  cView = cDefaultView ;
Else ;
  If( pDebug >= 1 );
    sMessage = 'Using view: ' | pView;
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  cView = pView ;
EndIf;

## Validate that a Filter has been provided.
If( Trim( pFilter) @= '' );
  If( pDebug >= 1 );
    sMessage = 'Filter has not been specified. User "Clear Cube" as the filter to zero out the entire cube. ';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
ELSEIF(
Trim( pFilter ) @= 'Clear Cube' );
  pFilter = '';
EndIf;

### Create View ###
If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'Create view.' );
EndIf;
If( pDebug <= 1 );
  vRes = ExecuteProcess('Bedrock.Cube.View.Create',
    'pCube', pCube,
    'pView', cView,
    'pFilter', pFilter,
    'pSuppressZero', 1,
    'pSuppressConsol',1,
    'pSuppressRules',1,
    'pDimensionDelim', pDimensionDelim,
    'pElementStartDelim', pElementStartDelim,
    'pElementDelim', pElementDelim,
    'pDebug', pDebug );

EndIf;

### Zero Out View ###
If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'View and Subsets created' );
EndIf;
If( pDebug <= 1 );
  IF (vRes = ProcessExitNormal());
      ViewZeroOut( pCube, cView );
  ELSE;
    AsciiOutput( sDebugFile, 'Process Bedrock.Cube.View.Create Failed, nothing will be ZeroOut' );
  ENDIF;
EndIf;


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,36

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

### Destroy temporary views and susbsets ###
If( pDebug <= 1 );
  ExecuteProcess('Bedrock.Cube.ViewAndSubsets.Delete',
    'pCube', pCube,
    'pView', cView,
    'pSubset', cView,
    'pMode', pDestroyTempObj,
    'pDebug', pDebug);

ENDIF;

If( pDebug >= 1 );
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
