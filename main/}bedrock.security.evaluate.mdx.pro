601,100
602,"}bedrock.security.evaluate.mdx"
562,"NULL"
586,
585,
564,
565,"kCgymiY_B_^a;wAKGh3nKvjJa]RXHXLaVcDAa@:zD=Ww<7cBHlpw6^FVx[:HIS>Ujum_Ld<6cI7AINK:2GEGf0^b4OKji3]mH_slUKy\=aivvhmAB168AmFgV18=TRyv\d]Jtv=2KKnFmmgkOp<`ry[<ZdmTAr[?e[dL`V4RWDW?zLD4aU3U1A>@N3HIaswi>cO:p0B]"
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
560,7
pLogOutput
pStrictErrorHandling
pNameSpace
pFilePath
pFileName
pDelim
pQuote
561,7
1
1
1
2
2
2
2
590,7
pLogOutput,0
pStrictErrorHandling,0
pNameSpace,0
pFilePath,""
pFileName,""
pDelim,","
pQuote,""""
637,7
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pNameSpace,"If CAM ID is used we need to check namespaces enter 1 for CAMID 0 for not (mode 1)"
pFilePath,"OPTIONAL: Export Directory (will default to error file path)"
pFileName,"OPTIONAL: Export Filename (If Left Blank Defaults to processname_export.csv)"
pDelim,"OPTIONAL: AsciiOutput delimiter character (Default=comma, exactly 3 digits = ASCII code)"
pQuote,"OPTIONAL: AsciiOutput quote character (Accepts empty quote, exactly 3 digits = ASCII code)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,435
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess('}bedrock.security.evaluate.mdx', 'pLogOutput', pLogOutput,
       'pStrictErrorHandling', pStrictErrorHandling,
       'pNameSpace', 0,
       'pFilePath', pFilePath,
       'pFileName', pFileName,
       'pDelim', pDelim,
       'pQuote', pQuote
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
# This process will find out which dimensions have security on them - element security - and evaluate dynamic subsets with expressions impacted by the latest MDX security changes 

# Use case: Intended for development or production.


# Note:
# 
#EndRegion @DOC

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
StringGlobalVariable('sGlobPrivateSubsetsTotalString');
sGlobPrivateSubsetsTotalString = '';
nProcessReturnCode= 0;

### Constants ###
cThisProcName       = GetProcessName();
cTimeStamp          = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt          = NumberToString( INT( RAND( ) * 1000 ));
cUserName           = TM1User();
cMsgErrorLevel      = 'ERROR';
cMsgErrorContent    = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo            = 'Process:%cThisProcName% run with parameters pNameSpace:%pNameSpace%, pFilePath:%pFilePath%, pFileName:%pFileName%, pDelim:%pDelim%, pQuote:%pQuote%.' ;  
cMsgInfoContent    = 'User:%cUserName% Process:%cThisProcName% InfoMsg:%sMessage%';
cSecurityPrefix = '}ElementSecurity_';
cDimDim = '}Dimensions';
cUserDim = '}Clients';
cUserAttrDim= '}ElementAttributes_}Clients';
cUserAlias = '}TM1_DefaultDisplayValue';
cSubsetPrefix = '}Subsets_';
cGroupDim = '}Groups';
cSecCube = '}ClientGroups';

pFieldDelim       = TRIM(pDelim);
sCRChar           = Char( 13 );
sLFChar           = Char( 10 );
sCRLF             = Char( 13 ) | Char( 10 );
cLenASCIICode     = 3;
nDataCount        = 0;
nErrors           = 0;

cKeyWordList = 'DRILLDOWN&.Children&FirstChild&Ancestors&Ascendants&Cousin&DrillUp&FirstSibling&IsAncestor&FirstSibling&LastChild&LastSibling&Descendants';
cKeyWordList = UPPER ( cKeyWordList );
cKeyWordDelimiter = '&';

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###

# Namespace
If( pNameSpace <> 0 & pNameSpace <> 1 );
    nErrors         = 1;
    sMessage        = 'NameSpace parameter not valid';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## check operating system
If( SubSt( GetProcessErrorFileDirectory, 2, 1 ) @= ':' );
  sOS = 'Windows';
  sOSDelim = '\';
ElseIf( Scan( '/', GetProcessErrorFileDirectory ) > 0 );
  sOS = 'Linux';
  sOSDelim = '/';
Else;
  sOS = 'Windows';
  sOSDelim = '\';
EndIf;

# Validate file path
If(Trim( pFilePath ) @= '' );
    pFilePath = GetProcessErrorFileDirectory;
EndIf;
If( SubSt( pFilePath, Long( pFilePath ), 1 ) @= sOSDelim );
    pFilePath = SubSt( pFilePath, 1, Long( pFilePath ) -1 );
EndIf;
If(  FileExists( pFilePath ) = 0 );
    sMessage = Expand('Invalid export directory: %pFilePath%');
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;
pFilePath = pFilePath | sOSDelim;

# Validate file name
If( pFileName @= '' );
    sBaseFileName = Expand('%cThisProcName%_Export');
    sExt = '.csv';
    pFileName = sBaseFileName | '.csv';
Else;
    # determine file extension. If no file extension entered then use .csv as default
    If( Scan( '.', pFileName ) = 0 );
        sExt = '.csv';
        sBaseFileName = pFileName;
    Else;
        sExt = SubSt( pFileName, Scan( '.', pFileName ), Long( pFileName ) );
        sBaseFileName = SubSt( pFileName, 1, Scan( '.', pFileName ) - 1 );
    EndIf;
    pFileName = sBaseFileName | sExt;
EndIf;
cExportFile = pFilePath | pFileName;

# Validate file delimiter & quote character
If( pFieldDelim @= '' );
    pFieldDelim = ',';
Else;
    # If length of pFieldDelim is exactly 3 chars and each of them is decimal digit, then the pFieldDelim is entered as ASCII code
    nValid = 0;
    If ( LONG(pFieldDelim) = cLenASCIICode );
      nChar = 1;
      While ( nChar <= cLenASCIICode );
        If( CODE( pFieldDelim, nChar ) >= CODE( '0', 1 ) & CODE( pFieldDelim, nChar ) <= CODE( '9', 1 ) );
          nValid = 1;
        Else;
          nValid = 0;
        EndIf;
        nChar = nChar + 1;
      End;
    EndIf;
    If ( nValid<>0 );
      pFieldDelim=CHAR(StringToNumber( pFieldDelim ));
    Else;
      pFieldDelim = SubSt( Trim( pFieldDelim ), 1, 1 );
    EndIf;
EndIf;
If( pQuote @= '' );
    ## Use no quote character 
Else;
    # If length of pQuote is exactly 3 chars and each of them is decimal digit, then the pQuote is entered as ASCII code
    nValid = 0;
    If ( LONG(pQuote) = cLenASCIICode );
      nChar = 1;
      While ( nChar <= cLenASCIICode );
        If( CODE( pQuote, nChar ) >= CODE( '0', 1 ) & CODE( pQuote, nChar ) <= CODE( '9', 1 ) );
          nValid = 1;
        Else;
          nValid = 0;
        EndIf;
        nChar = nChar + 1;
      End;
    EndIf;
    If ( nValid<>0 );
      pQuote=CHAR(StringToNumber( pQuote ));
    Else;
      pQuote = SubSt( Trim( pQuote ), 1, 1 );
    EndIf;
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

DatasourceAsciiDelimiter = pFieldDelim;
DatasourceAsciiQuoteCharacter = '';
sTotalRowString = '';

sTitleRow = '%pQuote%DIMENSION%pQuote%%pFieldDelim%%pQuote%HAS SECURITY%pQuote%%pFieldDelim%%pQuote%SUBSET NAME%pQuote%';
sTitleRow = sTitleRow|'%pFieldDelim%%pQuote%IS PRIVATE%pQuote%%pFieldDelim%%pQuote%MDX EXPRESSION%pQuote%';
sTitleRow = sTitleRow|'%pFieldDelim%%pQuote%KEYWORDS%pQuote%%pFieldDelim%%pQuote%ELEMENTS%pQuote%%pFieldDelim%%pQuote%USERS WITH NO ACCESS%pQuote%';
TextOutput( cExportFile, Expand(sTitleRow) );
sTotalRowString = Expand(sTitleRow);

iDim = 1;
nMaxDim = DimSiz ( cDimDim );

While ( iDim <= nMaxDim );
    sDim = DimNm ( cDimDim, iDim );
    sSecurityCube = cSecurityPrefix | sDim;
    If ( CubeExists ( sSecurityCube ) = 1 );
        IF( pLogoutput = 1 );
            sMessage = 'The dimension ' | sDim | ' has element security assigned';
            LogOutput('INFO', Expand( cMsgInfoContent ) );
        ENDIF;
        # now we need to go find subsets - two ways of doing this - data directory or }subset dimension
        # data directory is the only place to find private subs but need to know the username to loop through
    #########################################################################################################################################      
        iUser = 1;
        nMaxUser = DimSiz ( cUserDim );
        While ( iUser <= nMaxUser );
            sUser = DimNm ( cUserDim, iUser );
            # if CAMId is used folder structure is different
            If ( DimIx ( cUserAttrDim, cUserAlias ) > 0 );
                sAlias = AttrS ( cUserDim, sUser, cUserAlias );
                If ( sAlias @= '' );
                    sAlias = sUser;
                EndIf;
            EndIf; 
            sNamespacePrefix = '';
            # if CAMId is used folder structure is different
            If ( pNamespace = 1 );
                # this \ or / is hardcoded as it is the CAMID }TM1_DefaultDisplayValue alias which sometimes uses back- and sometimes forward-slash. We aren't sanning for directory separator.
                nEnd = Scan( '/', sAlias);
                If ( nEnd = 0 );
                    nEnd = Scan ( '\', sAlias );
                EndIf;    
                sNamespace = SubSt ( sAlias, 1, nEnd - 1 );
                sAlias = SubSt ( sAlias, nEnd + 1, Long ( sAlias ) - nEnd );
                sNamespacePrefix = sNameSpace | sOSDelim;
            EndIf;    
            sSubset = WildcardFileSearch( Expand('%sNameSpacePrefix%%sAlias%%sOSDelim%%sDim%}subs%sOSDelim%*.sub') , '');
            # loop through all subsets
            While ( sSubset @<> '' );
                sSubsetName = Subst ( sSubset, 1, LONG ( sSubset ) - 4 );
                sFile = Expand('%sNameSpacePrefix%%sAlias%%sOSDelim%%sDim%}subs%sOSDelim%%sSubset%') ;
                IF( pLogoutput = 1 );
                    sMessage = Expand('Private subset called %sSubsetName% found for user %sAlias% in dimension %sDim%. File = %sFile%');
                    LogOutput('INFO', Expand( cMsgInfoContent ) );
                ENDIF;
                # run the sub process to evaluate the MDX
                If ( sSubset @<> '' );
                    nRet = ExecuteProcess('}bedrock.security.evaluate.mdx.private',
                               'pLogOutput', pLogOutput,
                               'pStrictErrorHandling', pStrictErrorHandling,
                               'pUser', sUser,
                               'pDimension', sDim,
                               'pSubset', sSubsetName,
                               'pSubsetFile', sFile,
                               'pFilePath', pFilePath,
                               'pFileName', '',
                               'pDelim', pDelim,
                               'pQuote', pQuote,
                               'pWriteOutput', 0
                      );
                    If( nRet <> ProcessExitNormal() );
                        nErrors = nErrors + 1;
                        sMessage= 'Error in evaluating private subsets.';
                        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
                    EndIf;

                EndIf;  
                sSubset = WildcardFileSearch( Expand('%sNameSpacePrefix%%sAlias%%sOSDelim%%sDim%}subs%sOSDelim%*.sub') , sSubset);                
            End;    
            iUser = iUser + 1;
        End;   
    ##########################################################################################################################################      
            # for public subsets we can use the subsets dimension
    #########################################################################################################################################      

        
        sSubsetDim = cSubsetPrefix | sDim;
        iSub = 1;
        nSubsetMax = DimSiz ( sSubsetDim );
        # loop through all subsets
        While ( iSub <= nSubsetMax );
            sSubsetName = DimNm ( sSubsetDim, iSub );
            sMDX = '';
            sMDX = SubsetMDXGet ( sDim, sSubsetName );
            sMDX = UPPER ( sMDX );
            If ( sMDX @<> '' );
                ## Remove line breaks from MDX string
                nMDXLen = Long( sMDX );
                nMDXCount = 1;
                While( nMDXCount <= nMDXLen );
                  sCharPoint = Subst( sMDX, nMDXCount, 1 );
                  IF( sCharPoint @= sCRChar % sCharPoint @= sLFChar );
                      Delet( sMDX, nMDXCount, 1 );
                      nMDXLen = Long( sMDX );
                  ENDIF;
                  
                  nMDXCount = nMDXCount + 1;
                End;
                nMDXLen = Long( sMDX );
                sMDXLastChar = Subst( sMDX, nMDXLen, 1 );
                While( sMDXLastChar @<> '}' );
                  sMDX = Subst( sMDX, 1, nMDXLen - 1 );
                  nMDXLen = Long( sMDX );
                  sMDXLastChar = Subst( sMDX, nMDXLen, 1 );
                End;
                sRow = '%pQuote%%sDim%%pQuote%%pFieldDelim%%pQuote%Y%pQuote%%pFieldDelim%%pQuote%%sSubsetName%%pQuote%%pFieldDelim%%pQuote%NO%pQuote%%pFieldDelim%%pQuote%%sMDX%%pQuote%';
                IF( pLogoutput = 1 );
                    sMessage = Expand('Public subset called %sSubsetName% found in dimension %sDim% with MDX %sMDX%');
                    LogOutput('INFO', Expand( cMsgInfoContent ) );
                ENDIF;
                # now parse the MDX 
                nKeywordFlag = 0;
                sKeyWordString = '';
                sKeywordList = cKeywordList;
                nKeywordLength = Long ( sKeywordList );
                While ( nKeywordLength > 0 );
                    nDelimiter = Scan ( cKeywordDelimiter, sKeyWordList );
                    If ( nDelimiter = 0 );
                        sKeyword = sKeyWordList;
                        sKeyWordList = '';
                    Else;
                        nEnd = nDelimiter - 1;
                        sKeyWord = SubSt ( sKeywordList, 1, nEnd );
                        sKeyWordList = Subst ( sKeywordList, nEnd + 2, nKeywordLength - nEnd);
                    EndIf;    
                    If ( Scan( sKeyWord, sMDX ) > 0 );
                        nKeyWordFlag = nKeyWordFlag + 1;
                        IF( Long( sKeyWordString ) = 0 );
                          sKeyWordString = sKeyWordString | sKeyWord;
                        ELSE;
                          sKeyWordString = sKeyWordString | pDelim | ' ' | sKeyWord;
                        ENDIF;
                        IF( pLogoutput = 1 );
                            sMessage = 'Keyword ' | sKeyWord | ' found in ' | sMDX;
                            LogOutput('INFO', Expand( cMsgInfoContent ) );
                        ENDIF;
                    EndIf;   
                    nKeywordLength = Long ( sKeywordList );
                End;    
                # if keywords found then see if we can match an element in the MDX with one in the dimension
                # element will be included within [] but there will be [dimension][hierarchy][subset][attribute] so could be a false positive
                If ( nKeyWordFlag > 0 );
                    sRow = sRow|'%pFieldDelim%%pQuote%%sKeyWordString%%pQuote%';
                    sUsersString = '';
                    sElementString = '';
                    sMDXTemp = sMDX;
                    sStarter = '[';
                    sEnder = ']';
                    nMDXLength = Long ( sMDXTemp );
                    While ( nMDXLength > 0 );
                        nStarter = SCAN ( sStarter, sMDXTemp );
                        If ( nStarter > 0 );
                            nEnder = SCAN ( sEnder, sMDXTemp );
                            sElement = SubSt ( sMDXTemp, nStarter + 1, nEnder - nStarter -1);
                            nToGo = nMDXLength - nEnder + 1;
                            sMDXTemp = Subst ( sMDXTemp, nEnder + 1, nToGo );
                            # check if that is actually an element
                            If ( DimIx ( sDim, sElement ) > 0 );
                                IF( Scan( sElement, sElementString ) = 0 );
                                    IF( sElementString @= '' );
                                        sElementString = sElementString | sElement;
                                    ELSE;
                                        sElementString = sElementString | pDelim | ' ' | sElement;
                                    ENDIF;
                                ENDIF;
                                IF( pLogoutput = 1 );
                                    sMessage = sElement | ' is referenced in the MDX and exists in the dimension';
                                    LogOutput('INFO', Expand( cMsgInfoContent ) );
                                ENDIF;
                                #loop thropugh all users
                                iUser = 1;
                                nMaxUser = DimSiz ( cUserDim );
                                While ( iUser <= nMaxUser );
                                    sUser = DimNm ( cUserDim, iUser );
                                    # now need to loop through relevant groups to see access
                                    # loop through all groups to check access to this element
                                    nUserCheck = 0;
                                    iGroup = 1;
                                    nGroupMax = DimSiz ( cGroupDim );
                                    While ( iGroup <= nGroupMax );
                                        sGroup = DimNm ( cGroupDim, iGroup );
                                        #skip the admin groups!
                                        If ( sGroup @<> 'ADMIN' & sGroup @<> 'SecurityAdmin' & sGroup @<> 'DataAdmin' & sGroup @<> 'OperationsAdmin' );
                                            nCheck = 1;
                                            # if we have a user check membership and we don;t need to continue if not in that group
                                            If ( CellGetS ( cSecCube, sUser, sGroup ) @= '' );
                                                nCheck = 0;
                                            EndIf;    
                                            If ( nCheck = 1 );
                                                # get the groups security assignment
                                                sAccess = CellGetS ( sSecurityCube, sElement, sGroup );
                                                # if the user has rights to that element then all is good and we can quit the loops
                                                If ( sAccess @<> '' & sAccess @<> 'NONE' );
                                                    nUserCheck = 1;
                                                    iGroup = nGroupMax + 1;
                                                EndIf;
                                            EndIf;
                                        Else;
                                            # if the user is in an admin group them they will have access
                                            
                                            If ( CellGetS ( cSecCube, sUser, sGroup ) @<> '' );
                                                nUserCheck = 1;
                                                iGroup = nGroupMax + 1;
                                            EndIf;   
                                        EndIf;    
                                        iGroup = iGroup + 1;
                                    End;    
                                    If ( nUserCheck = 0 );
                                        IF( Scan( sUser, sUsersString ) = 0 );
                                            IF( sUsersString @= '' );
                                              sUsersString = sUsersString | sUser;
                                            ELSE;
                                              sUsersString = sUsersString | pDelim | ' ' | sUser;
                                            ENDIF;
                                        ENDIF;
                                        IF( pLogoutput = 1 );
                                            sMessage = Expand('Public subset %sSubsetName% contains a keyword and a specific element %sElement% that the user %sUser% do not have access to');
                                            LogOutput('INFO', Expand( cMsgInfoContent ) );
                                        ENDIF;
                                    EndIf;
                                    iUser = iUser + 1;
                                End;
                            EndIf;
                            nMDXLength = Long ( sMDXTemp );
                        Else;
                            nMDXLength = 0;
                        EndIf;  
                    End;                      
                    
                sRow = sRow|'%pFieldDelim%%pQuote%%sElementString%%pQuote%%pFieldDelim%%pQuote%%sUsersString%%pQuote%';
                sTotalRowString = sTotalRowString | sCRLF | Expand(sRow);
                # Output data
                #TextOutput( cExportFile, Expand(sRow) );
                EndIf;    
            EndIf;    
            iSub = iSub + 1;
        End;    

    ##########################################################################################################################################  
    EndIf;    
    iDim = iDim + 1;
End;
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,36

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

### Write Output data
If( nErrors = 0 );
  TextOutput( cExportFile, sTotalRowString );
  TextOutput( cExportFile, sGlobPrivateSubsetsTotalString );
ENDIF;

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully created report file.' );
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
1217,0
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
