//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 21/08/19, 05:02:31
  // ----------------------------------------------------
  // Méthode : ASAPInitTbGenerauxParticipation
  // Description
  // Méyhode qui initialise les tableaux généraux 
  //   de participation aux RAEMA ce qui permet 
  //   d'éviter le recalcul à l'ouverture d'un client
  // ----------------------------------------------------

  // Tableau des pointeurs sur tableaux pour actualiser les MAJ serveur
ARRAY POINTER:C280(<>TbPtTbParticipation;0)
ARRAY TEXT:C222(<>TbXtéArgumentParticipation;0)

  // Tableau des renseignements à faire apparaître et ajout au tableau des pointeurs sur tableaux
ARRAY TEXT:C222(<>TbLotoUUIDLabo;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoUUIDLabo)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY TEXT:C222(<>TbLotoNumCampagne;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoNumCampagne)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY LONGINT:C221(<>TbLotoNumLaboRAEMA;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoNumLaboRAEMA)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY TEXT:C222(<>TbLotoTransporteur;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoTransporteur)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"Transporteur")

ARRAY TEXT:C222(<>TbLotoIdentifiantParticipation;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoIdentifiantParticipation)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY TEXT:C222(<>TbLotoNumLaboRapportCampagne;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoNumLaboRapportCampagne)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY LONGINT:C221(<>TbLotoBoiteIsotherme;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoBoiteIsotherme)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"BoîteIsotherme")

ARRAY BOOLEAN:C223(<>TbLotoSansPathogene;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoSansPathogene)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"SansPathogene")

ARRAY TEXT:C222(<>TbLotoNumBonCommandePoudre;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoNumBonCommandePoudre)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"NumBonCommandePoudre")

ARRAY TEXT:C222(<>TbLotoProformaPoudre;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoProformaPoudre)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"Proforma")

ARRAY TEXT:C222(<>TbLotoCodeRaemaLié;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoCodeRaemaLié)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"CodeRaemaLié")

ARRAY LONGINT:C221(<>TbLotoNbColisPoudreSR;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoNbColisPoudreSR)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"NbreColisSupSansRapport")

ARRAY LONGINT:C221(<>TbLotoNbColisPoudreAR;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoNbColisPoudreAR)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"NbreColisSupAvecRapport")

ARRAY TEXT:C222(<>TbLotoNumBonCommandeGel;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoNumBonCommandeGel)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"NumBonCommandeGel")

ARRAY TEXT:C222(<>TbLotoProformaGel;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoProformaGel)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"RGProforma")

ARRAY TEXT:C222(<>TbLotoBacillus;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoBacillus)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY LONGINT:C221(<>TbLotoBacillusNCGSR;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoBacillusNCGSR)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY LONGINT:C221(<>TbLotoBacillusNCGAR;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoBacillusNCGAR)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY TEXT:C222(<>TbLotoPseudo;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoPseudo)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY LONGINT:C221(<>TbLotoPseudoNCGSR;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoPseudoNCGSR)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY LONGINT:C221(<>TbLotoPseudoNCGAR;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoPseudoNCGAR)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY TEXT:C222(<>TbLotoLactiques;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoLactiques)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY LONGINT:C221(<>TbLotoLactiquesNCGSR;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoLactiquesNCGSR)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY LONGINT:C221(<>TbLotoLactiquesNCGAR;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoLactiquesNCGAR)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY TEXT:C222(<>TbLotoLevMoisEns;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoLevMoisEns)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY LONGINT:C221(<>TbLotoLevMoisEnsNCGSR;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoLevMoisEnsNCGSR)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY LONGINT:C221(<>TbLotoLevMoisEnsNCGAR;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoLevMoisEnsNCGAR)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY TEXT:C222(<>TbLotoLevMoisSep;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoLevMoisSep)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY LONGINT:C221(<>TbLotoLevMoisSepNCGSR;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoLevMoisSepNCGSR)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY LONGINT:C221(<>TbLotoLevMoisSepNCGAR;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoLevMoisSepNCGAR)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY TEXT:C222(<>TbLotoCampyloDen;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoCampyloDen)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY LONGINT:C221(<>TbLotoCampyloDenNCGSR;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoCampyloDenNCGSR)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY LONGINT:C221(<>TbLotoCampyloDenNCGAR;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoCampyloDenNCGAR)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY TEXT:C222(<>TbLotoCampyloChe;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoCampyloChe)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY LONGINT:C221(<>TbLotoCampyloCheNCGSR;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoCampyloCheNCGSR)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY LONGINT:C221(<>TbLotoCampyloCheNCGAR;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoCampyloCheNCGAR)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY TEXT:C222(<>TbLotoUUIDParticipation;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoUUIDParticipation)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY LONGINT:C221(<>TbLotoNumEnrParticipation;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoNumEnrParticipation)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")

ARRAY TEXT:C222(<>TbLotoAssociation;0)
APPEND TO ARRAY:C911(<>TbPtTbParticipation;-><>TbLotoAssociation)
APPEND TO ARRAY:C911(<>TbXtéArgumentParticipation;"")
