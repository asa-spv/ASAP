//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 21/08/19, 05:02:31
  // ----------------------------------------------------
  // Méthode : ASAPInitTbGenerauxCampagne
  // Description
  // Méthode qui initialise les tableaux généraux 
  //   de toutes les campagnes RAEMA ce qui permet d'éviter 
  //   les CHERCHER pour avoir les caractéristiques d'une campagne
  // ----------------------------------------------------

ARRAY POINTER:C280(<>TbPtTbCampagnes;0)

ARRAY DATE:C224(<>TbCampagnesDateEnvoiColis;0)
APPEND TO ARRAY:C911(<>TbPtTbCampagnes;-><>TbCampagnesDateEnvoiColis)

ARRAY DATE:C224(<>TbCampagnesDateLimiteReponse;0)
APPEND TO ARRAY:C911(<>TbPtTbCampagnes;-><>TbCampagnesDateLimiteReponse)

ARRAY DATE:C224(<>TbCampagnesDateMiseEnLigne;0)
APPEND TO ARRAY:C911(<>TbPtTbCampagnes;-><>TbCampagnesDateMiseEnLigne)

ARRAY LONGINT:C221(<>TbCampagnesNbParticipants;0)
APPEND TO ARRAY:C911(<>TbPtTbCampagnes;-><>TbCampagnesNbParticipants)

ARRAY TEXT:C222(<>TbCampagnesNumCampagne;0)
APPEND TO ARRAY:C911(<>TbPtTbCampagnes;-><>TbCampagnesNumCampagne)

ARRAY TEXT:C222(<>TbCampagnesUUID;0)
APPEND TO ARRAY:C911(<>TbPtTbCampagnes;-><>TbCampagnesUUID)

ARRAY OBJECT:C1221(<>TbCampagnesArguments;0)
APPEND TO ARRAY:C911(<>TbPtTbCampagnes;-><>TbCampagnesArguments)

ARRAY LONGINT:C221(<>TbNumEnrRaemaCampagne;0)
APPEND TO ARRAY:C911(<>TbPtTbCampagnes;-><>TbNumEnrRaemaCampagne)

ARRAY LONGINT:C221(<>TbCampagnesRang;0)
APPEND TO ARRAY:C911(<>TbPtTbCampagnes;-><>TbCampagnesRang)

ARRAY LONGINT:C221(<>TbCampagnesNbGermes;0)
APPEND TO ARRAY:C911(<>TbPtTbCampagnes;-><>TbCampagnesNbGermes)

ARRAY TEXT:C222(<>TbCampagnesNumEchEnvoi;0)
APPEND TO ARRAY:C911(<>TbPtTbCampagnes;-><>TbCampagnesNumEchEnvoi)

ARRAY TEXT:C222(<>TbCampagnesContamination;0)
APPEND TO ARRAY:C911(<>TbPtTbCampagnes;-><>TbCampagnesDateEnvoiColis)

