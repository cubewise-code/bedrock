601,100
602,"}bedrock.hier.elements.validate"
562,"SUBSET"
586,"}Dimensions"
585,"}Dimensions"
564,
565,"g[nj@IeaarPiT\neCu:cZ_>3p4:kFy6Ra_<TP1>GS;TMi_C6d=wAw:Wyw1^NOum:NXKgqdQo\]@bRx;20YC@^?E=ZLG^j:7[ukPw;?e9Zxs>7kZMq6PPe^nNylx7u7PkOd<o;KQ4\TPT]c5VK\PRv\i=S9Vzpqitq`GTdGHfA9[kH53sN:W3t0GohU^66]qzpWQjDmsG"
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
571,}Export.All
569,0
592,0
599,1000
560,6
pLogOutput
pStrictErrorHandling
pDim
pHier
pFirst
pDelim
561,6
1
1
2
2
1
2
590,6
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pHier,"*"
pFirst,1
pDelim,"&"
637,6
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"OPTIONAL: Dimension name or list? (accepts wildcards). Will process ALL if = *"
pHier,"OPTIONAL: Hierarchy name or list? (accepts wildcards). Will process ALL if = *"
pFirst,"OPTIONAL: 0 = Ignore 1st character requirements, 1 = Validate 1st character more stringently than other characters (e.g. for MDX no ""+"" as 1st character)"
pDelim,"OPTIONAL: Delimiter for dimension list (If blank or not passed then ""&"" will be used as default list delimiter)"
577,1
vDim
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
572,250
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.hier.elements.validate', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pDim', '', 'pHier', '*', 
    	'pFirst', 1, 'pDelim', '&'
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
# This process will review all elements in selected dimensions (you can specify a single dimension,
# multiple dimensions or wildcards to match dimensions) and hierarchies and will generate a `csv` 
# file listing all elements with unusual characters.
# Control dimensions are ignored.

# Note:
# - pDim: Specify which dimensions to validate. When specifying a dimension name, wildcards can
#   be specified by using the `*` and `?` characters. A list of dimensions can also be entered with
#   a delimiter (e.g. `v*&plan*` will process all dimensions starting with `v` and `plan`). If 
#   * is entered then it ignores anything entered for hierarchy (pHier) and processes all dimensions
# - pHier: Specify which hierarchies to validate. To validate ALL hierachies, enter *. 
#   When specifying a hierarchy name, wildcards can be specified by using the
#   `*` and `?` characters. A list of hierachies can also be entered with a delimiter. If pHier
#   has a value then it does not make sense that pDim can be set up as a list or with wildcards.
# - pDelim: The delimiter is used when specifying multiple dimensions or multiple hierachies. The
#   default delimiter is `&`. Any delimiter can be used by specifying a value for pDelim. Choose
#   a delimiter that won't be used in either the wildcard search strings or dimension names.
# - pFirst:
#   - When set to `1`: all requirements for all characters are validated.
#   - ELSE: ignores stringent requirements for 1st character.
#EndRegion @DOC


