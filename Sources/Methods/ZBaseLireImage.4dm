//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 13/11/17, 08:36:14
  // ----------------------------------------------------
  // Paramètres
  // $1 : chemin de l'image dans le dossier ressource sous la forme 
  //      img/name.png
  // ----------------------------------------------------
  // Méthode : PIC_GetPicture
  // Description
  //  
  //

C_TEXT:C284($1;$path)
C_PICTURE:C286($0;$img)

ASSERT:C1129(Count parameters:C259=1;"1 parameter expected")
ASSERT:C1129(Type:C295($1)=Est un texte:K8:3;"$1 must be path like images/name.png")

$path:=$1
READ PICTURE FILE:C678(Get 4D folder:C485(Dossier Resources courant:K5:16)+Replace string:C233($path;"/";Séparateur dossier:K24:12);$Img)
$0:=$img