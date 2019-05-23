601,100
602,"}bedrock.cube.view.create.bymdx"
562,"NULL"
586,"C:\TM1\Bedrock\Data\Bedrock.Z.MDX.Placeholder.csv"
585,"C:\TM1\Bedrock\Data\Bedrock.Z.MDX.Placeholder.csv"
564,
565,"fSxuS;aGp??ygPK2@]3ht;cko8]<gcB>Vwg\SRf0;zeQEUyA3aWfuc^@TucVJmiBEN4R>2qgAu2qLVnTOphvHW[>DXf[w35eF9L[oAn9Rv19HT6TwH610[coBqPq=9>u==;;xo>q0\n68rSgtxsnews9q02J[T^:\_[KRC>4dYh7i?3jzbEyjTtu?Z]c0\jCbcUs=dlf"
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
pCube
pView
pMDXExpr
pTemp
561,5
1
2
2
2
1
590,5
pLogOutput,0
pCube,""
pView,""
pMDXExpr,""
pTemp,1
637,5
pLogOutput,"Optional: write parameters and action summary to server message log (Boolean True = 1)"
pCube,"Required: Cube Name"
pView,"Required: View Name"
pMDXExpr,"Required: Valid MDX Expression"
pTemp,"Optional: Make View Temporary (1=Temporary)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,114
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.cube.view.create.bymdx', 'pLogOutput', pLogOutput,
    	'pCube', '', 'pView', '',
    	'pMDXExpr', '',
    	'pTemp', 1
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
# This process will Create a dynamic view from an MDX expression that evaluates to a non-empty set in the specified dimension.

# Use case: Intended for development/prototyping or production.
# 1/ Create a view to zero out data.
# 2/ Create a view to use as a source for exporting or copying.

# Note:
# Naturally, a valid cube name (pCube) is mandatory otherwise the process will abort.
# If the MDX does not compile or produces an empty set the process will error.
# pTemp: This parameter will control whether to make the view temporary (value 1) or if the
#   view will be permanently retained (value 0).
#EndRegion @DOC

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###

cThisProcName     = GetProcessName();
cUserName = TM1User();
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cTempSubset = cThisProcName | '_' | cTimeStamp | '_' | cRandomInt;
cTempFile = GetProcessErrorFileDirectory | cTempSubset | '.csv';
sMessage = 	'';
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pCube:%pCube%, pView:%pView%, pMDXExpr:%pMDXExpr%, pTemp:%pTemp%.' ;  
 

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

sMDXExpr = TRIM( pMDXExpr );

### Validate Parameters ###
nErrors = 0;

# Validate Cube
If( Trim( pCube ) @= '' );
    sMessage = 'No cube specified.';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( CubeExists( pCube ) = 0 );
    sMessage = Expand('Cube %pCube% does not exist') ;
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate View
If( Trim( pView ) @= '' );
    sMessage = 'No view specified';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate MDX
If( Trim( sMDXExpr ) @= '' );
    sMessage = 'No MDX expression specified';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate MDX. Checking Cube name mentioned in MDX
If( SCAN ( pCube , sMDXExpr ) = 0 );
    sMessage = 'No Cube Name mentioned in MDX. Not a valid MDX expression';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate pTemp
IF( pTemp<> 0 & pTemp<> 1 );
    nErrors = 1;
    sMessage = 'Invalid value for pTemp' | NumberToString( pTemp ) | '. Valid values are 0 and 1';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
    ProcessBreak;
EndIf;

### Create View ###
If( ViewExists( pCube , pView ) = 1 );
    ViewDestroy( pCube , pView );
EndIf;

ViewCreatebyMDX ( pCube , pView , sMDXExpr, pTemp ) ; 

### End Prolog ###
573,5

#****Begin: Generated Statements***
#****End: Generated Statements****


574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,25

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully created view %pView% in cube %pCube%.' );
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
