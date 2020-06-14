//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 21/08/18, 15:31:49
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : SupprimeDoublonsPatricipation
  // Description

C_LONGINT:C283($Salé;$FT)

READ WRITE:C146([CampagneParticipations:17])
QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];[CampagneParticipations:17]Arguments:5;"NumRaemaLié";#;Null:C1517)
QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];[CampagneParticipations:17]Arguments:5;"CodeRaemaLié";#;Null:C1517)
ALL RECORDS:C47([CampagneParticipations:17])
ORDER BY:C49([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3;>;[CampagneParticipations:17]UUIDPersonne:2;>)
SELECTION TO ARRAY:C260([CampagneParticipations:17]UUIDPersonne:2;$TbUUID)
LONGINT ARRAY FROM SELECTION:C647([CampagneParticipations:17];$TbNumEnr)
ARRAY LONGINT:C221($TbPeloton;0)
$FT:=Size of array:C274($TbNumEnr)
For ($Salé;2;$FT)
	If ($TbUUID{$Salé}=$TbUUID{$Salé-1})
		APPEND TO ARRAY:C911($TbPeloton;$TbNumEnr{$Salé})
		GOTO RECORD:C242([CampagneParticipations:17];$TbNumEnr{$Salé-1})
		OB REMOVE:C1226([CampagneParticipations:17]Arguments:5;"NumRaemaLié")
		OB REMOVE:C1226([CampagneParticipations:17]Arguments:5;"CodeRaemaLié")
		SAVE RECORD:C53([CampagneParticipations:17])
	End if 
End for 
CREATE SELECTION FROM ARRAY:C640([CampagneParticipations:17];$TbPeloton)
DELETE SELECTION:C66([CampagneParticipations:17])