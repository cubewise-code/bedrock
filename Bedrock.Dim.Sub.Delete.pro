601,100
602,"Bedrock.Dim.Sub.Delete"
562,"NULL"
586,
585,
564,
565,"lNLPYJB3aLl3yIRXELd\vfnD7v;lMbP{0tdj4M^vxA>pqIJk5w1k2RdU^`TA<@:BS7@u:kmZG^h1Ip517=J@7azxR8G\K;u6n0>3=^9>IAKuXJFsQe5<_0J]Q_4@HZ9Wnb0PfL;1`MpR0bnFyO5=;b\sdlQh0tS?bcUB_;a7v2@fyRMBf7a?I;zNMoIvpv;VT8Ilcpc"
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
pDimensions
pSubsets
pDelimiter
pMode
pDebug
561,5
2
2
2
1
1
590,5
pDimensions,""
pSubsets,"}Bedrock*"
pDelimiter,"&"
pMode,0
pDebug,0
637,5
pDimensions,"List of Dimensions Separated by Delimiter (Blank = All Dimensions)"
pSubsets,"List of Subsets Separated by Delimiter. Wild-cards Permitted on Subset Names."
pDelimiter,"Delimiter Character"
pMode,"<=1 destroy subset 2 delete all elements"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,204

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process deletes public subsets

# Notes:
# - This process can work on a single dimension or multiple dimensions
# - This process can work on a single subset or multiple subsets
# - When specifying subset names wildcards can be specified by using the * character

# Parameters:
# - pDimensions:
#   - To specify which dimensions to delete subsets from use the pDimensions parameter
#   - To delete subsets from a single dimension only just specify that dimension name e.g. Product
#   - To delete subsets from multiple dimensions specify each dimension name seperated by a delimiter e.g. Product;Customer;Account
#   - To delete subsets from all dimensions then leave pDimensions parameter blank
#   - If any invalid dimensions are specified they will be skipped but the process will continue to process the other dimensions
# - pSubsets:
#   - To specify which subsets to delete use the pSubsets parameter
#   - This parameter must be specified, a blank value will cause the process to terminate
#   - To delete a single subset only just specify that subset name e.g. SmallProducts
#   - To delete multiple subsets specify each subset name seperated by a delimiter e.g. SmallProducts;LargeProducts
#   - When specifying subset names wildcards are permitted and all subsets that match the wildcard search string will be deleted
#     - The wildcard search string follows the same format as windows based file wildcards
#     - To delete all subsets that "start" with a specific string use a trailing * e.g. Bedrock*
#     - To delete all subsets that "end" in a specific string use a leading * e.g. *Bedrock
#     - To delete all subsets that "contain" a specific string use leading and trailing *'s e.g. *Bedrock*
#     - To delete a single specific subset only don't use *'s at all e.g. Bedrock
#     - To specify multiple search stings list them all seperated by a delimiter e.g. Bedrock*;*Temp;*Test*
#   - Specific subset names and wildcard based names can both be used together e.g. SalesByProduct;Bedrock*
# - pDelimiter:
#   - The delimiter is used when specifying multiple dimensions and/or multiple subsets
#   - The default delimiter is ;
#   - Any delimiter can be used by specifying a value for pDelimiter
#   - Choose a delimiter that won't be used in either the wildcard search strings or dimension names


### Constants ###

cProcess = 'Bedrock.Dim.Sub.Delete';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;
cDimension = '}Dimensions';
cSubProc = 'Bedrock.Dim.Sub.Delete.SubsetDestroy';

### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimensions : ' | pDimensions );
  AsciiOutput( sDebugFile, '            pSubsets    : ' | pSubsets );
  AsciiOutput( sDebugFile, '            pDelimiter  : ' | pDelimiter );
  AsciiOutput( sDebugFile, '            pMode      : ' | NumberToString(pMode) );

EndIf;


### Validate Parameters ###

nErrors = 0;

# Validate subsets
If( Trim( pSubsets ) @= '' );
  nErrors = 1;
  sMessage = 'No subsets specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Validate delimiter
If( Trim( pDelimiter ) @= '' );
  pDelimiter = '&';
EndIf;


