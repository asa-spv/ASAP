//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 22/08/19, 05:07:07
  // ----------------------------------------------------
  // Méthode : ASAPInitTbPUMCampagne
  // Description
  // Méthode qui initialise les tableaux généraux 
  //   et les variables interprocess des campagnes en cours
  // ----------------------------------------------------

ARRAY POINTER:C280(<>TbPtPUMCampagne;0)

ARRAY TEXT:C222(<>PUMCampagne;0)
APPEND TO ARRAY:C911(<>TbPtPUMCampagne;-><>PUMCampagne)

ARRAY TEXT:C222(<>PUMAnRaemaPoudre;0)
APPEND TO ARRAY:C911(<>TbPtPUMCampagne;-><>PUMAnRaemaPoudre)

<>NumCampagneEnCoursSaisie:=""
APPEND TO ARRAY:C911(<>TbPtPUMCampagne;-><>NumCampagneEnCoursSaisie)

<>CampagneEnCoursRP:=(<>NumCampagneEnCoursSaisie#"@a")
APPEND TO ARRAY:C911(<>TbPtPUMCampagne;-><>CampagneEnCoursRP)

<>NumCampagneEnCoursRecup:=""
APPEND TO ARRAY:C911(<>TbPtPUMCampagne;-><>NumCampagneEnCoursRecup)

<>NumCampagneEnCoursInfoOK:=""
APPEND TO ARRAY:C911(<>TbPtPUMCampagne;-><>NumCampagneEnCoursInfoOK)
