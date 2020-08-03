601,100
602,"}bedrock.cube.view.delete"
562,"NULL"
586,
585,
564,
565,"m?gMztU7Ts\dJagMy@@qaQwmV5pq@77PyEcKH=vqss^9J4>uU6;=KJ[=aizbiDY_b[IdKGrS^F0I_BDXLay8<\p\WB_1V7BJvQzqOqJ=UBao@iO5EZ;xNFS=dY9u8feM>W<O0D?Jfj34TlUXiKFFARuV<PD2v?NhFuSskgOOoD?xH]>Tse\bwd[j5;rIhjR<N5NhWYOh"
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
560,5
pLogOutput
pStrictErrorHandling
pCube
pView
pDelim
561,5
1
1
2
2
2
590,5
pLogOutput,0
pStrictErrorHandling,0
pCube,""
pView,"}bedrock*"
pDelim,"&"
637,5
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pCube,"REQUIRED: List of Cubes Separated by Delimiter (For all cubes just the wildcard character alone i.e. *)"
pView,"REQUIRED: List of Views Separated by Delimiter. Wildcards Permitted on View Names."
pDelim,"OPTIONAL: Delimiter Character  (default value if blank = '&')"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,228
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.cube.view.delete', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
	    'pCube', '', 'pView', '', 'pDelim', '&'
	);
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This process deletes public views.

# Use case: Intended for development/prototyping or production.
# 1/ After a view has been created to zero or as a data source it needs to be deleted.
# 2/ Clean up public views after Go Live.

# Note:
# This process can work on a single cubes or multiple cubes.
# This process can work on a single view or multiple views.
# When specifying view names wildcards can be included by using the * character. 
#       **Parameter pCube**.
#   - To specify which cubes to delete views from use the pCubes parameter.
#   - To delete views from a single cube only just specify that cube name e.g. Sales.
#   - To delete views from multiple cubes specify each cube name separated by a delimiter e.g. Sales&Inventory&Cashflow.
#   - To delete views from all cubes then set pCubes as *.
#   - If any invalid cubes are specified they will be skipped but the process will continue to process the other cubes.
#       **Parameter pView**.
#   - To specify which views to delete use the pViews parameter.
#   - This parameter must be specified, a blank value will cause the process to terminate.
#   - To delete a single view only just specify that view name e.g. SalesByProduct.
#   - To delete multiple views specify each view name separated by a delimiter e.g. SalesByProduct&SalesByManager&SalesByStore.
#   - When specifying view names wildcards are permitted and all views that match the wildcard search string will be deleted.
#   - The wildcard search string follows the same format as windows based file wildcards.
#   - To delete all views that "start" with a specific string use a trailing * e.g. Bedrock*.
#   - To delete all views that "end" in a specific string use a leading * e.g. *Bedrock.
#   - To delete all views that "contain" a specific string use leading and trailing *'s e.g. *Bedrock*.
#   - To delete a single specific view only don't use *'s at all e.g. Bedrock.
#   - To specify multiple search stings list them all separated by a delimiter e.g. Bedrock*;*Temp;*Test*.
#   - Specific view names and wildcard based names can both be used together e.g. SalesByProduct;Bedrock*.
#       **Parameter pDelim**.
#   - The delimiter can be used when specifying multiple cubes and/or multiple views.
#   - The default delimiter is &.
#   - Any delimiter can be used by specifying a value for pDelimiter.
#   - Choose a delimiter that won't be used in either the wildcard search strings or cube names.
#EndRegion @DOC


##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;


### Constants ###
cThisProcName       = GetProcessName();
cUserName           = TM1User();
cTimeStamp          = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt          = NumberToString( INT( RAND( ) * 1000 ));
cTempSubset         = cThisProcName | '_' | cTimeStamp | '_' | cRandomInt;
cTempFile           = GetProcessErrorFileDirectory | cTempSubset | '.csv';
sMessage            = 	'';
cMsgErrorLevel      = 'ERROR';
cMsgErrorContent    = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo            = 'Process:%cThisProcName% run with parameters pCube:%pCube%, pView:%pView%, pDelim:%pDelim%.' ;  

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

nErrors             = 0;
cDimension          = '}Cubes';

### Validate Parameters ###
nErrors = 0;

# Validate views
If( Trim( pView ) @= '' );
    sMessage        = 'No views specified.';
    nErrors         = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate delimiter
If( Trim( pDelim ) @= '' );
    pDelim     = '&';
EndIf;

### Iterate through cubes ###

# If no cube has been specified then process all cubes
If( Trim( pCube ) @= '' );
    sMessage = 'No cube specified.';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Check for errors before continuing
