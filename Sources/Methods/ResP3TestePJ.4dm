//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 05/08/18, 20:16:10
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ResP3TestePJ
  // Description
  // // Test qui décompte le nombre de colonne de la PJ et l'absence de deux tabulations successives

C_LONGINT:C283($TT;$NbCampagne;$Pos)
ARRAY TEXT:C222($Tb;0)

$PJMail:=$1
ZTexteVersTableau ($PJMail;->$Tb;<>ZTab)
$TT:=Size of array:C274($Tb)
$T:=ZTableauVersTexte (->$Tb)
  //FIXER TEXTE DANS CONTENEUR($T)

QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=<>NumCampagneEnCoursSaisie)
$NbCampagne:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"NbreLignePJ";Est un entier long:K8:6)

$PbLongueur:=($NbCampagne#$TT)

$Pos:=Position:C15((<>ZTab*2);$PJMail)

$0:=($PbLongueur) | ($Pos>0)