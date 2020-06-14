//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 18/02/16, 11:12:50
  // ----------------------------------------------------
  // Méthode : RaemaInfP1 <- WebClicParticipant
  // Description
  // Gestion d'une demande d'informations
  // sur le RAEMA après identification du labo
  //
  // ----------------------------------------------------


ZAmnistieInternationale 
  // Initialisation des tableaux présents dans chaque connexion (WebChercheFicheXDonnées)
ARRAY TEXT:C222($TbNoms;0)  // les noms récoltés sur le formulaire Web P1
ARRAY TEXT:C222($TbValeurs;0)  // les valeurs récoltées sur le formulaire Web P1

WEB GET VARIABLES:C683($TbNoms;$TbValeurs)  // Lecture des données de la page Web
NumCampagneActuelle:=<>NumCampagneEnCoursInfoOK  // récupérons le n° de RAEMA actuel (alphanumérique)
RaemaPoudre:=(String:C10(Num:C11(NumCampagneActuelle))=NumCampagneActuelle)
  // si Vrai RAEMA traditionnel, Complémentaire si Faux
MotDePasseActuel:=WebTrouveValeurParNom ("MdP";->$TbNoms;->$TbValeurs)  // Le mot de passe, bien sur
NumLaboActuelA:=WebTrouveValeurParNom ("CodeRaema";->$TbNoms;->$TbValeurs)  // Le n° de RAEMA 
LangueCourante:=WebTrouveValeurParNom ("hiddenField";->$TbNoms;->$TbValeurs)  // F pour français et A pour Anglais = champ caché de la P1 
  // testons la validité de tout ça
If (ResP1Preambule (True:C214))  // les données ont-elles été correctement renseignées ??
	RaemaInfEcritP2 
	$H:="Identification du labo le "+String:C10(Current date:C33;3)+" à "+String:C10(Current time:C178)
	$H:=$H+" pour l'obtention de renseignements sur le RAEMA "+<>NumCampagneEnCoursInfoOK
	$H:=$H+<>ZCR+"Numéro de labo : "+NumLaboActuelA+" et mot de passe : "+MotDePasseActuel+<>ZCR2
	$UUID:=WebTrouveValeurParNom (MotDePasseActuel;-><>TbPerIdentificateur;-><>TbPerUUID)
	READ WRITE:C146([CampagneParticipations:17])
	QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=NumCampagneActuelle;*)
	QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=$UUID)
Else   // Les données ne sont pas correctes
	If (LangueCourante="F")
		TitrePage:="Erreur de saisie"
		MotifRefus:="Le numéro de laboratoire est incompatible avec le mot de passe"
		WEB SEND FILE:C619("DlgErreurDataFr.shtml")
	Else 
		TitrePage:="Data error"
		MotifRefus:="The laboratory number is incompatible with the password"
		WEB SEND FILE:C619("DlgErreurDataEn.shtml")
	End if 
End if 
