601,100
602,"}bedrock.dim.attr.create"
562,"NULL"
586,
585,
564,
565,"j3166_Ksj6aCi0bBBA6>cBjcr=XXTeeLYfpA9N@BGT1eXWEp=bI<^8JcgGxNN?I<hkYUv21Ph8_\iCC7KQG:z3j3NR]kW@YqzB1Jrm9h3id01LrlQL\otG?@sL]3\3iU@s`j2O6H=PyJxU\drM48sLp2lJ8xX@RmYdHKiwR6Uyde7W?tafNuUJevtLtwbnH2Tv4@0k4u"
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
pDim
pAttr
pPrevAttr
pAttrType
pDelim
561,7
1
1
2
2
2
2
2
590,7
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pAttr,""
pPrevAttr,""
pAttrType,""
pDelim,"&"
637,7
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"REQUIRED: dimension name, parameter accepts delimited list and wildcards"
pAttr,"REQUIRED: attribute name, parameter accepts delimited list (separate with delimiter for multiple item e.g. Type&Active )"
pPrevAttr,"OPTIONAL: insert position (previous attribute) (Defaults to blank)"
pAttrType,"OPTIONAL: attribute type (e.g. A, S or N. If blank then assumed to be type=string)"
pDelim,"OPTIONAL: delimiter character for attribute list. (Defaults to & if blank)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,214
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.dim.attr.create', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pDim', '', 'pAttr', '',
    	'pPrevAttr', '', 'pAttrType', '',
    	'pDelim', '&'
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
# This process can insert one or more attributes in one or more specified dimensions. 

# Use case: Intended for development/prototyping.
# 1/ Add multiple dimension attributes.

# Note:
# Delimited lists and/or wild card(*) are acceptable for pDim & pAttr.
# Naturally, valid dimension name(s) (pDim) are mandatory otherwise the process will abort.
# Known limitation: This process can insert multiple attributes to multiple dimensions but only for a single attribute type.
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName   = GetProcessName();
cUserName       = TM1User();
cTimeStamp      = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
cTempSub        = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cMsgErrorLevel  = 'ERROR';
cMsgErrorContent= 'Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo        = 'User:%cUserName% Process:%cThisProcName% run with parameters pDim:%pDim%, pPrevAttr:%pPrevAttr%, pAttr:%pAttr%, pAttrType:%pAttrType%, pDelim:%pDelim%.'; 

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;

# Validate dimension
If( Trim( pDim ) @= '' );
    nErrors         = 1;
    sMessage        = 'No dimension specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate attribute
IF( Trim( pAttr ) @= '' );
    nErrors         = 1;
    sMessage        = 'No attribute specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate attribute type
pAttrType           = Upper( SubSt( pAttrType, 1, 1 ) );
If( pAttrType @<> 'A' & pAttrType @<> 'S' & pAttrType @<> 'N' );
    nErrors         = 1;
    sMessage        = 'Invalid attribute type specified: ' | pAttrType | '. Defaulted to String type';
    LogOutput( 'INFO', Expand( cMsgErrorContent ) );
EndIf;

# Validate previous attribute
If( DimIx( '}ElementAttributes_' | pDim, pPrevAttr ) = 0 % pPrevAttr @= pAttr );
    pPrevAttr       = '';
EndIf;

# If blank delimiter specified then convert to default
If( pDelim @= '' );
    pDelim          = '&';
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

