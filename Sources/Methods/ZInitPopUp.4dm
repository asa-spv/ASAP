//%attributes = {"publishedWeb":true}
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 29/04/18, 05:10:35
  // ----------------------------------------------------
  // Méthode : ZInitPopUp
  // Historique : ZInitPopUp V11 du mardi 20 juillet 2010
  // Description
  // Méthode dans laquelle sont définies les tableaux ,
  // les menus locaux et les listes déroulantes utilisées dans le standard
  // les autres menus locaux sont dans ZMAJInitPopUp
  // ----------------------------------------------------

  // GESTION des PUM ASAP

  // PUM des banques
  //Insérer Ici les PopUp que vous créez dans le cadre de votre application
ALL RECORDS:C47([Ventes:16])
DISTINCT VALUES:C339([Ventes:16]Banque:10;PUMBanque)

  // Les popUp de participation
ARRAY TEXT:C222(PUMNumCampagneSuivi;0)
COPY ARRAY:C226(<>PUMCampagne;PUMNumCampagneSuivi)
PUMNumCampagneSuivi:=Find in array:C230(<>PUMCampagne;<>NumCampagneEnCoursSaisie)

  // Les types de proforma
ARRAY TEXT:C222(PUMProforma;4)
ARRAY TEXT:C222(PUMProformaGel;4)
PUMProforma{1}:="Pas de modèle"
PUMProforma{2}:="Commercial"
PUMProforma{3}:="Proforma"
PUMProforma{4}:="Facture"
COPY ARRAY:C226(PUMProforma;PUMProformaGel)

  // Les transporteurs
ARRAY TEXT:C222(PUMTransporteur;10)
PUMTransporteur{1}:="Chronopost"
PUMTransporteur{2}:="SDV"
PUMTransporteur{3}:="UPS"
PUMTransporteur{4}:="DHL "
PUMTransporteur{5}:="SIFA"
PUMTransporteur{6}:="TNT"
PUMTransporteur{7}:="FEDEX"
PUMTransporteur{8}:="coursiers"
PUMTransporteur{9}:="-"
PUMTransporteur{10}:="Autres"

  // Les RAEMA poudre
ARRAY TEXT:C222(PUMMarsBoite;3)
ARRAY TEXT:C222(PUMOctobreBoite;3)
PUMMarsBoite{1}:="Aucune"
PUMMarsBoite{2}:="Gratuite"
PUMMarsBoite{3}:="Payante"
COPY ARRAY:C226(PUMMarsBoite;PUMOctobreBoite)

  // Les catégories de mails
ARRAY TEXT:C222(PUMMail;3)
PUMMail{1}:="Récupération rapport"
PUMMail{2}:="Diffusion d’information"
PUMMail{3}:="Comptabilité"

ARRAY TEXT:C222(TbNomGermesPossibles;0)
APPEND TO ARRAY:C911(TbNomGermesPossibles;"Bacillus")
APPEND TO ARRAY:C911(TbNomGermesPossibles;"Pseudomonas")
APPEND TO ARRAY:C911(TbNomGermesPossibles;"Bacilles lactiques")
APPEND TO ARRAY:C911(TbNomGermesPossibles;"Levures moisissures")
APPEND TO ARRAY:C911(TbNomGermesPossibles;"Levures + moisissures")

  // GA15InitPUMAnRaemaGel 

  // Gestion des sélections en LB
ARRAY TEXT:C222(TbMethodeLapin;0)


  //  gestion des ensembles
ARRAY TEXT:C222(ZTbEnsNom;0)  //  tableau des noms des ensembles
ARRAY DATE:C224(ZTbEnsDate;0)
ARRAY TEXT:C222(ZTbEnsQVL;0)  //  tableau des noms des auteurs
ARRAY REAL:C219(ZTbEnsNbre;0)
ARRAY LONGINT:C221(ZTbEnsNumEnr;0)


  //  gestion des pop-up de ListeNB
  // Initialisation des Pop Up menus
  //utilisés dans les petits formats
  // Odieusement piquée à JM Collu de Montauban
ARRAY TEXT:C222(ZSuppress;2)
ZSuppress{1}:="Supprimer toute la sélection"
ZSuppress{2}:="Supprimer la fiche désignée"

ARRAY TEXT:C222(ZDestroy;2)  // permet des traitements sur les suppressions
ZDestroy{2}:="Supprimer toute la sélection"
ZDestroy{1}:="Supprimer la fiche désignée"

ARRAY TEXT:C222(ZEnsemb;5)
ZEnsemb{1}:="Appeler ensemble"
ZEnsemb{2}:="Enregistrer ensemble"
ZEnsemb{3}:="Supprimer ensemble "
ZEnsemb{4}:="Calcul sur ensemble"
ZEnsemb{5}:="Reprendre sélection"

ARRAY TEXT:C222(ZSelection;5)
ZSelection{1}:="Ajouter à sélection"
ZSelection{2}:="Enlever à sélection"
ZSelection{3}:="Trier la sélection"
ZSelection{4}:="Ôter les lignes désignées"
ZSelection{5}:="Reprendre sélection"

ARRAY TEXT:C222(ZRechercheR;4)
ZRechercheR{1}:="Recherches standard"
ZRechercheR{3}:="Tout voir"
ZRechercheR{2}:="Sélection sur liste"
ZRechercheR{4}:="Reprendre sélection"

ARRAY TEXT:C222(ZImpression;2)
ZImpression{1}:="Imprimer la sélection"
ZImpression{2}:="Etats sur la sélection"

ARRAY TEXT:C222(ZRechListe;4)
ZRechListe{1}:="Recherches standard"
ZRechListe{3}:="Tout voir"
ZRechListe{2}:="Recherche par l'exemple"
ZRechListe{4}:="Reprendre sélection"

ARRAY TEXT:C222(ZSelListe;4)
ZSelListe{1}:="Ajouter à sélection"
ZSelListe{2}:="Enlever à sélection"
ZSelListe{3}:="Trier la sélection"
ZSelListe{4}:="Reprendre sélection"