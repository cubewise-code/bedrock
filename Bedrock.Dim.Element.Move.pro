601,100
602,"Bedrock.Dim.Element.Move"
562,"NULL"
586,
585,
564,
565,"e:ab6altUxNZ?iXb@h^QaKFW=@[i_T6um4x;svJu^2zE@f5cl7wyV?6Har`E:xW[HN<>rJRAT5>0D31s9R<;PeCt[BP@@z[o_enYiW8u;SE@UoA55Z_kyq55Qe3zr7OwPaGL`lLiEl^6hb7z^QsVZ4OnzvdbI?TQxw7YLyXBW6ur_@Js8Eln\<WhNwrMOAuPs_mjAzlL"
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
pDimension
pElement
pTargetConsol
pAction
pElWeight
pDebug
561,6
2
2
2
2
1
1
590,6
pDimension,""
pElement,""
pTargetConsol,""
pAction,"Add"
pElWeight,1
pDebug,0
637,6
pDimension,Dimension Name
pElement,Element Name
pTargetConsol,Target Consolidation
pAction,Add or Remove Element from Consolidation
pElWeight,Element Weight (for Add only)
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,147

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will Add or Remove Elements from a Consolidation


### Constants ###

cProcess = 'Bedrock.Dim.Element.Move';
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
  AsciiOutput( sDebugFile, 'Parameters: pDimension    : ' | pDimension );
  AsciiOutput( sDebugFile, '            pElement      : ' | pElement );
  AsciiOutput( sDebugFile, '            pTargetConsol : ' | pTargetConsol );
  AsciiOutput( sDebugFile, '            pAction       : ' | pAction );
  AsciiOutput( sDebugFile, '            pElWeight     : ' | NumberToString( pElWeight ) );

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
  sMessage = 'Dimension: ' | pDimension | ' does not exist on server.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Validate Element
If( Trim( pElement ) @= '' );
  nErrors = 1;
  sMessage = 'No element specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;
If( DimIx( pDimension, pElement ) = 0 );
  nErrors = 1;
  sMessage = 'Element: ' | pElement | ' does not exist in dimension: ' | pDimension;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Validate target consol
If( DimIx( pDimension, pTargetConsol ) = 0 );
  nErrors = 1;
  sMessage = 'Consolidated Element: ' | pTargetConsol | ' does not exist in dimension: ' | pDimension;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;
If( DType( pDimension, pTargetConsol ) @<> 'C' );
  nErrors = 1;
  sMessage = 'Target Consolidation: ' | pTargetConsol | ' has incorrect element type.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;
If( ElIsAnc( pDimension, pElement, pTargetConsol ) = 1 );
  nErrors = 1;
  sMessage = 'Cannot add element: ' | pElement | ' to consolidation: ' | pTargetConsol | ' due to circular reference.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Validate action
If( pAction @<> 'Add' & pAction @<> 'Remove' );
  nErrors = 1;
  sMessage = 'Invalid action: ' | pAction | '. Valid actions are Add or Remove';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;


If( pDebug <= 1 );

  ### Insert Element into consolidation ###

  If( pAction @= 'Add' );
    DimensionElementComponentAdd( pDimension, pTargetConsol, pElement, pElWeight );
  EndIf;


  ### Remove Element from consolidation ###

  If( pAction @= 'Remove' );

    # Check that element is actually a child of target consol
    If( ElIsComp ( pDimension, pElement, pTargetConsol ) = 1 );
      DimensionElementComponentDelete( pDimension, pTargetConsol, pElement );
    Else;
      nErrors = 1;
      sMessage = 'Element: ' | pElement | ' is not a child of consolidation: ' | pTargetConsol;
      If( pDebug >= 1 );
        AsciiOutput( sDebugFile, sMessage );
      EndIf;
      ItemReject( sMessage );
    EndIf;

  EndIf;

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
