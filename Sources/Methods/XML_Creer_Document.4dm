//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick
  // Date et heure : 18/12/2011
  // ----------------------------------------------------
  // Methode : XML_Creer_Document
  // Description
  // création d'un document XML
  //
  // Parametres
  //$0:HEURE:RefDoc ouvert
  //{$1:TEXTE:Chemin d'accès}
  // ----------------------------------------------------
C_TEXT:C284($1)

C_TIME:C306($_vh_refDoc)
If (Count parameters:C259=0)
	$_vh_refDoc:=Create document:C266("";"xml")
Else 
	$_vh_refDoc:=Create document:C266($1;"xml")
End if 

C_TIME:C306($0)
$0:=$_vh_refDoc