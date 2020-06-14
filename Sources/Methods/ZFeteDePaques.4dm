//%attributes = {"publishedWeb":true}
  // ZFFeteDePaques  V11 du 14/08/2010
  // fonction qui renvoie la date de paques
  // $1= année concernée

C_LONGINT:C283($AnnéeConcernée;$Siècle;$NombreOr;$Soleil;$Lune;$Epact;$PleineLune)

$AnnéeConcernée:=$1
$Siècle:=($AnnéeConcernée\100)+1
$NombreOr:=($AnnéeConcernée%19)+1
$Soleil:=((3*$Siècle)\4)-12
$Lune:=(((8*$Siècle)+5)\25)-5
$JourSolaire:=((5*$AnnéeConcernée)\4)-$Soleil-10
$Epact:=((11*$NombreOr)+20+$Lune-$Soleil)%30
$Epact:=$Epact+(30*Num:C11($Epact<0))
If ((($Epact=25) & ($NombreOr>11)) | ($Epact=24))
	$Epact:=$Epact+1
End if 
$PleineLune:=44-$Epact
$PleineLune:=$PleineLune+(30*Num:C11($PleineLune<21))
$PleineLune:=$PleineLune+7-(($JourSolaire+$PleineLune)%7)
If ($PleineLune>31)
	$Mois:=4
	$Jour:=$PleineLune-31
Else 
	$Mois:=3
	$Jour:=$PleineLune
End if 
$ChaineDate:=String:C10($Jour)+"/"+String:C10($Mois)+"/"+String:C10($AnnéeConcernée)
$0:=Date:C102($ChaineDate)