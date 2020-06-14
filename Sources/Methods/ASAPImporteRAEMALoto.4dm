//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 12/08/18, 10:46:43
  // ----------------------------------------------------
  // Paramètre aucum
  // ----------------------------------------------------
  // Méthode : ASAPImporteRAEMALoto
  // Description : importe le fichier .txt et attribue à [RAEMACampagnes]Arguments
  // // Le tableau du loto (liste des laboratoires participants)

C_TEXT:C284($Var;$NumRaema)
C_LONGINT:C283($Salé;$FT)

READ WRITE:C146([RAEMACampagnes:20])
SET CHANNEL:C77(13;"")
If (OK=1)
	
	RECEIVE VARIABLE:C81($Var)  // "Loto"
	If ($Var#"Loto")
		ALERT:C41("le fichier ne semble pas être le bon...")
	Else 
		
		
		RECEIVE VARIABLE:C81($Var)  // Une autre
		While ($Var="Une autre")
			RECEIVE VARIABLE:C81($NumRaema)
			RECEIVE VARIABLE:C81($TexteLoto)
			ARRAY TEXT:C222($TbLotoA;0)
			ZTexteVersTableau ($TexteLoto;->$TbLotoA)
			$FT:=Size of array:C274($TbLotoA)
			ARRAY LONGINT:C221($TbLoto;0)
			ARRAY LONGINT:C221($TbLoto;$FT)
			For ($Salé;1;$FT)
				$TbLoto{$Salé}:=Num:C11($TbLotoA{$Salé})
			End for 
			QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$NumRaema)
			OB SET ARRAY:C1227([RAEMACampagnes:20]Arguments:7;"Loto";$TbLoto)
			SAVE RECORD:C53([RAEMACampagnes:20])
			RECEIVE VARIABLE:C81($Var)  // Une autre
		End while 
		SET CHANNEL:C77(11)
		ZAmnistiePartielle (->[RAEMACampagnes:20])
		ALERT:C41("Importation du loto terminée")
		
	End if 
End if 