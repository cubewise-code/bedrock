601,100
602,"Bedrock.Cube.Data.Copy"
562,"VIEW"
586,"Balance Sheet"
585,"Balance Sheet"
564,
565,"vOdV?\Gf[VGrsAb:sKSs;UaWNmjXCXNGpcnb>du`K^?:gqztkSmh:E<F==C?Xl;9b2qo9dw10OPrr1TK5_<gbwXEjb4ddwWal``Ae3QRE]4Ue72ocDd45jZA8Yg:f8ig4p3\cXF5[5?wlIuTE;z3FtXO;eaYPS35SkE_TOrvc2`kPK[2yka6uT5[vUj^Nc]N?y]SHIg\"
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
570,Default
571,
569,0
592,0
599,1000
560,11
pCube
pViewSource
pViewTarget
pDimension
pSourceElement
pTargetElement
pSkipRules
pZeroTarget
pZeroSource
pDestroyTempObj
pDebug
561,11
2
2
2
2
2
2
1
1
1
1
1
590,11
pCube,""
pViewSource,""
pViewTarget,""
pDimension,""
pSourceElement,""
pTargetElement,""
pSkipRules,1
pZeroTarget,1
pZeroSource,0
pDestroyTempObj,1
pDebug,0
637,11
pCube,"Cube"
pViewSource,"Temporary view name for source"
pViewTarget,"Temporary view name for target"
pDimension,"Dimension to Copy Data"
pSourceElement,"Source Element"
pTargetElement,"Target Element"
pSkipRules,"Skip Rule Values? (1=Skip)"
pZeroTarget,"Zero out Target Element PRIOR to Copy? (Boolean 1=True)"
pZeroSource,"Zero out Source Element AFTER Copy? (Boolean 1=True)"
pDestroyTempObj,"Delete temporary view and Subset ( 0 = Retain View and Subsets 1 = Delete View and Subsets 2 = Delete View only )"
pDebug,"Debug Mode"
577,51
V1
V2
V3
V4
V5
V6
V7
V8
V9
V10
V11
V12
V13
V14
V15
V16
V17
V18
V19
V20
V21
V22
V23
V24
V25
V26
V27
V28
V29
V30
V31
V32
V33
V34
V35
V36
V37
V38
V39
V40
V41
V42
V43
V44
V45
V46
V47
V48
V49
V50
Value
578,51
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
1
579,51
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
580,51
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
581,51
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
582,51
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=33ColType=827
603,0
572,89

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#This Process was changed into shell that will call another process from Bedrock v4
##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName   = GetProcessName();
cUserName       = TM1User();
cMsgErrorContent= 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cTimeStamp      = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile      = GetProcessErrorFileDirectory | cThisProcName | '.' | cTimeStamp | '.' | cRandomInt ;
cMsgErrorLevel  = 'ERROR';
cMsgErrorContent= '%cThisProcName% : %sMessage% : %cUserName%';
cMsgErrorShell  = Expand('Executing process %cThisProcName% has failed.');

### Set debug file name
sDebugFile      = cDebugFile | 'Prolog.debug';

### Initialise Debug ###
If( pDebug >= 1 );
  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCube          : ' | pCube );
  AsciiOutput( sDebugFile, '            pViewSource    : ' | pViewSource );
  AsciiOutput( sDebugFile, '            pViewTarget    : ' | pViewTarget );
  AsciiOutput( sDebugFile, '            pDimension     : ' | pDimension );
  AsciiOutput( sDebugFile, '            pSourceElement : ' | pSourceElement );
  AsciiOutput( sDebugFile, '            pTargetElement : ' | pTargetElement );
  AsciiOutput( sDebugFile, '            pSkipRules     : ' | NumberToString( pSkipRules ) );
  AsciiOutput( sDebugFile, '            pZeroTarget    : ' | NumberToString( pZeroTarget ) );
  AsciiOutput( sDebugFile, '            pZeroSource    : ' | NumberToString( pZeroSource ) );
  AsciiOutput( sDebugFile, '            pDestroyTempObj: ' | NumberToString( pDestroyTempObj ) );  
EndIf;

### Getting cube logging parameter
sCubeLogging = CellGetS('}CubeProperties', pCube, 'LOGGING' );
nCubeLogging = IF(sCubeLogging@='YES',1,0);
  
If(pDimension @<>'' & pSourceElement @<> '' & pTargetElement @<> '');
  sEleMapping = pDimension|':'|pSourceElement|'->'|pTargetElement;
Endif;  

nRet = ExecuteProcess( '}bedrock.cube.data.copy',
  'pLogOutput', pDebug,
  'pStrictErrorHandling',1,
  'pCube', pCube,
  'pSrcView', pViewSource,
  'pTgtView', pViewTarget,
  'pFilter',  '',
  'pEleMapping', sEleMapping,
  'pMappingDelim','->',
  'pFactor', 1,
  'pDimDelim', '&',
  'pEleStartDelim', ':',
  'pEleDelim', '+',
  'pSuppressRules', pSkipRules ,
  'pCumulate', 0 ,
  'pZeroSource', pZeroSource, 
  'pZeroTarget', pZeroTarget,
  'pTemp', pDestroyTempObj,
  'pCubeLogging', nCubeLogging
);

IF(nRet <> 0);
    sMessage = 'the process incurred at least 1 major error and consequently aborted. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% aborted. Check tm1server.log for details.' );
    If ( pDebug >= 1 );
        AsciiOutput( sDebugFile, Expand( cMsgErrorContent ) );
        AsciiOutput( sDebugFile, Expand( 'Process exit code: %nRes%' ) );
        AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );
    EndIf;
    ProcessError();
ENDIF;


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,9

#****Begin: Generated Statements***
#****End: Generated Statements****






575,22

#****Begin: Generated Statements***
#****End: Generated Statements****


################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 


### Initialise Debug ###

If( pDebug >= 1 );
  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';
  # Log finish time
  AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

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
917,1
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
