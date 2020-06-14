//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 06/07/18, 08:51:32
  // ----------------------------------------------------
  // Méthode : GAImportePostesBudget
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

$Doc:=Open document:C264("";Mode lecture:K24:5)
If (OK=1)
	
	RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
	If (Ligne#"PBGA")
		ALERT:C41("Désolé, il semble que le ficier ouvert ne corresponde pas aux postes budgétaires")
	Else 
		READ WRITE:C146([PostesBudgetaires:18])
		ALL RECORDS:C47([PostesBudgetaires:18])
		DELETE SELECTION:C66([PostesBudgetaires:18])
		
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		
		Repeat 
			ARRAY TEXT:C222($TbDescription;4)  // recueil des valeurs exportées
			$FT:=Size of array:C274($TbDescription)-1
			For ($Salé;1;$FT)
				YImportFichierLitColonne (->$TbDescription;$Salé)
			End for 
			$TbDescription{$FT+1}:=Ligne
			CREATE RECORD:C68([PostesBudgetaires:18])
			[PostesBudgetaires:18]IntitulePoste:3:=$TbDescription{2}
			[PostesBudgetaires:18]ChapitrePoste:4:=$TbDescription{3}
			[PostesBudgetaires:18]NumPoste:2:=$TbDescription{4}
			SAVE RECORD:C53([PostesBudgetaires:18])
			
			RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		Until (Ligne="")
		CLOSE DOCUMENT:C267($Doc)
	End if 
End if 
