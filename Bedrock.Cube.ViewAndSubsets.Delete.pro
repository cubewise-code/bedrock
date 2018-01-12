601,100
602,"Bedrock.Cube.ViewAndSubsets.Delete"
562,"NULL"
586,
585,
564,
565,"uQzscMbCdpNoXsyrLGEL?aCeIP=\17m3A_tR=TiTVtGBb8^MXp93r[pHkYjMdXD0w;7b_Bf4>F84z6WgJWkh]6_5g8?C]6tNa71khSGEW\hrW7EkncJ4p2R<]wDF0DgBU2DT07H^5ZDWr:LRLr_Fefr;Ikl`_hAX0d^[:FM4Y^T@P7];gk_yEK3DnRKXpq=ure\o3LQb"
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
pCube
pView
pSubset
pMode
pDebug
561,5
2
2
2
1
1
590,5
pCube,""
pView,""
pSubset,""
pMode,1
pDebug,0
637,5
pCube,"Cube Name"
pView,"View Name"
pSubset,"Subset Name"
pMode,"Delete temporary view and Subset ( 0 = Retain View and Subsets 1 = Delete View and Subsets 2 = Delete View only )"
pDebug,"Debug"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,104

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process deletes a view and all subsets that have the same name

cProcess = 'Bedrock.Cube.ViewAndSubsets.Delete';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;
nErrors = 0;

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCube  : ' | pCube );
  AsciiOutput( sDebugFile, '            pView  : ' | pView );
  AsciiOutput( sDebugFile, '            pSubset: ' | pSubset );
  AsciiOutput( sDebugFile, '            pMode  : ' | NumberToString( pMode) );

EndIf;

### Validate Paramters ##
IF(
pMode = 0);
  If( pDebug >= 1 );
    sMessage = 'Mode 0: Do not destroy views and subsets.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessBreak;
ENDIF;

If( Trim( pCube ) @= '' );
  If( pDebug >= 1 );
    sMessage = 'No cube specified';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
EndIf;


If( pView @= '' & pSubset @= '' );
  If( pDebug >= 1 );
    sMessage = 'No view or subset name has been provided.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ProcessQuit;
ElseIf( pView @<> '' & pSubset @= '' );
  ## Use the nominated view name for the subset name.
  cView = pView;
  cSubset = pView;
ElseIf( pView @= '' & pSubset @<> '' );
  ## Use the nominated subset name for the view name.
  cView = pSubset;
  cSubset = pSubset;
Else;
  cView = pView;
  cSubset = pSubset;
EndIf;


## Clean up view
If( pDebug >= 1 );
    AsciiOutput( sDebugFile, 'Destroying view ' | cView | ' on cube ' | pCube );
EndIf;
If( pDebug <= 1 );
    ViewDestroy(pCube, cView);
EndIf;


## Clean up subsets
IF(
pMode = 1);
  If( pDebug >= 1 );
    sMessage = 'Destroying subset ' | cSubset | ' for the ' | cView | ' view.' ;
    AsciiOutput( sDebugFile, sMessage );
  EndIf;

  nDimCount = 0;
  i = 1;
  sDimName = TabDim( pCube, i );
  While( sDimName @<> '' );
    If( SubsetExists (sDimName, cSubset) = 1 );
      If( pDebug >= 1 );
          AsciiOutput( sDebugFile, 'Destroying subset ' | cSubset | ' on dimension ' | sDimName );
      EndIf;
      If( pDebug <= 1 );
          SubsetDestroy( sDimName, cSubset );
      EndIf;
    EndIf;
    sDimName = TabDim( pCube, i );
    i = i + 1;
  End;
ENDIF;
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,41

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
