//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 19/07/19, 18:31:31
  // ----------------------------------------------------
  // Paramètres : $1 = N° de la campagne, $2 = n° de labo
  // ----------------------------------------------------
  // Méthode : ASAPTexteMailRAEMAGel
  // Description
  // Méthode qui traduit dans un texte envoyable par mail
  //   la description d'une camapgne RAEMA gel

$NumCampagne:=$1
$NumLabo:=$2
$Texte:=""
$L:=Find in array:C230(<>TbCampagnesNumCampagne;$NumCampagne)
If ($L<0)
	ALERT:C41("Désolé, cette campagne n'est pas prévue dans ASAP")
Else 
	$IdentifiantLoto:=$NumLabo+"_"+$NumCampagne+"_"
	$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$IdentifiantLoto;($L+1))
	If ($L<0)
		$Texte:=$Texte+"Il semble que vous n'avez pas prévu de participer au RAEMA "+$NumCampagne+"."
	Else 
		$DateEnvoiA:=String:C10(<>TbCampagnesDateEnvoiColis{$L};3)
		$DateLimRéponseA:=String:C10(<>TbCampagnesDateLimiteReponse{$L};3)
		$Texte:=$Texte+"Les colis de la campagne "+$NumCampagne+" seront envoyés le "+$DateEnvoiA+"."
		$Texte:=$Texte+"La date limite pour nous faire parvenir les résulats des analyses est fixée au "+$DateLimRéponseA+"."
		$Texte:=$Texte+<>ZCR+<>ZCR+"Vous avez demandé le programme suivant :"+<>ZCR
		$Bacillus:=Num:C11(<>TbLotoBacillus{$L}#"")*"Bacillus Cereus"
		If (<>TbLotoBacillusNCGSR{$L}>0)
			$s:=Num:C11(<>TbLotoBacillusNCGSR{$L}>1)*"s"
			$Bacillus:=$Bacillus+" avec "+String:C10(<>TbLotoBacillusNCGSR{$L})+" pot"+$s+" supplémentaire"+$s+" sans rapport COFRAC"
		End if 
		If (<>TbLotoBacillusNCGAR{$L}>0)
			$s:=Num:C11(<>TbLotoBacillusNCGAR{$L}>1)*"s"
			$Bacillus:=$Bacillus+" et "+String:C10(<>TbLotoBacillusNCGAR{$L})+" pot"+$s+" supplémentaire"+$s+" avec rapport COFRAC"
		End if 
		
	End if 
End if 
