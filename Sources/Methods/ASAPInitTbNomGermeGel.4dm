//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 21/08/19, 17:08:46
  // ----------------------------------------------------
  // Méthode : ASAPInitTbNomGermeGel
  // Description
  //  Méthode qui liste les différents noms des germes 
  //  et des tableaux généraux correspondants
  // ----------------------------------------------------

ARRAY POINTER:C280(<>TbPtTbNomGermeGel;0)

ARRAY TEXT:C222(<>TbNomGermeCampagneGEL;0)
APPEND TO ARRAY:C911(<>TbPtTbNomGermeGel;-><>TbNomGermeCampagneGEL)
ARRAY TEXT:C222(<>TbNomGermeSchémaGEL;0)
APPEND TO ARRAY:C911(<>TbPtTbNomGermeGel;-><>TbNomGermeSchémaGEL)
ARRAY TEXT:C222(<>TbPetitNomGermeWeb;0)
APPEND TO ARRAY:C911(<>TbPtTbNomGermeGel;-><>TbPetitNomGermeWeb)
ARRAY POINTER:C280(<>TbPtTbParticipeGermeGEL;0)
APPEND TO ARRAY:C911(<>TbPtTbNomGermeGel;-><>TbPtTbParticipeGermeGEL)
ARRAY POINTER:C280(<>TbPtTbLotoGermeGELNCGSR;0)
APPEND TO ARRAY:C911(<>TbPtTbNomGermeGel;-><>TbPtTbLotoGermeGELNCGSR)
ARRAY POINTER:C280(<>TbPtTbLotoGermeGELNCGAR;0)
APPEND TO ARRAY:C911(<>TbPtTbNomGermeGel;-><>TbPtTbLotoGermeGELNCGAR)
