﻿601,100
602,"}bedrock.hier.create"
562,"NULL"
586,
585,
564,
565,"z??u>>3FsIu@;K<w4Y4fn:M[kLa;0YB><@xkj@pG70[fb=22LAGYixy3sAg4A9j6li\joClQ]SHszVULcN=d0yH=?4jUZE`Ps0[\\JY=aySS\Wl=@6v2Z;EN_kbfpFi;hvho`?Iww<94NTDAFko`1n;zjpQ]jPD<^tMI>N`=0s;@U\;hBgvUwPeUm55<z3F8?vd7J:3Y"
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
570,
571,
569,0
592,0
599,1000
560,4
pLogOutput
pDim
pHier
pDelim
561,4
1
2
2
2
590,4
pLogOutput,0
pDim,""
pHier,""
pDelim,"&"
637,4
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pDim,"REQUIRED: Dimension, accepts wildcards (if = *, then all the dimensions)"
pHier,"OPTIONAL: Hierarchy, accepts delimited list"
pDelim,"OPTIONAL: delimiter character for element list. (default value if blank = '&')"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,167
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.create', 'pLogOutput', pLogOutput,
	    'pDim', '', 'pHier', '', 'pDelim', '&'
	);
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0 ~~##
################################################################################################# 

#Region @DOC
# Description:
# This process will create a new hierarchy pHier in target dimension pDim.

# Use case: Intended for Development but could be used in production too.
# 1/ Create a new hierarchy for testing.
# 2/ Create a new hierarchy to reflect new business needs.

# Note:
# If dimension pDim doesn't exist, it will be created.
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName     = GetProcessName();
cUserName         = TM1User();
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cTempSub          = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cMsgInfoContent   = 'User:%cUserName% Process:%cThisProcName% Message:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%, pDelim:%pDelim%.'; 

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;

If( Scan( '*', pDim ) = 0 & Scan( '?', pDim ) = 0 & Scan( pDelim, pDim ) = 0 & Scan( ':', pDim ) > 0 & pHier @= '' );
    # A hierarchy has been passed as dimension. Handle the input error by splitting dim:hier into dimension & hierarchy
    pHier       = SubSt( pDim, Scan( ':', pDim ) + 1, Long( pDim ) );
    pDim        = SubSt( pDim, 1, Scan( ':', pDim ) - 1 );
EndIf;

If( Trim( pDim ) @= '' );
  nErrors = 1;
  sMessage = 'No dimension specified.';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# If blank delimiter specified then convert to default
If( pDelim @= '' );
    pDelim = '&';
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
    ProcessBreak;
EndIf;

# Set up hierachy if not provided
If( Trim( pHier ) @= '' );
  pHier = pDim;
EndIf;

# Loop through dimensions in pDim
sDims = pDim;
nDimDelimiterIndex = 1;
sMdx = '';
# Get 1st dimension
While( nDimDelimiterIndex <> 0 );
    # Extract 1st dimension > sDim
    nDimDelimiterIndex = Scan( pDelim, sDims );
    If( nDimDelimiterIndex = 0 );
        sDim = sDims;
    Else;
        sDim = Trim( SubSt( sDims, 1, nDimDelimiterIndex - 1 ) );
        sDims = Trim( Subst( sDims, nDimDelimiterIndex + Long(pDelim), Long( sDims ) ) );
    EndIf;
    
    ###Creating Dimension if not exist, where no wildcard
    If( Scan( '*', sDim ) = 0 & Scan( '?', sDim ) = 0 & Scan( pDelim, sDim ) = 0 & DimensionExists( sDim ) = 0 );
      DimensionCreate( sDim );
      If( pLogOutput = 1 );
        sMessage = Expand( 'Creating  Dimension %sDim%' );
        LogOutput( 'INFO', Expand( cMsgInfoContent ) );
      EndIf;
    EndIf;
    
      # Create subset of dimensions using Wildcard to loop through dimensions in pDim with wildcard
    sDimExp = '"'|sDim|'"';
    sMdxPart = '{TM1FILTERBYPATTERN( EXCEPT( TM1SUBSETALL( [}Dimensions] ) , TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) , "*:*") ) ,'| sDimExp | ')}';
    IF( sMdx @= ''); 
      sMdx = sMdxPart; 
    ELSE;
      sMdx = sMdx | ' + ' | sMdxPart;
    ENDIF;
End;

If( SubsetExists( '}Dimensions' , cTempSub ) = 1 );
    # If a delimited list of dim names includes wildcards then we may have to re-use the subset multiple times
    SubsetMDXSet( '}Dimensions' , cTempSub, sMDX );
Else;
    # temp subset, therefore no need to destroy in epilog
    SubsetCreatebyMDX( cTempSub, sMDX, '}Dimensions' , 1 );
EndIf;

# Loop through dimensions in subset created based on wildcard
nCountDim = SubsetGetSize( '}Dimensions' , cTempSub );
While( nCountDim >= 1 );
    sDim = SubsetGetElementName( '}Dimensions' , cTempSub, nCountDim );
    # Validate dimension name
    If( DimensionExists(sDim) = 0 );
        nErrors = 1;
        sMessage = Expand( 'Dimension %sDim% does not exist.' );
        LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
    Else;
        If( pLogOutput = 1 );
          sMessage = Expand( 'Dimension %sDim% being processed....' );
          LogOutput( 'INFO', Expand( cMsgInfoContent ) );
        EndIf;
        # Loop through hierarchies in pHier
        sHierarchies              = pHier;
        nDelimiterIndexA    = 1;
        While( nDelimiterIndexA <> 0 );

            nDelimiterIndexA = Scan( pDelim, sHierarchies );
            If( nDelimiterIndexA = 0 );
                sHierarchy   = sHierarchies;
            Else;
                sHierarchy   = Trim( SubSt( sHierarchies, 1, nDelimiterIndexA - 1 ) );
                sHierarchies  = Trim( Subst( sHierarchies, nDelimiterIndexA + Long(pDelim), Long( sHierarchies ) ) );
            EndIf;
            ###Creating Hierarchy
            If( HierarchyExists( sDim, sHierarchy ) = 1 & sDim @<> sHierarchy );
                nErrors = 1;
                sMessage = 'The Hierachy ' | pHier | ' already exists.';
                LogOutput( cMsgErrorLevel, sMessage );
            ElseIf( sDim @<> sHierarchy );
                HierarchyCreate( sDim , sHierarchy );
                If( pLogOutput = 1 );
                  sMessage = Expand( 'Creating hierarchy %sHierarchy% in Dimension %sDim%' );
                  LogOutput( 'INFO', Expand( cMsgInfoContent ) );
                EndIf;
            EndIf;
        End;
    EndIf;
    
    nCountDim = nCountDim - 1;
End;
  

### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,26

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
Else;
    sProcessAction     = Expand( 'Process:%cThisProcName% successfully created the %pHier% hierarchy in the %pDim% dimension.' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogoutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );   
    EndIf;
EndIf;



### End Epilog ###
576,
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
