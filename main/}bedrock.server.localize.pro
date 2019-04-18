601,100
602,"}bedrock.server.localize"
562,"NULL"
586,
585,
564,
565,"xvw@]qxBc0ZPbdYy6?RaydoBayjZqxV_lJ6dUj6z\CL:snFaY3G=xwAl@6J3z7ZWSI4HTSf1jRdKUBo^T5X3Z`xY[`KzwiN^93X__1j6[xSy`nek[GgEHq07hI0FdCqB@kAkA:jj>pm\A\[JouE91t<ZJodcUvD`ety17<RYXWwCBjt9\QPnZSVcRSF@;ik>2ViVt1h4"
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
pLogOutput
pDim
pDelim
561,3
1
2
2
590,3
pLogOutput,0
pDim,""
pDelim,"&"
637,3
pLogOutput,"Optional: write parameters and action summary to server message log (Boolean True = 1)"
pDim,"Required: Dimension (Delimited list & wildcards (*) acceptable)"
pDelim,"Required: delimiter character for dimension list. (Defaults to & if blank)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,147

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~ Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0 ~~##
################################################################################################# 

#Region @DOC
# Description:
# This process localizes cube & dimension names & optionally localizes attributes for any dimension

# Note:
# In no dimension is passed, just cube & dimension names will be localized
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

### Check for errors before continuing
If( nErrors <> 0 );
  ProcessBreak;
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


## Localization of attributes for any dimension passed
# Loop through dimensions in pDim 
sDims               = Trim( pDim );
nDimDelimiterIndex  = 1;
# Get 1st dimension
While( nDimDelimiterIndex <> 0 );
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
        Endif;
    Else;
        # Create subset of dimensions using Wildcard to loop through dimensions in pDim with wildcard
        sDimExp = '"'|sDim|'"';
        sMdx = '{TM1FILTERBYPATTERN( EXCEPT ( EXCEPT ( TM1SUBSETALL( [}Dimensions] ) , TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) , "*:*") ), TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) , "}ElementAttributes_*") ) ,'| sDimExp | ')}';
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
            Endif;
            nCountDim = nCountDim - 1;
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

575,24

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
