//%attributes = {}
  // ----------------------------------------------------
  // $1 : texte d'où extraire l'extension
  // ----------------------------------------------------
  // Méthode : YTrouveExtension
  // Description
  // Fonction qui renvoie l'extension à partir du chemin
  // ou du nom d'un document
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 29/04/20, 18:40:16
C_LONGINT:C283($Salé;$FT)

$Chaine:=$1
$Ext:=""
While ($Chaine[[Length:C16($Chaine)]]#".")
	$Ext:=$Chaine[[Length:C16($Chaine)]]+$Ext
	$Chaine:=Substring:C12($Chaine;1;Length:C16($Chaine)-1)
End while 
$0:=$Ext
