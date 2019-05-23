601,100
602,"}bedrock.cube.rule.manage"
562,"NULL"
586,
585,
564,
565,"z5ET]\aTJIstnCu1iZB[gdsxPQak2GsC;=A=2pT61G1M[Z`LV;6iStS9N5`TriTfuCP<YaX\Om:Fw<8W1k2QS]4]`TfNDsDQfCn=k9yBRlISeMlEI2MvXgJ>Ed3gI:Flw>u4c5^jdpggR3n2>Q_nMIabDn3g\5=NoW?ddjB1wu=bEdYv\AZq7VGWF6y<fzX>ecDF[zFN"
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
560,6
pLogOutput
pCube
pMode
pFileName
pDelim
pPath
561,6
1
2
2
2
2
2
590,6
pLogOutput,0
pCube,""
pMode,""
pFileName,""
pDelim,"&"
pPath,""
637,6
pLogOutput,"Optional: write parameters and action summary to server message log (Boolean True = 1)"
pCube,"Required: Cube Name to Load/Unload rule (Separated by Delimiter, Accepts Wild card)"
pMode,"Required: Load/Unload the cube rule (=Load, the file name should be available in the data directory with the required file name Suffix)"
pFileName,"Optional: Full file name for storing the rule (if empty = cube name.txt)"
pDelim,"Optional: Delimiter  (default value if blank = '&')"
pPath,"Optional: Saves the file and the backup of the existing rule in this location. If Null, backup will be saved in Data Directory. Default value Null"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,243
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}bedrock.cube.rule.manage', 'pLogOutput', pLogOutput,
    	'pCube', '', 'pMode', '',
    	'pFileName', '', 'pDelim','&', 
    	'pPath', ''
	);
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# ####################
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 

#Region @DOC
# Description:
# This process will backup & remove **OR** re-attach the rule file to cube.

# Use case: Intended to be used in production.
# 1/ Remove rule file before data load to speed up data load.
# 2/ Re-attach rule file after data load.

# Note:
# Naturally, a valid cube name (pCube) is mandatory otherwise the process will abort.
# The mandatory pMode parameter must be set to 'Unload' to remove/unload the rule file.
# The pMode parameter must be set to 'Load' to re-attach the rule file and apply the rules.
#EndRegion @DOC

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###

cThisProcName       = GetProcessName();
cTimeStamp          = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt          = NumberToString( INT( RAND( ) * 1000 ));
cTempSub            = cThisProcName | '_' | cTimeStamp | '_' | cRandomInt;
cCubeDim            = '}Cubes';
cCubeHier           = cCubeDim;
sPath               = '';
cUserName           = TM1User();
cMsgErrorLevel      = 'ERROR';
cMsgErrorContent    = 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo            = 'Process:%cThisProcName% run with parameters pCube:%pCube%, pMode:%pMode%, pFileName:%pFileName%, pDelim:%pDelim%, pPath:%pPath%.' ;  

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

cBlankRuleName = 'BlankRuleFile.rux';
nErrors = 0;

### PROCESS PROPERTIES
DatasourceASCIIDelimiter = '';
DatasourceASCIIQuoteCharacter = '';

##Validate Mode

If(upper(pMode) @<> 'LOAD' & upper(pMode) @<> 'UNLOAD');
    sMessage = Expand('Invalid Mode: %pMode%. Valid Modes are Load or Unload');
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
Endif;

##Validate Cube

If( Trim(pCube) @= '' );
    sMessage = Expand('No cube specified');
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
Endif;

## Default filter delimiters
If( pDelim     @= '' );
    pDelim     = '&';
EndIf;

