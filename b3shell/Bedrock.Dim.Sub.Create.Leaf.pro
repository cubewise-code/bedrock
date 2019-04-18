601,100
602,"Bedrock.Dim.Sub.Create.Leaf"
562,"NULL"
586,
585,
564,
565,"xK6;reX71_ict_>VlHtGB4pja3\rVkskSmu7b2\]H?SIs?vBntX<AzkL=WFZbK=uy74wLJHq0U8]l@8uSfefLmWNYZ`7GkUF19vOdKDBk=Q;S9f^mUfP[>^6v`[l5YkWb_9wVk@n4`ET];pL4_MWGDhC:n@mjRx5uD<sB0\7\vh@FyD9JwQn>fi87qwIQ]@Na4G2=cUt"
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
pAddToSubset
pExclusions
pDelimiter
pAlias
pDebug
561,7
2
2
1
2
2
2
1
590,7
pDimension,""
pSubset,""
pAddToSubset,0
pExclusions,""
pDelimiter,"&"
pAlias,""
pDebug,0
637,7
pDimension,"Dimension"
pSubset,"Subset"
pAddToSubset,"Add to an existing Subset (Boolean: 1=True)"
pExclusions,"Excluded Elements"
pDelimiter,"Delimiter"
pAlias,"Assign an alias to the subset"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,56

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
  sDebugFile = cDebugFile | 'Prolog.debug';
  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension : ' | pDimension | ', pSubset : ' | pSubset  | ', pAddToSubset : ' | NumberToString(pAddToSubset)  | ', pExclusions : ' | pExclusions  | ', pDelimiter : ' | pDelimiter  | ', pAlias : ' | pAlias );
EndIf;

nRet = EXECUTEPROCESS('}bedrock.hier.sub.create.leaf',
  'pLogOutput', pDebug,
  'pDim', pDimension,
  'pHier', '',
  'pSub', pSubset,
  'pAddToSubset', pAddToSubset,
  'pExclusions', pExclusions,
  'pDelim', pDelimiter,
  'pAlias', pAlias,
  'pTemp', 0
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
