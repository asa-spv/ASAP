//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 18/07/19, 11:42:20
  // ----------------------------------------------------
  // Paramètre : $1 = Pt sur l'objet de description
  // ----------------------------------------------------
  // Méthode : ASAPFabriqueObjetDescriptifLabo
  // Description
  // Méthode qui décrit le contenu variable de l'enregistrement d'une personne
  //

C_TEXT:C284($ValeurCourante)
C_LONGINT:C283($ValeurCouranteN)
C_BOOLEAN:C305($ValeurCouranteB)

$PtObjet:=$1
  // Remplissage avec les champs modifiables de la table [Personnes]
OB SET:C1220($PtObjet->;"Caduc";[Personnes:12]Caduc:8)
OB SET:C1220($PtObjet->;"Identificateur";[Personnes:12]Identificateur:4)
OB SET:C1220($PtObjet->;"NomCourt";[Personnes:12]NomCourt:3)
OB SET:C1220($PtObjet->;"[Personnes]NomLong";[Personnes:12]NomLong:2)


SELECTION TO ARRAY:C260([PersonnesAdresses:11]CodePostal:6;$TbCP\
;[PersonnesAdresses:11]LigneAdresse1:3;$TbAd1\
;[PersonnesAdresses:11]LigneAdresse2:4;$TbAd2\
;[PersonnesAdresses:11]LigneAdresse3:5;$TbAd3\
;[PersonnesAdresses:11]Pays:8;$TbPays\
;[PersonnesAdresses:11]TypeAdresse:9;$TbType\
;[PersonnesAdresses:11]Ville:7;$TbVille)
SORT ARRAY:C229($TbType;$TbCP;$TbAd1;$TbAd2;$TbAd3;$TbPays;$TbVille;>)
$FT:=Size of array:C274($TbType)
For ($Salé;1;$FT)
	$TypeCourant:=$TbType{$Salé}
	OB SET:C1220($PtObjet->;"CodePostal"+$TypeCourant;$TbCP{$Salé})
	OB SET:C1220($PtObjet->;"LigneAdresse1"+$TypeCourant;$TbAd1{$Salé})
	OB SET:C1220($PtObjet->;"LigneAdresse2"+$TypeCourant;$TbAd2{$Salé})
	OB SET:C1220($PtObjet->;"LigneAdresse3"+$TypeCourant;$TbAd3{$Salé})
	OB SET:C1220($PtObjet->;"Pays"+$TypeCourant;$TbPays{$Salé})
	OB SET:C1220($PtObjet->;"Ville"+$TypeCourant;$TbVille{$Salé})
End for 
ARRAY TEXT:C222($TbNomX;0)
OB GET PROPERTY NAMES:C1232([Personnes:12]Arguments:7;$TbNomX;$TabType)
$FT:=Size of array:C274($TbNomX)
For ($Salé;1;$FT)
	Case of 
		: ($TabType{$Salé}=Est un booléen:K8:9)
			$ValeurCouranteB:=OB Get:C1224([Personnes:12]Arguments:7;$TbNomX{$Salé})
			OB SET:C1220($PtObjet->;$TbNomX{$Salé};$ValeurCouranteB)
			
		: ($TabType{$Salé}=Est un entier long:K8:6)
			$ValeurCouranteN:=OB Get:C1224([Personnes:12]Arguments:7;$TbNomX{$Salé})
			OB SET:C1220($PtObjet->;$TbNomX{$Salé};$ValeurCouranteN)
			
		Else 
			$ValeurCourante:=OB Get:C1224([Personnes:12]Arguments:7;$TbNomX{$Salé})
			OB SET:C1220($PtObjet->;$TbNomX{$Salé};$ValeurCourante)
	End case 
	
End for 