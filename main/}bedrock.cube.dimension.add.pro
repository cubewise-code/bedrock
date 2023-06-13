601,100
602,"}bedrock.cube.dimension.add"
562,"NULL"
586,
585,
564,
565,"aaVYwvZ=oxOxo0p4Vj4WTTY0f:fQQ9nVYy_dWjaStQVYREqaCL9E]Y5YQHa\EiN\dRM9rXJw_F85lRQ1tUKil2KCa15`uKEcrO?r;>TcT;S9WlMfrTToH9oAKuIJOB6]R6i49p4UJm2^o38^yWABamcR@?NT=e7DxeFZU5s_DNJ6S9DYR:I^=Y<fs_tPh\tLZ9n^vRGM"
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
560,10
pLogOutput
pStrictErrorHandling
pCube
pDim
pDimIndex
pIncludeData
pEle
pIncludeRules
pCtrlObj
pTemp
561,10
1
1
2
2
1
1
2
1
1
1
590,10
pLogOutput,0
pStrictErrorHandling,0
pCube,""
pDim,""
pDimIndex,1
pIncludeData,0
pEle,""
pIncludeRules,2
pCtrlObj,0
pTemp,1
637,10
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pCube,"REQUIRED: Cube name"
pDim,"REQUIRED: Dimension to be added"
pDimIndex,"REQUIRED: Dimension number of the new dimension in the cube"
pIncludeData,"OPTIONAL: If 1 then data is kept (copied through clone cube)"
pEle,"REQUIRED: if IncludeData flag =1: Element of new dimension where to store data"
pIncludeRules,"Unload and reload the rule (0 = do not keep the rule, 1 = unload the rule, 2 = unload the rule and reload on new cube)"
pCtrlObj,"OPTIONAL: Allow overwrite control cubes (default = 0)"
pTemp,"OPTIONAL: Delete the clone cube (1 = delete, 0 = not delete)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,367
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.cube.dimension.add', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pCube', '', 'pDim', '', 'pDimIndex', 1,
    	'pIncludeData', 0, 'pEle', '', 'pIncludeRules', 2,
    	'pCtrlObj', 0, 'pTemp', 1
	);
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This TI adds a dimension to a cube that has already been built with the ability to preserve data.

# Use case: Intended for development/prototyping.
# 1/ Rebuild existing cube with extra dimension without losing data.

# Note:
# Naturally, a valid target cube name (pCube) is mandatory otherwise the process will abort.
# Also, a valid new dimension name (pDim) is mandatory otherwise the process will abort.
# When data needs to be kept (using pIncludeData) a valid element (pEle) must be specified where to store the data in new dimension.
# Rule can be kept as backup file only or reloaded back.
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName   = GetProcessName();
cUserName       = TM1User();
cTimeStamp      = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
cTempSub        = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cMsgErrorLevel  = 'ERROR';
cMsgErrorContent= 'Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo        = 'Process:%cThisProcName% run with parameters pCube:%pCube%, pDim:%pDim%, pDimIndex:%pDimIndex%, pIncludeData:%pIncludeData%, pEle:%pEle%, pIncludeRules:%pIncludeRules%, pCtrlObj:%pCtrlObj%, pTemp:%pTemp%.';

## check operating system
If( SubSt( GetProcessErrorFileDirectory, 2, 1 ) @= ':' );
  sOS = 'Windows';
  sOSDelim = '\';
ElseIf( Scan( '/', GetProcessErrorFileDirectory ) > 0 );
  sOS = 'Linux';
  sOSDelim = '/';
Else;
  sOS = 'Windows';
  sOSDelim = '\';
EndIf;

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;
# Validate cube
cDimCount = 0;
If( Trim( pCube ) @= '' );
    nErrors = nErrors + 1;
    sMessage = 'No cube specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( CubeExists( pCube ) = 0 );
    nErrors = nErrors + 1;
    sMessage = Expand( 'Invalid cube specified: %pCube%.');
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
Else;
    cDimCount = CubeDimensionCountGet(pCube);
EndIf;

