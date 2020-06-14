//%attributes = {"publishedWeb":true}
  //YNbTotalEnregistrements
  //RETOURNE DANS $0 LE NOMBRE TOTAL DE FICHES DE LA BASE
  //ON PEUT METTRE LES NUMÉROS DES TABLES À PRENDRE EN COMPTE
  //Écrit à Paris le Jeudi 8 Juin 1995 par MIMOSA

C_LONGINT:C283($0;$i)
C_LONGINT:C283(${1})  //Pour le compilateur

$0:=0

If (Count parameters:C259=0)
	For ($i;1;Get last table number:C254)
		If (Is table number valid:C999($i))
			$Nb:=Records in table:C83(Table:C252($i)->)
			$0:=$0+$Nb
		End if 
	End for 
	
Else   //On a spécifié les tables à considérer
	For ($i;1;Count parameters:C259)
		$0:=$0+Records in table:C83(Table:C252(${$i})->)
	End for 
End if 

