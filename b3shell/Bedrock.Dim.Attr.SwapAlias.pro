601,100
602,"Bedrock.Dim.Attr.SwapAlias"
562,"NULL"
586,"Bedrock.Temp"
585,"Bedrock.Temp"
564,
565,"upj:B\WI:iJ`hFTV6yQDVa5UZKyb9Eyxxj`1i2=@OpGcBjqOpMfobriKUi9[dlqc`l_lncXevu`LWJ;h5LbxXxNnnz=sukD9V>S9c;x>5E;ASF12]lHClwze_KW<GBn]xNb]<O<fj77`e>XwAayzjlUg\8Q9l6xy5Xf11_`:0uq]nwie>iTK6;oY4Y0RhcYKC_Kfui@j"
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
589,"."
568,""""
570,
571,All
569,0
592,0
599,1000
560,3
pDimension
pAlias
pDebug
561,3
2
2
1
590,3
pDimension,""
pAlias,""
pDebug,0
637,3
pDimension,"Dimension"
pAlias,"Alias"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,48

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4.
##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName     = GetProcessName();
cUserName         = TM1User();
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile        = GetProcessErrorFileDirectory | cThisProcName | '.' | cTimeStamp | '.' | cRandomInt ;

### Initialise Debug ###
If( pDebug >= 1 );
    # Set debug file name
    sDebugFile = cDebugFile | '.Prolog.debug';
    # List parameters
    AsciiOutput( sDebugFile, 'Parameters: pDimension : ' | pDimension );
    AsciiOutput( sDebugFile, '            pAlias     : ' | pAlias );
EndIf;


nRet = EXECUTEPROCESS('}bedrock.dim.attr.swapalias',
    'pLogOutput', pDebug,
    'pStrictErrorHandling',1,
    'pDim', pDimension,
    'pAlias', pAlias
);

IF(nRet <> 0);
    sMessage = 'the process incurred at least 1 major error and consequently aborted. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% aborted. Check tm1server.log for details.' );
    ProcessError;
EndIf;

### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,4

#****Begin: Generated Statements***
#****End: Generated Statements****

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
