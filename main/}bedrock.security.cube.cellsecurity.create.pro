﻿601,100
602,"}bedrock.security.cube.cellsecurity.create"
562,"NULL"
586,
585,
564,
<<<<<<< HEAD
565,"hxTmsBYezJnWD4a`ZkfWu1w=0>XGC3;vbP0ZV^L6YkXccXeMYtOT>oACuTi>Od=Um>6}VH?mtf_AHTQneXhkAvQdMvbC]:NApeTrAe?kRg]b7ztuYUE\:7UKL=lfYgt`=8PAsu7p=KtFk>N1G<]WVUHGq<YQe^kGgiDt7vRQ<yU9f8H?To_AVOnW5iz6J\fGYwMtWPAShxTmsBYetJnWD4a`ZkfWu1w=0>XGC3;6hP0ZV^L6YkXccXhMYtOT>oACu$O=OdmRm>6]QH?mtfoMH4TneXhkAvQdMvrB]:NApeTBEe?kRg]b7zD4UUE\:7UKL=lfIzq`=hVa}u7p=Ktff>NQE<]wUUHGq<YQe^kGgitu7v2]<yU9&;H?To_AV_`W5iz6J\jGSwMtWPAS"
=======
565,"tDD90YORDbwTR4z5]fRIzEqmcQdE6i`uBE7<Fv0;R1]upZuhH7K866ajpZi>4o4uOYXr6SSpEyY1;X1kOGET3RB6<?a3FutMruA{QaPi8STN76uu9v<VahD`D?9i_gd:H1pLctjN:O9Ck\u3GLOUvQ>0=>hcsjhcMaBt]v]QIhgziX>BDo@aAE^m>hbuX\FMyLijDbXNtDD90YORDbwTR4z5]fRItEqmcQdE6i`5HE7<Fv0;R1]upZxhH7K866ajp*_74odrOYXR1SSpEyi=;84kOGET3RB6<?q2FutMruAkPaPi8STN76E45v<VahD`D?9iO]k:HavlmtjN:O9cf\ucILOUuQ>0=>hcsjhcMaru]v=]Ihgz)[>BDo@aAUPm>hbuX\JMsLijDbXN"
>>>>>>> upstream/master
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
pCube
pDim
561,3
1
2
2
590,3
pLogOutput,0
pCube,""
pDim,""
637,3
pLogOutput,"Optional: write parameters and action summary to server message log (Boolean True = 1)"
pCube,"Required: Cube to create cell security for"
pDim,"Required: Map of dimensions to include in cell security as a array of 1:0 colon delimited e.g. ""1:0:0:1:0"""
577,0
578,0
579,0
580,0
581,0
582,0
603,0
<<<<<<< HEAD
572,117
=======
572,119
>>>>>>> upstream/master

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Region @DOC
# Description:
<<<<<<< HEAD
# This process will create a cell security cube for the specified cube for the specified list of dimensions.

# Use case: Intended for development.
# 1/ Set up initial security.

# Note:
# Naturally, a valid cube (pCube) is mandatory otherwise the process will abort.
# If cell security has already been set up the TI will abort.
# The pDim parameter must map ALL the dimensions in order in the cube with a 0 or 1.
=======
# This process will create a cell security cube for the specified cube for the specified list of dimensions 
# using the TI function _CellSecurityCubeCreate_. The benefit of this process is not needing to write a custom
# process each time in order to create a cell security cube.

# Use case: Intended for development.
# 1/ Set up cell security cubes

# Note:
# * Naturally, a valid cube (pCube) is mandatory otherwise the process will abort.
# * If cell security has already been set up the TI will abort.
# * The pDim parameter must map _ALL_ the dimensions in order in the cube with a 0 or 1.
>>>>>>> upstream/master
#EndRegion @DOC

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName       = GetProcessName();
cTimeStamp          = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt          = NumberToString( INT( RAND( ) * 1000 ));
cUserName           = TM1User();
cMsgErrorLevel      = 'ERROR';
cMsgErrorContent    = 'User:%cUserName% Process:%cThisProcName% Message:%sMessage%';
cLogInfo            = 'Process:%cThisProcName% run with parameters pCube:%pCube%, pDim:%pDim%.' ;  
cDelim              = ':';

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;

# If no cube has been specified then terminate process
If( Trim( pCube ) @= '' );
    nErrors = 1;
    sMessage = 'No cube specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( CubeExists( pCube ) = 0 );
    nErrors = 1;
    sMessage = Expand('Cube %pCube% does not exist.');
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Check if cell security cube already exists
If( CubeExists(  '}CellSecurity_' | pCube ) = 1 );
    nErrors = 1;
    sMessage = 'Cell Security cube already exists.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
    ProcessBreak;
EndIf;

### Count dimensions in cube ###
nDims               = 0;
iDim                = 1;
While( TabDim( pCube, iDim ) @<> '' );
   nDims            = iDim;
   iDim             = iDim + 1;
End;

### Count dimensions mapped in pDim ###
sDimensions         = pDim;
nDelimiterIndex     = 1;
nMapDims            = 0;
iDim                = 1;
While( nDelimiterIndex <> 0 );
    nMapDims        = iDim;
    nDelimiterIndex = Scan( cDelim, sDimensions );
    If( nDelimiterIndex = 0 );
        sDimension  = sDimensions;
    Else;
        sDimension  = Trim( SubSt( sDimensions, 1, nDelimiterIndex - 1 ) );
        sDimensions = Trim( Subst( sDimensions, nDelimiterIndex + Long(cDelim), Long( sDimensions ) ) );
    EndIf;
    # Redundant?
    If( sDimension @= '1' );
        sMessage    = ' INCLUDE in cell security cube';
    ElseIf( sDimension @= '0' );
        sMessage    = ' EXCLUDE from cell security cube';
    Else;
        sMessage    = ' INVALID map parameter: ' | sDimension;
    EndIF;
    iDim            = iDim + 1;
End;

### Check dimension count of dimension map vs. dimensions in cube ###
If( nDims <> nMapDims );
    nErrors         = 1;
    sMessage        = 'Parameter count of dimension map does not match dimension count of cube!';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
Else;
    nRet            = CellSecurityCubeCreate ( pCube, pDim );
    If( nRet = 1 );
        sMessage    = '}CellSecurity_' | pCube | ' successfully created';
        LogOutput( 'INFO', Expand( cMsgErrorContent ) );
    Else;
        sMessage    = 'Error. Could not create }CellSecurity_' | pCube;
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    EndIf;
EndIf;

### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,25

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully created cell security for %pCube% and %pDim%.' );
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
917,1
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