# Don't allow system cubes to be modified
If( SubSt( pCube, 1, 1 ) @= '}' & pCtrlObj <= 0 );
    nErrors = nErrors + 1;
    sMessage = Expand( 'Do not modify system cubes: %pCube%.');
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate index
If( pDimIndex = 0 );
    nErrors = nErrors + 1;
    sMessage = Expand( 'Index for new dimension is a REQUIRED parameter!');
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( pDimIndex > cDimCount + 1 );
    nErrors = nErrors + 1;
    sMessage = Expand( 'Cube %pCube% has %cDimCount% dimensions. %pDimIndex% is not valid for the new dimension index!');
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate dimension
If( Trim( pDim ) @= '' );
    nErrors = nErrors + 1;
    sMessage = 'No dimension specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( DimensionExists( pDim ) = 0 );
    nErrors = nErrors + 1;
    sMessage = Expand( 'New dimension: %pDim% does not exist');
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# check element chosen in new dimension
If( pIncludeData = 1 & Trim(pEle)@='' );
    nErrors = nErrors + 1;
    sMessage = Expand( 'No element specified in new dimension %pDim% to store cube data.');
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

If( pIncludeData = 1 & DIMIX(pDim, pEle)=0 );
    nErrors = nErrors + 1;
    sMessage = Expand( 'Invalid element %pEle% specified for the new dimension %pDim% to store cube data.');
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

IF(pIncludeRules = 1 % pIncludeRules = 2);
    cCubeRuleFileName = '.' | sOSDelim | pCube | '.rux';
    If(FileExists(Lower(cCubeRuleFileName)) = 0);
        pIncludeRules = 0;
        LogOutput( 'INFO', Expand( 'No rule found for %pCube%.' ) );
    Endif;
Endif;  

### Determine number of dims in source cube & create strings to check and recreate ###
nCount = 1;
sDimString = '';
sDimCheck = '';
sDelim = '+';
nNewFound = 0;
nIncrement = 1;
While( TabDim( pCube, nCount ) @<> '' );
  sDim = TabDim( pCube, nCount );
  IF(nCount = pDimIndex & nNewFound = 0);
    sNewDim = pDim;
    nNewFound = 1;
    nIncrement = 0;
  else;
    sNewDim = sDim;
    nIncrement = 1;
  Endif;  
  sDimCheck = sDimCheck|'+'|sDim|'+';
  sDimString = sDimString|'+'|sNewDim;
  nCount = nCount + nIncrement;
End;
nDimensionCount = nCount;

# Cover case of new dimension in last position (pDimIndex = cDimCount+1)
If( nDimensionCount = pDimIndex & nNewFound = 0 );
    nNewFound = 1;
    sNewDim=pDim;
    sDimString = sDimString|'+'|sNewDim;
EndIf;

# Remove any leading +
IF( Subst( sDimString , 1 , 1 ) @= '+' );
    sDimString      = Subst ( sDimString , 2, Long(sDimString)-1 );
EndIf;

IF( Scan('+'|Lower(pDim)|'+', Lower(sDimCheck)) > 0 );
    nErrors = nErrors + 1;
    sMessage = Expand( 'The chosen new dimension %pDim% already exists in cube %pCube%.');
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
Endif;

# Check if cube exceeds current max dimenions
If( nDimensionCount > 27 );
    sMessage = 'Process needs to be modified to handle cubes with more than 27 dimensions';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

######  CALLING THE STEP PROCESSES #####

# Keep the rule
IF(pIncludeRules = 1 % pIncludeRules = 2);
  
  sProc = '}bedrock.cube.rule.manage';
  nRet = ExecuteProcess( sProc,
    'pLogOutput', pLogOutput,
    'pStrictErrorHandling', pStrictErrorHandling,
    'pCube', pCube,
    'pMode', 'UNLOAD'
    );
    
  IF(nRet <> 0);
    sMessage = 'Error unloading the rule for %pCube%.';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    If( pStrictErrorHandling = 1 ); 
        ProcessQuit; 
    Else;
        ProcessBreak;
    EndIf;
  ENDIF;
  
Endif; 

# create clone cube with data
IF(pIncludeData = 1);
  
    pCloneCube = pCube | '_Clone';
    nIncludeRules = IF(pIncludeRules = 1 % pIncludeRules = 2, 1, 0);
    nSuppressRules = IF(nIncludeRules = 1,  1, 0);
  
    sProc = '}bedrock.cube.clone';
    nRet = ExecuteProcess( sProc,
        'pLogOutput', pLogOutput,
        'pStrictErrorHandling', pStrictErrorHandling,
        'pSrcCube', pCube,
        'pTgtCube', pCloneCube,
        'pIncludeRules', nIncludeRules,
        'pIncludeData', pIncludeData,
        'pSuppressRules', nSuppressRules,
        'pTemp', pTemp,
        'pCubeLogging', 0
        );

    IF(nRet <> 0);
        sMessage = 'Error creating cloned cube for keeping data.';
        nErrors = nErrors + 1;
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        If( pStrictErrorHandling = 1 ); 
            ProcessQuit; 
        Else;
            ProcessBreak;
        EndIf;
    ENDIF;
