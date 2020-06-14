//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 11/08/18, 05:12:12
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ResP1MF <= WebClicParticipant
  // Description
  // 
  // méthode appelée par clic sur le bouton adéquat de l'espace cleint

C_TEXT:C284(LangueCourante;NumCampagneActuelle;TitrePage)

  // Initialisation des tableaux présents dans chaque connexion (WebChercheFicheXDonnées)
ARRAY TEXT:C222(TbNoms;0)  // les noms récoltés sur le formulaire Web P1
ARRAY TEXT:C222(TbValeurs;0)  // les valeurs récoltées sur le formulaire Web P1
ARRAY TEXT:C222(TbNomsP2;0)  // les noms récoltés sur le formulaire Web P2
ARRAY TEXT:C222(TbValeursP2;0)  // les valeurs récoltées sur le formulaire Web P2
ARRAY TEXT:C222(TbNomsP3;0)  // les noms récoltés sur le formulaire Web P3
ARRAY TEXT:C222(TbValeursP3;0)  // les valeurs récoltées sur le formulaire Web P3
ARRAY TEXT:C222(TbNumEch;0)  // les n° d'échantillons tels que saisis par le labo
ARRAY TEXT:C222(TbNumEchT;0)  // les n° d'échantillons triés 
ARRAY TEXT:C222(TbTexteResume;0)  // les valeurs du résumé
ARRAY TEXT:C222(TbPJMailRaema;0)  // les valeurs du courriel
ARRAY BOOLEAN:C223(TbNumEnrRaemaRetenu;0)

  //WEB LIRE VARIABLES(TbNoms;TbValeurs)  // Lecture des données de la page Web
  //NumCampagneActuelle:=<>NumCampagneEnCoursSaisie  // récupérons le n° de RAEMA actuel (alphanumérique)
  //RaemaPoudre:=(NumCampagneActuelle#"@A")


  //  // si Vrai RAEMA poudre, Gel si Faux
  //MotDePasseActuel:=TbValeurs{3}  // Le mot de passe, bien sur
  //NumLaboActuelA:=TbValeurs{2}  // Le n° de RAEMA 
  //Si (Chercher dans tableau(TbNoms;"Imag@")<0)  // il n'a pas cliqué sur le drapeau
  //LangueCourante:=WebTrouveValeurParNom ("hiddenField";->TbNoms;->TbValeurs)  // F pour français et A pour Anglais = champ caché de la P1 
  //$Langue:=LangueCourante
  //  // testons la validité de tout ça
  //Si (ResP1Preambule )  // les données ont-elles été correctement renseignées ??
  // lecture d'éventuelles données antérieures
WebLireTableauxAnterieurs 
If (RaemaPoudre)
	ResP1ConstruitP2Poudre 
Else   // Raema gel
	LangueCourante:="F"
	ResP1ConstruitP2Gel 
End if 
  //Sinon   // Les données ne sont pas correctes
  //Si (LangueCourante="F")
  //TitrePage:="Erreur de saisie"
  //WEB ENVOYER FICHIER("DlgErreurDataFr.shtml")
  //Sinon 
  //TitrePage:="Imput error"
  //WEB ENVOYER FICHIER("DlgErreurDataEn.shtml")
  //Fin de si 
  //Fin de si 
  //Sinon   // il a cliqué sur le drapeau
  //Si (TbValeurs{3}="F")
  //WEB ENVOYER FICHIER("saisieraema.shtml")
  //Sinon 
  //WEB ENVOYER FICHIER("saisieraemaA.shtml")
  //Fin de si 
  //Fin de si 