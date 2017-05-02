601,100
562,"CHARACTERDELIMITED"
586,"C:\TM1\Bedrock\Data\Bedrock.Z.MDX.Placeholder.csv"
585,"C:\TM1\Bedrock\Data\Bedrock.Z.MDX.Placeholder.csv"
564,
565,"xrMw?OMbXAO[OnXGK2`xrrb9a[dj^[S1bD0pES7OcKl0X8Hp<\<UgXMNC0G0Lfu2EX^vW;y:jRiF5lU_CIyJFG]uADSH4?g@^AEp>W?b^1\1b7yPzhY]tlJk3YPXD=Wo`q]5>OgZRS3obwrm31i1o;QQ\kTWT2WZ=Y6ruqQ[b<bT^;HuRdI=AJLFSY\FBN\yz:5ZpD@="
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
pDimension
pSubset
pMDXExpr
pConvertToStatic
pDebug
561,5
2
2
2
1
1
590,5
pDimension,""
pSubset,""
pMDXExpr,""
pConvertToStatic,1.
pDebug,0.
637,5
pDimension,Dimension
pSubset,Subset
pMDXExpr,Valid MDX Expression for Specified Dimension
pConvertToStatic,Bolean: 1 = True (convert to static subset)
pDebug,Debug Mode
577,2
vElement
V2
578,2
2
1
579,2
1
2
580,2
0
0
581,2
0
0
582,2
VarType=32ColType=827
VarType=33ColType=827
572,147

#****Begin: Generated Statements***
#****End: Generated Statements****




#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 2.0.2~~##
#####################################################################################

# This process will Create a dynamic subset from an MDX expression
# that evaluates to a non-empty set in the specified dimension.
# If the MDX does not compile or produces an empty set the process will error.
# If convert to static is true then the MDX subset will be replaced by a static subset.


### Constants ###

cProcess = 'Bedrock.Dim.Sub.Create.ByMDX';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 100000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;
cTempSubset = '}' | cProcess | '.' | NumberToString( Int( Rand() * 100000 ) );
cTempFile = GetProcessErrorFileDirectory | cTempSubset | '.csv';


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension       : ' | pDimension );
  AsciiOutput( sDebugFile, '            pSubset          : ' | pSubset );
  AsciiOutput( sDebugFile, '            pMDXExpr         : ' | pMDXExpr );
  AsciiOutput( sDebugFile, '            pConvertToStatic : ' | NumberToString( pConvertToStatic ) );

EndIf;


### Validate Parameters ###

nErrors = 0;

# Validate dimension
If( Trim( pDimension ) @= '' );
  nErrors = 1;
  sMessage = 'No dimension specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;
If( DimensionExists( pDimension ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dimension: ' | pDimension;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate subset
If( Trim( pSubset ) @= '' );
  nErrors = 1;
  sMessage = 'No subset specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate MDX
If( Trim( pMDXExpr ) @= '' );
  nErrors = 1;
  sMessage = 'No MDX expression specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;
If( Scan( pDimension, pMDXExpr ) = 0 );
  nErrors = 1;
  sMessage = 'Dimension name is not in MDX expression';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;


### Create Subset ###

If( pDebug <= 1 );

  # If subset is to remain dynamic then just create it
  If( pConvertToStatic <> 1 );
    If( SubsetExists( pDimension, pSubset ) = 1 );
      SubsetDestroy( pDimension, pSubset );
    EndIf;
    SubsetCreateByMDX( pSubset, pMDXExpr );
    DataSourceType = 'NULL';

  # If subset if to be converted to static then create temp MDX subset for processing
  Else;
    If( SubsetExists( pDimension, pSubset ) = 1 );
      SubsetDeleteAllElements( pDimension, pSubset );
    Else;
      SubsetCreate( pDimension, pSubset );
    EndIf;

    # Note: it is unlikley that the temp subset would already exist as it has a random number
    #       in it's name. However, the check is included in case the random number generator comes
    #       up with the same number twice in seperate process executions
    If( SubsetExists( pDimension, cTempSubset ) = 1 );
      SubsetDestroy( pDimension, cTempSubset );
    EndIf;
    SubsetCreateByMDX( cTempSubset, pMDXExpr );

    nSubsetSize = SubsetGetSize( pDimension, cTempSubset );
    nSubsetIndex = 1;
    While( nSubsetIndex <= nSubsetSize );
      sElement = SubsetGetElementName( pDimension, cTempSubset, nSubsetIndex );
      AsciiOutput( cTempFile, sElement );
      nSubsetIndex = nSubsetIndex + 1;
    End;
    nSubsetIndex = 0;
    DataSourceType = 'CHARACTERDELIMITED';
    DataSourceNameForServer = cTempFile;

  EndIf;

EndIf;


### End Prolog ###
573,21

#****Begin: Generated Statements***
#****End: Generated Statements****




#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 2.0.2~~##
#####################################################################################


### Insert elements into static subset from dynamic subset ###

nSubsetIndex = nSubsetIndex + 1;
If( pDebug <= 1 );
  SubsetElementInsert( pDimension, pSubset, vElement, nSubsetIndex );
EndIf;


### End Metadata ###
574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,52

#****Begin: Generated Statements***
#****End: Generated Statements****




#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 2.0.2~~##
#####################################################################################


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';

EndIf;


### Delete temp file if it exists ###

If( FileExists( cTempFile ) = 1 );
  AsciiDelete( cTempFile );
EndIf;


### Finalise Debug ###

If( pDebug >= 1 );

  # Log errors
  If( nErrors <> 0 );
    AsciiOutput( sDebugFile, 'Errors Occurred' );
  EndIf;

  # Log finish time
  AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

EndIf;


### If errors occurred terminate process with a major error status ###

If( nErrors <> 0 );
  ProcessQuit;
EndIf;


### End Epilog ###
576,CubeAction=1511DataAction=1503CubeLogChanges=0
638,1
804,0
1217,1
900,
901,
902,
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
