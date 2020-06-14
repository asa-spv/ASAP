//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 30/01/17, 14:29:07
  // ----------------------------------------------------
  // Méthode : ResControleEch
  // Description : permet de contrôler l'existance des numéros 
  // d'échantillons du RAEMA poudre par Ajax à partir de la page Web
  // 
  //
  // Paramètre : $1= message Ajax
  // ----------------------------------------------------
$NumEchA:=Substring:C12($1;12)
QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=<>NumCampagneEnCoursSaisie)
$listeNumeros:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"N° des échantillons";Est un texte:K8:3)
$pos:=Position:C15($NumEchA;$listeNumeros)
$envoi:=Num:C11($pos=0)*"N"
WEB SEND TEXT:C677($envoi)