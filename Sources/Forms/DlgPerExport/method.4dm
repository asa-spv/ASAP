$evt:=Form event code:C388

If ($evt=Sur chargement:K2:1)
	C_OBJECT:C1216(ObjetExport;$Objet1;$Objet2;$Objet3;$Objet4)
	ARRAY TEXT:C222(TbChampsPossibles;4)
	TbChampsPossibles{1}:="Nom du laboratoire"
	TbChampsPossibles{2}:="Coordonnées"
	TbChampsPossibles{3}:="Identifiants"
	TbChampsPossibles{4}:="Facturation"
	OB SET ARRAY:C1227($Objet1;"Nom Court";<>TbPerNomCourt)
	OB SET ARRAY:C1227($Objet1;"Nom Long";<>TbPerNomLong)
	OB SET:C1220(ObjetExport;TbChampsPossibles{1};$Objet1)
	
	OB SET ARRAY:C1227($Objet2;"CP livraison";<>TbPerAdrLivCP)
	OB SET ARRAY:C1227($Objet2;"Ville livraison";<>TbPerAdrLivVille)
	OB SET:C1220(ObjetExport;TbChampsPossibles{2};$Objet2)
	
	OB SET ARRAY:C1227($Objet3;"Mot de passe";<>TbPerIdentificateur)
	OB SET ARRAY:C1227($Objet3;"N° Raema";<>TbPerNumLaboRAEMAA)
	OB SET ARRAY:C1227($Objet3;"N° Adhérent";<>TbPerNumPersonneA)
	OB SET:C1220(ObjetExport;TbChampsPossibles{3};$Objet3)
	
	
	OB SET ARRAY:C1227($Objet4;"N° TVA";<>TbPANumTVAIntraCom)
	OB SET ARRAY:C1227($Objet4;"Facturation spéciale";<>TbPAFacturationSpeciale)
	OB SET:C1220(ObjetExport;TbChampsPossibles{4};$Objet4)
	
	
	ARRAY TEXT:C222(TbChampsExport;0)
	ARRAY TEXT:C222(PUMCodage;3)
	PUMCodage{1}:="Windows"
	PUMCodage{2}:="Mac"
	PUMCodage{3}:="UTF-8"
	PUMCodage:=1
	
	OBJECT SET VISIBLE:C603(*;"BouExport";False:C215)
End if 