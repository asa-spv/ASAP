//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 05/05/18, 09:29:25
  // ----------------------------------------------------
  // Pas de paramètres 
  // ----------------------------------------------------
  // Méthode : Configuration_SupprimeLogo
  // Description
  //  

C_PICTURE:C286($img)
C_BOOLEAN:C305($Continue)

$img:=(OBJECT Get pointer:C1124(Objet nommé:K67:5;"logo"))->
$Continue:=True:C214
If (Picture size:C356($img)>0)  // Il y a une image
	CONFIRM:C162("Voulez-vous supprimer votre logo ?")
	$Continue:=(OK=1)
End if 

If ($Continue)
	
	$img:=$img*0
	READ WRITE:C146([XData:1])
	QUERY BY FORMULA:C48([XData:1];([XData:1]XType:3="Configuration") & ([XData:1]XNom:2="Logo"))
	[XData:1]XImage:11:=$img
	SAVE RECORD:C53([XData:1])
	ZAmnistiePartielle (->[XData:1])
	
	(OBJECT Get pointer:C1124(Objet nommé:K67:5;"logo"))->:=$img
	
End if 