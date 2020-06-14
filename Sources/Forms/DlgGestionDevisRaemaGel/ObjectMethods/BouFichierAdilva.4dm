
$Doc:=Open document:C264("";Mode lecture:K24:5)
If (OK=1)
	$Texte:=Document to text:C1236(Document)
	CLOSE DOCUMENT:C267($Doc)
	VarCDFichier:=Document
	If ($Texte="n°@")
		  // Elimnation de la colonne des ET
		$Pos:=Position:C15(<>ZCR;$Texte)
		$Ligne:=Substring:C12($Texte;1;($Pos-1))
		$Texte:=Substring:C12($Texte;($Pos+1))
		$Pos:=Position:C15(<>ZCR;$Texte)
		Repeat 
			$Ligne:=Substring:C12($Texte;1;($Pos-1))
			GA15AdilvaGelTraiteLigne ($Ligne)
			$Texte:=Substring:C12($Texte;($Pos+1))
			$Pos:=Position:C15(<>ZCR;$Texte)
		Until ($Pos=0)
		If ($Texte#"")  // Le p'tit dernier
			GA15AdilvaGelTraiteLigne ($Texte)
		End if 
		COPY ARRAY:C226(ColRGA1;Colonne1)  // N° RAEMA
		COPY ARRAY:C226(ColRGA8;Colonne2)  // Bacillus Mai
		COPY ARRAY:C226(ColRGA9;Colonne3)  // Pseudo Mai
		COPY ARRAY:C226(ColRGA10;Colonne4)  // Lactiques Mai
		COPY ARRAY:C226(ColRGA11;Colonne5)  // LM Ens Mai
		COPY ARRAY:C226(ColRGA12;Colonne6)  // LM Sep Mai
		COPY ARRAY:C226(ColRGA23;Colonne7)  // Bacillus Décembre
		COPY ARRAY:C226(ColRGA24;Colonne8)  // Pseudo Décembre
		COPY ARRAY:C226(ColRGA25;Colonne9)  // Lactiques Décembre
		COPY ARRAY:C226(ColRGA26;Colonne10)  // LM Ens Décembre
		COPY ARRAY:C226(ColRGA27;Colonne11)  // LM Sep Décembre
		OBJECT SET VISIBLE:C603(*;"Adilva@";True:C214)
		
	Else 
		ALERT:C41("Désolé, ce fichier ne semble pas être correctement formaté pour l'import des données ADILVA")
		OBJECT SET VISIBLE:C603(*;"Adilva@";False:C215)
	End if 
End if 