If( nErrors > 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

# Work through all cubes specified in pCube
sCubes                          = pCube;
nCubeDelimIndex                 = 1;
sDelimiter                      = pDelim;
sMdx = '';
While( nCubeDelimIndex <> 0 );
    nCubeDelimIndex             = Scan( sDelimiter, sCubes  );
    If( nCubeDelimIndex = 0 );
        sCube                   = Trim( sCubes );
    Else;
        sCube                   = Trim( SubSt( sCubes, 1, nCubeDelimIndex - 1 ) );
        sCubes                  = Trim( SubSt( sCubes, nCubeDelimIndex + Long( sDelimiter ), Long( sCubes ) ) );
    EndIf;

    # Create subset of cubes using Wildcard to loop through cubes in pCube with wildcard
    sCubeExp = '"'|sCube|'"';
    sMdxPart = Expand('{TM1FILTERBYPATTERN( TM1SUBSETALL( [}Cubes] ), %sCubeExp% )}');
    IF( sMdx @= ''); 
      sMdx = sMdxPart; 
    ELSE;
      sMdx = sMdx | ' + ' | sMdxPart;
    ENDIF;
End;
    
If( SubsetExists( '}Cubes' , cTempSubset ) = 1 );
    # If a delimited list of cube names includes wildcards then we may have to re-use the subset multiple times
    SubsetMDXSet( '}Cubes' , cTempSubset, sMDX );
Else;
    # temp subset, therefore no need to destroy in epilog
    SubsetCreatebyMDX( cTempSubset, sMDX, '}Cubes' , 1 );
EndIf;
    
    
    # Loop through cubess in subset created based on wildcard
    nCountCubes = SubsetGetSize( '}Cubes' , cTempSubset );
    While( nCountCubes >= 1 );
      sCurrentCube = SubsetGetElementName( '}Cubes' , cTempSubset, nCountCubes );
      # If a valid cube has been specified then delete specified views from it
      If( CubeExists( sCurrentCube ) = 1 );
          If( pLogOutput = 1 );
            LogOutput( 'INFO', Expand( 'Processing cube %sCurrentCube%.' ) );
          EndIf;
          # Work through all views specified in pViews
          sViews                  = pView;
          nViewDelimIndex         = 1;
          sMdxView = '';
  
          While( nViewDelimIndex <> 0 );
              nViewDelimIndex       = Scan( sDelimiter, sViews );
              If( nViewDelimIndex = 0 );
                  sView           = Trim( sViews );
              Else;
                  sView           = Trim( SubSt( sViews, 1, nViewDelimIndex - 1 ) );
                  sViews          = Trim( SubSt( sViews, nViewDelimIndex + Long( sDelimiter ), Long( sViews ) ) );
              EndIf;
  
              # Check if a wildcard has been used to specify the view name.
              # If it hasn't then just delete the view if it exists
              If( Scan( '*', sView ) = 0 );
                  If( ViewExists( sCurrentCube, sView ) = 1 );
                      If( pLogOutput = 1 );
                        LogOutput( 'INFO', Expand( '  Destroying view %sView% in cube %sCurrentCube%.' ) );
                      EndIf;
                      ViewDestroy( sCurrentCube, sView );
                  EndIf;
              # If it has then iterate through '}Views_CubeName' dimension
              Else;
                  sDimViews       = '}Views_' | sCurrentCube ;
                  If( DimensionExists( sDimViews ) = 1 );
                    # Create subset of views using Wildcard to loop through views in current cube
                    sViewExp = '"'|sView|'"';
                    sMdxViewPart = Expand('{TM1FILTERBYPATTERN( {TM1SUBSETALL([%sDimViews%])}, %sViewExp% )}');
                    IF( sMdxView @= ''); 
                      sMdxview = sMdxViewPart; 
                    ELSE;
                      sMdxView = sMdxView | ' + ' | sMdxViewPart;
                    ENDIF;
                    If( SubsetExists( sDimViews, cTempSubset ) = 1 );
                        # If a delimited list of attr names includes wildcards then we may have to re-use the subset multiple times
                        SubsetMDXSet( sDimViews, cTempSubset, sMdxView );
                    Else;
                        # temp subset, therefore no need to destroy in epilog
                        SubsetCreatebyMDX( cTempSubset, sMdxView, sDimViews, 1 );
                    EndIf;
                
                    # Loop through subset of views created based on wildcard
                    nCountView = SubsetGetSize( sDimViews, cTempSubset );
                    While( nCountView >= 1 );
                        sViewEle = SubsetGetElementName( sDimViews, cTempSubset, nCountView );
                        # Validate attribute name in sDim
                        If( ViewExists( sCurrentCube, sViewEle ) = 1 );
                          If( pLogOutput = 1 );
                            LogOutput( 'INFO', Expand( 'Destroying view %sViewEle% in cube %sCurrentCube%.' ) );
                          EndIf;
                            ViewDestroy( sCurrentCube, sViewEle );
                        Endif;
                        nCountView = nCountView - 1;
                    End;
                  EndIf;
              EndIf;
          
          End;
  
      # Cube does not exist
      Else;
          sMessage                = Expand('Cube %sCurrentCube% does not exist.');
          LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
      EndIf;
            
      nCountCubes = nCountCubes - 1;
    End;

### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,28

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully deleted view %pView% from cube %pCube%.' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogoutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );   
    EndIf;
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
