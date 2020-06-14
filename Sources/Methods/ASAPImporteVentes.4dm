//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 19/06/18, 06:44:06
  // ----------------------------------------------------
  // Méthode : GAImporteVentes
  // Description
  // Méthode qui importe dans ASAP les [Ventes] de GA
  //
  // ----------------------------------------------------


$Doc:=Open document:C264("";Mode lecture:K24:5)
If (OK=1)
	RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
	If (Ligne#"Ventes@")
		ALERT:C41("Désolé, ce fichier n'a pas l'air d'être dédié aux ventes")
	Else 
		
		READ WRITE:C146([Ventes:16])
		ALL RECORDS:C47([Ventes:16])
		DELETE SELECTION:C66([Ventes:16])
		
		  // Gestion des manques
		$Rapport:=""
		ARRAY TEXT:C222($TbNumFacturePb;0)
		ARRAY TEXT:C222($TbComLaboPb;0)
		
		
		ALL RECORDS:C47([Factures:15])
		SELECTION TO ARRAY:C260([Factures:15]NumFacture:3;$TbNumFac)
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		READ WRITE:C146([Ventes:16])
		
		Repeat 
			ARRAY TEXT:C222($TbDescription;15)  // recueil des valeurs exportées
			$FT:=Size of array:C274($TbDescription)-1
			For ($Salé;1;$FT)
				YImportFichierLitColonne (->$TbDescription;$Salé)
			End for 
			$TbDescription{$FT+1}:=Ligne
			
			If (Find in array:C230($TbNumFac;$TbDescription{9})>0)
				CREATE RECORD:C68([Ventes:16])
				[Ventes:16]DateVente:4:=Date:C102($TbDescription{5})
				[Ventes:16]NumFacture:2:=$TbDescription{9}
				[Ventes:16]Intitule:3:=$TbDescription{2}
				[Ventes:16]PrixTotalHT:7:=Num:C11($TbDescription{6})
				[Ventes:16]PrixUHT:5:=Num:C11($TbDescription{3})
				[Ventes:16]Quantité:6:=Num:C11($TbDescription{8})
				[Ventes:16]TauxTVA:8:=Num:C11($TbDescription{4})
				[Ventes:16]Banque:10:=$TbDescription{10}
				[Ventes:16]NumCheque:11:=$TbDescription{11}
				[Ventes:16]DateReglement:12:=Date:C102($TbDescription{12})
				SAVE RECORD:C53([Ventes:16])
			Else 
				$Com:="La ligne de facture "+<>ZGuil+$TbDescription{2}+<>ZGuil+" n'a pas pu être importée dans la facture "
				$Com:=$Com+$TbDescription{9}+" car celle-ci n'existe pas dans ASAP"
				$LCom:=Find in array:C230($TbNumFacturePb;$TbDescription{2})
				If ($LCom<0)
					APPEND TO ARRAY:C911($TbNumFacturePb;$TbDescription{1})
					APPEND TO ARRAY:C911($TbComLaboPb;$Com)
				Else 
					$TbComLaboPb{$LCom}:=$TbComLaboPb{$LCom}+<>ZCR+$Com
				End if 
				
			End if 
			RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		Until (Ligne="")
		CLOSE DOCUMENT:C267($Doc)
		
		ALERT:C41("Export terminé")
		
		
		  // Ecriture du rapport des manques
		SORT ARRAY:C229($TbNumFacturePb;$TbComLaboPb;>)
		$FT:=Size of array:C274($TbComLaboPb)
		$Rapport:=""
		For ($Salé;1;$FT)
			$Rapport:=$Rapport+$TbNumFacturePb{$Salé}+<>ZCR+$TbComLaboPb{$Salé}+<>ZCR2
		End for 
		
		SET TEXT TO PASTEBOARD:C523($Rapport)
		
		
	End if 
End if 

If (False:C215)
	
	  //  $TbDescription{1} = CodeBénéficiaire
	  //  $TbDescription{2} = Intitulé
	  //  $TbDescription{3} = PrixUHT
	  //  $TbDescription{4} = TauxTVA
	  //  $TbDescription{5} = DateVente
	  //  $TbDescription{6} = PrixTHT
	  //  $TbDescription{7} = PrixTTC
	  //  $TbDescription{8} = Quantité
	  //  $TbDescription{9} = NumFacture
	  //  $TbDescription{10} = Banque
	  //  $TbDescription{11} = NumChèque
	  //  $TbDescription{12} = DateRéglement
	  //  $TbDescription{13} = Adhérent
	  //  $TbDescription{14} = NomBénéficiaire
	  //  $TbDescription{15} = Labo
	  //  $TbDescription{16} = ID
	
End if 