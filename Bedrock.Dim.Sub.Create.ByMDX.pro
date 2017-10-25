601,100
602,"Bedrock.Dim.Sub.Create.ByMDX"
562,"NULL"
586,"C:\TM1\Bedrock\Data\Bedrock.Z.MDX.Placeholder.csv"
585,"C:\TM1\Bedrock\Data\Bedrock.Z.MDX.Placeholder.csv"
564,
565,"bGajYTx1l3iBhoaQ::7TegveUT<aMIh;gwJ0rYXCu\5aJ<p`@[xb64yitIAzjMkI5`ZNsEo^QUy;=_a3dKX94K[^BXA0ba4Sd16VCQs53Wu0TOs?jBSkn^dXFNR2W97dey\j:WMS:pPnRNvUaCRUrIiBUb:5f@qgIVTDH?fgrbFDplCJu=D`i7C^h^XWC@]Mj>L1bBkK"
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
pConvertToStatic,1
pDebug,0
637,5
pDimension,"Dimension"
pSubset,"Subset"
pMDXExpr,"Valid MDX Expression for Specified Dimension"
pConvertToStatic,"Bolean: 1 = True (convert to static subset)"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,136

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will Create a dynamic subset from an MDX expression
# that evaluates to a non-empty set in the specified dimension.
# If the MDX does not compile or produces an empty set the process will error.
# If convert to static is true then the MDX subset will be replaced by a static subset.

### Constants ###

cProcess = 'Bedrock.Dim.Sub.Create.ByMDX';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;
cTempSubset = cProcess | '.' | sRandomInt;
cTempFile = GetProcessErrorFileDirectory | cTempSubset | '.csv';

sMDXExpr = pMDXExpr;

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
If( Trim( sMDXExpr ) @= '' );
  nErrors = 1;
  sMessage = 'No MDX expression specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;
If( Scan( Upper( pDimension ), Upper( sMDXExpr ) ) = 0 );
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
    SubsetCreateByMDX( pSubset, sMDXExpr, pDimension );

  # If subset if to be converted to static then create temp MDX subset for processing
  Else;

    #Modify MDX to exclude empty MDX error
    sMDXExpr = '{{[' | pDimension | '].MEMBERS.ITEM(0)},' | sMDXExpr | '}';

    # Note: it is unlikley that the temp subset would already exist as it has a random number
    #       in it's name. However, the check is included in case the random number generator comes
    #       up with the same number twice in seperate process executions
    If( SubsetExists( pDimension, cTempSubset ) = 1 );
      SubsetDestroy( pDimension, cTempSubset );
    EndIf;
    SubsetCreateByMDX( cTempSubset, sMDXExpr, pDimension );

    SubsetElementDelete( pDimension , cTempSubset , 1 );

    ExecuteProcess( 'Bedrock.Dim.Sub.Clone'
      , 'pDimension' , pDimension
      , 'pSourceSub' , cTempSubset
      , 'pTargetSub' , pSubset
      , 'pDebug' , pDebug
    );

  EndIf;

EndIf;

### End Prolog ###
573,5

#****Begin: Generated Statements***
#****End: Generated Statements****


574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,48

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';

EndIf;

### Destroy Temporary Subset ###

If( pConvertToStatic = 1 );

  If( SubsetExists( pDimension, cTempSubset ) = 1 );
    SubsetDestroy( pDimension, cTempSubset );
  EndIf;

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
