//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 21/08/19, 17:32:16
  // ----------------------------------------------------
  // Méthode : ASAPInitTbPersonnes
  // Description
  // Méthode qui initialise les tableaux généraux
  // concernant les [Personnes]
  // ----------------------------------------------------

ARRAY POINTER:C280(<>TbPtPersonnes;0)

ARRAY TEXT:C222(<>TbPerIdentificateur;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerIdentificateur)

ARRAY TEXT:C222(<>TbPerNomCourt;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerNomCourt)

ARRAY TEXT:C222(<>TbPerNomLong;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerNomLong)

ARRAY TEXT:C222(<>TbPerTypePersonne;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerTypePersonne)

ARRAY TEXT:C222(<>TbPerUUID;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerUUID)

ARRAY BOOLEAN:C223(<>TbPerCaduc;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerCaduc)

ARRAY OBJECT:C1221(<>TbPerArguments;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerArguments)

  // les adresses
ARRAY TEXT:C222(<>TbPerAdrFacCP;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrFacCP)
ARRAY TEXT:C222(<>TbPerAdrFacAd1;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrFacAd1)
ARRAY TEXT:C222(<>TbPerAdrFacAd2;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrFacAd2)
ARRAY TEXT:C222(<>TbPerAdrFacAd3;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrFacAd3)
ARRAY TEXT:C222(<>TbPerAdrFacPays;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrFacPays)
ARRAY TEXT:C222(<>TbPerAdrFacVille;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrFacVille)


ARRAY TEXT:C222(<>TbPerAdrPerCP;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrPerCP)
ARRAY TEXT:C222(<>TbPerAdrPerAd1;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrPerAd1)
ARRAY TEXT:C222(<>TbPerAdrPerAd2;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrPerAd2)
ARRAY TEXT:C222(<>TbPerAdrPerAd3;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrPerAd3)
ARRAY TEXT:C222(<>TbPerAdrPerPays;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrPerPays)
ARRAY TEXT:C222(<>TbPerAdrPerVille;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrPerVille)

ARRAY TEXT:C222(<>TbPerAdrProCP;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrProCP)
ARRAY TEXT:C222(<>TbPerAdrProAd1;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrProAd1)
ARRAY TEXT:C222(<>TbPerAdrProAd2;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrProAd2)
ARRAY TEXT:C222(<>TbPerAdrProAd3;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrProAd3)
ARRAY TEXT:C222(<>TbPerAdrProPays;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrProPays)
ARRAY TEXT:C222(<>TbPerAdrProVille;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrProVille)

ARRAY TEXT:C222(<>TbPerAdrLivCP;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrLivCP)
ARRAY TEXT:C222(<>TbPerAdrLivAd1;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrLivAd1)
ARRAY TEXT:C222(<>TbPerAdrLivAd2;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrLivAd2)
ARRAY TEXT:C222(<>TbPerAdrLivAd3;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrLivAd3)
ARRAY TEXT:C222(<>TbPerAdrLivPays;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrLivPays)
ARRAY TEXT:C222(<>TbPerAdrLivVille;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerAdrLivVille)

ASAPInitTbArgumentsPersonnes 
  // Les valeurs des anciens identifiants [Adhérents]NumAdhérent, [Adhérents]NumRAEMA, [Adhérents]NumRAEMAEntier
ARRAY LONGINT:C221(<>TbPerNumPersonne;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerNumPersonne)

ARRAY LONGINT:C221(<>TbPerNumLaboRAEMA;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerNumLaboRAEMA)

ARRAY TEXT:C222(<>TbPerNumPersonneA;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerNumPersonneA)

ARRAY TEXT:C222(<>TbPerNumLaboRAEMAA;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerNumLaboRAEMAA)

  // les Numéros de RAEMA liés
ARRAY TEXT:C222(<>TbPANumRAEMALiés;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPANumRAEMALiés)

  // les nom des arguments
ARRAY TEXT:C222(<>PUMPerProprio;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>PUMPerProprio)