601,100
562,"CHARACTERDELIMITED"
586,"C:\TM1\MDXSubset.csv"
585,"C:\TM1\MDXSubset.csv"
564,
565,"kp;Xza@wgP?auR`3hpC`qn;zp2384hhqDJ2_Tzp=YL5e^`k2iBm:E`VDYaRGJOfc@6OrLViEOW3\Vh23pSB`iM6f4uTeWC=VINfAnVVuqvSqGtXsgvo>[8IPCpXg30NL36GYTAnRK2tK9SqYA1dM5=p8zfw>>k2DB_]qM6?tvz]<1zYC7guj5LW`HXZLxo:;Qf_jz2N;"
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
577,1
vElement
578,1
2
579,1
1
580,1
0
581,1
0
582,1
VarType=32€ColType=827€
572,144





#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################

# This process will Create a dynamic subset from an MDX expression
# that evaluates to a non-empty set in the specified dimension.
# If the MDX does not compile or produces an empty set the process will error.
# If convert to static is true then the MDX subset will be replaced by a static subset.


### Constants ###

cProcess = 'Bedrock.Dim.Sub.Create.ByMDX';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.';
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
573,19





#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################


### Insert elements into static subset from dynamic subset ###

nSubsetIndex = nSubsetIndex + 1;
If( pDebug <= 1 );
  SubsetElementInsert( pDimension, pSubset, vElement, nSubsetIndex );
EndIf;


### End Metadata ###
574,1

575,50





#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
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
576,CubeAction=1511€DataAction=1503€CubeLogChanges=0€
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
