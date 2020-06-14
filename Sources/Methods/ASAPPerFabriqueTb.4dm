//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/06/18, 09:15:32
  // ----------------------------------------------------
  // Paramètre : {$1} si existe ne filtre pas les caducs
  // ----------------------------------------------------
  // Méthode : ASAPPerFabriqueTb
  // Description
  // Méthode qui fabrique les tableaux 
  //  de la LB de gestion des laboratoires et des adhérents
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT)
$Labo:=(ZAvantProc#"@Adh")
If (Count parameters:C259=0)
	QUERY SELECTION:C341([Personnes:12];[Personnes:12]Caduc:8=False:C215;*)
	$TypePersonne:=(Num:C11(ZAvantProc="@labo")*"laboratoire")+(Num:C11(ZAvantProc="@Adh")*"Individu")+(Num:C11(ZAvantProc="@tes")*"Testeur")
	QUERY SELECTION:C341([Personnes:12]; & [Personnes:12]TypePersonne:5=$TypePersonne)
End if 

SELECTION TO ARRAY:C260([Personnes:12]NomLong:2;$TbNomLong;[Personnes:12]Arguments:7;$TbArguments;[Personnes:12]NomCourt:3;$TbNomCourt;[Personnes:12]Identificateur:4;$TbIdentificateur;[Personnes:12]TypePersonne:5;$TbTypePersonne;[Personnes:12]UUID:1;$TbUUID)
LONGINT ARRAY FROM SELECTION:C647([Personnes:12];TbNumEnr)

$FT:=Size of array:C274($TbUUID)
ARRAY LONGINT:C221(TbPerNum;$FT)
ARRAY TEXT:C222(TbPerNom;$FT)
ARRAY TEXT:C222(TbPerAdr;$FT)
ARRAY TEXT:C222(TbPerPay;$FT)
ARRAY TEXT:C222(TbPerMel;$FT)
For ($Salé;1;$FT)
	$L:=Find in array:C230(<>TbPerUUID;$TbUUID{$Salé})  // Repérons le labo courant 
	  // N° de RAEMA
	If ($Labo)
		TbPerNum{$Salé}:=RAEMADemoduleMdPWeb ($TbIdentificateur{$Salé})
	Else 
		TbPerNum{$Salé}:=RAEMADemoduleMdPWeb ($TbIdentificateur{$Salé};True:C214)
	End if 
	
	If ($Labo)
		  // Nom affiché = court si existe long sinon
		If ($TbNomCourt{$Salé}#"")
			TbPerNom{$Salé}:=$TbNomCourt{$Salé}
		Else 
			TbPerNom{$Salé}:=$TbNomLong{$Salé}
		End if 
	Else 
		$Prénom:=OB Get:C1224($TbArguments{$Salé};"Prénom";Est un texte:K8:3)
		TbPerNom{$Salé}:=$TbNomLong{$Salé}+" "+$Prénom
	End if 
	  // Localisation CP + Ville et Pays 
	If ($Labo)
		If (<>TbPerAdrLivCP{$L}#"")
			$Adresse:=<>TbPerAdrLivCP{$L}+" - "+<>TbPerAdrLivVille{$L}
			$Pays:=<>TbPerAdrLivPays{$L}
		Else 
			$Adresse:=<>TbPerAdrFacCP{$L}+" - "+<>TbPerAdrFacVille{$L}
			$Pays:=<>TbPerAdrFacPays{$L}
			If ($Pays="")
				$Pays:=<>TbPerAdrLivPays{$L}
			End if 
		End if 
	Else 
		If (<>TbPerAdrPerCP{$L}#"")
			$Adresse:=<>TbPerAdrPerCP{$L}+" - "+<>TbPerAdrPerVille{$L}
			$Pays:=<>TbPerAdrPerPays{$L}
		Else 
			$Adresse:=<>TbPerAdrProCP{$L}+" - "+<>TbPerAdrProVille{$L}
			$Pays:=<>TbPerAdrProPays{$L}
		End if 
		If ($Pays="")
			$Pays:="FRANCE"
		End if 
	End if 
	TbPerAdr{$Salé}:=$Adresse
	TbPerPay{$Salé}:=Uppercase:C13($Pays)
	
	TbPerMel{$Salé}:=<>TbPAEMail{$L}
End for 

SORT ARRAY:C229(TbPerNum;TbPerNom;TbPerPay;TbPerAdr;TbPerMel;TbNumEnr;>)


