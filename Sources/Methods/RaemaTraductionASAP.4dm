//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/07/18, 17:25:03
  // ----------------------------------------------------
  // Paramètres : $1= référence cherchée
  //   $2 = Pt sur tableau où rechercher
  //   $3 = Radical du tableau à trouver (sans <>TB et sans A ou F)
  // ----------------------------------------------------
  // Méthode : RaemaTraductionASAP
  // Description : renvoie la valeur correspondante à $1  dans la bonne langue 
  // 
C_TEXT:C284($1;$3;$Code;$Radical;$0)
C_POINTER:C301($PtTbRechercher;$PtTbTrouverF;$PtTbTrouverA)
C_LONGINT:C283($L)
$Code:=$1
$PtTbRechercher:=$2
$Radical:=$3
$PtTbTrouverF:=Get pointer:C304("<>Tb"+$Radical+"F")
$PtTbTrouverA:=Get pointer:C304("<>Tb"+$Radical+"A")
$L:=Find in array:C230($PtTbRechercher->;$Code)
If ($L>0)
	$0:=(Num:C11(LangueCourante="A")*$PtTbTrouverA->{$L})+(Num:C11(LangueCourante#"A")*$PtTbTrouverF->{$L})
Else 
	$0:=""
End if 