//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 26/11/16, 15:57:07
  // ----------------------------------------------------
  // Méthode : ReamaTrouveMoisParNumCampagne
  // Description
  // Permet de renvoyer "Mai" ou "Décembre"
  //  en fonction du n° de campagne
  // Paramètre : $1 = n° de campagne
  // ----------------------------------------------------
$NumCampagne:=$1
$test:=Num:C11($NumCampagne)
$Pair:=($test%2=0)
$Impair:=Not:C34($Pair)
If ($NumCampagne="@A")  // RAEMA Gel
	$0:=(Num:C11($Pair)*"Mai")+(Num:C11($Impair)*"Décembre")
Else 
	$0:=(Num:C11($Pair)*"Mars")+(Num:C11($Impair)*"Octobre")
End if 