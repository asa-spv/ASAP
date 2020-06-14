
$evt:=Form event code:C388
Case of 
	: ($evt=Sur clic:K2:4)
		C_LONGINT:C283($C;$L)
		LISTBOX GET CELL POSITION:C971(*;"ListBoxAttributions";$C;$L)
		If ($L>0)
			If (TbAttributions{$L}="Entreprise")
				$Mess:="Désolé, l'attribution "+<>ZGuil+"Entreprise"+<>ZGuil\
					+" ne peut être supprimée car elle est systématiquement confiée à tout utilisateur"
				ALERT:C41($Mess)
			Else 
				LISTBOX DELETE ROWS:C914(*;"ListBoxAttributions";$L)
				ZDroitsRecalcule 
			End if 
		Else 
			ALERT:C41("Merci de choisir la fonction à attribuer à "+[XUtilisateurs:2]Prenom:3+" "+[XUtilisateurs:2]Nom:2)
		End if 
End case 
