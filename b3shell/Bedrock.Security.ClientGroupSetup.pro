﻿601,100
602,"Bedrock.Security.ClientGroupSetup"
562,"NULL"
586,
585,
564,
565,"upj:B\WI:iJ`hFTV6yQDVy5UZKyb9EyXrj`1i2=@OpGcBZwOpMfobriKUYqWdlaa`l_|`cXevuPBWJ9h5LbxXxNnnz=pukD9V>S9m;x>5E;ASFAYTlHClwze_KW<7In]x^d=5O<fj77`k>XWHay:mlUg\8Q9l6xy5Xv51_p:0uq]~yie>iTK6{eY4Y0RhsRKM_Kfui@j"
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
589,"."
568,""""
570,
571,
569,0
592,0
599,1000
560,6
pClients
pGroups
pPassword
pMaxPorts
pDelimiter
pDebug
561,6
2
2
2
1
2
1
590,6
pClients,""
pGroups,""
pPassword,""
pMaxPorts,5
pDelimiter,"&"
pDebug,0
637,6
pClients,"List of Clients Seperated by Delimiter"
pGroups,"List of Groups Seperated by Delimiter"
pPassword,"Initial Password"
pMaxPorts,"Maximum Ports"
pDelimiter,"Delimiter Character"
pDebug,"Debug Mode"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,32

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 3.1.0~~##
#####################################################################################

# This process will create a client with full setup


### Call processes to add clients and assign client to groups ###

ExecuteProcess( 'Bedrock.Security.Client.Create',
  'pClients', pClients,
  'pPassword', pPassword,
  'pMaxPorts', pMaxPorts,
  'pDelimiter', pDelimiter,
  'pDebug', pDebug
);

ExecuteProcess( 'Bedrock.Security.Client.Group.Assign',
  'pAddOrRemove', 'Add',
  'pClients', pClients,
  'pDelimiter', pDelimiter,
  'pGroups', pGroups,
  'pSecurityRefresh', 'No',
  'pDebug', pDebug
);


### End Prolog ###
573,7

#****Begin: Generated Statements***
#****End: Generated Statements****


#****Begin: Generated Statements***
#****End: Generated Statements****
574,7

#****Begin: Generated Statements***
#****End: Generated Statements****


#****Begin: Generated Statements***
#****End: Generated Statements****
575,5

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
