//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 22/04/18, 16:06:25
  // ----------------------------------------------------
  // Méthode : ZLBUtilSurChargement
  // Description
  // Méthode déclenchée Sur chargement
  // du formulaire [XUtilisateurs];"Entrée"
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)
  // ZGereVisuBoutonNavigationSaisie 
  // Fonction minimale "Entreprise" est elle présente ?

  // Le PUM des localisations
ARRAY TEXT:C222(PUMUtilAdresses;5)
PUMUtilAdresses{1}:="Adresse personnelle"
PUMUtilAdresses{2}:="Adresse professionnelle"
PUMUtilAdresses{3}:="Adresse livraison"
PUMUtilAdresses{4}:="Adresse facturation"
PUMUtilAdresses{5}:="Adresse autre"


$L:=Find in array:C230(<>TbFonctionsNomFonction;"Entreprise")
$UUIDFonction:=<>TbFonctionsUUID{$L}
QUERY:C277([XAttributions:5];[XAttributions:5]UUIDUtilisateur:2=[XUtilisateurs:2]UUID:1;*)
QUERY:C277([XAttributions:5]; & [XAttributions:5]UUIDFonction:3=$UUIDFonction)
If (Records in selection:C76([XAttributions:5])=0)
	CREATE RECORD:C68([XAttributions:5])
	[XAttributions:5]UUIDUtilisateur:2:=[XUtilisateurs:2]UUID:1
	[XAttributions:5]UUIDFonction:3:=$UUIDFonction
	  // [XAttributions]Descriptif:=ZDroitsDecritAttribution 
	SAVE RECORD:C53([XAttributions:5])
End if 
RELATE MANY:C262([XUtilisateurs:2]UUID:1)
SELECTION TO ARRAY:C260([XAttributions:5]UUIDFonction:3;TbUUIDFonction)
ZDroitsRecalcule 
ZDroitsActualiseDroits 


  // recherche des [XAttributions]
RELATE MANY:C262([XUtilisateurs:2]UUID:1)
$FT:=Records in selection:C76([XAttributions:5])
ARRAY TEXT:C222(TbUUIDFonction;$FT)
ARRAY TEXT:C222(TbAttributions;$FT)
  // Affichage des [XAttributions]
SELECTION TO ARRAY:C260([XAttributions:5]UUIDFonction:3;TbUUIDFonction)

For ($Salé;1;$FT)
	$UUIDCourante:=TbUUIDFonction{$Salé}
	$L:=Find in array:C230(<>TbFonctionsUUID;$UUIDCourante)
	TbAttributions{$Salé}:=<>TbFonctionsNomFonction{$L}
End for 

  // Affichage des [XDroits]
SELECTION TO ARRAY:C260([XDroits:7]Ajouter:5;TbAjouter\
;[XDroits:7]Voir:4;TbVoir\
;[XDroits:7]NumTableSensible:3;TbNumTableSensible\
;[XDroits:7]Imprimer:8;TbImprimer\
;[XDroits:7]Modifier:6;TBModifier\
;[XDroits:7]Special1:9;TbSpécial1\
;[XDroits:7]Special2:10;TbSpécial2\
;[XDroits:7]Supprimer:7;TbSupprimer)
$FT:=Size of array:C274(TbNumTableSensible)
ARRAY TEXT:C222(TbTableSensible;$FT)
For ($Salé;1;$FT)
	TbTableSensible{$Salé}:=Table name:C256(TbNumTableSensible{$Salé})
End for 

  // GESTION DES VISIBILITES
  // gestion de la visualisation simple
OBJECT SET VISIBLE:C603(*;"Modif@";ZModif)
OBJECT SET VISIBLE:C603([XUtilisateurs:2]AccesStructure:12;((Current user:C182="Concepteur") | (Current user:C182="Administrateur")))
OBJECT SET VISIBLE:C603(*;"BouModifMdP";Not:C34(ZModif))


  // Test de nouvel enregistrement
VarNomUtil:=[XUtilisateurs:2]Nom:2

  // Le serveur de mail
<>ServeurFAM:=OB Get:C1224([XUtilisateurs:2]ObjetUtilisateur:13;"ServeurFAM";Est un texte:K8:3)
If (<>ServeurFAM="")
	<>ServeurFAM:="Orange"
End if 
PUMFAM:=Find in array:C230(PUMFAM;<>ServeurFAM)
