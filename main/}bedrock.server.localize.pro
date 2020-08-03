601,100
602,"}bedrock.server.localize"
562,"NULL"
586,
585,
564,
565,"dGb9ajgKeMbgk:>x<r:Sgk19N=;mgz?eq:354`;I@\ZO9ck:dxtr7tV^Rfg7JzbDtx;iqMz\rHds[GI0otKzTJk1KYcDpsuozBM>ko7c73`a[:^Sw]5LX:@ingU?np]j<5]quFvsV]xWtZVRFc7EGXHu\agM0VZ2h3Z6RT841z2A<rhb5m@41oM;IM=gNmN_^k[5XdTS"
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
560,6
pLogOutput
pStrictErrorHandling
pDim
pCube
pDelim
pSub
561,6
1
1
2
2
2
1
590,6
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pCube,""
pDelim,"&"
pSub,0
637,6
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"OPTIONAL: Dimension (Delimited list & wildcards (*) acceptable)"
pCube,"OPTIONAL: Cube( Delimited list & wildcards (*) acceptable)"
pDelim,"OPTIONAL: delimiter character for dimension list. (Defaults to & if blank)"
pSub,"OPTIONAL: If localizing attributes for a dimension also localize subset names?"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,263
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.server.localize', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
	    'pDim', '', 'pCube', '', 'pDelim', '&', 'pSub', 0
    );
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~ Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0 ~~##
################################################################################################# 

#Region @DOC
# Description:
# This process localizes cube & dimension names & optionally localizes:
# * attributes for specified dimension(s)
# * subsets for specified dimension(s)
# * views for specified cube(s)

# Note:
# If no dimension or cube names are passed, then just cube & dimension names will be localized.
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
cLogInfo          = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pDelim:%pDelim%.'; 

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;

If( Trim( pDelim ) @= '' );
    pDelim = '&';
EndIf;

If( pSub <> 1 );
    pSub = 0;
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

IF( CubeExists( '}CubeAttributes' ) = 0 );
    CubeAttrInsert( '', 'Caption', 'S');
ELSEIF( DimIx( '}CubeAttributes', 'Caption' ) = 0 );
    CubeAttrInsert( '', 'Caption', 'S');
ENDIF;
IF( CubeExists( '}DimensionAttributes' ) = 0 );
    DimensionAttrInsert( '', 'Caption', 'S');
ELSEIF( DimIx( '}DimensionAttributes', 'Caption' ) = 0 );
    DimensionAttrInsert( '', 'Caption', 'S');
ENDIF;

IF( CubeExists( '}LocalizedCubeAttributes' ) = 0 );
    CubeAttrPutS( '', '}CubeAttributes', 'Caption', 'en');
ENDIF;
IF( CubeExists( '}LocalizedDimensionAttributes' ) = 0 );
    DimensionAttrPutS( '', '}Cultures', 'Caption', 'en');
ENDIF;

### Localization of attributes (& subsets) for any dimension passed
# Loop through dimensions in pDim 
sDims               = Trim( pDim );
nDimDelimiterIndex  = 1;
# Get 1st dimension
While( pDim @<> '' & nDimDelimiterIndex > 0 );
    # Extract 1st dimension > sDim
    nDimDelimiterIndex = Scan( pDelim, sDims );
    If( nDimDelimiterIndex = 0 );
        sDim        = sDims;
    Else;
        sDim        = Trim( SubSt( sDims, 1, nDimDelimiterIndex - 1 ) );
        sDims       = Trim( Subst( sDims, nDimDelimiterIndex + Long(pDelim), Long( sDims ) ) );
    EndIf;
    
    # Check if sDim has wildcard
    If( Scan( '*', sDim ) = 0);
        If( DimensionExists(sDim) = 0 );
            nErrors = 1;
            sMessage = Expand( 'Dimension "%sDim%" does not exist.' );
            LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
        Else;
            sAttrDim = '}ElementAttributes_' | sDim;
            sLocAttrDim = '}LocalizedElementAttributes_' | sDim; 
            sSubDim = '}Subsets_' | sDim;
            sSubAttr = '}SubsetAttributes_' | sDim;
            sLocSubAttr = '}LocalizedSubsetAttributes_' | sDim;
            IF( CubeExists( sAttrDim ) = 0 );
                AttrInsert( sDim, '', 'Caption', 'S' );
            ELSEIF( DimIx( sAttrDim, 'Caption' ) = 0 );
                AttrInsert( sDim, '', 'Caption', 'S' );
            ENDIF;
            IF( CubeExists( sLocAttrDim ) = 0 );
                sFirstEle = '';
                sFirstEle = DimNm( sDim, 1 );
                IF( sFirstEle @<> '' );
                    AttrPutS( '', sDim, sFirstEle, 'Caption', 'en' );
                ENDIF;
            ENDIF;
            If( pSub = 1 & DimSiz( sSubDim ) > 0 );
                If( CubeExists( sSubAttr ) = 0 );
                    SubsetAttrInsert( sDim, '', 'Caption', 'S' );
                EndIf;
                If( CubeExists( sLocSubAttr ) = 0 );
                    sSub = DimNm( sSubDim, 1 );
                    If( Scan( ':', sSub ) > 0 );
                        sDim = sDim |':'| SubSt( sSub, 1, Scan( ':', sSub ) - 1 );
                        sSub = SubSt( sSub, Scan( ':', sSub ) + 1, Long( sSub ) );
                    EndIf;
                    SubsetAttrPutS( '', sDim, sSub, 'Caption', 'en' );
                EndIf;
            EndIf;
        Endif;
    Else;
        # Create subset of dimensions using Wildcard to loop through dimensions in pDim with wildcard
        sMdx = Expand('{TM1FILTERBYPATTERN( EXCEPT ( EXCEPT ( TM1SUBSETALL( [}Dimensions] ) , TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) , "*:*") ), TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) , "}ElementAttributes_*") ) , "%sDim%" )}');
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
            If( DimensionExists(sDim) = 0 );
                nErrors = 1;
                sMessage = Expand( 'Dimension %sDim% does not exist.' );
                LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
            Else;
                sAttrDim = '}ElementAttributes_' | sDim;
                sLocAttrDim = '}LocalizedElementAttributes_' | sDim; 
                sSubDim = '}Subsets_' | sDim;
                sSubAttr = '}SubsetAttributes_' | sDim;
                sLocSubAttr = '}LocalizedSubsetAttributes_' | sDim;
                IF( CubeExists( sAttrDim ) = 0 );
                    AttrInsert( sDim, '', 'Caption', 'S' );
                ELSEIF( DimIx( sAttrDim, 'Caption' ) = 0 );
                    AttrInsert( sDim, '', 'Caption', 'S' );
                ENDIF;
                IF( CubeExists( sLocAttrDim ) = 0 );
                    sFirstEle = '';
                    sFirstEle = DimNm( sDim, 1 );
                    IF( sFirstEle @<> '' );
                        AttrPutS( '', sDim, sFirstEle, 'Caption', 'en' );
                    ENDIF;
                ENDIF;
                If( pSub = 1 );
                    If( CubeExists( sSubAttr ) = 0 );
                        SubsetAttrInsert( sDim, '', 'Caption', 'S' );
                    EndIf;
                    If( CubeExists( sLocSubAttr ) = 0 & DimSiz( sSubDim ) > 0 );
                        sSub = DimNm( sSubDim, 1 );
                        If( Scan( ':', sSub ) > 0 );
                            sDim = sDim |':'| SubSt( sSub, 1, Scan( ':', sSub ) - 1 );
                            sSub = SubSt( sSub, Scan( ':', sSub ) + 1, Long( sSub ) );
                        EndIf;
                        SubsetAttrPutS( '', sDim, sSub, 'Caption', 'en' );
                    EndIf;
                EndIf;
            Endif;
            nCountDim = nCountDim - 1;
        End;
    EndIf;