# define backupdir
If(pPath @<> '');
    If(Subst(pPath,long(pPath),1) @= '\' % Subst(pPath,long(pPath),1) @= '/' );
        sPath = pPath;
    Else;
        sPath = pPath | '\';
    Endif;
else;
  sPath = '.\';
Endif;

##Create Blank Rule file in the data directory
IF(FileExists( cBlankRuleName ) = 0 );

  sFile = '.\' | cBlankRuleName;
  
  sCommand = 'cmd /c "(echo SKIPCHECK;) > ' | sFile | '"';
  ExecuteCommand ( sCommand, 0 );
  
  sCommand = 'cmd /c "(echo FEEDERS;) >> ' | sFile | '"';
  ExecuteCommand ( sCommand, 0 );
  
ENDIF;


## Default files names for storing rule and backups
IF(pFileName@='');
  sRuleFileName         = '%sCube%.txt';
  sBackupFileName       = '%sCube%.rux.bkp_%cTimeStamp%.txt';
  sWildFileName         = '%sCube%.txt';
  sBackupWildFileName   = '%sCube%.rux.bkp_%cTimeStamp%.txt';
Else;
  sRuleFileName         = pFileName;
  sBackupFileName       = '%pFileName%.bkp_%cTimeStamp%.txt';
  sWildFileName         = subst(pFileName,1,scan('.',pFileName)-1)|'%sCube%'|subst(pFileName,scan('.',pFileName),long(pFileName));
  sBackupWildFileName   = subst(pFileName,1,scan('.',pFileName)-1)|'%sCube%'|subst(pFileName,scan('.',pFileName),long(pFileName))|'.bkp_%cTimeStamp%.txt';
Endif;  
  
# Loop through list of Cubes
sCubes = pCube;
nCubeDelimIndex = 1;

While( nCubeDelimIndex <> 0 );
  nCubeDelimIndex = Scan( pDelim, sCubes );
  If( nCubeDelimIndex = 0 );
    sCube = sCubes;
  Else;
    sCube = Trim( SubSt( sCubes, 1, nCubeDelimIndex - 1 ) );
    sCubes = Trim( Subst( sCubes, nCubeDelimIndex + Long(pDelim), Long( sCubes ) ) );
  EndIf;

  If( Scan( '*', sCube ) = 0);
    If(CubeExists(sCube) <> 0);

      cCubeRuleFileName = '.\'|sCube | '.RUX';
      cStoreDirFile = sPath | Expand(sRuleFileName);
      cBackupDirFile = sPath | Expand(sBackupFileName); 
      
        # if there already is a rule file
      If(FileExists(cCubeRuleFileName) <> 0);
        ##Loading the Rule###
        If(Upper(pMode) @= 'LOAD');
          ##Backup the existing rule (saved as .bkp.txt in given path or data directory) 
          ##and load the new rule file. New Rule file should available in the given path or in data directory
          
          sCmd = 'cmd /c "copy """' | cCubeRuleFileName | '"""  """' | cBackupDirFile |'""" "';          
          ExecuteCommand(sCmd,1);
          RuleLoadFromFile( sCube, cStoreDirFile);
          
        Else;
          ##Unloading the Rule###
          ##Before unloading, backup the existing rule (saved as .bkp.txt in data directory or with the suffix parameter)
          ##and load the blank rule
          
          sCmd = 'cmd /c "copy """' | cCubeRuleFileName | '"""  """' | cBackupDirFile |'""" "';
          ExecuteCommand(sCmd,1);
          sCmd = 'cmd /c "copy """' | cCubeRuleFileName | '"""  """' | cStoreDirFile |'""" "';
          ExecuteCommand(sCmd,1);
          RuleLoadFromFile( sCube, cBlankRuleName );
          
        Endif;
        
      Else;
        ###To create a new rule file for the cube (no existing rule)
        If(Upper(pMode) @= 'LOAD');
          RuleLoadFromFile( sCube, cStoreDirFile );
        Else;
          nErrors = nErrors + 1;
          sMessage = 'No Rule file found for cube: ' | sCube;
          LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        Endif;
      Endif;
    Else;
      nErrors = nErrors + 1;
      sMessage = 'No cube available with: ' | sCube;
      LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    Endif;
  Else;
    # Wildcard search string
        sSearch = '.\' | sCube | '.RUX';

        # Find all Cubes that match search string
        sFilename = WildcardFileSearch( sSearch, '' );
        While( sFilename @<> '' & Subst( sFilename, Long(sFilename)-3, 4) @= '.RUX' );
          # Trim .RUX off the filename
          sCube = SubSt( sFilename, 1, Long( sFilename ) - 4 );
          
          If( CubeExists( sCube ) = 1 ); 
            cCubeRuleFileName = '.\'|sCube | '.RUX';
            cStoreDirFile = sPath | Expand(sWildFileName);
            cBackupDirFile = sPath | Expand(sBackupWildFileName); 
            
            ###Checking whether rule file exists. If exists, backup th existing rule file and load new rule file
            If(FileExists(cCubeRuleFileName) <> 0);
              
              ##Loading Rule for the cube
              If(Upper(pMode) @= 'LOAD');
                ##Backup the existing rule (saved as .bkp.txt in data directory) 
                ##and load the new rule file. New Rule file should available in the data directory/backupdirectory
                
                sCmd = 'cmd /c "copy """' | cCubeRuleFileName | '"""  """' | cBackupDirFile |'""" "';          
                ExecuteCommand(sCmd,1);
                RuleLoadFromFile( sCube, cStoreDirFile);

              Else;
                ##Unloading the Rule
                ##Before unloading, backup the existing rule (saved as .bkp.txt in data directory or with the suffix parameter)
                ##and load the blank rule
                
                sCmd = 'cmd /c "copy """' | cCubeRuleFileName | '"""  """' | cBackupDirFile |'""" "';
                ExecuteCommand(sCmd,1);
                sCmd = 'cmd /c "copy """' | cCubeRuleFileName | '"""  """' | cStoreDirFile |'""" "';
                ExecuteCommand(sCmd,1);
                RuleLoadFromFile( sCube, cBlankRuleName );
                
              Endif;
            Else;
              ##Loading rule for the cube that did not have it before
              If(Upper(pMode) @= 'LOAD');
                
                RuleLoadFromFile( sCube, cStoreDirFile );
                
              Else;
                nErrors = nErrors + 1;
                sMessage = 'No Rule file found for cube: ' | sCube;
                LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
              Endif;
            Endif;
          Else;
            nErrors = nErrors + 1;
            sMessage = 'No cube available with: ' | sCube;
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
          Endif;
          
          sFilename = WildcardFileSearch( sSearch, sFilename );
        End;
    
  Endif;
End;
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,5

#****Begin: Generated Statements***
#****End: Generated Statements****


575,25

#****Begin: Generated Statements***
#****End: Generated Statements****

################################################################################################# ####################
##~~Join the bedrock TM1 community on GitHub https://github.com/cubewise-code/bedrock Ver 4.0~~##
################################################################################################# 


### Return code & final error message handling
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
Else;
    sProcessAction = Expand( 'Process:%cThisProcName% successfully %pMode% cube rule from cube %pCube% .' );
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
917,0
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
