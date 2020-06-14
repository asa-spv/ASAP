//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 05/05/18, 13:00:14
  // ----------------------------------------------------
  // Paramètres
  // $1 = Nom de la propriété à récupérer
  // $2 = Pointeur sur la variable à remplir
  // $3 = 1 pour Texte, 2 pour Numérique
  // ----------------------------------------------------
  // Méthode : Configuration_Get_Param
  // Description
  //  

C_OBJECT:C1216($Config)
C_TEXT:C284($1;$Propriété)
C_POINTER:C301($2;$Var)
C_LONGINT:C283($3;$Type)

$Propriété:=$1
$Var:=$2
$Type:=$3

QUERY BY FORMULA:C48([XData:1];([XData:1]XType:3="Configuration") & ([XData:1]XNom:2="Configuration"))
$Config:=[XData:1]XObjet:18

Case of 
	: ($Type=1)
		$Var->:=OB Get:C1224($Config;$Propriété;Est un texte:K8:3)
		
	: ($Type=2)
		$Var->:=OB Get:C1224($Config;$Propriété;Est un entier long:K8:6)
		
End case 