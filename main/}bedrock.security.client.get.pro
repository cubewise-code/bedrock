601,100
602,"}bedrock.security.client.get.pro"
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
588,"."
589,","
568,""""
570,
571,
569,0
592,0
599,1000
560,4
pUser
pClient_Attribute
pStrip_Off_Prefix
pValidate_Username
561,4
2
2
2
2
590,4
pUser,""
pClient_Attribute,"}TM1_DefaultDisplayValue"
pStrip_Off_Prefix,"Y"
pValidate_Username,"N"
637,4
pUser,"User ?"
pClient_Attribute,"Client attribute ?"
pStrip_Off_Prefix,"Strip off prefix (like a domain) ? (Y/N)"
pValidate_Username,"Return a validated string for the username ? (Y/N)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,187

#****Begin: Generated Statements***
#****End: Generated Statements****


#Region - IntroduceThisProcess
####################################################
# Wim Gielis, May 2026
####################################################
#
# Technical helper process to retrieve a more descriptive username for a TM1 user.
#
# Outcome of the process is threefold:
#
# - A global string variable "vUser_Desc": a descriptive name for the user (like a real name) or for a chore (no real user).
# - A global string variable "vUser_Name": an approximation of the username that was passed, but not necessarily an existing TM1 user.
# - A global string variable "vUser_Name_Existing": a user that is guaranteed to exist and serves us when the passed username does not lead to an existing user.
#     This could happen when:
#     * the passed user is coming from a running chore
#     * this process is called with a non-existing user (e.g. the user was hardcoded and deleted afterwards)
#
# pClient_Attribute can be alias, string attribute or numeric attribute.
# pStrip_Off_Prefix is typically used to remove the prefix like "Planning Analytics" or "Business Analytics".
# pValidate_Username is used when the username is part of TI programming to return unique object names that could be stored on the file system.
# For this parameter we delegate the work to a different Bedrock process.
#
####################################################

#####
# Add the following process(es) to this TM1 model:
# - }bedrock.server.util.string.validate
#####
#EndRegion


#Region - CallThisProcess
## call this custom process as, for instance:
If( 1 = 0 );
StringGlobalVariable( 'vUser_Desc' );
StringGlobalVariable( 'vUser_Name' );
StringGlobalVariable( 'vUser_Name_Existing' );
ExecuteProcess( 'TECH_get username' );
# 3 global variables are now populated

# Or, more complete:
StringGlobalVariable( 'vUser_Desc' );
StringGlobalVariable( 'vUser_Name' );
StringGlobalVariable( 'vUser_Name_Existing' );
ExecuteProcess( 'TECH_get username', 'pUser', TM1User(), 'pClient_Attribute', '}TM1_DefaultDisplayValue', 'pStrip_Off_Prefix', 'Y', 'pValidate_Username', 'N' );
# 3 global variables are now populated
EndIf;
#EndRegion


# # Logging
# b = CHAR(13) | FILL( ' ', 8 ) | '*'; LogOutput( 'INFO', '... parameter values:' 
#      | b | 'User: ' | pUser
#      | b | 'Client alias: ' | pClient_Attribute
#      | b | 'Strip off prefix: ' | pStrip_Off_Prefix
#      | b | 'Return a TM1 safe username for objects/file system: ' | pValidate_Username
#  );


## Global variables
# We need to pass back information to the calling process
StringGlobalVariable( 'vUser_Desc' );
StringGlobalVariable( 'vUser_Name' );
StringGlobalVariable( 'vUser_Name_Existing' );


# Default values and constant values
cEA = '}ElementAttributes_}Clients';
vUser = Trim( If( pUser @= '', TM1User(), pUser ));
pStrip_Off_Prefix = If( pStrip_Off_Prefix @= '', 'Y', pStrip_Off_Prefix );
pValidate_Username = If( pValidate_Username @= '', 'N', pValidate_Username );

If( pStrip_Off_Prefix @<> 'Y' 
  & pStrip_Off_Prefix @<> 'N' );
    LogOutput( 'ERROR', 'The parameter ''pStrip_Off_Prefix'' needs to be Y or N. The parameter value is now ''' | pStrip_Off_Prefix | '''. Please check the logs.' );
    ProcessQuit;
EndIf;
If( pValidate_Username @<> 'Y' 
  & pValidate_Username @<> 'N' );
    LogOutput( 'ERROR', 'The parameter ''pValidate_Username'' needs to be Y or N. The parameter value is now ''' | pValidate_Username | '''. Please check the logs.' );
    ProcessQuit;
EndIf;


# Return a descriptive value for the user in question
If( Subst( vUser, 1, 2 ) @= 'R*' );

    vUser_Desc = 'Chore: ' | Delet( vUser, 1, 2 );

ElseIf( ElementIndex( '}Clients', '', vUser ) = 0 );

    vUser_Desc = '';

ElseIf( DimensionExists( cEA ) = 0 );

    vUser_Desc = vUser;

ElseIf( CubeExists( cEA ) = 0 );

    vUser_Desc = vUser;

Else;

    If( ElementIndex( cEA, '', pClient_Attribute ) > 0 );
        If( ElementType( cEA, '', pClient_Attribute ) @= 'AN' );
            vAttribute_Value = NumberToString( CellGetN( cEA, vUser, pClient_Attribute ));
            pStrip_Off_Prefix = 'N';
        Else;
            vAttribute_Value = CellGetS( cEA, vUser, pClient_Attribute );
        EndIf;

    ElseIf( ElementIndex( cEA, '', '}TM1_DefaultDisplayValue' ) > 0 );
        vAttribute_Value = CellGetS( cEA, vUser, '}TM1_DefaultDisplayValue' );

    ElseIf( ElementIndex( cEA, '', 'Caption' ) > 0 );
        vAttribute_Value = CellGetS( cEA, vUser, 'Caption' );

    ElseIf( ElementIndex( cEA, '', 'Name' ) > 0 );
        vAttribute_Value = CellGetS( cEA, vUser, 'Name' );

    EndIf;

    If( vAttribute_Value @= '' );
        vUser_Desc = vUser;
    Else;
        vUser_Desc = Trim( vAttribute_Value );
    EndIf;

EndIf;

# Strip off prefix in the descriptive username (e.g. to exclude the domain/LDAP)
If( pStrip_Off_Prefix @= 'Y' );

    r = Scan( '\', vUser_Desc );
    If( r > 0 );
        vUser_Desc = Delet( vUser_Desc, 1, r );
    EndIf;

    r = Scan( '/', vUser_Desc );
    If( r > 0 );
        vUser_Desc = Delet( vUser_Desc, 1, r );
    EndIf;

EndIf;


# Return 2 "usernames" of which one (vUser_Name_Existing) is guaranteed to exist (except in very improbable situations), 
# and the other one (vUser_Name) will probably exist too and coincide.
vUser_Name = vUser;

If( ElementIndex( '}Clients', '', vUser_Name ) > 0 );
    vUser_Name_Existing = vUser_Name;
Else;
    If( ElementIndex( '}Clients', '', 'Admin' ) > 0 );
        vUser_Name_Existing = 'Admin';
    Else;
        vUser_Name_Existing = '';
        u = 1;
        While( u <= ElementCount( '}Clients', '' ));
            vUser_Loop = ElementName( '}Clients', '', u );
            If( CellGetS( '}ClientGroups', vUser_Loop, 'ADMIN' ) @= 'ADMIN' );
                vUser_Name_Existing = vUser_Loop;
                Break;
            EndIf;
            u = u + 1;
        End;
    EndIf;
EndIf;

# Validations for TM1 objects/file system
If( pValidate_Username @= 'Y' );

    cProcess = '}bedrock.server.util.string.validate';
    If( ProcessExists( cProcess ) = 1 );
        StringGlobalVariable( 'sOutputString' );

        ExecuteProcess( cProcess, 'pInputString', vUser_Name, 'pChanges', '', 'pReplaceIfNotFound', '_', 'pMode', 3 );
        vUser_Name = sOutputString;
        ExecuteProcess( cProcess, 'pInputString', vUser_Name_Existing, 'pChanges', '', 'pReplaceIfNotFound', '_', 'pMode', 3 );
        vUser_Name_Existing = sOutputString;

    EndIf;
EndIf;
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,3

#****Begin: Generated Statements***
#****End: Generated Statements****
576,CubeAction=1511DataAction=1503CubeLogChanges=0_ParameterConstraints=e30=
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
