//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 23/07/18, 06:48:32
  // ----------------------------------------------------
  // Paramètre aucun
  // ----------------------------------------------------
  // Méthode : ASAPInitTbArgumentsPersonnes
  // Description
  // //  Initialise les tableaux généraux des personnes hérités de[Personnes]Arguments

ARRAY TEXT:C222(TbNomProprioRetenues;0)

ARRAY TEXT:C222(<>TbPAAssociation;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPAAssociation)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPAAssociation")

ARRAY TEXT:C222(<>TbPABoiteIsotherme;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPABoiteIsotherme)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPABoiteIsotherme")

ARRAY TEXT:C222(<>TbPAEMail;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPAEMail)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPAEMail")

ARRAY TEXT:C222(<>TbPAPhonePro;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPAPhonePro)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPAPhonePro")

ARRAY TEXT:C222(<>TbPAFaxPro;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPAFaxPro)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPAFaxPro")

ARRAY TEXT:C222(<>TbPANumClient;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPANumClient)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPANumClient")

ARRAY TEXT:C222(<>TbPANomContact;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPANomContact)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPANomContact")

ARRAY TEXT:C222(<>TbPANumTVAIntraCom;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPANumTVAIntraCom)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPANumTVAIntraCom")

ARRAY TEXT:C222(<>TbPARemarques;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPARemarques)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPARemarques")

ARRAY TEXT:C222(<>TbPAUPSConforme;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPAUPSConforme)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPAUPSConforme")

ARRAY TEXT:C222(<>TbPAEmailRAEMA;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPAEmailRAEMA)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPAEmailRAEMA")

ARRAY TEXT:C222(<>TbPANbrePoudreSupMars;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPANbrePoudreSupMars)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPANbrePoudreSupMars")

ARRAY TEXT:C222(<>TbPAModeEnvoiColis;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPAModeEnvoiColis)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPAModeEnvoiColis")

ARRAY TEXT:C222(<>TbPACivilités;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPACivilités)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPACivilités")

ARRAY TEXT:C222(<>TbPAMailTexteBrut;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPAMailTexteBrut)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPAMailTexteBrut")

ARRAY TEXT:C222(<>TbPAPrénom;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPAPrénom)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPAPrénom")

ARRAY TEXT:C222(<>TbPASociété;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPASociété)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPASociété")

ARRAY TEXT:C222(<>TbPAMotDePasse;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPAMotDePasse)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPAMotDePasse")

ARRAY TEXT:C222(<>TbPAEMailInternet;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPAEMailInternet)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPAEMailInternet")

ARRAY TEXT:C222(<>TbPAPortable;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPAPortable)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPAPortable")

ARRAY TEXT:C222(<>TbPATelephonePerso;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPATelephonePerso)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPATelephonePerso")

ARRAY TEXT:C222(<>TbPACodeFacturation;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPACodeFacturation)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPACodeFacturation")

ARRAY TEXT:C222(<>TbPAFacturationPays;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPAFacturationPays)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPAFacturationPays")

ARRAY TEXT:C222(<>TbPAEMailBis;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPAEMailBis)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPAEMailBis")

ARRAY TEXT:C222(<>TbPAFaxPerso;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPAFaxPerso)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPAFaxPerso")

ARRAY TEXT:C222(<>TbPANbrePoudreSupOctobre;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPANbrePoudreSupOctobre)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPANbrePoudreSupOctobre")

ARRAY TEXT:C222(<>TbPANumBonCommandePoudre;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPANumBonCommandePoudre)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPANumBonCommandePoudre")

ARRAY TEXT:C222(<>TbPANonSoumisCotisation;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPANonSoumisCotisation)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPANonSoumisCotisation")

ARRAY TEXT:C222(<>TbPATelephoneContact;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPATelephoneContact)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPATelephoneContact")

ARRAY TEXT:C222(<>TbPANonSoumisTVA;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPANonSoumisTVA)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPANonSoumisTVA")

ARRAY TEXT:C222(<>TbPAFacturationSpeciale;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPAFacturationSpeciale)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPAFacturationSpeciale")

ARRAY TEXT:C222(<>TbPANbrePotSupGelSansRapport;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPANbrePotSupGelSansRapport)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPANbrePotSupGelSansRapport")

ARRAY TEXT:C222(<>TbPAProforma;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPAProforma)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPAProforma")

ARRAY TEXT:C222(<>TbPAPayeDeuxFois;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPAPayeDeuxFois)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPAPayeDeuxFois")

ARRAY TEXT:C222(<>TbPANumBonCommandeGel;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPANumBonCommandeGel)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPANumBonCommandeGel")

ARRAY TEXT:C222(<>TbPANbrePotSupGelAvecRapport;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPANbrePotSupGelAvecRapport)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPANbrePotSupGelAvecRapport")

ARRAY TEXT:C222(<>TbPASansPathogenes;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPASansPathogenes)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPASansPathogenes")

  //TABLEAU TEXTE(<>TbPACodesRAEMALiés;0)
  //AJOUTER À TABLEAU(<>TbPtPersonnes;-><>TbPACodesRAEMALiés)
  //AJOUTER À TABLEAU(TbNomProprioRetenues;"<>TbPACodesRAEMALiés")

ARRAY TEXT:C222(<>TbPATbCodesRAEMALiés;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPATbCodesRAEMALiés)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPATbCodesRAEMALiés")


ARRAY TEXT:C222(<>TbPANumRAEMALiés;0)
APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPANumRAEMALiés)
APPEND TO ARRAY:C911(TbNomProprioRetenues;"<>TbPANumRAEMALiés")
