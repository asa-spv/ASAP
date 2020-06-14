//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 12/12/16, 09:35:48
  // ----------------------------------------------------
  // Méthode : WebDevisImprime
  // Description
  // Imprime le devis reçu par le Web
  // ET = 0 -> 85
  // Campagne 
  // Desiste 105 -> 139
  // Annonce 105 -> 178  VarTitreCampagne 
  // Ligne 1 et 2 178 -> 20 VarTitreLigne Var1 -> Var5
  // Ligne 3 223 -> 257  Var1 -> Var5
  // Pied 260 -> 440  VarAdresse VarPrixHT
  // Paramètres :
  // $1 = Pointeur sur Tb de Noms    $2 = Pointeur sur Tb de Valeurs
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT;$HautMax)


$PtTbNoms:=->TbNoms
$PtTbValeurs:=->TbValeurs
VarTitreLigne:=""
Var1:=""
Var2:=""
Var3:=""
Var4:=""
Var5:=""
VarPrixHT:=""
VarAdresse:=""


GET PRINTABLE AREA:C703($HautMax)
$HautCourante:=0
  // Impression du blanc pour papier à ET
ContexteImpression:="Vide"
VarHauteurVide:=100
$H:=Print form:C5("DevisRaemaGel")
$HautCourante:=$HautCourante+VarHauteurVide
<>CampagneDevisRGMai:=RaemaTrouveNumCampagneParAn (<>AnCourantDevisRGN;2)
<>CampagneDevisRGDec:=RaemaTrouveNumCampagneParAn (<>AnCourantDevisRGN;4)
VarAnneeGel:="RAEMA Gel "+<>AnCourantDevisRGA
  // Impression de l'ET
ContexteImpression:="ET"
$H:=Print form:C5("DevisRaemaGel")
$HautCourante:=$HautCourante+$H
  // La campagne de Mai
$L:=Find in array:C230($PtTbNoms->;"cbmai@")

