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
	If (Ligne#"DepGA")
		ALERT:C41("Désolé, il semble que le fichier ouvert ne corresponde pas aux dépenses")
	Else 
		READ WRITE:C146([Depenses:19])
		ALL RECORDS:C47([Depenses:19])
		DELETE SELECTION:C66([Depenses:19])
		
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		
		Repeat 
			ARRAY TEXT:C222($TbDescription;8)  // recueil des valeurs exportées
			$FT:=Size of array:C274($TbDescription)-1
			For ($Salé;1;$FT)
				YImportFichierLitColonne (->$TbDescription;$Salé)
			End for 
			$TbDescription{$FT+1}:=Ligne
			CREATE RECORD:C68([Depenses:19])
			[Depenses:19]Affectation:7:=$TbDescription{1}
			[Depenses:19]DateDepense:2:=Date:C102($TbDescription{2})
			[Depenses:19]EcritureLettre:9:=$TbDescription{3}
			[Depenses:19]IDCumul:8:=$TbDescription{4}
			[Depenses:19]Intitule:6:=$TbDescription{5}
			[Depenses:19]MoisDepense:3:=$TbDescription{6}
			[Depenses:19]MontantDepense:4:=Num:C11($TbDescription{7})
			[Depenses:19]PosteBudetDepense:5:=$TbDescription{8}
			SAVE RECORD:C53([Depenses:19])
			
			RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		Until (Ligne="")
		CLOSE DOCUMENT:C267($Doc)
	End if 
End if 
