//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 27/11/16, 04:35:46
  // ----------------------------------------------------
  // Méthode : InfRAEMACreationTitreConta
  // Description
  // Crée le haut de la page de contamination
  //
  // Paramètre $1 = N° de campagne
  // ----------------------------------------------------

$NumRaema:=$1

If ($NumRaema="@A")
	$TitrePage:=(Num:C11(LangueCourante="F")*"Niveau de contamination des échantillons du RAEMA Gel ")
	$TitrePage:=$TitrePage+(Num:C11(LangueCourante#"F")*"Level of contamination of samples RAEMA ")
Else 
	$TitrePage:=(Num:C11(LangueCourante="F")*"Niveau de contamination des échantillons du RAEMA Poudre ")
	$TitrePage:=$TitrePage+(Num:C11(LangueCourante#"F")*"Level of contamination of samples RAEMA ")
End if 

$TitrePage:=$TitrePage+$NumRaema
$0:="<br /> <p class="+<>ZGuil+"titrepage"+<>ZGuil+">"+$TitrePage+"</p>"+<>ZCR