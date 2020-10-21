601,100
602,"Bedrock.Dim.Sub.Create"
562,"NULL"
586,"}Cubes"
585,"}Cubes"
564,
565,"rer_;Y6pZzYC82oauUa6tw5DZ9_n7p0_M8_5UxNhCK^Y8IeAHWa]>EKMMubOb4YQsn3;5Rj0<Z1:0VW68@tOreD_\R94iVN8MDO^bvCOccgHkJV7a`y;\q?WyuY[D;yCy[QeSe2ADf8YWec_ZEbH>n>RR3qvHnt\A][uEt6GYK_PB`]:5^JMSr@FFcmp2lfE3M<JgdNJ"
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
560,12
pDimension
pSubset
pConsol
pAttribute
pAttributeValue
pLevelFrom
pLevelTo
pExclusions
pDelimiter
pAddToSubset
pAlias
pDebug
561,12
2
2
2
2
2
1
1
2
2
1
2
1
590,12
pDimension,""
pSubset,""
pConsol,""
pAttribute,""
pAttributeValue,""
pLevelFrom,0
pLevelTo,20
pExclusions,""
pDelimiter,"&"
pAddToSubset,0
pAlias,""
pDebug,0
637,12
pDimension,"Dimension"
pSubset,"Subset"
pConsol,"Consolidated Element (Blank Equals All)"
pAttribute,"Attribute (Blank Equals All)"
pAttributeValue,"Attribute Value"
pLevelFrom,"From Element Level"
pLevelTo,"To Element Level"
pExclusions,"Elements to Exclude From Subset (Separated by Delimiter)"
pDelimiter,"Delimiter"
pAddToSubset,"Add to Subset if it Already Exists (0=No 1=Yes)"
pAlias,"Set Alias for Subset"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,87

#****Begin: Generated Statements***
#****End: Generated Statements****

### Start Prolog ###

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4.

# This process will create a static subset

# Note:
# - This process uses a number of parameters to determine what to include in the subset:
#   - pConsol      : If specified, only elements that are descendants of the consol will be included in the subset
#                    If blank, then this filter will be ignored
#   - pAttribute   : If specified, only elements that have a value equivalent to pAttributeValue will be included
#                    in the subset. If blank, this filter will be ignored
#   - pLevelFrom   : Only elements with a level greater than or equal to pLevelFrom will be included in the subset
#   - pLevelTo     : Only elements with a level less than or equal to pLevelFrom will be included in the subset
#   - pExclusions  : If pExclusions is specified then the elements (separated by a delimiter) will be excluded
#                    from the subset
#   - pAddToSubset : If the specified subset already exists then this parameter will control whether elements will
#                    be added to the existing subset (value 1) or a new subset will be created (value 0)


##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName   = GetProcessName();
cUserName       = TM1User();
cMsgErrorContent= 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cTimeStamp      = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile      = GetProcessErrorFileDirectory | cThisProcName | '.' | cTimeStamp | '.' | sRandomInt ;
cAttributeDim   = '}ElementAttributes_' | pDimension;

### Initialise Debug ###
If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';
  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension      : ' | pDimension );
  AsciiOutput( sDebugFile, '            pSubset         : ' | pSubset );
  AsciiOutput( sDebugFile, '            pConsol         : ' | pConsol );
  AsciiOutput( sDebugFile, '            pAttribute      : ' | pAttribute );
  AsciiOutput( sDebugFile, '            pAttributeValue : ' | pAttributeValue );
  AsciiOutput( sDebugFile, '            pLevelFrom      : ' | NumberToString( pLevelFrom ) );
  AsciiOutput( sDebugFile, '            pLevelTo        : ' | NumberToString( pLevelTo ) );
  AsciiOutput( sDebugFile, '            pExclusions     : ' | pExclusions );
  AsciiOutput( sDebugFile, '            pDelimiter      : ' | pDelimiter );
  AsciiOutput( sDebugFile, '            pAddToSubset    : ' | NumberToString( pAddToSubset ) );
  AsciiOutput( sDebugFile, '            pAlias      : ' | pAlias );
EndIf;

nRet = EXECUTEPROCESS('}bedrock.hier.sub.create',
  'pLogOutput', pDebug,
  'pStrictErrorHandling',1,
  'pDim', pDimension,
  'pHier', '',
  'pSub', pSubset,
  'pConsol', pConsol,
  'pAttr', pAttribute,
  'pAttrValue', pAttributeValue,
  'pLevelFrom', pLevelFrom,
  'pLevelTo', pLevelTo,
  'pExclusions', pExclusions,
  'pDelim', pDelimiter,
  'pAddToSubset', pAddToSubset,
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
573,10

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 



574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,10

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 



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
