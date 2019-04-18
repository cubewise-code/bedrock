601,100
602,"Bedrock.Security.Cube.CellSecurity.Destroy"
562,"NULL"
586,
585,
564,
565,"vX_fwSWUsa]vzJX\EE`>EEz<[3X;iGmwrpM>DLJqyKm8LYE?FrJ9z;UANXi~xV9eNVPpfIDtmtZAmVAFzB[agvY_^IdSveLSz:3uQ^klfpu?O^xuIrhD_7rhPfXhXgT;?>`@S]WpRJuB[5M0gxa]fZ3E0@w\qG[3BvMdnGP1Ghy\hXId<J;brBnzMcLI1X6J9oEPJ5tMvX_fwSWUsa]vzJX\EE`>EEt<[3X;iGm7xpM>DLJqyKm8LYH?FrJ9z;UAN(_xxVibNVPPaIDtmtjMm6DFzB[agvY_^ItRveLSz:35Q^klfpu?O^H4ErhD_7rhPfXhHeP;?nf`]]WpRJubV5MPjxa=hZ3E0@w\qG[3Bv}enG0=Ghy\([Id<J;brR`zMcLI1X:J3oEPJ5tM"
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
pCubes
pDelimiter
pDebug
561,3
2
2
1
590,3
pCubes,""
pDelimiter,"&"
pDebug,0
637,3
pCubes,"List of cubes separated by delimiter"
pDelimiter,"Delimiter"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,50

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4.

# This process will destroy cell security cubes for the specified list of cubes

# Notes:
# - Multiple cubes can be specified separated by a delimiter


### Constants ###

cProcess = 'Bedrock.Security.Cube.CellSecurity.Destroy';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt ;
DatasourceASCIIQuoteCharacter = '';


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCubes: ' | pCubes );
  AsciiOutput( sDebugFile, '            pDelimiter: ' | pDelimiter );
  AsciiOutput( sDebugFile, '' );

EndIf;


EXECUTEPROCESS('}bedrock.security.cube.cellsecurity.destroy',
  'pLogOutput', pDebug,
  'pCube', pCubes,
  'pDelim', pDelimiter
  );
  

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
