601,100
602,"}bedrock.dim.filter.fromsubset"
562,"NULL"
586,
585,
564,
565,"TM1rules"
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
588,","
589,"."
568,""""
570,
571,
569,0
592,0
599,1000
560,11
pLogOutput
pStrictErrorHandling
pSelection_1
pSelection_2
pSelection_3
pSelection_4
pSelection_5
pSelectionDelim
pDimDelim
pEleStartDelim
pEleDelim
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
2
590,11
pLogOutput,0
pStrictErrorHandling,0
pSelection_1,"Account \ subset:assets accounts"
pSelection_2,"Company \ mdx:Filter( TM1FilterByLevel( TM1SubsetAll( [Company] ), 0 ), [Company].CurrentMember.Properties(""Region"") = ""' | pRegion | '"" )"
pSelection_3,"Account\mdx: Head ( [Account].[Total Revenue].Children, 3 )"
pSelection_4,""
pSelection_5,""
pSelectionDelim,"\"
pDimDelim,"&"
pEleStartDelim,"¦"
pEleDelim,"+"
637,11
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pSelection_1,"OPTIONAL: a delimited string containing dimension name and subset name or MDX"
pSelection_2,"OPTIONAL: a delimited string containing dimension name and subset name or MDX"
pSelection_3,"OPTIONAL: a delimited string containing dimension name and subset name or MDX"
pSelection_4,"OPTIONAL: a delimited string containing dimension name and subset name or MDX"
pSelection_5,"OPTIONAL: a delimited string containing dimension name and subset name or MDX"
pSelectionDelim,"OPTIONAL: delimiter character for element list. (default value if blank = '&')"
pDimDelim,"OPTIONAL: Delimiter between dimensions  (default value if blank = '&')"
pEleStartDelim,"OPTIONAL: Delimiter for start of element list  (default value if blank = '¦')"
pEleDelim,"OPTIONAL: Delimiter between elements  (default value if blank = '+')"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,218
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    StringGlobalVariable('sFilter_String');
    vFilter = 'Year¦2025 + 2026 & ';
    # or:
    vFilter = '';
    # or even without a vFilter and just with sFilter_String
    ExecuteProcess( '}bedrock.dim.filter.fromsubset', 
                   'pLogOutput', pLogOutput, 'pStrictErrorHandling', pStrictErrorHandling,
                   'pSelectionDelim', '\', 'pDimDelim', '&', 'pEleStartDelim', '¦', 'pEleDelim', '+', 
                   'pSelection_1', 'Year \ subset: My years subset', 'pSelection_2', 'Company \ subset: Level 0 company', 'pSelection_3', '', 'pSelection_4', '', 'pSelection_5', ''
	);
    vFilter = vFilter | sFilter_String;
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0 ~~##
################################################################################################# 

#Region @DOC
# Description:
# This process will create a filter string for Bedrock processes. The elements are either contained in a public subset, or can be retrieved from an MDX.
# The elements that are found will be concatenated and form a correct filter string for a dimension.
# If the source is a subset then it should be a public subset. It can be static or dynamic. It can be permanent or temporary.
# PA alternate hierarchies are not allowed. Make sure that string count limits are not exceeded.
# The global string variable 'sFilter_String' is populated. The process can also append to it.
# Up to 5 filters can be created with 1 call of this process.
# Do not forget the keywords 'subset' and 'mdx' in the parameter values.

# Use case: Intended for Development but could be used in production too.
# To circumvent the limitation with Bedrock filter strings that they can only contain hardcoded lists of elements.

#EndRegion @DOC

### Global Variables
StringGlobalVariable('sFilter_String');
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName     = GetProcessName();
cUserName         = TM1User();
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cTempSub          = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cMsgInfoContent   = 'User:%cUserName% Process:%cThisProcName% Message:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pSelectionDelim:%pSelectionDelim%, pDimDelim:%pDimDelim%, pEleStartDelim:%pEleStartDelim%, pEleDelim:%pEleDelim%, 
pSelection_1:%pSelection_1%, pSelection_2:%pSelection_2%, pSelection_3:%pSelection_3%, pSelection_4:%pSelection_4%, pSelection_5:%pSelection_5%.'; 

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;


## Default delimiters
If( pSelectionDelim @= '' );
    pSelectionDelim = '\';
EndIf;
If( pDimDelim     @= '' );
    pDimDelim     = '&';
EndIf;
If( pEleStartDelim@= '' );
    pEleStartDelim= '¦';
EndIf;
If( pEleDelim     @= '' );
    pEleDelim     = '+';
EndIf;


# Initialization
sFilter = '';
sTreated_Dimensions = '#';

# Loop through the selections
nSelectionIndex = 1;
While( nSelectionIndex <= 5 );
    sParameter_Name = 'pSelection_' | NumberToString( nSelectionIndex );
    sSelection = Expand( '%' | sParameter_Name | '%' );
    If( sSelection @<> '' );

        sDimension = '';
        sSubset = '';
        sMDX = '';
        nNrOfDelimiters = 0;

        # Get the different parts in the string
        nDimDelimiterIndex = 1;
        While( nDimDelimiterIndex <> 0 );

            nDimDelimiterIndex = Scan( pSelectionDelim, sSelection );
            If( nDimDelimiterIndex = 0 );
                sPart = sSelection;
            Else;
                sPart = Trim( Subst( sSelection, 1, nDimDelimiterIndex - 1 ));
                sSelection = Trim( Delet( sSelection, 1, nDimDelimiterIndex ));
            EndIf;

            nNrOfDelimiters = nNrOfDelimiters + 1;
            If( nNrOfDelimiters = 1 );
                sDimension = sPart;
            ElseIf( nNrOfDelimiters = 2 );
                If( Scan( 'subset:', Lower( sPart )) = 1 );
                    sSubset = Trim( Delet( sPart, 1, 7 ));
                ElseIf( Scan( 'mdx:', Lower( sPart )) = 1 );
                    sMDX = Trim( Delet( sPart, 1, 4 ));
                EndIf;
            EndIf;

        End;

        # Validation checks
        If( sDimension @= '' );
            nErrors = 1;
            If( pLogOutput = 1 );
                sMessage = Expand( 'Empty dimension name: %sDimension% [%sParameter_Name%]' );
                LogOutput( 'ERROR', Expand( cMsgInfoContent ) );
            EndIf;
        EndIf;

        If( Scan( ':', sDimension ) > 0 );
            nErrors = 1;
            If( pLogOutput = 1 );
                sMessage = Expand( 'Hierarchies are not accepted: %sDimension% [%sParameter_Name%]' );
                LogOutput( 'ERROR', Expand( cMsgInfoContent ) );
            EndIf;
        EndIf;

        If( DimensionExists( sDimension ) = 0 );
            nErrors = 1;
            If( pLogOutput = 1 );
                sMessage = Expand( 'Invalid dimension name: %sDimension% [%sParameter_Name%]' );
                LogOutput( 'ERROR', Expand( cMsgInfoContent ) );
            EndIf;
        EndIf;

        If( sSubset @= '' & sMDX @= '' );
            nErrors = 1;
            If( pLogOutput = 1 );
                sMessage = Expand( 'Empty subset name and empty MDX specification, or missing keywords ''subset:'' and ''mdx:'': %sDimension% [%sParameter_Name%]' );
                LogOutput( 'ERROR', Expand( cMsgInfoContent ) );
            EndIf;
        EndIf;

        If( sSubset @<> '' );
            If( SubsetExists( sDimension, sSubset ) = 0 );
                nErrors = 1;
                If( pLogOutput = 1 );
                    sMessage = Expand( 'Invalid subset name: %sSubset% in dimension %sDimension% [%sParameter_Name%]' );
                    LogOutput( 'ERROR', Expand( cMsgInfoContent ) );
                EndIf;
            EndIf;
        EndIf;

        If( Scan( '#' | NumberToString( Dimix( '}Dimensions', sDimension )) | '#', sTreated_Dimensions ) > 0 );
            nErrors = 1;
            If( pLogOutput = 1 );
                sMessage = Expand( 'Dimension used twice: %sDimension% [%sParameter_Name%]' );
                LogOutput( 'ERROR', Expand( cMsgInfoContent ) );
            EndIf;
        EndIf;

        # All good for now, let's continue with the heart of the process
        # We create a temporary subset and loop over its contents
        If( sSubset @<> '' );
            sMDX = 'Distinct( TM1SubsetToSet( [' | sDimension | '], "' | sSubset | '", "public" ))';
        EndIf;
        SubsetCreateByMDX( cTempSub, sMDX, sDimension, 1 );
        n = SubsetGetSize( sDimension, cTempSub );
        If( n = 0 );
            nErrors = 1;
            If( pLogOutput = 1 );
                sMessage = Expand( 'The ' | If( sSubset @<> '', 'subset', 'MDX' ) | ' selection leads to 0 elements or an invalid MDX was passed: %sDimension% in %sDimension% [%sParameter_Name%]' );
                LogOutput( 'ERROR', Expand( cMsgInfoContent ) );
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


        # Finally there, let's loop and concatenate element names
        sFilter = sFilter | If( sFilter @= '', '', ' ' | pDimDelim | ' ' ) | sDimension | pEleStartDelim;
        m = 1;
        While( m <= n );
            vElement = SubsetGetElementName( sDimension, cTempSub, m );
            sFilter = sFilter | If( m = 1, '', ' ' | pEleDelim | ' ' ) | vElement;
            m = m + 1;
        End;

        # Note that this dimension is done and should not be used more than once
        sTreated_Dimensions = sTreated_Dimensions | NumberToString( Dimix( '}Dimensions', sDimension )) | '#';

    EndIf;
    nSelectionIndex = nSelectionIndex + 1;
End;


sFilter_String = sFilter_String | If( sFilter_String @= '', '', ' ' | pDimDelim | ' ' ) | sFilter;

### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,29

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
    If( pStrictErrorHandling = 1 ); 
        ProcessQuit; 
    EndIf;
Else;
    sProcessAction     = Expand( 'Process:%cThisProcName% successfully returned/updated the filter string.' );
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
