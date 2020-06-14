//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 13/08/18, 05:53:23
  // ----------------------------------------------------
  // Paramètre aucun
  // ----------------------------------------------------
  // Méthode : ASAPImporteRaemaLIes
  // Description ; méthode qui précise pour les laboratoires
  // ayant des colis suplémentaires avec rapport COFRAC 
  // les numéros attribués et le code 
  // 
C_LONGINT:C283($Salé;$FT)
READ WRITE:C146([Personnes:12])
QUERY BY ATTRIBUTE:C1331([Personnes:12];[Personnes:12]Arguments:7;"NumRAEMALié";#;Null:C1517)
$ft:=Records in selection:C76([Personnes:12])
For ($Salé;1;$FT)
	OB REMOVE:C1226([Personnes:12]Arguments:7;"NumRAEMALié")
	SAVE RECORD:C53([Personnes:12])
	NEXT RECORD:C51([Personnes:12])
End for 
$Doc:=Open document:C264("";Mode lecture:K24:5)
RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
If ($Ligne#"IDPoudreSup@")
	ALERT:C41("Le fichier "+ZDocNomFichier (Document;0)+" n'est pas le bon...")
Else 
	ARRAY TEXT:C222($TbDescription;8)
	RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
	Repeat 
		  // Fabrication du tableau de l'import
		  // $TbDescription{1} = n° d'ordre 
		  // $TbDescription{2} = NumRaema
		  // $TbDescription{3} = ModalitéEnvoiPoudre (Mars , Octobre ou Mars Octobre)
		  // $TbDescription{4} = NumRAEMALié
		  // $TbDescription{5} = DemandeActuelle
		  // $TbDescription{6} = CodeSaisieGel
		  // $TbDescription{7} = ID dans GA
		$SFT:=7
		For ($Salé;1;$SFT)
			YImportFichierLitColonne (->$TbDescription;$Salé)
		End for 
		$TbDescription{$SFT+1}:=Ligne
		
		$L:=Find in array:C230(<>TbPerNumLaboRAEMAA;$TbDescription{2})
		QUERY:C277([Personnes:12];[Personnes:12]UUID:1=<>TbPerUUID{$l})
		ARRAY TEXT:C222($TbNumRAEMALié;0)
		OB GET ARRAY:C1229([Personnes:12]Arguments:7;"TbNumRAEMALié";$TbNumRAEMALié)
		APPEND TO ARRAY:C911($TbNumRAEMALié;$TbDescription{4})
		OB SET ARRAY:C1227([Personnes:12]Arguments:7;"TbNumRAEMALié";$TbNumRAEMALié)
		
		ARRAY TEXT:C222($TbCodeRAEMALié;0)
		OB GET ARRAY:C1229([Personnes:12]Arguments:7;"TbCodeRAEMALié";$TbCodeRAEMALié)
		APPEND TO ARRAY:C911($TbCodeRAEMALié;$TbDescription{6})
		OB SET ARRAY:C1227([Personnes:12]Arguments:7;"TbCodeRAEMALié";$TbCodeRAEMALié)
		
		SAVE RECORD:C53([Personnes:12])
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
	Until (Ligne="")
End if 
ZAmnistiePartielle (->[Personnes:12])