601,100
602,"}bedrock.hier.sub.create.orphans"
562,"NULL"
586,
585,
564,
565,"l^^79Yo2E4KCat2La0_Wak?M@F586g;TUZqSG7har8OO0cf:Oh6p9wQAf9;CqzMthTx?1h^i1:p_4tZ@@zTO=m1o^`]?u_:nWbv>[iuJx8z?vvQfqEHGoPp[R:KwZ<e6`>tLeUGpTrTPj7AaKpeb;rZLuods]<mI<Dz`nKW0H1WLjgkx[=7\I5tZ4\\NXRV8vn^Eog>M"
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
pStrictErrorHandling
pDim
pHier
pTemp
561,5
1
1
2
2
1
590,5
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pHier,""
pTemp,1
637,5
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"REQUIRED: Dimension name"
pHier,"OPTIONAL: Hierarchy name (default if blank = same named hierarchy)"
pTemp,"OPTIONAL: Use temporary objects? (Boolean 1=True)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,149
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.sub.create.orphans', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
	    'pDim', '', 'pHier', '', 'pTemp', 1
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
# This process will create a static subset in a Hierarchy of target Dimension that consists of
# all orphan elements.

# Note:
# Orphan element is defined as:
# - Consolidated element without children.
# - Leaf element without parent.
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName       = GetProcessName();
cUserName           = TM1User();
cTimeStamp          = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt          = NumberToString( INT( RAND( ) * 1000 ));
cTempSub            = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cMsgErrorLevel      = 'ERROR';
cMsgErrorContent    = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo            = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%, pTemp:%pTemp%.'; 
cAttributeDim       = '}ElementAttributes_' | pDim;
cSubsetOrphanC = 'Orphan C Elements (no children)';
cSubsetOrphanN = 'Orphan N Elements (no parents)';

## LogOutput parameters
IF ( pLogoutput = 1 );
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
  sMessage = 'No dimension specified';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;
If( DimensionExists( pDim ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dimension: ' | pDim;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate Hierarchy
IF(pHier @= 'Leaves' );
  nErrors = 1;
  sMessage = 'Invalid  Hierarchy: ' | pDim |':'|pHier;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

If( Trim( pHier ) @= '' );
  sHier = pDim;
Else;
  sHier = pHier;
EndIf;

IF(HierarchyExists(pDim, sHier ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dimension Hierarchy: ' | pDim |':'|sHier;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate pTemp
IF( pTemp <> 0 & pTemp <> 1 );
    nErrors = 1;
    sMessage = 'Wrong parameter pTemp value (only 0 or 1 accepted).';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Create Subsets ###
If( nErrors = 0 );
  If( HierarchySubsetExists( pDim, sHier, cSubsetOrphanC ) = 1 );
    HierarchySubsetDeleteAllElements( pDim, sHier, cSubsetOrphanC );
  Else;
    HierarchySubsetCreate( pDim, sHier, cSubsetOrphanC, pTemp );
  EndIf;
  If( HierarchySubsetExists( pDim, sHier, cSubsetOrphanN ) = 1 );
    HierarchySubsetDeleteAllElements( pDim, sHier, cSubsetOrphanN );
  Else;
    HierarchySubsetCreate( pDim, sHier, cSubsetOrphanN, pTemp );
  EndIf;
EndIf;


### Populate subsets ###
nElementCount = DimSiz( pDim|':'|sHier);
nElementIndex = 1;
nLeafCount = 0;
nConsolCount = 0;
While( nElementIndex <= nElementCount );
  sElement = ElementName( pDim, sHier, nElementIndex );
  If( ElementType( pDim, sHier, sElement ) @= 'N' & ElementParent( pDim, sHier, sElement, 1 ) @= '' );
    # N element with no parents
    nLeafCount = nLeafCount + 1;
    HierarchySubsetElementInsert( pDim, sHier, cSubsetOrphanN, sElement, nLeafCount );
  EndIf;
  If(ElementType(pDim,sHier, sElement) @= 'C' & ElementComponentCount(pDim, sHier, sElement) = 0);
    # C element with no children
    nConsolCount = nConsolCount + 1;
    HierarchySubsetElementInsert( pDim, sHier, cSubsetOrphanC, sElement, nConsolCount );
  EndIf;
  nElementIndex = nElementIndex + 1;
End;


### Tidy up ###

# If no orphans then destroy empty subsets
If( nErrors = 0 );
  If( HierarchySubsetGetSize( pDim, sHier, cSubsetOrphanN ) = 0 );
    HierarchySubsetDestroy( pDim, sHier, cSubsetOrphanN );
  EndIf;
  If( HierarchySubsetGetSize( pDim, sHier, cSubsetOrphanC ) = 0 );
    HierarchySubsetDestroy( pDim, sHier, cSubsetOrphanC );
  EndIf;
EndIf;


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,41

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
    If( nLeafCount > 0 );
       sProcessAction = Expand( 'Process:%cThisProcName% successfully created subset %cSubsetOrphanN% from dimension %pDim%:%pHier%.' );
       sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
       nProcessReturnCode = 1;
       If( pLogoutput = 1 );
           LogOutput('INFO', Expand( sProcessAction ) );
           nProcessReturnCode = 0; 
       EndIf;
    EndIf ;
    
    If( nConsolCount > 0 );
       sProcessAction = Expand( 'Process:%cThisProcName% successfully created subset %cSubsetOrphanC% from dimension %pDim%:%pHier%.' );
 
       sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
       nProcessReturnCode = 1;

      If( pLogoutput = 1 );
          LogOutput('INFO', Expand( sProcessAction ) );   
      EndIf;
    Endif ;
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
