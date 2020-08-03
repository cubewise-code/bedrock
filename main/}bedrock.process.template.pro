601,100
602,"}bedrock.process.template"
562,"NULL"
586,
585,
564,
565,"sP?lswkLDI1M@C0=VCUaBr=N>fOTutdN59`uP?zAY@G4;2HF>Dm8oRJN:fZQAUGuT74Q5`R?dVuNlgGtM[RK_TlfJXzF7yMu4j7AQ<3o@2@rbS0@Rxe\o_XJw5LXvn5d7e^1_eiWqjEGDpjp<9z_e=AF<i]ahDVw[Ho6O@[GYnTE1keli]=G5NOQB4py`^h5t:]MY<E^"
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
560,3
pLogOutput
pStrictErrorHandling
pTemp
561,3
1
1
1
590,3
pLogOutput,0
pStrictErrorHandling,0
pTemp,1
637,3
pLogOutput,"Write status messages to tm1server.log file?"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pTemp,"Use temporary objects for views & subsets?"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,183
################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
### CHANGE HISTORY:
### MODIFICATION DATE 	CHANGED BY 	    COMMENT
### YYYY-MM-DD 		    Developer Name 	Creation of Process
### YYYY-MM-DD 		    Developer Name 	Reason for modification here
################################################################################################# 
#Region @DOC
# Description:
# A description of what this process does here.

# Use case:
# A description of the use cast for this process does here.

# Note:
# * List any notes for users to be aware of here.
#EndRegion @DOC
################################################################################################# 

################################################################################################# 
#Region Process Declarations
### Process Parameters
# a short description of what the process does goes here in cAction variable, e.g. "copied data from cube A to cube B". This will be written to the message log if pLogOutput=1
cAction             = 'ran with no action';
cParamArray         = '';
# to use the parameter array remove the line above and uncomment the line below, adding the needed parameters in the provided format
#cParamArray         = 'pLogOutput:%pLogOutput%, pTemp:%pTemp%';

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');

### Standard Constants
cThisProcName       = GetProcessName();
cUserName           = TM1User();
cTimeStamp          = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt          = NumberToString( INT( RAND( ) * 1000 ));
cTempObjName        = Expand('%cThisProcName%_%cTimeStamp%_%cRandomInt%');
cViewClr            = '}bedrock_clear_' | cTempObjName;
cViewSrc            = '}bedrock_source_' | cTempObjName;
cMsgErrorLevel      = 'ERROR';
cMsgErrorContent    = 'Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo            = 'Process:%cThisProcName% run with parameters %cParamArray%';
sDelimEleStart      = '¦';
sDelimDim           = '&';
sDelimEle           = '+';
nProcessReturnCode  = 0;
nErrors             = 0;
nMetadataRecordCount= 0;
nDataRecordCount    = 0;

### Process Specific Constants
cCubeSrc            = 'Source Cube';
cCubeTgt            = 'Target Cube';

#EndRegion Process Declarations
################################################################################################# 

### LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

################################################################################################# 
#Region Validate Parameters

# pLogOutput
If( pLogOutput >= 1 );
    pLogOutput = 1;
Else;
    pLogOutput = 0;
EndIf;
    
# pTemp
If( pTemp >= 1 );
    pTemp = 1;
Else;
    pTemp = 0;
EndIf;

# Validate source cube
If( Trim( cCubeSrc ) @= '' );
    nErrors = nErrors + 1;
    sMessage = 'No source cube specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( CubeExists( cCubeSrc ) = 0 );
    nErrors = nErrors + 1;
    sMessage = Expand( 'Invalid source cube specified: %cCubeSrc%.');
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate target cube
If( Trim( cCubeTgt ) @= '' );
    nErrors = nErrors + 1;
    sMessage = 'No target cube specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( CubeExists( cCubeTgt ) = 0 );
    nErrors = nErrors + 1;
    sMessage = Expand( 'Invalid target cube specified: %cCubeTgt%.');
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# If any parameters fail validation then set data source of process to null and go directly to epilog
If( nErrors > 0 );
    DataSourceType = 'NULL';
    If( pStrictErrorHandling = 1 ); 
        ProcessQuit; 
    Else;
        ProcessBreak;
    EndIf;
EndIf;

################################################################################################# 
#EndRegion Validate Parameters

### If required switch transaction logging off (this should be done AFTER the escape/reject if parameters fail validation and BEFORE the zero out commences)
nCubeLogChanges = CubeGetLogChanges( cCubeTgt );
CubeSetLogChanges( cCubeTgt, 0 );


################################################################################################# 
#Region - ZeroOut

sProc       = '}bedrock.cube.data.clear';
# Set filter as per logic requirement of the ZeroOut
sFilter     = 'Dim1' | sDelimEleStart | 'El1' | sDelimDim | 'Dim2' | sDelimEleStart | 'El2';
nRet        = ExecuteProcess( sProc, 'pLogOutput', pLogOutput,
  'pStrictErrorHandling', pStrictErrorHandling,
	'pCube', cCubeTgt, 'pView', cViewClr, 'pFilter', sFilter,
	'pDimDelim', sDelimDim, 'pEleStartDelim', sDelimEleStart, 'pEleDelim', sDelimEle,
	'pTemp', pTemp 
);
If( nRet <> ProcessExitNormal() );
    nErrors = nErrors + 1;
    sMessage= 'Error in ZeroOut.';
    DataSourceType = 'NULL';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

#EndRegion - ZeroOut
################################################################################################# 

################################################################################################# 
#Region - DataSource

sProc   = '}bedrock.cube.view.create';
# Set filter as per logic requirement of the data source processing
sFilter = Expand('Dim1%sDelimEleStart%El1%%sDelimDim%Dim2%sDelimEleStart%El2%');
# Adjust parameters for skipping of blanks / consols / rule calcs as required
bSuppressNull   = 1;
bSuppressC      = 1;
bSuppressRule   = 1;
nRet = ExecuteProcess( sProc, 'pLogOutput', pLogOutput, 
  'pStrictErrorHandling', pStrictErrorHandling,
	'pCube', cCubeSrc, 'pView', cViewSrc, 'pFilter', sFilter,
	'pSuppressZero', bSuppressNull, 'pSuppressConsol', bSuppressC, 'pSuppressRules', bSuppressRule,
	'pDimDelim', sDelimDim, 'pEleStartDelim', sDelimEleStart, 'pEleDelim', sDelimEle,
	'pTemp', pTemp
);
If( nRet <> ProcessExitNormal() );
    nErrors = nErrors + 1;
    sMessage= 'Error in source view creation.';
    DataSourceType = 'NULL';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Assign data source
If( nErrors = 0 );
    DatasourceType          = 'VIEW';
    DatasourceNameForServer = cCubeSrc;
    DatasourceCubeView      = cViewSrc;
EndIf;

#EndRegion - DataSource
################################################################################################# 

### End Prolog ###
573,7
#****Begin: Generated Statements***
#****End: Generated Statements****

If( pLogOutput >= 1 );
   nMetadataRecordCount = nMetadataRecordCount + 1;
EndIf;

574,7
#****Begin: Generated Statements***
#****End: Generated Statements****

If( pLogOutput >= 1 );
   nDataRecordCount = nDataRecordCount + 1;
EndIf;

575,29
################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#****Begin: Generated Statements***
#****End: Generated Statements****

### If required switch transaction logging back on 
CubeSetLogChanges( cCubeTgt, nCubeLogChanges );

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully %cAction%. %nDataRecordCount% records processed.' );
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
1217,0
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
