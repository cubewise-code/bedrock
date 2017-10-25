601,100
602,"Bedrock.Dim.Attr.Insert"
562,"NULL"
586,
585,
564,
565,"sAtT6`wcBy4=TNqJ]M\as@ki4LkH<UaYnG?qYSOilKN2W6RZ9rkaei;>5@TY>gQVZM6s5Vh<V<Ntqk7hK3TSbo7H9;5SqevTws?5x:GOH\xB667xXPDEc<qrlv7oPy`q6CL6?k;L8^PHX4sOMsORV3t:2Rs6j`2p<g\cEsI[:YK0PxVjQ=n2HJ6[ggm;@8F3:mcdLnh="
559,0
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
560,5
pDimension
pPrevAttr
pAttribute
pAttributeType
pDebug
561,5
2
2
2
2
1
590,5
pDimension,""
pPrevAttr,""
pAttribute,""
pAttributeType,""
pDebug,0
637,5
pDimension,Dimension Name
pPrevAttr,Previous Attribute
pAttribute,Attribute Name
pAttributeType,Attribute Type
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,86

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

### Constants ###

cProcess = 'Bedrock.Dim.Attr.Insert';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # List parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension     : ' | pDimension );
  AsciiOutput( sDebugFile, '            pPrevAttr      : ' | pPrevAttr );
  AsciiOutput( sDebugFile, '            pAttribute     : ' | pAttribute );
  AsciiOutput( sDebugFile, '            pAttributeType : ' | pAttributeType );

EndIf;


### Validate Parameters ###

# Validate dimension
If( Trim( pDimension ) @= '' );
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, 'No dimension specified' );
  EndIf;
  ProcessQuit;
EndIf;
If( DimensionExists( pDimension ) = 0 );
 If( pDebug >= 1 );
    AsciiOutput( sDebugFile, 'Dimension: ' | pDimension | ' does not exist' );
  EndIf;
  ProcessQuit;
EndIf;

# Validate attribute
If( Trim( pAttribute ) @= '' );
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, 'No attribute specified' );
  EndIf;
  ProcessQuit;
EndIf;
If( DimIx( '}ElementAttributes_' | pDimension, pAttribute ) > 0 );
  ## The attribute to be inserted already exist in the dimension.
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, 'Attribute: "' | pAttribute | '" already exists in dimension: "' | pDimension | '"' );
  EndIf;
  ProcessQuit;
EndIf;

# Validate attribute type
pAttributeType = Upper( SubSt( pAttributeType, 1, 1 ) );
If( pAttributeType @<> 'A' & pAttributeType @<> 'S' & pAttributeType @<> 'N' );
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, 'Invalid attribute type: '| pAttributeType );
  EndIf;
  ProcessQuit;
EndIf;

# Validate previous attribute
If( DimIx( '}ElementAttributes_' | pDimension, pPrevAttr ) = 0 % pPrevAttr @= pAttribute );
  pPrevAttr = '';
EndIf;


### Insert Attribute ###

If( pDebug <= 1 );
  AttrInsert( pDimension, pPrevAttr, pAttribute, pAttributeType );
EndIf;


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

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
918,0
919,0
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
