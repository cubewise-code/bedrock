﻿601,100
602,"}bedrock.server.util.string.validate"
562,"NULL"
586,
585,
564,
565,"sX5<C1o]:OG3=y27R^Ra@LA:STtaEHUG`FXSA^Hb1G=V=_I?;1Ic`y8io52\vu\ZPmuH0fxh2es47:OP;bX<N?jvRLHfhw@L_nM@?EFrexO^TqpH1n:g>t2a5;Ho[0WdULtW8VyJv[2mxYoxzRZQ?RdAorDM3?WnTsXcGAh8deer70iEiPoc9d:yAi`Gvf1DxAtSJ<XW"
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
560,9
pLogOutput
pInputString
pUndesirableFileSystem
pUndesirable1st
pChanges
pReplaceIfNotFound
pDelim
pSeperator
pMode
561,9
1
2
2
2
2
2
2
2
1
590,9
pLogOutput,1
pInputString,""
pUndesirableFileSystem,"/|\>""<:?*"
pUndesirable1st,"'+-[]@!{}%"
pChanges,"\,B Slash&/,F Slash&|, &-,Minus&+,Plus&>,greater than&<,less than"
pReplaceIfNotFound,"_"
pDelim,"&"
pSeperator,","
pMode,3
637,9
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pInputString,"REQUIRED: Element name to validate and update if necessary"
pUndesirableFileSystem,"OPTIONAL: Undesirable characters for file system (e.g. /|\>""<:?* )"
pUndesirable1st,"OPTIONAL: Undesirable 1st characters (e.g. '+-[]@!{}% )"
pChanges,"OPTIONAL: String showing what to change. Replaces with pReplaceIfNotFound if blank."
pReplaceIfNotFound,"OPTIONAL: Replace ndesirable character with this if not specified in pChanges above (blank will delete)"
pDelim,"REQUIRED: Delimiter between definitions"
pSeperator,"REQUIRED: Seperator between current & desired"
pMode,"REQUIRED: 1=Validate for File System only, 2=Validate for 1st only, 3=Validate Fully"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,180
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.server.util.string.validate', 'pLogOutput', pLogOutput,
	    'pInputString', '', 'pUndesirableFileSystem', '/|\>"<:?*', 'pUndesirable1st', Char(39) | '+-[]@!{}%',
	    'pChanges', '\,B Slash&/,F Slash&|, &-,Minus&+,Plus&>,greater than&<,less than',
	    'pReplaceIfNotFound', '_',
	    'pDelim', '&', 'pSeperator', ',', 'pMode', 3 
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
# This process will validate a string pInputString based on rules in pChanges and change or 
# eliminate characters to create a global variable sOutputString that can be used in the source TI.

# Note:
# - pInputString: This is the input string that needs to be validated based on file system 
#   limitations or undesirable 1st characters.

# - pUndesirableFileSystem: These are characters considered undesirable (even forbidden) in 
#   object/element names due to file system limitations of the operation system. 

# - pUndesirable1st: These are characters considered undesirable as 1st characters in object/element
#   names due to TM1 limitations.

# - pChanges: This string defines the rule of how to change undesirable characters. It can be made up
#   of many definitions delimited by pDelim (e.g. `&` which is not considered undesirable
#   anywhere). Each definition would contain a character considered undesirable and the desired 
#   character separatedby pSeperator (e.g. to change a `%` to Percentage and `"` to inches, it would
#   be `%,Percentage&",inches` if pDelim = `&` and pSeperator = `,`).

# - pReplaceIfNotFound: This is a catch all for characters listed in pUndesirableFileSystem or 
#   pUndesirable1st that don't have a rule in pChanges.

# - pDelim: This is a character that is used to seperate definitions in pChanges.

# - pSeperator: This is a character used to seperate the current and desired character within each
#   definition in pChanges.

# - pMode: This can be used to limit whether the TI looks at pUndesirableFileSystem or pUndesirable1st 
#   without having to delete the characters in those parameters.
#EndRegion @DOC

#Region # Variables & Constants
# Global Variables
StringGlobalVariable('sProcessReturnCode');
StringGlobalVariable('sOutputString');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode = 0;

# Constants 
cThisProcName   = GetProcessName();
cUserName       = TM1User();
cTimeStamp      = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
cSubset         = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cMsgErrorLevel  = 'ERROR';
cMsgErrorContent= '%cThisProcName% : %sMessage% : %cUserName%';
cLogInfo        = 'Process:%cThisProcName% run with parameters pLogOutput=%pLogOutput%, pInputString=%pInputString%, pUndesirableFileSystem=%pUndesirableFileSystem%, pUndesirable1st=%pUndesirable1st%, pChanges=%pChanges%, pReplaceIfNotFound=%pReplaceIfNotFound%, pDelim=%pDelim%, pSeperator=%pSeperator%, pMode=%pMode%';

