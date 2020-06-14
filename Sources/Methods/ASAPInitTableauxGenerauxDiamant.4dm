//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/08/18, 15:17:34
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPInitTableauxGenerauxDiamant
  // Description
  // // Méthode qui crée les tableaux interprocess du contenu des tables
  // ----------------------------------------------------

$MCE:=Macintosh command down:C546  // Permet de mettre le tableau des personnes dans le pp en maintenant la touche commande enfoncée

$H1:=Milliseconds:C459

ASAPFabriqueTbNomGermeGel (True:C214)
RaemaInitPUMCampagne (True:C214)

If (<>ZClient)
	ASAPFabriqueTbPersonnesMAJ 
	ASAPFabriqueTbCampagneToutesMAJ 
	ASAPFabriqueTbCampagneUneMAJ 
	ASAPFabriqueTbParticipeMAJ 
Else 
	ASAPFabriqueTbPersonnes 
	ASAPFabriqueTbCampagnesToutes 
	ASAPFabriqueTbParticipe 
	ASAPFabriqueTbCampagneUne 
End if 
ASAPFabriqueTbPrestations (True:C214)

ALL RECORDS:C47([Factures:15])
$FT:=Records in selection:C76([Factures:15])
SELECTION TO ARRAY:C260([Factures:15]NumFacture:3;<>TbFacNumFacture;[Factures:15]UUIDPersonne:2;<>TbFacUUIDPersonne;[Factures:15]UUID:1;<>TbFacUUID)

ALL RECORDS:C47([XUtilisateurs:2])
SELECTION TO ARRAY:C260([XUtilisateurs:2]Anniversaire:6;<>TbUtilAnniversaire;[XUtilisateurs:2]Email:9;<>TbUtilEmail;[XUtilisateurs:2]Initiales:4;<>TbUtilInitiales;[XUtilisateurs:2]Mec:7;<>TbUtilMec;[XUtilisateurs:2]Nom:2;<>TbUtilNom;[XUtilisateurs:2]NomJeuneFille:8;<>TbUtilNomJeuneFille;[XUtilisateurs:2]Passoire:5;<>TbUtilPassoire;[XUtilisateurs:2]Prenom:3;<>TbUtilPrenom;[XUtilisateurs:2]UUID:1;<>TbUtilUUID)


  // Création des tableaux de correspondance [XFonctions]
ALL RECORDS:C47([XFonctions:3])
SELECTION TO ARRAY:C260([XFonctions:3]Description:3;<>TbFonctionsDescription;[XFonctions:3]NomFonction:2;<>TbFonctionsNomFonction;[XFonctions:3]UUID:1;<>TbFonctionsUUID)

$H2:=Milliseconds:C459
  // ALERTE(Chaîne($H2-$H1))temps au  jeudi 21 juin 2018=300 millisecondes