### Global Variables
StringGlobalVariable ('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode = 0;

### Constants ###
cThisProcName     = GetProcessName();
cUserName         = TM1User();
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cSubset           = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = '%cThisProcName% : %sMessage% : %cUserName%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%, pFirst:%pFirst%, pDelim:%pDelim%';
cDim              = '}Dimensions';
cFile             = GetProcessErrorFileDirectory | 'Element Issues.csv';

# Variables
nMeta             = 0;

## LogOutput parameters
IF ( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;

If( Scan( '*', pDim ) = 0 & Scan( '?', pDim ) = 0 & Scan( pDelim, pDim ) = 0 & Scan( ':', pDim ) > 0 & pHier @= '' );
    # A hierarchy has been passed as dimension. Handle the input error by splitting dim:hier into dimension & hierarchy
    pHier       = SubSt( pDim, Scan( ':', pDim ) + 1, Long( pDim ) );
    pDim        = SubSt( pDim, 1, Scan( ':', pDim ) - 1 );
EndIf;

# Validate dimension
If( Trim( pDim ) @= '' );
    nErrors = 1;
    sMessage = 'No dimension specified. Use * to process all dimensions';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate hierarchy
If( Trim( pHier ) @= '' );
    ## use same name as Dimension. Since wildcards are allowed, this is managed inside the code below
EndIf;

If( pDelim @= '' );
    pDelim = '&';
EndIf;

## Validate dimension
IF( Trim( pDim ) @= '*' );
    sMDX                = Expand('{ TM1SUBSETALL( [}Dimensions] ) }');
ElseIf( Trim( pHier ) @= '*' );
    IF( Scan( pDelim , pDim )>0 );
        # delimiter in pDim. Seperate and add MDX for each part separately
        sMDX            = '{ ';
        sDims           = Trim( pDim );
        nDelimiterIndex = 1;
        While( nDelimiterIndex <> 0 );    
            nDelimiterIndex = Scan( pDelim, sDims );
            If( nDelimiterIndex = 0 );
                sDim            = sDims;
            ELSE;
                sDim            = Trim( SubSt( sDims, 1, nDelimiterIndex - 1 ) );
                sDims           = Trim( Subst( sDims, nDelimiterIndex + Long(pDelim), Long( sDims ) ) );
            ENDIF;
            IF(DimensionExists(sDim)=1 );
                sMDX            = Expand('{TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) ,"%sDim%*")}');
            ELSEIF(Scan( '*', sDim )=0 & Scan( '?', sDim )=0 );
                #nErrors = 1;
                sMessage= Expand('Dimension %sDim% does not exist.');
                LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            ELSE;
                sMDX            = sMDX | IF(Long(sMDX)>4,
                                            Expand(',TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) ,"%sDim%")'),
                                            Expand(' TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) ,"%sDim%")')); 
            ENDIF;
        END;
        sMDX                    = sMDX | ' }';
    ELSE;
        IF(DimensionExists(pDim)=1 );
            sMDX                = Expand('{TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) ,"%pDim%*")}');
        ELSEIF(Scan( '*', pDim )=0 & Scan( '?', pDim )=0 );
            nErrors = 1;
            sMessage= Expand('Dimension %pDim% does not exist.');
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        ELSE;
            sMDX                = Expand('{TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) ,"%pDim%")}');
        ENDIF;
    ENDIF;
    
ElseIf( HierarchyExists( pDim , pHier ) = 1 & Trim( pHier ) @<>'' );
    sMDX = Expand('{TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) ,"%pDim%:%pHier%")}');
    
ElseIf( Scan( pDelim  , pHier )>0 % Scan( '*'     , pHier )>0 % Scan( '?'     , pHier )>0);
    sMDX            = '{ ';
    IF( Scan( pDelim  , pHier )>0 );
        # delimiter in pHier. Seperate and add MDX for each part separately
        sHiers           = Trim( pHier );
        nDelimiterIndex = 1;
        While( nDelimiterIndex <> 0 );    
            nDelimiterIndex = Scan( pDelim, sHiers );
            If( nDelimiterIndex = 0 );
                sHier            = sHiers;
            ELSE;
                sHier            = Trim( SubSt( sHiers, 1, nDelimiterIndex - 1 ) );
                sHiers           = Trim( Subst( sHiers, nDelimiterIndex + Long(pDelim), Long( sHiers ) ) );
            ENDIF;
            IF(HierarchyExists( pDim, sHier )=1 );
                sMDX            = sMDX | IF(Long(sMDX)>4,
                                            Expand(',TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) ,"%pDim%:%sHier%")'),
                                            Expand(' TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) ,"%pDim%:%sHier%")')); 
            ELSEIF(Scan( '*', sHier )=0 & Scan( '?', sHier )=0 );
                nErrors = 1;
                sMessage= Expand('Dimension:Hierarchy %pDim%:%sHier% does not exist.');
                LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            ELSE;
                sMDX            = sMDX | IF(Long(sMDX)>4,
                                            Expand(',TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) ,"%pDim%:%sHier%")'),
                                            Expand(' TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) ,"%pDim%:%sHier%")')); 
            ENDIF;
                
        END;
        sMDX                    = sMDX | ' }';
    ELSE;
        # No delimiters but with wildcards in hierachy
        IF(HierarchyExists( pDim, pHier )=1 );
            sMDX                = Expand('{TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) ,"%pDim%:%pHier%")}');
        ELSEIF(Scan( '*', pHier )=0 & Scan( '?', pHier )=0 );
            nErrors = 1;
            sMessage= Expand('Dimension:Hierarchy %pDim%:%pHier% does not exist.');
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        ELSE;
            sMDX                = Expand('{TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) ,"%pDim%:%pHier%")}');
        ENDIF;
        
    ENDIF;

ElseIf( Trim( pHier ) @='' );
    ## Use main hierarchy for each dimension processed
    pHier = Trim( pDim );
    sMDX            = '{ ';
    IF( Scan( pDelim  , pHier )>0 );
        # delimiter in pHier. Seperate and add MDX for each part separately
        sHiers           = Trim( pHier );
        nDelimiterIndex = 1;
        While( nDelimiterIndex <> 0 );    
            nDelimiterIndex = Scan( pDelim, sHiers );
            If( nDelimiterIndex = 0 );
                sHier            = sHiers;
            ELSE;
                sHier            = Trim( SubSt( sHiers, 1, nDelimiterIndex - 1 ) );
                sHiers           = Trim( Subst( sHiers, nDelimiterIndex + Long(pDelim), Long( sHiers ) ) );
            ENDIF;
            IF(HierarchyExists( sHier, sHier )=1 );
                sMDX            = sMDX | IF(Long(sMDX)>4,
                                            Expand(',TM1FILTERBYPATTERN( EXCEPT( TM1SUBSETALL( [}Dimensions] ) , TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) , "*:*") ) ,"%sHier%")'),
                                            Expand(' TM1FILTERBYPATTERN( EXCEPT( TM1SUBSETALL( [}Dimensions] ) , TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) , "*:*") ) ,"%sHier%")')); 
            ELSEIF(Scan( '*', sHier )=0 & Scan( '?', sHier )=0 );
                nErrors = 1;
                sMessage= Expand('Dimension:Hierarchy %sHier%:%sHier% does not exist.');
                LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
            ELSE;
                sMDX            = sMDX | IF(Long(sMDX)>4,
                                            Expand(',TM1FILTERBYPATTERN( EXCEPT( TM1SUBSETALL( [}Dimensions] ) , TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) , "*:*") ) ,"%sHier%")'),
                                            Expand(' TM1FILTERBYPATTERN( EXCEPT( TM1SUBSETALL( [}Dimensions] ) , TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) , "*:*") ) ,"%sHier%")')); 
            ENDIF;
                
        END;
        sMDX                    = sMDX | ' }';
    ELSE;
        # No delimiters but with wildcards in hierachy
        IF(HierarchyExists( pDim, pHier )=1 );
            sMDX                = Expand('{TM1FILTERBYPATTERN( EXCEPT( TM1SUBSETALL( [}Dimensions] ) , TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) , "*:*") ) ,"%pDim%")}');
        ELSEIF(Scan( '*', pHier )=0 & Scan( '?', pHier )=0 );
            nErrors = 1;
            sMessage= Expand('Dimension:Hierarchy %pDim%:%pHier% does not exist.');
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        ELSE;
            sMDX                = Expand('{TM1FILTERBYPATTERN( EXCEPT( TM1SUBSETALL( [}Dimensions] ) , TM1FILTERBYPATTERN( TM1SUBSETALL( [}Dimensions] ) , "*:*") ) ,"%pDim%")}');
        ENDIF;
        
    ENDIF;
    
ELSE;
    nErrors = 1;
    sMessage= Expand('Dimension:Hierarchy %pDim%:%pHier% does not exist.');
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
    DatasourceType = 'NULL';
    ProcessBreak;
EndIf;

# Create temporary subset
SubsetCreatebyMDX(cSubset, sMDX , 1 );

### Set data source for process ### 
DatasourceType              = 'SUBSET';
DatasourceNameForServer     = cDim; 
DatasourceNameForClient     = cDim;
DatasourceDimensionSubset   = cSubset;

### End Prolog ###
573,75

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0.0~~##
################################################################################################# 

# Validates characters in elements

# Increment nMeta
nMeta           = nMeta + 1;

# Output 1st line
IF( nMeta = 1 );
    sOutput     = 'Dimension:Hierarchy"' |','| '"Element"'  |','| '"Type"' |','| '"Comments';
    TextOutput ( cFile , sOutput );
EndIf;

### Skip Control dimensions###
IF(Subst(vDim , 1 , 1 ) @= '}' );
    ItemSkip;
ENDIF;

# Set Dim name & hierachy name
IF( SCAN( ':' , vDim )=0 );
    sDim        = vDim ;
    sHier       = sDim ;
ELSE;
    sDim        = SUBST( vDim, 1 , SCAN( ':' , vDim ) -1 );
    sHier       = SUBST( vDim, SCAN( ':' , vDim ) +1, 99 );
ENDIF;

nDimSize        = ElementCount( sDim , sHier );
nCount          = 1;
While( nCount <= nDimSize );
    sEle        = ElementName( sDim , sHier , nCount );
    sEleType    = ElementType( sDim , sHier , sEle );
    sEleNew     = '';
    nEleSiz     = Long(sEle);
    nChar       = 1;
    While( nChar <= nEleSiz & ElementIndex( sDim , sHier , sEle ) > 0 );
        sChar       = NumberToString( nChar );
        sEleChar    = Subst( sEle , nChar , 1 );
        nCode       = CODE( sEle , nChar );
        sCode       = NumberToString( nCode );
        IF( vDim @= sDim );
            IF( nChar=1 & pFirst=1 & (nCode=39 % nCode=45 % nCode=91 % nCode=34 % nCode=64 % nCode=33 % nCode=43 % nCode=123 % nCode=37));
                sOutput = Expand('%vDim%" , %sEle% , %sEleType% ,Has an illegal 1st character "%sEleChar%" with an AscII code of %sCode%.');
                TextOutput ( cFile , sOutput );
            EndIf;
            IF( sEleChar@='/' % sEleChar@='|' % sEleChar@='"' % sEleChar@='\' % sEleChar@='>' % 
                sEleChar@='<' % sEleChar@=':' % sEleChar@='?' % sEleChar@='*');     
                sOutput = Expand('%vDim%" , %sEle% , %sEleType% ,Has a forbidden character #%sChar% "%sEleChar%" with an AscII code of %sCode%.');
                TextOutput ( cFile , sOutput );
            ENDIF;
        ELSEIF( ElementType( sDim, sHier, sEle)@='C' % pHier@<>'' );
            IF( nChar=1 & pFirst=1 & (nCode=39 % nCode=45 % nCode=91 % nCode=34 % nCode=64 % nCode=33 % nCode=43 % nCode=123 % nCode=37));
                sOutput = Expand('%vDim%" , %sEle% , %sEleType% ,Has an illegal 1st character "%sEleChar%" with an AscII code of %sCode%.');
                TextOutput ( cFile , sOutput );
            EndIf;
            IF( sEleChar@='/' % sEleChar@='|' % sEleChar@='"' % sEleChar@='\' % sEleChar@='>' % 
                sEleChar@='<' % sEleChar@=':' % sEleChar@='?' % sEleChar@='*');     
                sOutput = Expand('%vDim%" , %sEle% , %sEleType% ,Has a forbidden character #%sChar% "%sEleChar%" with an AscII code of %sCode%.');
                TextOutput ( cFile , sOutput );
            ENDIF;
        ENDIF;

        nChar       = nChar + 1;
    End;
    
    nCount      = nCount + 1;
End;

### End MetaData ###
574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,27

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# 
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0.0~~##
################################################################################################# 

### If errors occurred terminate process with a major error status ###
If( nErrors <> 0 );
  sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% incurred at least 1 major error and consequently aborted.' );
  nProcessReturnCode = 0;
  LogOutput( 'ERROR', Expand( sProcessReturnCode | ' Please see above lines in this file for more details.' ) );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  EndIf;
EndIf;

#Return Code
sProcessAction      = Expand( 'Process:%cThisProcName% has validated all the elements for %pDim% dimension and generated a csv report: %cFile%.' );
sProcessReturnCode  = Expand( '%sProcessReturnCode% %sProcessAction%' );
nProcessReturnCode  = 1;
IF ( pLogoutput = 1 );
  LogOutput('INFO', sProcessAction );   
ENDIF;

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
