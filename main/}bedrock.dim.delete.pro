601,100
602,"}bedrock.dim.delete"
562,"NULL"
586,
585,
564,
565,"yPELWb<ph9`d_V6@2itRsFn92aL_oc5oLoh=AcuXNRdZ`6hivHFmXkMWN<TCW_=[Y3Inr;1rmK4k0lQ7UVqv_KQbbj=RyvVQM;;X<mmX2C55^cjCuLz=Q>aPnS`_4=ziL\1VPc=XTbOTermUgVuwa<@ztHJbyR=c<at8jdnAm<Gu:ihjH@zziW:K]UQuUf>Tj7>DaZLN"
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
pStrictErrorHandling
pDim
pDelim
561,4
1
1
2
2
590,4
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pDelim,"&"
637,4
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"REQUIRED: Dimension (Delimited list & wildcards (*) acceptable)"
pDelim,"REQUIRED: delimiter character for attribute list. (default value if blank = '&')"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,178
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.dim.delete', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
	    'pDim', '', 'pDelim', '&'
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
# This process deletes a dimension, list of dimensions, or set of dimensions specified by wildcard name match.

# Use case: Intended for development/prototyping.
# 1. During active agile development to remove dimensions due to renaming, change of requirements, etc.
# 2. Clean up unused dimensions prior to system Go Live.

# Note:
# * A valid dimension name pDim or list thereof is mandatory otherwise the process will abort.
# * Attribute dimensions are deliberately excluded because these are automatically cleaned up by removing the base dimension.
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

If( Trim( pDim ) @= '' );
  nErrors = 1;
  sMessage = 'No dimension specified.';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Default delimiter
If( pDelim     @= '' );
    pDelim     = '&';
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

## Dimension delete
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
        # check if dim is used in a cube
        sDimIsUsed ='';
        nDimIsUsed = 0;
        nCubes = DimSiz( '}Cubes' );
        nCube = 1;
        While(nCube <= nCubes);
            sCube = DimNm( '}Cubes' , nCube );
            nDim = 1;
            While(TabDim(sCube,nDim)@<>'' & Subst( sCube , 1 , 1) @<>'}' );
                sDimInCube = TABDIM(sCube,nDim);
                If(sDimInCube@=sDim);
                    sDimIsUsed = sDimIsUsed | sCube | ' ';
                    nDimIsUsed = nDimIsUsed+1;
                EndIf;
                nDim = nDim + 1;
            End;
            nCube = nCube + 1;
        End;     
        
        # Delete if it exists and is not being used in a cube
        If( DimensionExists(sDim) = 0 );
            nErrors = 1;
            sMessage = Expand( 'Dimension "%sDim%" does not exist.' );
            LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
        ElseIF( sDimIsUsed@='');
            DimensionDestroy( sDim );
        Else;
            nErrors = 1;
            sMessage = 'The dimension ' | sDim | ' could not be destroyed as it is being used for ' | NumberToString(nDimIsUsed)  | ' cube(s) :' | sDimIsUsed;
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
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
            # check if dim is used in a cube
            sDimIsUsed ='';
            nDimIsUsed = 0;
            nCubes = DimSiz( '}Cubes' );
            nCube = 1;
            While(nCube <= nCubes);
                sCube = DimNm( '}Cubes' , nCube );
                nDim = 1;
                While(TabDim(sCube,nDim)@<>'' & Subst( sCube , 1 , 1) @<>'}' );
                    sDimInCube = TABDIM(sCube,nDim);
                    If(sDimInCube@=sDim);
                        sDimIsUsed = sDimIsUsed | sCube | ' ';
                        nDimIsUsed = nDimIsUsed+1;
                    EndIf;
                    nDim = nDim + 1;
                End;
                nCube = nCube + 1;
            End;  
            # Delete if it exists and is not being used in a cube
            If( DimensionExists(sDim) = 0 );
                nErrors = 1;
                sMessage = Expand( 'Dimension %sDim% does not exist.' );
                LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
            ElseIF( sDimIsUsed@='');
                DimensionDestroy( sDim );
            Else;
                nErrors = 1;
                sMessage = 'The dimension ' | sDim | ' could not be destroyed as it is being used for ' | NumberToString(nDimIsUsed)  | ' cube(s) :' | sDimIsUsed;
                LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            Endif;
            IF( SubsetGetSize( '}Dimensions' , cTempSub ) < nCountDim - 1 );
              nCountDim = SubsetGetSize( '}Dimensions' , cTempSub );
            ELSE;
            nCountDim = nCountDim - 1;
            ENDIF;
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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully deleted dimensions %pDim%.' );
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
