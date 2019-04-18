601,100
602,"Bedrock.Security.Cube.CellSecurity.Create"
562,"NULL"
586,
585,
564,
565,"wwI90`zLY5wb=D9Odb0zd0HzKVmlwtutBh?FTj4cLUgbzPe_3Km5SswWk]i~DT6uNgiwfJt3mVW1CV1dorPGVzYqYZjCT>HoEJ?yQeOJrx3ZZEsu9e@dJF:Gh`:sRgT3m2`Ls_K8BnRM{Ix3Gyp^VYt0ZX^9LBx^R`Dd9NVqXrqSmXt0BaoCZDNd1frSmTVByp>RXO^5wwI90`zLY5wb=D9Odb0zd0HtKVmlwtu4Hh?FTj4cLUgbzPh_3Km5SswWk-?pDTfrNgiWaJt3mVg=C64dorPGVzYqYZzBT>HoEJ?Y[eOJrx3ZZEC45e@dJF:Gh`:sR@[3mbfl}_K8BnRmvIx3IypnPYt0ZX^9LBx^R`te9N6}XrqS-[t0BaoCZT@d1frSmTZBsp>RXO^5"
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
pCube
pDimensions
pDebug
561,3
2
2
1
590,3
pCube,""
pDimensions,""
pDebug,0
637,3
pCube,"Cube to create cell security for"
pDimensions,"Map of dimensions to include in cell security as a array of 1:0 colon delimited e.g. ""1:0:0:1:0"""
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,52

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#This Process was changed into shell, that will call another process from Bedrock v4.

# This process will create a cell security cube for the specified cube for the specified list of dimensions

# Notes:
# - Some checks performed based on dimension map matching the number of dimensions in the cube


### Constants ###

cProcess = 'Bedrock.Security.Cube.CellSecurity.Create';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.' | sRandomInt;
pDelimiter = ':';
DatasourceASCIIQuoteCharacter = '';

### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCube: ' | pCube );
  AsciiOutput( sDebugFile, '            pDimensions: ' | pDimensions );
  AsciiOutput( sDebugFile, '' );

EndIf;



EXECUTEPROCESS('}bedrock.security.cube.cellsecurity.create',
  'pLogOutput', pDebug,
  'pCube', pCube,
  'pDim', pDimensions
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
