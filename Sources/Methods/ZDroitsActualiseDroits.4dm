//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 31/01/18, 07:09:17
  // ----------------------------------------------------
  // Méthode : ZDroitsActualiseDroits
  // Description
  // Création des droits à partir des tableaux affichés ou non
  // ----------------------------------------------------

$FT:=Size of array:C274(TbNumTableSensible)
ARRAY TEXT:C222($TbUUIDUtilisateur;$FT)
For ($Salé;1;$FT)
	$TbUUIDUtilisateur{$Salé}:=[XUtilisateurs:2]UUID:1
End for 
ARRAY TO SELECTION:C261($TbUUIDUtilisateur;[XDroits:7]UUIDUtilisateur:2\
;TbNumTableSensible;[XDroits:7]NumTableSensible:3\
;TbVoir;[XDroits:7]Voir:4\
;TbAjouter;[XDroits:7]Ajouter:5\
;TbImprimer;[XDroits:7]Imprimer:8\
;TBModifier;[XDroits:7]Modifier:6\
;TbSpécial1;[XDroits:7]Special1:9\
;TbSpécial2;[XDroits:7]Special2:10\
;TbSupprimer;[XDroits:7]Supprimer:7)