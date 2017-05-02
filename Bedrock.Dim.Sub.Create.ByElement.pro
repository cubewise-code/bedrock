601,100
562,"NULL"
586,
585,
564,
565,"pNj39hpS=kGUJY^FaBd[_x6z__mBeOP=EWv7GOjK\bzvJEXNUM`A]Dg8@UXLiM3\b9NYU;Z;9r4BMy=Z1oOoLjyrFtEmzOCVizGPrvYLOOV;qC6tyAZsTEqGK]Q=JN^cvol4Cl5?2XEE\`UB<Qm1jXLw2jr2t1;o17^y:uCV;?Jq][gYvz6LmV87_a^aQV0kS8G5d3@k"
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
pSubset
pElements
pDelimiter
pAddToSubset
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
pSubset,""
pElements,""
pDelimiter,"&"
pAddToSubset,0.
pDebug,0.
637,6
pDimension,Dimension
pSubset,Subset
pElements,Elements Separated by Delimiter
pDelimiter,Delimiter
pAddToSubset,Add to an existing Subset (Boolean: 1=True)
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,159

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 2.0.2~~##
#####################################################################################

# This process will create a static subset based on a list of supplied elements


### Constants ###

cProcess = 'Bedrock.Dim.Sub.Create.ByElement';
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
  AsciiOutput( sDebugFile, 'Parameters: pDimension   : ' | pDimension );
  AsciiOutput( sDebugFile, '            pSubset      : ' | pSubset );
  AsciiOutput( sDebugFile, '            pElements    : ' | pElements );
  AsciiOutput( sDebugFile, '            pDelimiter   : ' | pDelimiter );

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

# Validate subset
If( Trim( pSubset ) @= '' );
  nErrors = 1;
  sMessage = 'No subset specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Validate elements
If( Trim( pElements ) @= '' );
  nErrors = 1;
  sMessage = 'No elements specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Validate delimiter
If( pDelimiter @= '' );
  pDelimiter = '&';
EndIf;

# Validate add to subset
If( pAddToSubset <> 0 & pAddToSubset <> 1 );
  nErrors = 1;
  sMessage = 'Invalid value for pAddToSubset: ' | NumberToString( pAddToSubset ) | '. Valid values are 0 and 1';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;


### Prepare subset ###

If( SubsetExists( pDimension, pSubset ) = 1 );
  If( pAddtoSubset <> 1 );
    If( pDebug <= 1 );
      SubsetDeleteAllElements( pDimension, pSubset );
    EndIf;
    nSubsetSize = 0;
  Else;
    nSubsetSize = SubsetGetSize( pDimension, pSubset );
  EndIf;
Else;
  If( pDebug <= 1 );
    SubsetCreate( pDimension, pSubset );
  EndIf;
  nSubsetSize = 0;
EndIf;


### Insert elements ###

nSubsetIndex = 1;
sElements = pElements;
nDelimIndex = 1;

# Split filter into seperate dimensions
While( nDelimIndex <> 0 & Long( sElements ) > 0 );

  nDelimIndex = Scan( pDelimiter, sElements );
  If( nDelimIndex <> 0 );
    sElement = Trim( SubSt( sElements, 1, nDelimIndex - 1 ) );
    sElements = Trim( SubSt( sElements, nDelimIndex + Long( pDelimiter ), Long( sElements ) ) );
  Else;
    sElement = Trim( sElements );
  EndIf;

  If( DimIx( pDimension, sElement ) <> 0 );
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, 'Element: ' | sElement | ' to be added to subset.' );
    EndIf;
    If( pDebug <= 1 );
       IF(
       ELLEV( pDimension, sElement) > 0);
       ExecuteProcess( 'Bedrock.Dim.Sub.Create.Consolidation.All',
         'pDimension', pDimension,
         'pSubset', pSubset,
         'pConsol', sElement,
         'pAddToSubset', 1,
         'pExclusions', '',
         'pDelimiter', pDelimiter ,
         'pDebug', pDebug );
      ELSE;
        SubsetElementInsert( pDimension, pSubset, sElement, nSubsetIndex );
      ENDIF;
    EndIf;
    nSubsetIndex = nSubsetIndex + 1;
  Else;
    AsciiOutput( sDebugFile, 'Element: ' | sElement | ' does not exist in dimension: ' | pDimension | ', skipping' );
  EndIf;
End;


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
