601,100
602,"}bedrock.security.evaluate.mdx.private"
562,"CHARACTERDELIMITED"
586,"Admin\store}subs\Euros.sub"
585,"Admin\store}subs\Euros.sub"
564,
565,"vM^eFAvfUMhZPyySj_kg]YaoBMgOjc]gvm0>^CL8G7m6YxaEptc8ls^qV>Mh<xL[e?Pg65cP>9Z?xBnCLF6aN5omeQa?Qt3Y7c:xnvknv:3Gn0]nJSGJAEQ7PvP2xKYU;mT\`APRF18Q9i6kQXAW@6GVlQO:eqkCYI6L?0_ywyM[fgwH0kdw0QnAz^H1SVb8Y2lGJ1?n"
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
567,"@"
588,"."
589,","
568,""""
570,
571,
569,1
592,0
599,1000
560,11
pLogOutput
pStrictErrorHandling
pUser
pDimension
pSubset
pSubsetFile
pFilePath
pFileName
pDelim
pQuote
pWriteOutput
561,11
1
1
2
2
2
2
2
2
2
2
1
590,11
pLogOutput,0
pStrictErrorHandling,0
pUser,""
pDimension,""
pSubset,""
pSubsetFile,""
pFilePath,""
pFileName,""
pDelim,","
pQuote,""""
pWriteOutput,1
637,11
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pUser,"REQUIRED: User name"
pDimension,"REQUIRED: Dimension name"
pSubset,"REQUIRED: Subset name"
pSubsetFile,"REQUIRED: Path to subset file"
pFilePath,"OPTIONAL: Export Directory (will default to error file path)"
pFileName,"OPTIONAL: Export Filename (If Left Blank Defaults to processname_user_dimension_subset_export.csv)"
pDelim,"OPTIONAL: AsciiOutput delimiter character (Default=comma, exactly 3 digits = ASCII code)"
pQuote,"OPTIONAL: AsciiOutput quote character (Accepts empty quote, exactly 3 digits = ASCII code)"
pWriteOutput,"DO NOT USE: for internal use only"
577,1
vLine
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
603,0
572,231
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess('}bedrock.security.evaluate.mdx.private',
       'pLogOutput', pLogOutput,
       'pStrictErrorHandling', pStrictErrorHandling,
       'pUser', pUser,
       'pDimension', pDimension,
       'pSubset', pSubset,
       'pSubsetFile', pSubsetFile,
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
# This process will find out PRIVATE dynamic subsets of dimensions having security on them - element security - and evaluate expressions impacted by the latest MDX security changes 

# Use case: Intended for development or production.

# Note:
# 
#EndRegion @DOC

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
StringGlobalVariable('sGlobPrivateSubsetsTotalString');
nProcessReturnCode= 0;

### Constants ###
cThisProcName       = GetProcessName();
cTimeStamp          = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt          = NumberToString( INT( RAND( ) * 1000 ));
cUserName           = TM1User();
cMsgErrorLevel      = 'ERROR';
cMsgErrorContent    = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo            = 'Process:%cThisProcName% run with parameters pUser:%pUser%, pDimension:%pDimension%, pSubset:%pSubset%, pSubsetFile:%pSubsetFile%, pFilePath:%pFilePath%, pFileName:%pFileName%, pDelim:%pDelim%, pQuote:%pQuote%.' ;  
cMsgInfoContent    = 'User:%cUserName% Process:%cThisProcName% InfoMsg:%sMessage%';
cSecurityPrefix = '}ElementSecurity_';
cDimDim = '}Dimensions';
cUserDim = '}Clients';
cUserAttrDim= '}ElementAttributes_}Clients';
cUserAlias = '}TM1_DefaultDisplayValue';
cSubsetPrefix = '}Subsets_';
cGroupDim = '}Groups';
cSecCube = '}ClientGroups';
nGroupMax = DimSiz ( cGroupDim );
nUserMax = DimSiz ( cUserDim );
cEleSecCube = cSecurityPrefix | pDimension;

pFieldDelim       = TRIM(pDelim);
sCRLF             = Char( 13 ) | Char( 10 );
cLenASCIICode     = 3;
nDataCount        = 0;
nErrors           = 0;

#reset flag and string
nMDXFlag = 0;
sMDX = '';
sTotalRowString = '';

#keywords to look out for in an MDX expression
cKeyWordList = 'DRILLDOWN&.Children&FirstChild&Ancestors&Ascendants&Cousin&DrillUp&FirstSibling&IsAncestor&FirstSibling&LastChild&LastSibling&Descendants';
cKeyWordList = UPPER ( cKeyWordList );
cKeyWordDelimiter = '&';

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###

# Validate user
IF( DimIx( cUserDim,  pUser) = 0 );
    sMessage = Expand('Invalid user: %pUser%');
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ENDIF;

# Validate dimension
IF( DimIx( cDimDim,  pDimension) = 0 );
    sMessage = Expand('Invalid dimension: %pDimension%');
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ENDIF;

# Validate subset name
IF( pSubset @= '' % Scan( pSubset, pSubsetFile ) = 0  );
    sMessage = Expand('Invalid subset name: %pSubset%');
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ENDIF;

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
    sBaseFileName = Expand('%cThisProcName%_%pUser%_%pDimension%_%pSubset%_Export');
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

# Validate subset file

If ( FileExists( pSubsetFile ) = 0 );
    sMessage = Expand('Invalid subset file: %pSubsetFile%');
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

### Initialize output

sTotalOutputRowString = '';
IF( pWriteOutput <> 0 );
  sTitleRow = '%pQuote%DIMENSION%pQuote%%pFieldDelim%%pQuote%HAS SECURITY%pQuote%%pFieldDelim%%pQuote%SUBSET NAME%pQuote%';
  sTitleRow = sTitleRow|'%pFieldDelim%%pQuote%IS PRIVATE%pQuote%%pFieldDelim%%pQuote%MDX EXPRESSION%pQuote%';
  sTitleRow = sTitleRow|'%pFieldDelim%%pQuote%KEYWORDS%pQuote%%pFieldDelim%%pQuote%ELEMENTS%pQuote%%pFieldDelim%%pQuote%USERS WITH NO ACCESS%pQuote%';
  sTotalOutputRowString = Expand(sTitleRow);
ENDIF;
sRow = '';

### Assign data source
If( nErrors = 0 );
    DataSourceType ='CHARACTERDELIMITED';
    DatasourceNameForServer = pSubsetFile;
    DatasourceASCIIDelimiter='@@';
EndIF;

573,2
#****Begin: Generated Statements***
#****End: Generated Statements****
574,144
#****Begin: Generated Statements***
#****End: Generated Statements****

# MDX statement flag ends on 278

If ( Subst ( vLine, 1, 3 ) @= '278' );
    # parse this MDX for keywords
    sKeyWordString = '';
    nKeywordFlag = 0;
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
                sMessage = 'Keyword ' | sKeyWord | ' found in ' |sMDX;
                LogOutput('INFO', Expand( cMsgInfoContent ) );
            ENDIF;
        EndIf;   
        nKeywordLength = Long ( sKeywordList );
    End;
    IF( sKeyWordString @<> '' );
        sRow = '%pQuote%%pDimension%%pQuote%%pFieldDelim%%pQuote%Y%pQuote%%pFieldDelim%%pQuote%%pSubset%%pQuote%%pFieldDelim%%pQuote%%pUser%%pQuote%';
        sRow = sRow|'%pFieldDelim%%pQuote%%sMDX%%pQuote%';
        sRow = sRow|'%pFieldDelim%%pQuote%%sKeyWordString%%pQuote%';
    ENDIF;
    # end parsing for keywords
    # if keywords found then see if we can match an element in the MDX with one in the dimension
    # element will be included within [] but there will be [dimension][hierarchy][subset][attribute] so could be a false positive
    sElementString = '';
    sUsersString = '';
    If ( nKeyWordFlag > 0 );
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
                If ( DimIx ( pDimension, sElement ) > 0 );
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
                    # now need to loop through relevant groups to see access
                    # loop through all groups to check access to this element
                    nUserCheck = 0;
                    iGroup = 1;
                    While ( iGroup <= nGroupMax );
                        sGroup = DimNm ( cGroupDim, iGroup );
                        #skip the admin groups!
                        If ( sGroup @<> 'ADMIN' & sGroup @<> 'SecurityAdmin' & sGroup @<> 'DataAdmin' & sGroup @<> 'OperationsAdmin' );
                            nCheck = 1;
                            # if we have a user check membership and we don;t need to continue if not in that group
                            If ( CellGetS ( cSecCube, pUser, sGroup ) @= '' );
                                nCheck = 0;
                            EndIf;    
                            If ( nCheck = 1 );
                                # get the groups security assignment
                                sAccess = CellGetS ( cEleSecCube, sElement, sGroup );
                                # if the user has rights to that element then all is good and we can quit the loops
                                If ( sAccess @<> '' & sAccess @<> 'NONE' );
                                    nUserCheck = 1;
                                    iGroup = nGroupMax + 1;
                                EndIf;
                            EndIf;
                        Else;
                            # if the user is in an admin group them they will have access
                            If ( CellGetS ( cSecCube, pUser, sGroup ) @<> '' );
                                nUserCheck = 1;
                            EndIf;       
                        EndIf;    
                        iGroup = iGroup + 1;
                    End;    
                    If ( nUserCheck = 0 );
                        sAlias = AttrS ( cUserDim, pUser, cUserAlias );
                        If ( sAlias @= '' );
                            sAlias = pUser;
                        EndIf;
                        IF( Scan( sAlias, sUsersString ) = 0 );
                            IF( sUsersString @= '' );
                              sUsersString = sUsersString | sAlias;
                            ELSE;
                              sUsersString = sUsersString | pDelim | ' ' | sAlias;
                            ENDIF;
                        ENDIF;
                        IF( pLogoutput = 1 );
                            sMessage = Expand('Private subset %pSubset% contains a keyword and a specific element %sElement% that the user %sAlias% do not have access to');
                            LogOutput('INFO', Expand( cMsgInfoContent ) );
                        ENDIF;
                    EndIf;
                EndIf;
                nMDXLength = Long ( sMDXTemp );
            Else;
                nMDXLength = 0;
            EndIf;    
        End;  
    sRow = sRow|'%pFieldDelim%%pQuote%%sElementString%%pQuote%%pFieldDelim%%pQuote%%sUsersString%%pQuote%';
    EndIf;
    nMDXFlag = 0;
    IF( sTotalOutputRowString @= '' );
        sTotalOutputRowString = Expand(sRow);
    ELSE;
        sTotalOutputRowString = sTotalOutputRowString | sCRLF | Expand(sRow);
    ENDIF;
EndIf;


If ( nMDXFlag = 1 );
    sMDX = UPPER ( sMDX | vLine ); 
EndIf;    

# MDX statement flag starts on 275

If ( Subst ( vLine, 1, 3 ) @= '275' );
    nMDXFlag = 1;
EndIf;
575,43

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

### Write Output data
If( nErrors = 0 );
  IF( pWriteOutput <> 0 );
      DatasourceAsciiQuoteCharacter = '';
      TextOutput( cExportFile, Expand(sTotalOutputRowString) );
  ELSE;
      IF( sGlobPrivateSubsetsTotalString @= '' );
          sGlobPrivateSubsetsTotalString = sTotalOutputRowString;
      ELSE;
          IF( sTotalOutputRowString @<> '' );
              sGlobPrivateSubsetsTotalString = sGlobPrivateSubsetsTotalString | sCRLF | sTotalOutputRowString;
          ENDIF;
      ENDIF;
  ENDIF;
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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully executed.' );
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