If ($L>0)  // Il a coché au moins une case de la campagne de mai
	  // Impression de l'Annonce
	VarTitreCampagne:="Participation au RAEMA GEL "+<>CampagneDevisRGMai+" (Mai "+<>AnCourantDevisRGA+")"
	ContexteImpression:="Annonce"
	$H:=Print form:C5("DevisRaemaGel")
	$HautCourante:=$HautCourante+$H
	
	  // impression des lignes des germes
	ARRAY TEXT:C222($TbPetitNomGerme;0)
	ARRAY TEXT:C222($TbPetitNomGermeRaccourciMai;0)
	ARRAY TEXT:C222($TbPetitNomGermeRaccourciDec;0)
	ARRAY TEXT:C222($TbNomWebGermeDec;0)
	ARRAY TEXT:C222($TbNomWebGermeMai;0)
	C_TEXT:C284($NomWebGermeRaccourciDec;$NomWebGermeRaccourciMai)
	Repeat 
		APPEND TO ARRAY:C911($TbPetitNomGerme;$PtTbNoms->{$L})
		$L:=Find in array:C230($PtTbNoms->;"cbmai@";($L+1))
	Until ($L=-1)
	
	$TT:=Size of array:C274($TbPetitNomGerme)
	For ($fumé;1;$TT)
		$NomWebGermeRaccourciMai:=Substring:C12($TbPetitNomGerme{$fumé};6)
		$L3:=Find in array:C230(<>TbPetitNomGermeWeb;$NomWebGermeRaccourciMai)
		$NomWebGermeMai:=<>TbNomGermeSchémaGEL{$L3}
		APPEND TO ARRAY:C911($TbPetitNomGermeRaccourciMai;$NomWebGermeMai)
	End for 
	
	$FT:=Size of array:C274(<>TbNomGermemai)
	$RemarqueCOFRAC:=False:C215
	For ($Salé;1;$FT)
		$PetitNomGerme:=Substring:C12($TbPetitNomGerme{$Salé};6)
		  //$L:=Chercher dans tableau(<>TbPetitNomGermeWeb;$PetitNomGerme)
		  //$NomGermeSchéma:=<>TbNomGermeSchémaGEL{$l}
		  //$L:=Chercher dans tableau(<>TbNomGermedec;$NomGermeSchéma)
		$L2:=Find in array:C230($TbPetitNomGermeRaccourciMai;<>TbNomGermemai{$Salé})
		$Cofrac:=Num:C11(<>TbCofracGermemai{$Salé})*"*"
		
		If ($L2=-1)
			If ($Cofrac#"")
				$RemarqueCOFRAC:=True:C214
			End if 
			Var1:=<>TbNomGermemai{$Salé}+$Cofrac
			Var2:=""
			Var3:=""
			Var4:=""
			ContexteImpression:="Lignemilieu"
			$H:=Print form:C5("DevisRaemaGel")
			$HautCourante:=$HautCourante+$H
		Else 
			If ($Cofrac#"")
				$RemarqueCOFRAC:=True:C214
			End if 
			Var1:=<>TbNomGermedec{$Salé}+$Cofrac
			Var2:=Char:C90(9989)
			$L:=Find in array:C230(<>TbNomGermeSchémaGEL;(<>TbNomGermemai{$Salé}))
			$PetitNomGermeWeb:=<>TbPetitNomGermeWeb{$L}
			$L:=Find in array:C230($PtTbNoms->;("nbpotsuparmai"+$PetitNomGermeWeb))
			Var3:=$PtTbValeurs->{$L}
			$L:=Find in array:C230($PtTbNoms->;("nbpotsupsrmai"+$PetitNomGermeWeb))
			Var4:=$PtTbValeurs->{$L}
			ContexteImpression:="Lignemilieu"
			$H:=Print form:C5("DevisRaemaGel")
			$HautCourante:=$HautCourante+$H
		End if 
	End for 
	ContexteImpression:="LigneFin"
	$H:=Print form:C5("DevisRaemaGel")
	$HautCourante:=$HautCourante+$H
	
	If ($RemarqueCOFRAC)
		ContexteImpression:="Cofrac"
		$H:=Print form:C5("DevisRaemaGel")
		$HautCourante:=$HautCourante+$H
	End if 
	
Else 
	VarTitreCampagne:="Vous ne souhaitez pas participer au RAEMA GEL "+<>CampagneDevisRGMai+" (Mai "+$An+")"
	ContexteImpression:="Desiste"
	$H:=Print form:C5("DevisRaemaGel")
	$HautCourante:=$HautCourante+$H
End if 


  // La campagne de décembre
$L:=Find in array:C230($PtTbNoms->;"cbdec@")
If ($L>0)  // Il a coché au moins une case de la campagne de dec
	  // Impression de l'Annonce
	VarTitreCampagne:="Participation au RAEMA GEL "+<>CampagneDevisRGDec+" (décembre "+<>AnCourantDevisRGA+")"
	ContexteImpression:="Annonce"
	$H:=Print form:C5("DevisRaemaGel")
	$HautCourante:=$HautCourante+$H
	
	  // impression des lignes des germes
	ARRAY TEXT:C222($TbPetitNomGerme;0)
	Repeat 
		APPEND TO ARRAY:C911($TbPetitNomGerme;$PtTbNoms->{$L})
		$L:=Find in array:C230($PtTbNoms->;"cbdec@";($L+1))
	Until ($L=-1)
	$TT:=Size of array:C274($TbPetitNomGerme)
	For ($fumé;1;$TT)
		$NomWebGermeRaccourciDec:=Substring:C12($TbPetitNomGerme{$fumé};6)
		$L3:=Find in array:C230(<>TbPetitNomGermeWeb;$NomWebGermeRaccourciDec)
		APPEND TO ARRAY:C911($TbPetitNomGermeRaccourciDec;<>TbNomGermeSchémaGEL{$L3})
	End for 
	
	$FT:=Size of array:C274(<>TbNomGermedec)
	$RemarqueCOFRAC:=False:C215
	For ($Salé;1;$FT)
		$PetitNomGerme:=Substring:C12($TbPetitNomGerme{$Salé};6)
		  //$L:=Chercher dans tableau(<>TbPetitNomGermeWeb;$PetitNomGerme)
		  //$NomGermeSchéma:=<>TbNomGermeSchémaGEL{$l}
		  //$L:=Chercher dans tableau(<>TbNomGermedec;$NomGermeSchéma)
		$L2:=Find in array:C230($TbPetitNomGermeRaccourciDec;<>TbNomGermedec{$Salé})
		$Cofrac:=Num:C11(<>TbCofracGermedec{$Salé})*"*"
		
		If ($L2=-1)
			If ($Cofrac#"")
				$RemarqueCOFRAC:=True:C214
			End if 
			Var1:=<>TbNomGermedec{$Salé}+$Cofrac
			Var2:=""
			Var3:=""
			Var4:=""
			ContexteImpression:="Lignemilieu"
			$H:=Print form:C5("DevisRaemaGel")
			$HautCourante:=$HautCourante+$H
		Else 
			If ($Cofrac#"")
				$RemarqueCOFRAC:=True:C214
			End if 
			Var1:=<>TbNomGermedec{$Salé}+$Cofrac
			Var2:=Char:C90(9989)
			$L:=Find in array:C230(<>TbNomGermeSchémaGEL;(<>TbNomGermedec{$Salé}))
			$PetitNomGermeWeb:=<>TbPetitNomGermeWeb{$L}
			$L:=Find in array:C230($PtTbNoms->;("nbpotsupardec"+$PetitNomGermeWeb))
			Var3:=$PtTbValeurs->{$L}
			$L:=Find in array:C230($PtTbNoms->;("nbpotsupsrdec"+$PetitNomGermeWeb))
			Var4:=$PtTbValeurs->{$L}
			ContexteImpression:="Lignemilieu"
			$H:=Print form:C5("DevisRaemaGel")
			$HautCourante:=$HautCourante+$H
		End if 
	End for 
	ContexteImpression:="LigneFin"
	$H:=Print form:C5("DevisRaemaGel")
	$HautCourante:=$HautCourante+$H
	If ($RemarqueCOFRAC)
		ContexteImpression:="Cofrac"
		$H:=Print form:C5("DevisRaemaGel")
		$HautCourante:=$HautCourante+$H
	End if 
	
Else 
	VarTitreCampagne:="Vous ne souhaitez pas participer au RAEMA GEL "+<>CampagneDevisRGDec+" (Décembre "+$An+")"
	ContexteImpression:="Desiste"
	$H:=Print form:C5("DevisRaemaGel")
	$HautCourante:=$HautCourante+$H
End if 



  // Impression du blanc avant pied
$Vide:=$HautMax-$HautCourante-210
If ($Vide>0)
	ContexteImpression:="Vide"
	VarHauteurVide:=$Vide  // Hauteur du pied 460-260 = 200 px  
	$H:=Print form:C5("DevisRaemaGel")
End if 


  // Impression du pied de page
  //$NumLabo:=WebTrouveValeurParNom ("numlabo";$PtTbNoms;$PtTbValeurs)

  //$L:=Chercher dans tableau(<>TbPerNumLaboRAEMAA;$NumLabo)
  //Si ($L>0)
  //VarAdresse:="Laboratoire n°"+$NumLabo+<>ZCR+"("+<>TBPERNOMLONG{$L}+")"
  //Sinon 
  //VarAdresse:=WebTrouveValeurParNom ("Nom";$PtTbNoms;$PtTbValeurs)+<>ZCR
  //VarAdresse:=VarAdresse+WebTrouveValeurParNom ("adresse";$PtTbNoms;$PtTbValeurs)+<>ZCR
  //VarAdresse:=VarAdresse+WebTrouveValeurParNom ("CP";$PtTbNoms;$PtTbValeurs)+"-"
  //VarAdresse:=VarAdresse+WebTrouveValeurParNom ("Ville";$PtTbNoms;$PtTbValeurs)+<>ZCR
  //VarAdresse:=VarAdresse+WebTrouveValeurParNom ("Pays";$PtTbNoms;$PtTbValeurs)+<>ZCR
  //VarAdresse:=VarAdresse+"email : "+WebTrouveValeurParNom ("mail";$PtTbNoms;$PtTbValeurs)+<>ZCR
  //Fin de si 

$L:=Find in array:C230(<>TbPerNumLaboRAEMA;NumLabo)
If ($L>0)
	VarAdresse:="Laboratoire n°"+String:C10(NumLabo)+<>ZCR+"("+<>TBPERNOMLONG{$L}+")"
Else 
	VarAdresse:=WebTrouveValeurParNom ("Nom";$PtTbNoms;$PtTbValeurs)+<>ZCR
	VarAdresse:=VarAdresse+WebTrouveValeurParNom ("adresse";$PtTbNoms;$PtTbValeurs)+<>ZCR
	VarAdresse:=VarAdresse+WebTrouveValeurParNom ("CP";$PtTbNoms;$PtTbValeurs)+"-"
	VarAdresse:=VarAdresse+WebTrouveValeurParNom ("Ville";$PtTbNoms;$PtTbValeurs)+<>ZCR
	VarAdresse:=VarAdresse+WebTrouveValeurParNom ("Pays";$PtTbNoms;$PtTbValeurs)+<>ZCR
	VarAdresse:=VarAdresse+"email : "+WebTrouveValeurParNom ("mail";$PtTbNoms;$PtTbValeurs)+<>ZCR
End if 



VarPrixHT:=WebTrouveValeurParNom ("valht";$PtTbNoms;$PtTbValeurs)
ContexteImpression:="Pied"
$H:=Print form:C5("DevisRaemaGel")
