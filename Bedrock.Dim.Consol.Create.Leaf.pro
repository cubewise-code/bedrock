601,100
602,"Bedrock.Dim.Consol.Create.Leaf"
562,"SUBSET"
586,"}Dimensions"
585,"}Dimensions"
564,
565,"hA0ka<2eaB@LN_5M9XcGfAO=?HT5u_<m6z`n7Oz^=5AK4]=9kw1rbpAnNx_<peN_oKw>:5QQ`EbELV1:ubTyG<VEPuY>fxRHeYgN3J@bPUcWksBb7BQT2DXLVx2IlZAxU7Q4HugO?zTKDe\Fjeb;OmhU8pa?dgDIE>RhjK]SN@mtnU>84IZ3UIVuEh>7MWqN>^1x_tUe"
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
571,All
569,0
592,0
599,1000
560,4
pDimension
pConsol
pMemberConsol
pDebug
561,4
2
2
2
1
590,4
pDimension,""
pConsol,""
pMemberConsol,""
pDebug,0
637,4
pDimension,Dimension
pConsol,Consolidation Name
pMemberConsol,The element is a member of the consolidation.
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
VarType=32ColType=827
572,155

#****Begin: Generated Statements***
#****End: Generated Statements****

### Start Prolog ###

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################


### Constants ###

cProcess = 'Bedrock.Dim.Consol.Create.Leaf';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension      : ' | pDimension );
  AsciiOutput( sDebugFile, '            pConsol         : ' | pConsol );
  AsciiOutput( sDebugFile, '            pMemberConsol   : ' | pMemberConsol );
EndIf;


### Validate Parameters ###

nErrors = 0;

IF( 
Trim( pDimension ) @= '' );
  ## No dimension nominated.
  nErrors = 1;
  If( pDebug >= 1 );
    sMessage = 'No dimension specified.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  PROCESSBREAK;
EndIf;

IF( 
SUBST( pDimension, 1, 1 ) @= '}' );
  ## Nominated dimension is a system dimension.
  nErrors = 1;
  If( pDebug >= 1 );
    sMessage = 'Can not modify a system dimension with this Bedrock.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  PROCESSBREAK;
EndIf;

If( 
DimensionExists( pDimension ) = 0 );
  ## Dimension does not exist in the model.
  nErrors = 1;
  If( pDebug >= 1 );
    sMessage = 'The dimension does not exist in the model: ' | pDimension;
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

IF( 
Trim( pDimension ) @= '' );
  ## No dimension nominated.
  nErrors = 1;
  If( pDebug >= 1 );
    sMessage = 'No dimension specified.';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  PROCESSBREAK;
EndIf;


## Validate consolidation Parameter
pConsol = Trim( pConsol );
If( pConsol @= '' );
  ## No consolidation nominated, us default name.
  pConsol = 'Total Leaf Elements';
    If( pDebug >= 1 );
    sMessage = 'No Consolidation point nominated, using default consolidation "Total Leaf Elements".';
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
EndIf;


## Validate Member Consolidation
pMemberConsol = Trim( pMemberConsol );
IF( 
pMemberConsol @<> '' );
  ## A member consolidation has been nominated.
  IF(
  DIMIX( pDimension, pMemberConsol ) = 0 );
  ## The Member Consolidation does not exist in the dimension.
    nErrors = 1;
    If( pDebug >= 1 );
      sMessage = 'The Member Consolidation does not exist in the model: ' | pMemberConsol;
      AsciiOutput( sDebugFile, sMessage );
    EndIf;
    ItemReject( sMessage );
  ENDIF;
ENDIF;



### Check for errors in Validate Parameters ###

If( nErrors <> 0 );
  ProcessBreak;
EndIf;

### UNWIND CONSOLIDATION ###
IF( 
DIMIX( pDimension, pConsol ) > 0 );
  ExecuteProcess('Bedrock.Dim.Hierarchy.Unwind.Consolidation'
  , 'pDimension', pDimension
  , 'pConsol', pConsol
  , 'pRecursive', 0
  , 'pDebug', pDebug
  );

  IF( pDebug >= 1 );
    sMessage = 'Unwind consolidation: ' | pConsol;
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
ELSE;
  DimensionElementInsert( pDimension, '', pConsol, 'C' );

  IF( pDebug >= 1 );
    sMessage = 'Add consolidation: ' | pConsol;
    AsciiOutput( sDebugFile, sMessage );
  EndIf;

ENDIF;


### Assign Datasource ###

DatasourceNameForServer = pDimension;
DataSourceDimensionSubset = 'All';


### End Prolog ###

573,55

#****Begin: Generated Statements***
#****End: Generated Statements****


### Start Metadata ###

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Metadata.debug';

EndIf;


### VALIDATE RECORD ###

sElType = DTYPE( pDimension, vElement );
IF(
sElType @<> 'N' );
  ## The element is not a 'N' element.
  ITEMSKIP;

ENDIF;

IF( 
pMemberConsol @<> '' );
  ## A member consolidation is been used.
  IF(
  ELISANC( pDimension, pMemberConsol, vElement ) = 0 );
  ## The element is not a member of the nominated consolidation.
    ITEMSKIP;
    
  ENDIF;
ENDIF;  


### BUILD CONSOLIDATION ###

If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'Element "' | vElement | '" has been added to "' | pConsol | '" consolidation.' );
EndIf;
If( pDebug <= 1 );
  DimensionElementComponentAdd( pDimension, pConsol, vElement, 1 );
EndIf;


### End Metadata ###
574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,4

#****Begin: Generated Statements***
#****End: Generated Statements****

576,CubeAction=1511DataAction=1503CubeLogChanges=0
930,0
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
