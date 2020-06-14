C_BOOLEAN:C305($LettrePasEnvoyée)
$LettrePasEnvoyée:=OB Get:C1224([Personnes:12]Arguments:7;"LettreCodeMdPAEnvoyer";Est un booléen:K8:9)
If ($LettrePasEnvoyée)
	CONFIRM:C162("Editer la lettre contenant le code et le mot de passe ?")
	If (OK=1)
		ASAPImprimeLettreCodeMdP 
	End if 
End if 