# Loop through dimensions in pDim and attributes in pAttr
sDims               = pDim;
nDimDelimiterIndex  = 1;
# Get 1st dimension
While( nDimDelimiterIndex <> 0 );
    # Extract 1st dimension > sDim
    nDimDelimiterIndex = Scan( pDelim, sDims );
    If( nDimDelimiterIndex = 0 );
        sDim        = sDims;
    Else;
        sDim        = Trim( SubSt( sDims, 1, nDimDelimiterIndex - 1 ) );
        sDims       = Trim( Subst( sDims, nDimDelimiterIndex + Long(pDelim), Long( sDims ) ) );
    EndIf;
    
    # Check if sDim has wildcard
    If( Scan( '*', sDim ) = 0);
        # Validate dimension
        If( DimensionExists(sDim) = 0 );
            nErrors = 1;
            sMessage = Expand( 'Dimension "%sDim%" does not exist.' );
            LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
            If( pStrictErrorHandling = 1 ); 
                ProcessQuit; 
            Else;
                ProcessBreak;
            EndIf;
        Else;
            # Loop through attributes in pAttr  
            sAttrs = pAttr;
            nDelimiterIndex = 1;
            sAttrDim = '}ElementAttributes_'|sDim ;
            While( nDelimiterIndex <> 0 );
    
                nDelimiterIndex = Scan( pDelim, sAttrs );
                If( nDelimiterIndex = 0 );
                    sAttr   = sAttrs;
                Else;
                    sAttr   = Trim( SubSt( sAttrs, 1, nDelimiterIndex - 1 ) );
                    sAttrs  = Trim( Subst( sAttrs, nDelimiterIndex + Long(pDelim), Long( sAttrs ) ) );
                EndIf;
    
                # Check to see if attribute already exists.
                If( Dimix( sAttrDim , sAttr ) = 1 );
                    nErrors = 1;
                    sMessage = 'Attribute ' | sAttr | ' already exist in dimension ' | sDim;
                    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
                Else;
                    AttrInsert( sDim , pPrevAttr , sAttr , pAttrType ) ;
                    If( pLogOutput = 1 );
                        LogOutput( 'INFO', Expand( 'Attribute "%sAttr%" added to dimension %sDim%.' ) );
                    EndIf;
                Endif;
            End;
        EndIf;    
    Else;
        # Create subset using Wildcard to loop through dimensions in pDim with wildcard
        sDimExp = '"'|sDim|'"';
        sMdx = '{TM1FILTERBYPATTERN( EXCEPT ( TM1SUBSETALL( [}Dimensions] ) , TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) , "*:*") ) ,'| sDimExp | ')}';
        If( SubsetExists( '}Dimensions' , cTempSub ) = 1 );
            # If a delimited list of attr names includes wildcards then we may have to re-use the subset multiple times
            SubsetMDXSet( '}Dimensions' , cTempSub, sMDX );
        Else;
            # temp subset, therefore no need to destroy in epilog
            SubsetCreatebyMDX( cTempSub, sMDX, '}Dimensions' , 1 );
        EndIf;
        
        # Loop through dimensions in subset created based on wildcard
        nCountDim = SubsetGetSize( '}Dimensions' , cTempSub );
        While( nCountDim >= 1 );
            
            sDim = SubsetGetElementName( '}Dimensions' , cTempSub, nCountDim );
            # Validate dimension name
            If( DimensionExists(sDim) = 0 );
                nErrors = 1;
                sMessage = Expand( 'Dimension "%sDim%" does not exist.' );
                LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
                If( pStrictErrorHandling = 1 ); 
                    ProcessQuit; 
                Else;
                    ProcessBreak;
                EndIf;
            Else;
            # Loop through attributes in pAttr 
                sAttrs = pAttr;
                nDelimiterIndex = 1;
                sAttrDim = '}ElementAttributes_'|sDim ;
                While( nDelimiterIndex <> 0 );
    
                    nDelimiterIndex = Scan( pDelim, sAttrs );
                    If( nDelimiterIndex = 0 );
                        sAttr   = sAttrs;
                    Else;
                        sAttr   = Trim( SubSt( sAttrs, 1, nDelimiterIndex - 1 ) );
                        sAttrs  = Trim( Subst( sAttrs, nDelimiterIndex + Long(pDelim), Long( sAttrs ) ) );
                    EndIf;
    
                    # Check to see if attribute already exists.
                    If( Dimix( sAttrDim , sAttr ) = 1 );
                        nErrors = 1;
                        sMessage = 'Attribute ' | sAttr | ' already exist in dimension ' | sDim;
                        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
                    Else;
                        AttrInsert( sDim , pPrevAttr , sAttr , pAttrType ) ;
                        If( pLogOutput = 1 );
                            LogOutput( 'INFO', Expand( 'Attribute "%sAttr%" added to dimension %sDim%.' ) );
                        EndIf;
                    Endif;
                End; 
            EndIf;
            
            nCountDim = nCountDim - 1;
        End;
    EndIf;
    
   
End;

### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,23

#****Begin: Generated Statements***
#****End: Generated Statements****

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully created attribute %pAttr% in dimension %pDim%.' );
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