Endif;

# recreate the cube
sProc = '}bedrock.cube.create';
nRet = ExecuteProcess( sProc,
    'pLogOutput', pLogOutput,
    'pStrictErrorHandling', pStrictErrorHandling,
    'pCube', pCube,
    'pDims', sDimString,
    'pRecreate', 1,
    'pDelim', sDelim
    );

IF(nRet <> 0);
    sMessage = Expand('Error recreating the cube: %pCube%.');
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    If( pStrictErrorHandling = 1 ); 
        ProcessQuit; 
    Else;
        ProcessBreak;
    EndIf;
ENDIF;

# copy back the data
IF(pIncludeData = 1);
    sEleStartDelim = '¦';
    sMappingToNewDims = pDim|sEleStartDelim|pEle;
  
    nRet = ExecuteProcess('}bedrock.cube.data.copy.intercube',
  	'pLogOutput',pLogOutput,
  	'pStrictErrorHandling', pStrictErrorHandling,
  	'pSrcCube',pCloneCube,
  	'pFilter','',
  	'pTgtCube',pCube,
  	'pMappingToNewDims',sMappingToNewDims,
        'pSuppressConsol', 1,
        'pSuppressRules', nSuppressRules,
  	'pZeroTarget',0,
  	'pZeroSource',0,
  	'pFactor',1,
  	'pDimDelim','&',
  	'pEleStartDelim',sEleStartDelim,
  	'pEleDelim','+',
  	'pTemp',pTemp,
  	'pCubeLogging',0);
    
    IF(nRet <> 0);
        sMessage = Expand('Error copying back the data from clone cube: %pCloneCube%.');
        nErrors = nErrors + 1;
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        If( pStrictErrorHandling = 1 ); 
            ProcessQuit; 
        Else;
            ProcessBreak;
        EndIf;
    ENDIF;
  
    # destroy clone cube
    IF(pTemp=1);
        sProc = '}bedrock.cube.delete';
        nRet = ExecuteProcess( sProc,
            'pLogOutput', pLogOutput,
            'pStrictErrorHandling', pStrictErrorHandling,
            'pCube', pCloneCube,
            'pCtrlObj', 0
            );

        IF(nRet <> 0);
            sMessage = Expand('Error deleting the clone cube: %pCloneCube%.');
            nErrors = nErrors + 1;
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            If( pStrictErrorHandling = 1 ); 
                ProcessQuit; 
            Else;
                ProcessBreak;
            EndIf;
        ENDIF;
    Endif;

Endif; 

# reload the rule
IF(pIncludeRules = 2);
  
    sProc = '}bedrock.cube.rule.manage';

    nRet = ExecuteProcess( sProc,
        'pLogOutput', pLogOutput,
        'pStrictErrorHandling', pStrictErrorHandling,
        'pCube', pCube,
        'pMode', 'LOAD'
        );
    
    IF(nRet <> 0);
      sMessage = Expand('Error reloading the rule for %pCube%.');
      nErrors = nErrors + 1;
      LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
      # Create error rule file 
      cErrorRuleName = 'ErrorRuleFile.rux';
      
      IF(FileExists( Lower(cErrorRuleName) ) = 0 );
        sFile = '.' | sOSDelim | Lower(cErrorRuleName);
        LogOutput(cMsgErrorLevel, 'Rule could not be attached due to invalid !Dimension references. Please recover from the backup and fix manually.');
      ENDIF;
      
      ExecuteProcess( sProc,
      'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
      'pCube', pCube,
      'pFileName', Lower(cErrorRuleName),
      'pMode', 'LOAD'
      );
      If( pStrictErrorHandling = 1 ); 
          ProcessQuit; 
      Else;
          ProcessBreak;
      EndIf;
    ENDIF;
  
Endif; 

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully added dimension %pDim%.' );
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
920,0
921,""
922,""
923,0
924,""
925,""
926,""
927,""
