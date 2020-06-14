//%attributes = {"executedOnServer":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 05/05/18, 20:18:08
  // ----------------------------------------------------
  // Pas de paramètres
  // ----------------------------------------------------
  // Méthode : Configuration_TesteCheminCloud
  // Description
  // Vérifie le chemin de sauvegarde Cloud 

C_TEXT:C284($Chemin)
C_BOOLEAN:C305($Resultat)

QUERY BY FORMULA:C48([XData:1];([XData:1]XType:3="Configuration") & ([XData:1]XNom:2="Configuration"))
$Chemin:=[XData:1]XTexte:9
ZAmnistiePartielle (->[XData:1])

$Resultat:=(Test path name:C476($Chemin)=Est un dossier:K24:2)

READ WRITE:C146([XData:1])
QUERY BY FORMULA:C48([XData:1];([XData:1]XType:3="Configuration") & ([XData:1]XNom:2="Configuration"))
[XData:1]XBool:14:=$Resultat
[XData:1]XEntier:6:=1
SAVE RECORD:C53([XData:1])
ZAmnistiePartielle (->[XData:1])
