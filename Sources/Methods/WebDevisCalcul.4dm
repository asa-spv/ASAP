//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 11/12/16, 19:09:19
  // ----------------------------------------------------
  // Méthode : WebDevisCalcul
  // Description
  // Reçoit le message AJAX de type 
  // "calculedevisO"+nbmai+";"+nbpotsrmai+";"+nbpotarmai+";"+nbdec+";"+nbpotsrdec+";"+nbpotardec = si déjà inscrit
  // "calculedevisN"+nbmai+";"+nbpotsrmai+";"+nbpotarmai+";"+nbdec+";"+nbpotsrdec+";"+nbpotardec = si pas inscrit

  // Paramètre $1=message AJAX   {$2} si le calcul du prix de fait sur appel de devis antérieur
  // ----------------------------------------------------
ARRAY LONGINT:C221($TbPrix1Campagne;5)
$TbPrix1Campagne{0}:=0
$TbPrix1Campagne{1}:=Num:C11(WebDevisCracheTarifRG ("G11"))
$TbPrix1Campagne{2}:=Num:C11(WebDevisCracheTarifRG ("G12"))
$TbPrix1Campagne{3}:=Num:C11(WebDevisCracheTarifRG ("G13"))
$TbPrix1Campagne{4}:=Num:C11(WebDevisCracheTarifRG ("G14"))
$TbPrix1Campagne{5}:=Num:C11(WebDevisCracheTarifRG ("G15"))

ARRAY LONGINT:C221($TbPrix2Campagne;5)
$TbPrix2Campagne{1}:=Num:C11(WebDevisCracheTarifRG ("G21"))
$TbPrix2Campagne{2}:=Num:C11(WebDevisCracheTarifRG ("G22"))
$TbPrix2Campagne{3}:=Num:C11(WebDevisCracheTarifRG ("G23"))
$TbPrix2Campagne{4}:=Num:C11(WebDevisCracheTarifRG ("G24"))
$TbPrix2Campagne{5}:=Num:C11(WebDevisCracheTarifRG ("G25"))

ARRAY REAL:C219($TbPrixPotSup;3)
$TbPrixPotSup{1}:=Num:C11(WebDevisCracheTarifRG ("GPS"))
$TbPrixPotSup{2}:=Num:C11(WebDevisCracheTarifRG ("GPA"))
$Test:="Cotisation ASA "+<>AnCourantDevisRGA
$L:=Find in array:C230(<>TbNomPrestation;$Test)
If ($L>0)
	$TbPrixPotSup{3}:=<>TbPrixPrestation{$L}
Else 
	$TbPrixPotSup{3}:=20+Num:C11(<>ZPERMMILLE)
End if 

$Mess:=$1
$Cotis:=$Mess[[13]]="N"
$Mess:=Substring:C12($Mess;14)  // elimination de "calculedevisO" ou "calculedevisN"

$Pos:=Position:C15(";";$Mess)
$NbMai:=Num:C11(Substring:C12($Mess;1;($Pos-1)))

$Mess:=Substring:C12($Mess;($Pos+1))
$Pos:=Position:C15(";";$Mess)
$Nbpotsrmai:=Num:C11(Substring:C12($Mess;1;($Pos-1)))

$Mess:=Substring:C12($Mess;($Pos+1))
$Pos:=Position:C15(";";$Mess)
$Nbpotarmai:=Num:C11(Substring:C12($Mess;1;($Pos-1)))

$Mess:=Substring:C12($Mess;($Pos+1))
$Pos:=Position:C15(";";$Mess)
$NbDec:=Num:C11(Substring:C12($Mess;1;($Pos-1)))

$Mess:=Substring:C12($Mess;($Pos+1))
$Pos:=Position:C15(";";$Mess)
$Nbpotsrdec:=Num:C11(Substring:C12($Mess;1;($Pos-1)))

$Nbpotardec:=Num:C11(Substring:C12($Mess;($Pos+1)))

$Prix:=0
$Dif:=0

  // le prix des envois principaux
If ($NbMai=0) | ($NbDec=0)  // tarif campagne unique
	$Prix:=$Prix+$TbPrix1Campagne{$NbMai+$NbDec}
	
Else   // 2 campagnes
	If ($NbMai=$NbDec)
		$Prix:=$Prix+$TbPrix2Campagne{$NbMai}
	Else 
		$Dif:=Abs:C99($NbMai-$NbDec)
		$NbreCommun:=(Num:C11($NbMai>$NbDec)*$NbDec)+(Num:C11($NbMai<$NbDec)*$NbMai)
		$Prix:=$Prix+$TbPrix2Campagne{$NbreCommun}
	End if 
	
End if 
  // le prix des pots sup sr
$Prix:=$Prix+($TbPrixPotSup{1}*($Dif+$Nbpotsrmai+$Nbpotsrdec))

  // le prix des pots sup ar
$Prix:=$Prix+($TbPrixPotSup{2}*($Nbpotarmai+$Nbpotardec))

  // la cotis si il n'était pas inscrit
If ($Cotis)
	$Prix:=$Prix+$TbPrixPotSup{3}
End if 
$PrixPourChoix:="Prix pour ce choix : "+String:C10($Prix;"####0.00")+" € HT"
$ValuePrix:=" value="+<>ZGuil+$PrixPourChoix+<>ZGuil+" "
$reponse:="<input class="+<>ZGuil+"grandtitrepage"+<>ZGuil+" readonly="+<>ZGuil+"readonly"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" size="+<>ZGuil+"30"+<>ZGuil+" name="+<>ZGuil+"valht"+<>ZGuil+$ValuePrix+">"
PrixDevisGel:=$Prix

If (Count parameters:C259=1)
	WEB SEND TEXT:C677($reponse)
Else 
	$0:=$reponse
End if 