# Variables
nErrors         = 0;
#EndRegion

#Region # LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );
ENDIF;
#EndRegion

#Region # Validate parameters
## Validate pInputString parameter
IF( Trim( pInputString ) @= '' );
    nErrors     =1;
    sError      = Expand('No element name specified in pInputString.');
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ELSE;
    sElementToUpdate        = Trim( pInputString ) ;
ENDIF;

## Validate pMode parameter
IF( pMode <>1 & pMode <>2 & pMode <>3 );
    nErrors     =1;
    sError      = Expand('pMode parameter must be 1, 2 or 3 not %pMode%.');
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ENDIF;

## Validate pDelim parameter
IF( Trim( pDelim ) @= '' );
    nErrors     =1;
    sError      = Expand('No delimiter specified in pDelim.');
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ELSE;
    sDelim      = SUBST( Trim( pDelim ) , 1 , 1 );
ENDIF;

## Validate pSeperator parameter
IF( Trim( pSeperator ) @= '' );
    nErrors     =1;
    sError      = Expand('No seperator specified in pSeperator.');
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ELSE;
    sSeperator      = SUBST( Trim( pSeperator ) , 1 , 1 );
ENDIF;

## Validate pChanges parameter
#pChanges        = Trim( pChanges );
IF( pChanges @= '' );
    
ELSEIF( SUBST( pChanges , LONG( pChanges ) , 1 )@<> sDelim );
    pChanges    = pChanges | sDelim ;
ENDIF;

#pChanges        = Trim( pChanges );
IF( pReplaceIfNotFound @= '' );
    sReplaceIfNotFound  = '';
ELSE;
    sReplaceIfNotFound  = Trim( pReplaceIfNotFound );
ENDIF;

##### Check for errors before continuing
If( nErrors <> 0 );
    ProcessBreak;
EndIf;
#EndRegion 

#Region # Prepare for While loop to validate each character seperately
sEle                        = TRIM( pInputString );
nEle                        = LONG( sEle );
sOutputString               = '';
nCount                      = 1;
# Loop through each character to see if valid
# If no script inlcuded in pChanges then the invalid character will be replaced  with pReplaceIfNotFound
WHILE( nCount <= nEle );
    sChar                   = SUBST( sEle , nCount , 1 );
    sChanges                = TRIM( pChanges );
    nUndesirableFileSystem  = SCAN( sChar , pUndesirableFileSystem );
    nUndesirable1st         = SCAN( sChar , pUndesirable1st );
    ## Test if sChar contains undesirable 
    IF( nUndesirableFileSystem >0 & ( pMode=1 % pMode=3) );
        ## Test if sChar in pChanges
        nChange             = SCAN( sChar , sChanges );
        IF( nChange >0 );
            sChanges        = SUBST( sChanges , nChange , 999 );
            nNewLong        = SCAN( sDelim , sChanges );       
            sNew            = SUBST( sChanges , 3  , nNewLong-3 );
            #sOutputString   = sOutputString | sNew ;
        ELSE;
            sNew            = sReplaceIfNotFound ;
        ENDIF;   
    ELSEIF( nUndesirable1st >0 & nCount=1 & ( pMode=2 % pMode=3) );
        ## Test if sChar in pChanges
        nChange             = SCAN( sChar , sChanges );
        IF( nChange >0 );
            sChanges        = SUBST( sChanges , nChange , 999 );
            nNewLong        = SCAN( sDelim , sChanges );       
            sNew            = SUBST( sChanges , 3  , nNewLong-3 );
            #sOutputString   = sOutputString | sNew ;
        ELSE;
            sNew            = pReplaceIfNotFound ;
        ENDIF;        
    ELSE;
        sNew                = sChar;
    ENDIF;
    sOutputString           = sOutputString | sNew ;
    # Loop through the rest of the characters
    nCount                  = nCount + 1 ;
END;
#EndRegion


573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,28

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0.0~~##
################################################################################################# 

IF( nCount <> 1000000 );
    #AttrPutS( NumberToString( StringToNumber( sUpdatesNew ) )  , sDim2 , sUpdatesNew , 'Number');
ENDIF;

### Return code & final error message handling
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
Else;
    sProcessAction = Expand( 'Process:%cThisProcName% has validated the string the element "%pInputString%" and returned "%sOutputString%".' );
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
