//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 06/08/18, 08:12:41
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : RaemaSchemaImporteUneTable
  // Description = méthode qui importe 
  // le enregistrements des [RAEMAGermes], [RAEMALignes] et [RAEMAValeurs]
  // à partir du fichier d'export

C_TEXT:C284($ReceptionA)
If (Count parameters:C259=0)
	RECEIVE VARIABLE:C81($ReceptionA)  //  le n° de la table concernée sous forme de chaine
Else 
	$ReceptionA:=$1
End if 
$PtTable:=Table:C252(Num:C11($ReceptionA))
RECEIVE VARIABLE:C81($ReceptionA)  //  l'indicateur de nouvel enregistrement = "une autre"
While ($ReceptionA="Une autre")
	RECEIVE RECORD:C79($PtTable->)
	SAVE RECORD:C53($PtTable->)
	RECEIVE VARIABLE:C81($ReceptionA)  //  l'indicateur de nouvel enregistrement = "une autre"
End while 
$0:=$ReceptionA
