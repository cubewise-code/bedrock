601,100
602,"Bedrock.Dim.Element.Component.Add"
562,"NULL"
586,
585,
564,
565,"danQaxIDLfC8qpRt\9<SPz>auP1nE:u4fEnOpKkkhvg^8I<;rUXSH@0T:U[::D[mrPLd^i@q[]Y1i@tWFZ6qlDmFUkaUU34^pEymUi0V0a\kkIT^rsIz_a\=7SlFb3w^ywBU<Q5^6eDiBsoBPF?Hz=\Qf]`c:iDR;[Aj\u5FYNKu4t=exZIqC5oGe]YjvX]gTDyUu6l["
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
571,
569,0
592,0
599,1000
560,5
pDimension
pParent
pElement
pWeight
pDebug
561,5
2
2
2
1
1
590,5
pDimension,""
pParent,""
pElement,""
pWeight,1
pDebug,0
637,5
pDimension,"Dimension Name"
pParent,"Parent Name"
pElement,"Element Name"
pWeight,"Component Weight"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,58

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4.

# This process will add a component to an element.
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
  AsciiOutput( sDebugFile, 'Parameters: pDimension : ' | pDimension );
  AsciiOutput( sDebugFile, '            pParent    : ' | pParent );
  AsciiOutput( sDebugFile, '            pElement   : ' | pElement );
  AsciiOutput( sDebugFile, '            pWeight    : ' | NumberToString( pWeight) );
EndIf;

nRet = EXECUTEPROCESS('}bedrock.hier.element.move',
  'pLogOutput', pDebug,
  'pStrictErrorHandling',1,
  'pDim', pDimension,
  'pHier', '',
  'pEle', pElement,
  'pTgtConsol', pParent,
  'pMode', 'Add',
  'pWeight', pWeight
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

575,12

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 




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
917,1
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
