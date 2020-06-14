//%attributes = {}
  // ZDestroyListe V11 du 14/08/2010
  //  MP de destruction de la sélection affichée
  //  Utilise ZAdieuSélection

C_LONGINT:C283($FT)
If (ZSupprime)
	$FT:=Records in selection:C76(ZPtTable->)
	If ($FT#0)
		If ($FT=1)
			LOAD RECORD:C52(ZPtTable->)
			CONFIRM:C162("Voulez-vous VRAIMENT détruire l'enregistrement "+<>Zguil+ZPtChamp->+<>Zguil)
		Else 
			CONFIRM:C162("Voulez-vous VRAIMENT détruire "+String:C10($FT)+" enregistrements")
		End if 
		If (OK=1)
			CONFIRM:C162("Présenter l'accord écrit du responsable à l'écran")
			If (OK=1)
				CONFIRM:C162("Etait-il à jeun ??!")
				If (OK=1)
					ZAdieuSel 
				End if 
			End if 
		End if 
	Else 
		ALERT:C41("peu d'intérêt de vouloir supprimer une sélection … vide")
	End if 
Else 
	ALERT:C41("vous ne pouvez pas détruire cette sélection")
End if 