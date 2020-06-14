//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : cgm
  // Date et heure : 31/12/16, 09:05:48
  // ----------------------------------------------------
  // Méthode : GA13RaemaGelGrilleInit
  // Description
  // Remet à zéro les cases et variables de la grille 
  //  du RAEMA Gel de [Adhérents];"SaisieLabo"
  // ----------------------------------------------------

VarNom:=""
VarAdresse:=""
VarCP:=""
VarVille:=""
VarPays:=""
VarMail:=""

  // Gestion des annonces
  // Mai
$Annonce:="Mai ("+<>CampagneDevisRGMai+")"
OBJECT SET TITLE:C194(*;"AnnonceMai";$Annonce)

  // Décembre 
$Annonce2:="Décembre ("+<>CampagneDevisRGDec+")"
OBJECT SET TITLE:C194(*;"AnnonceDec";$Annonce2)

ZViderSelectionCourante (->[PersonnesDevis:30])

ARRAY TEXT:C222(TbNomGermeMai;0)
ARRAY TEXT:C222(TbPSARMai;0)
ARRAY TEXT:C222(TbPSSRMai;0)
ARRAY TEXT:C222(TbNomGermeDec;0)
ARRAY TEXT:C222(TbPSARDec;0)
ARRAY TEXT:C222(TbPSSRDec;0)

ARRAY TEXT:C222(TbNoms;0)
ARRAY TEXT:C222(TbValeurs;0)