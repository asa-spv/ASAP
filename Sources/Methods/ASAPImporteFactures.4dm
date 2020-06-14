//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 19/06/18, 06:44:06
  // ----------------------------------------------------
  // Méthode : ASAPImporteFacture
  // Description
  // Méthode qui importe dans ASAP les [Factures] de GA
  //
  // ----------------------------------------------------

$Doc:=Open document:C264("";Mode lecture:K24:5)
If (OK=1)
	
	RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
	If (Ligne#"Factures@")
		ALERT:C41("Désolé, ce fichier n'a pas l'air d'être dédié aux factures")
	Else 
		  // Gestion des manques
		$Rapport:=""
		ARRAY TEXT:C222($TbNumFacturePb;0)
		ARRAY TEXT:C222($TbComLaboPb;0)
		
		
		READ WRITE:C146([Factures:15])
		ALL RECORDS:C47([Factures:15])
		DELETE SELECTION:C66([Factures:15])
		
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)  // les ET
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)  // la première ligne
		Repeat 
			ARRAY TEXT:C222($TbDescription;17)  // recueil des valeurs exportées
			$FT:=Size of array:C274($TbDescription)-1
			For ($Salé;1;$FT)
				YImportFichierLitColonne (->$TbDescription;$Salé)
			End for 
			$TbDescription{$FT+1}:=Ligne
			
			QUERY:C277([Factures:15];[Factures:15]NumFacture:3=$TbDescription{1})
			If (Records in selection:C76([Factures:15])=0)
				CREATE RECORD:C68([Factures:15])
			End if 
			$Adresse:=Replace string:C233($TbDescription{8};"£";<>ZCR)
			[Factures:15]AdresseFacturation:5:=$Adresse
			[Factures:15]CP:6:=$TbDescription{9}
			[Factures:15]DateFacture:4:=Date:C102($TbDescription{7})
			[Factures:15]NumFacture:3:=$TbDescription{1}
			[Factures:15]TotalHT:8:=Num:C11($TbDescription{2})
			[Factures:15]TotalTTC:10:=Num:C11($TbDescription{4})
			[Factures:15]TotalTVA:9:=Num:C11($TbDescription{3})
			[Factures:15]PaysFacturation:7:=$TbDescription{14}
			[Factures:15]NumBonCommande:14:=Replace string:C233($TbDescription{12};"£";<>ZCR)
			$CodeBenef:=Num:C11($TbDescription{5})
			$L:=Find in array:C230(<>TbPerNumPersonne;$CodeBenef)
			If ($l>0)
				[Factures:15]UUIDPersonne:2:=<>TbPerUUID{$L}
			Else 
				$Com:="La facture "+<>ZGuil+$TbDescription{1}+<>ZGuil+" n'a pas pu être importée"
				$LCom:=Find in array:C230($TbNumFacturePb;$TbDescription{1})
				If ($LCom<0)
					APPEND TO ARRAY:C911($TbNumFacturePb;$TbDescription{1})
					APPEND TO ARRAY:C911($TbComLaboPb;$Com)
				Else 
					$TbComLaboPb{$LCom}:=$TbComLaboPb{$LCom}+<>ZCR+$Com
				End if 
			End if 
			SAVE RECORD:C53([Factures:15])
			
			RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		Until (Ligne="")
		CLOSE DOCUMENT:C267($Doc)
		ALERT:C41("Import achevé")
		
		  // Ecriture du rapport des manques
		SORT ARRAY:C229($TbNumFacturePb;$TbComLaboPb;>)
		$FT:=Size of array:C274($TbComLaboPb)
		$Rapport:=""
		For ($Salé;1;$FT)
			$Rapport:=$Rapport+$TbNumFacturePb{$Salé}+<>ZCR+$TbComLaboPb{$Salé}+<>ZCR2
		End for 
		
		SET TEXT TO PASTEBOARD:C523($Rapport)
		
		ZAmnistieInternationale 
	End if 
End if 
If (False:C215)
	  //$TbDescription{1} = NumFacture
	  //$TbDescription{2} = TotalHT
	  //$TbDescription{3} = TotalTVA
	  //$TbDescription{4} = TotalTTC
	  //$TbDescription{5} = CodeBénéficiaire
	  //$TbDescription{6} = Adhérent
	  //$TbDescription{7} = Datefacture
	  //$TbDescription{8} = AdresseFacturation
	  //$TbDescription{9} = CP
	  //$TbDescription{10} = Regle
	  //$TbDescription{11} = Cotisation
	  //$TbDescription{12} = Commentaire
	  //$TbDescription{13} = AjoutBdC
	  //$TbDescription{14} = PaysFacturation
	  //$TbDescription{15} = Devis
	  //$TbDescription{16} = FactureSpeciale
	  //$TbDescription{17} = FactureAvecAvoir
	  //$TbDescription{18} = ID
End if 