End;

### Localization of views for any cube passed
# Loop through cubes in pCube 
sCubes              = Trim( pCube );
nCubDelimiterIndex  = 1;
# Get 1st Cube
While( pCube @<> '' & nCubDelimiterIndex > 0 );
    # Extract 1st cube > sCube
    nCubDelimiterIndex = Scan( pDelim, sCubes );
    If( nCubDelimiterIndex = 0 );
        sCube       = sCubes;
    Else;
        sCube       = Trim( SubSt( sCubes, 1, nCubDelimiterIndex - 1 ) );
        sCubes      = Trim( Subst( sCubes, nCubDelimiterIndex + Long(pDelim), Long( sCubes ) ) );
    EndIf;
    
    # Check if sCube has wildcard
    If( Scan( '*', sCube ) = 0);
        If( CubeExists(sCube) = 0 );
            nErrors = 1;
            sMessage = Expand( 'Cube "%sCube%" does not exist.' );
            LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
        Else;
            sViewDim = '}Views_' | sCube;
            sViewAttr = '}ViewAttributes_' | sCube;
            sLocViewAttr = '}LocalizedViewAttributes_' | sCube;
            IF( CubeExists( sViewAttr ) = 0 & DimensionExists( sViewDim ) = 1 );
                ViewAttrInsert( sCube, '', 'Caption', 'S' );
            ENDIF;
            IF( CubeExists( sLocViewAttr ) = 0 & DimSiz( sViewDim ) >= 1 );
                ViewAttrPutS( '', sCube, DimNm( sViewDim, 1 ), 'Caption', 'en' );
            ENDIF;
        Endif;
    Else;
        # Create subset of cubes using Wildcard to loop through cubes in pCube with wildcard
        sMdx = Expand('{TM1FILTERBYPATTERN( TM1SUBSETALL( [}Cubes] ),  "%sCube%" )}');
        If( SubsetExists( '}Cubes' , cTempSub ) = 1 );
            # If a delimited list of Cub names includes wildcards then we may have to re-use the subset multiple times
            SubsetMDXSet( '}Cubes' , cTempSub, sMDX );
        Else;
            # temp subset, therefore no need to destroy in epilog
            SubsetCreatebyMDX( cTempSub, sMDX, '}Cubes' , 1 );
        EndIf;
        
        # Loop through cubes in subset created based on wildcard
        nCountCub = SubsetGetSize( '}Cubes' , cTempSub );
        While( nCountCub >= 1 );
            sCube = SubsetGetElementName( '}Cubes' , cTempSub, nCountCub );
            If( CubeExists(sCube) = 0 );
                nErrors = 1;
                sMessage = Expand( 'Cube %sCube% does not exist.' );
                LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
            Else;
                sViewDim = '}Views_' | sCube;
                sViewAttr = '}ViewAttributes_' | sCube;
                sLocViewAttr = '}LocalizedViewAttributes_' | sCube;
                IF( CubeExists( sViewAttr ) = 0 & DimensionExists( sViewDim ) = 1 );
                    ViewAttrInsert( sCube, '', 'Caption', 'S' );
                ENDIF;
                IF( CubeExists( sLocViewAttr ) = 0 & DimSiz( sViewDim ) >= 1 );
                    ViewAttrPutS( '', sCube, DimNm( sViewDim, 1 ), 'Caption', 'en' );
                ENDIF;
            Endif;
            nCountCub = nCountCub - 1;
        End;
    EndIf;
End;

### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,27

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
    sProcessAction = Expand( 'Process:%cThisProcName% localized cube & dimension names & localized attributes for dimensions %pDim%.' );
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
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
