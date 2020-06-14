//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 18/02/19, 05:50:43
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPImporteLettresTypes2
  // Description
  // Méthode qui importe uniquement les lettres-types ajoutées récemment

ALL RECORDS:C47([CourrielsTypes:28])
SELECTION TO ARRAY:C260([CourrielsTypes:28]NomLettre:2;$TbNomLettre)
$Doc:=Open document:C264("";Mode lecture:K24:5)
If (OK=1)
	RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
	If (Ligne#"Lettre-type@")
		ALERT:C41("Désolé, il semble que le fichier ouvert ne corresponde pas aux lettres-types récentes")
	Else 
		
		$Pos:=Position:C15("_";Ligne)
		$TT:=Num:C11(Substring:C12(Ligne;($Pos+1)))
		$debutLigne:=Substring:C12(Ligne;1;($Pos-1))
		$FT:=Num:C11(Substring:C12($debutLigne;9))
		
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		
		For ($Fumé;1;$FT)
			ARRAY TEXT:C222($TbDescription;$TT)  // recueil des valeurs exportées
			$SFT:=Size of array:C274($TbDescription)-1
			For ($Salé;1;$SFT)
				YImportFichierLitColonne (->$TbDescription;$Salé)
			End for 
			$TbDescription{$SFT+1}:=Ligne
			  //$TbDescription{1} = Nom de la lettre
			  //$TbDescription{2} = NumRaema
			  //$TbDescription{3} = NomDuGerme
			  //$TbDescription{4} = Periode
			  //$TbDescription{5} = AnCampagne
			  //$TbDescription{6} = NbrePotAvecRapport
			  //$TbDescription{7} = texte à styler
			  //$TbDescription{8} = ID
			
			If (Find in array:C230($TbNomLettre;$TbDescription{1})<0)
				CREATE RECORD:C68([CourrielsTypes:28])
				[CourrielsTypes:28]NomLettre:2:=$TbDescription{1}
				[CourrielsTypes:28]Descriptif:3:="à styler"
				[CourrielsTypes:28]TexteType:5:=Replace string:C233($TbDescription{7};"£";<>ZCR)
				SAVE RECORD:C53([CourrielsTypes:28])
			End if 
			RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
			
		End for 
		
		CLOSE DOCUMENT:C267($Doc)
		
		ALERT:C41("Import achevé")
	End if 
End if 
