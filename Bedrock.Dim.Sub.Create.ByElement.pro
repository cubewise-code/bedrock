601,100
602,"Bedrock.Dim.Sub.Create.ByElement"
562,"NULL"
586,
585,
564,
565,"r5E:rihX@7Ron9`TIqayayr]?DOdE];e5JFn=9qPkNc[x=DaJ^Of?]b5vQGDdb]Ga8j0pwiM4893nfq9NLt::5TMxx9W?9<IJ2exsmSBbyMR=<\BAToQk0W8hW4F9?kCOtRsV[cg1=0uQxR?y9@0WZD2<DNGGR7pE:g1JL?L\hjegx70WKVK2tHexbP>DGL=9qvPRvU>"
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
pDimension
pSubset
pElements
pDelimiter
pAddToSubset
pAlias
pDebug
561,7
2
2
2
2
1
2
1
590,7
pDimension,""
pSubset,""
pElements,""
pDelimiter,""
pAddToSubset,0
pAlias,""
pDebug,0
637,7
pDimension,"Dimension"
pSubset,"Subset"
pElements,"Elements Separated by Delimiter"
pDelimiter,"Delimiter"
pAddToSubset,"Add to an existing Subset (Boolean: 1=True)"
pAlias,"Assign an alias to the subset"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,210

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.0.2~~##
#####################################################################################

# This process will create a static subset based on a list of supplied elements


### Constants ###

cProcess = 'Bedrock.Dim.Sub.Create.ByElement';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;


### Initialise Debug ###
## Set debug file name
 sDebugFile = cDebugFile | 'Prolog.debug';

If( pDebug >= 1 );

  ## Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  ## Log parameters
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

### Assign Alias to subset
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
    If( pDebug <= 1 );
       IF(
       ELLEV( pDimension, sElement) > 0);
         ExecuteProcess('Bedrock.Dim.Sub.Create',
           'pDimension', pDimension,
           'pSubset', pSubset,
           'pConsol', sElement,
           'pExclusions', '',
           'pDelimiter', pDelimiter,
           'pAddToSubset', 1,
           'pAlias', '',
           'pDebug', pDebug
          );

          If( pDebug >= 1 );
            AsciiOutput( sDebugFile, 'Consolidation: ' | sElement | ' has been added to the subset.' );
          EndIf;
      ELSE;
        SubsetElementInsert( pDimension, pSubset, sElement, nSubsetIndex );
        If( pDebug >= 1 );
          AsciiOutput( sDebugFile, 'Element: ' | sElement | ' has been added to the subset.' );
        EndIf;
      ENDIF;
    EndIf;
    nSubsetIndex = nSubsetIndex + 1;
  Else;
    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, 'Element: ' | sElement | ' does not exist in dimension: ' | pDimension | ', skipping' );
    EndIf;
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
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.0.2~~##
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
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
