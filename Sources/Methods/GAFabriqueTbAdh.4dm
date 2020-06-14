//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/06/18, 09:15:32
  // ----------------------------------------------------
  // Méthode : GAFabriqueTbAdh
  // Description
  // Méthode qui fabrique les tableaux 
  //  de la LB de gestion des laboratoires
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT)
QUERY SELECTION:C341([Personnes:12];[Personnes:12]Caduc:8=False:C215;*)
QUERY SELECTION:C341([Personnes:12]; & [Personnes:12]TypePersonne:5="Individu")
SELECTION TO ARRAY:C260([Personnes:12]NomLong:2;$TbNomLong;[Personnes:12]NomCourt:3;$TbNomCourt;[Personnes:12]Identificateur:4;$TbIdentificateur;[Personnes:12]TypePersonne:5;$TbTypePersonne;[Personnes:12]UUID:1;$TbUUID)
LONGINT ARRAY FROM SELECTION:C647([Personnes:12];TbNumEnr)

$FT:=Size of array:C274($TbUUID)
ARRAY LONGINT:C221(TbPerNum;$FT)
ARRAY TEXT:C222(TbPerNom;$FT)
ARRAY TEXT:C222(TbPerAdr;$FT)
ARRAY TEXT:C222(TbPerPay;$FT)
ARRAY TEXT:C222(TbPerMel;$FT)
For ($Salé;1;$FT)
	$L:=Find in array:C230(<>TbPerUUID;$TbUUID{$Salé})  // Repérons l'adhérent courant 
	  // N° de RAEMA
	TbPerNum{$Salé}:=RAEMADemoduleMdPWeb ($TbIdentificateur{$Salé};True:C214)
	  // Nom affiché
	TbPerNom{$Salé}:=$TbNomLong{$Salé}+" "+<>TbPAPrénom{$L}
	  // Localisation CP + Ville et Pays 
	
	If (<>TbPerAdrPerCP{$L}#"")
		$Adresse:=<>TbPerAdrPerCP{$L}+" - "+<>TbPerAdrPerVille{$L}
		$Pays:=<>TbPerAdrPerPays{$L}
	Else 
		$Adresse:=<>TbPerAdrProCP{$L}+" - "+<>TbPerAdrProVille{$L}
		$Pays:=<>TbPerAdrProPays{$L}
	End if 
	If ($Pays="")
		$Pays:="France"
	End if 
	TbPerAdr{$Salé}:=$Adresse
	TbPerPay{$Salé}:=$Pays
	
	TbPerMel{$Salé}:=<>TbPAEMail{$L}
End for 

SORT ARRAY:C229(TbPerNum;TbPerNom;TbPerPay;TbPerAdr;TbPerMel;TbNumEnr;>)


