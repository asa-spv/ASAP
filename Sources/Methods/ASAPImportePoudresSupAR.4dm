//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 13/08/18, 05:53:23
  // ----------------------------------------------------
  // Paramètre aucun
  // ----------------------------------------------------
  // Méthode : ASAPImportePoudresSupAR
  // Description ; méthode qui précise pour les laboratoires
  // ayant des colis suplémentaires avec rapport COFRAC 
  // les numéros attribués et le code 
  // A importerv en premier car permettra lors de l'importation des adhérents
  //  de distinguer les faux laboratoires 
  // créés uniquement pour gérer les colis sup avec apport COFRAC


C_LONGINT:C283($Salé;$FT)
$Doc:=Open document:C264("";Mode lecture:K24:5)
RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
If ($Ligne#"PoudreSup@")
	ALERT:C41("Le fichier "+ZDocNomFichier (Document;0)+" n'est pas le bon...")
Else 
	ARRAY TEXT:C222($TbNumRaemaLaboSaisie;0)
	ARRAY TEXT:C222($TbNumRaemaLaboOrigine;0)
	ARRAY TEXT:C222($TbCodeSaisie;0)
	RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
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
		$SFT:=6
		ARRAY TEXT:C222($TbDescription;$SFT)
		For ($Salé;1;$SFT)
			YImportFichierLitColonne (->$TbDescription;$Salé)
		End for 
		APPEND TO ARRAY:C911($TbNumRaemaLaboSaisie;$TbDescription{2})
		APPEND TO ARRAY:C911($TbNumRaemaLaboOrigine;$TbDescription{4})
		APPEND TO ARRAY:C911($TbCodeSaisie;$TbDescription{6})
		
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
	Until (Ligne="")
	READ WRITE:C146([XData:1])
	QUERY:C277([XData:1];[XData:1]XNom:2="PoudresSupAR";*)
	QUERY:C277([XData:1]; & [XData:1]XType:3="PoudresSupAR")
	If (Records in selection:C76([XData:1])=0)
		CREATE RECORD:C68([XData:1])
		[XData:1]XNom:2:="PoudresSupAR"
		[XData:1]XType:3:="PoudresSupAR"
	End if 
	OB SET ARRAY:C1227([XData:1]XObjet:18;"TbNumRaemaLaboSaisieA";$TbNumRaemaLaboSaisie)
	OB SET ARRAY:C1227([XData:1]XObjet:18;"TbNumRaemaLaboOrigine";$TbNumRaemaLaboOrigine)
	OB SET ARRAY:C1227([XData:1]XObjet:18;"TbCodeSaisie";$TbCodeSaisie)
	ZVariableVersBlob (->[XData:1]XBlob:13;->$TbNumRaemaLaboSaisie;->$TbNumRaemaLaboOrigine;->$TbCodeSaisie)
	SAVE RECORD:C53([XData:1])
	ZAmnistiePartielle (->[XData:1];True:C214)
End if 
