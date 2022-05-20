601,100
602,"}bedrock.dim.attr.swapalias"
562,"NULL"
586,
585,
564,
565,"w5f\^g\2OzYM]kJ:\BUC78paf`rhTnH?DVmDRO6x1RGf^H^UFiT`ph8KY<YuII^zO3VoRHScK7PKZCyYv=Zr1SANjTqH<9^642NBRJX3SH]Ph^v3=>:=NP;;NJ75zdDBX?]>n\[X9phJ<z3W@81f@SYPgIRb5^]c_S05ax\thwuSJc=3o95C<O=mrCxx@jb^X:H^grGz"
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
pAlias
561,4
1
1
2
2
590,4
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pAlias,""
637,4
pLogOutput,"REQUIRED: True or False (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"REQUIRED: Dimension name"
pAlias,"REQUIRED: Alias"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,102
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.dim.attr.swapalias', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
	    'pDim', '', 'pAlias', ''
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
# This process will swap the values of the nominated alias with the principal name for all elements of the target dimension.
#
# Use case: Strictly for development/prototyping scenarios. This process should **not be used** in a production environment. 
# 1. Swap an alias with principal name 
#
# Note:
# The SwapAliasWithPrincipalName function is **not supported** for alternate hierarchies. Therefore this process checks for the 
# existance of alternate hierarches and if any exist for the target dimension then the process will abort.
#
# Warning: 
# Use with care. This process works, however, the underlying SwapAliasWithPrincipalName function  has never been officially 
# documented or suported by IBM. 
#EndRegion @DOC

### Global Variables
StringGlobalVariable ('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode = 0;

### Constants ###
cThisProcName     = GetProcessName();
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile        = GetProcessErrorFileDirectory | cThisProcName | '.' | cTimeStamp | '.' | cRandomInt ;
cCubeAttr         = '}ElementAttributes_' | pDim;
cUserName         = TM1User();
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = '%cThisProcName% : %sMessage% : %cUserName%';
cLogInfo          = '***Parameters for Process:%cThisProcName% for pDim:%pDim%, pAlias:%pAlias%.' ;  
cDim              = '}Dimensions';
cSubset           = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt; 

## LogOutput parameters
IF ( pLogoutput = 1 );
  LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###

nErrors = 0;

## Validate dimension
IF( Trim( pDim ) @= '' );
  nErrors = 1;
  sMessage = 'No dimension specified.';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIF( DimensionExists( pDim ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dimension: ' | pDim;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate alias
If( Trim( pAlias ) @= '' );
  nErrors = 1;
  sMessage = 'No alias specified';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( DimIx( cCubeAttr, pAlias ) = 0 );
  nErrors = 1;
  sMessage = 'Alias: ' | pAlias | ' does not exist in dimension: ' | pDim;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

sElementType = DType( cCubeAttr, pAlias );
If( sElementType @<> 'AA' );
  nErrors = 1;
  sMessage = 'Attribute: ' | pAlias | ' is not a valid alias.';
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

### Swap Dimension ###
SwapAliasWithPrincipalName( pDim, pAlias, 0 );

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully swapped the principal element names of the %pDim% with the %pAlias% alias.' );
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