### Iterate through dimensions ###

# If no dimension has been specified then process all dimensions
If( Trim( pDimensions ) @= '' );

  nElemTotal = DimSiz( cDimension );
  nElemIndex = 1;

  While( nElemIndex <= nElemTotal );
    # Determine dimension name
    sDimension = DimNm( cDimension, nElemIndex );
    # Exclude control dimensions
    If( SubSt( sDimension, 1, 1 ) @<> '}' );
      If( Trim( pDimensions ) @= '' );
        pDimensions = sDimension;
      Else;
        pDimensions = pDimensions | pDelimiter | sDimension;
      EndIf;
    EndIf;
    nElemIndex = nElemIndex + 1;
  End;

EndIf;

# Work through all dimensions specified in pDimensions
sDimensions = pDimensions;
nDimensionDelimIndex = 1;

While( nDimensionDelimIndex <> 0 );

  nDimensionDelimIndex = Scan( pDelimiter, sDimensions  );
  If( nDimensionDelimIndex = 0 );
    sDimension = Trim( sDimensions );
  Else;
    sDimension = Trim( SubSt( sDimensions, 1, nDimensionDelimIndex - 1 ) );
    sDimensions = Trim( SubSt( sDimensions, nDimensionDelimIndex + Long( pDelimiter ), Long( sDimensions ) ) );
  EndIf;

  # If a valid dimension has been specified then delete specified views from it
  If( DimensionExists( sDimension ) = 1 );

    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, 'Dimension: ' | sDimension | ' OK' );
    EndIf;

    # Work through all subsets specified in pSubsets
    sSubsets = pSubsets;
    nSubsetDelimIndex = 1;

    While( nSubsetDelimIndex <> 0 );
      nSubsetDelimIndex = Scan( pDelimiter, sSubsets );
      If( nSubsetDelimIndex = 0 );
        sSubset = sSubsets;
      Else;
        sSubset = SubSt( sSubsets, 1, nSubsetDelimIndex - 1 );
        sSubsets = SubSt( sSubsets, nSubsetDelimIndex + Long( pDelimiter ), Long( sSubsets ) );
      EndIf;

      # Check if a wildcard has been used to specify the subset name.
      # If it hasn't then just delete the subset if it exists
      # If it has then search the relevant subsets folder to find the matches
      If( Scan( '*', sSubset ) = 0 );
        If( SubsetExists( sDimension, sSubset ) = 1 );
          If( pDebug >= 1 );
            AsciiOutput( sDebugFile, 'Subset: ' | sSubset | ' OK' );
          EndIf;
          If( pDebug <= 1 );
            If( pMode = 2 );
              SubsetDeleteAllElements( sDimension, sSubset );
            Else;
              ExecuteProcess( cSubProc, 'pDimension', sDimension, 'pSubset', sSubset, 'pMode', pMode, 'pDebug', pDebug );
            EndIf;
          EndIf;
        EndIf;
      Else;
        # Wildcard search string
        sSearch = '.\' | sDimension | '}subs\' | sSubset | '.sub';

        # Find all subsets that match search string
        sFilename = WildcardFileSearch( sSearch, '' );
        While( sFilename @<> '' );
          # Trim .sub off the filename
          sSubset = SubSt( sFilename, 1, Long( sFilename ) - 4 );
          # Delete subset
          If( SubsetExists( sDimension, sSubset ) = 1 );
            If( pDebug >= 1 );
              AsciiOutput( sDebugFile, 'Subset: ' | sSubset | ' OK' );
            EndIf;
            If( pDebug <= 1 );
              If( pMode = 2 );
                SubsetDeleteAllElements( sDimension, sSubset );
              Else;
                ExecuteProcess( cSubProc, 'pDimension', sDimension, 'pSubset', sSubset, 'pMode', pMode, 'pDebug', pDebug );
              EndIf;
            EndIf;
          EndIf;
          sFilename = WildcardFileSearch( sSearch, sFilename );
        End;
      EndIf;
    End;

  # Dimension does not exist
  Else;

    If( pDebug >= 1 );
      AsciiOutput( sDebugFile, 'Dimension: ' | sDimension | ' does not exist' );
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
