601,100
602,"}bedrock.hier.emptyconsols.delete"
562,"NULL"
586,
585,
564,
565,"s^hLL8y<w2hHDGzis@CazHuQC;EhvT>]rANkE0BhtC^zLd_cNCVM^43fa96>UxbwZnLjdwSIWej3ri0nzL9WJuQxx9<QR[kDVZH>RF=@S:U`u6V<j4qMgIsv4BHr^hV^HM4sIC0zjt[Ea@;kfcRv_@Pvh[5XMMCbfBjbfETEysmVND:r4oUE6BnSUo2CSdmX\It?9Tmz"
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
560,3
pLogOutput
pDim
pHier
561,3
1
2
2
590,3
pLogOutput,0
pDim,""
pHier,""
637,3
pLogOutput,"Optional: write parameters and action summary to server message log (Boolean True = 1)"
pDim,"Required: Target Dimension"
pHier,"Optional: Target Hierarchy (uses default hierarchy if left blank)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,100

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This process will delete all consolidated elements with no children in the target Hierarchy.

# Use case:
# - Service process to clean-up consolidations after dimension changes.

# Note:
# Valid target dimension (pDim) must be supplied otherwise the process will terminate.

# Caution: Target hierarchy (pHier) cannot be `Leaves`.
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
cLogInfo        = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%.' ;  

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;

If( Scan( ':', pDim ) > 0 & pHier @= '' );
    # A hierarchy has been passed as dimension. Handle the input error by splitting dim:hier into dimension & hierarchy
    pHier       = SubSt( pDim, Scan( ':', pDim ) + 1, Long( pDim ) );
    pDim        = SubSt( pDim, 1, Scan( ':', pDim ) - 1 );
EndIf;

# Validate dimension
If( Trim( pDim ) @= '' );
  nErrors = 1;
  sMessage = 'No dimension specified.';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( DimensionExists( pDim ) = 0 );
  nErrors = 1;
  sMessage = 'Dimension: ' | pDim | ' does not exist.';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate Hierarchy
If(pHier @= 'Leaves' );
  nErrors = 1;
  sMessage = 'Invalid  Hierarchy: ' | pDim |':'|pHier;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

If( Trim( pHier ) @= '' );
  sHier = pDim;
Else;
  sHier = pHier;
EndIf;

If( HierarchyExists( pDim, sHier ) = 0 );
  nErrors = 1;
  sMessage = 'The Hierachy ' | sHier | ' does not exists.';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
    ProcessBreak;
EndIf;

### Go through dimension and delete consols with no children ###
nElementCount       = ElementCount( pDim, sHier );
While( nElementCount >= 1 );
    sElement        = ElementName( pDim, sHier, nElementCount );
    sElementType    = ElementType( pDim, sHier, sElement );
    If( sElementType @= 'C' );
        nChildCount = ElementComponentCount( pDim, sHier, sElement );
        If( nChildCount = 0 );
            HierarchyElementDelete( pDim, sHier, sElement );
        EndIf;
    EndIf;
    nElementCount = nElementCount - 1;
End;

### End Prolog ###
573,5

#****Begin: Generated Statements***
#****End: Generated Statements****


574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,24

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully deleted all C level items that did not have children in dimension:hierarchy %pDim%:%sHier%.' );
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
