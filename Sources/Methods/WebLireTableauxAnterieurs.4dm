//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 01/08/18, 07:29:21
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : WebLireTableauxAnterieurs
  // Description
  // Méthode qui lit les tableaux des valeurs antérieures sur le dernier enregistrement de [WebConnexions]

ARRAY LONGINT:C221($TbAncNumEnrRaemaRetenu;0)
ARRAY LONGINT:C221($TbNumEnrRaemaRetenu;0)

  // Les derniers tableaux de la plus récente connexion
ARRAY TEXT:C222(TbAncNumEch;0)  // les anciens n° d'échantillons tels que saisis par le labo
ARRAY TEXT:C222(TbAncNumEchT;0)  // les anciens n° d'échantillons triés 
ARRAY TEXT:C222(TbAncNomsP2;0)  // les anciens noms récoltés sur le formulaire Web P2
ARRAY TEXT:C222(TbAncValeursP2;0)  // les anciennes valeurs récoltées sur le formulaire Web P2
ARRAY TEXT:C222(TbAncNomsP3;0)  // les anciens noms récoltés sur le formulaire Web P3
ARRAY TEXT:C222(TbAncValeursP3;0)  // les anciennes valeurs récoltées sur le formulaire Web P3
ARRAY TEXT:C222(TbAncTexteResume;0)  // les anciennes valeurs du résumé
ARRAY TEXT:C222(TbAncPJMailRaema;0)  // les anciennes valeurs du courriel

  //$CodeConnexion:=WebTrouveValeurParNom (MotDePasseActuel;-><>TbPerIdentificateur;-><>TbPerIdentificateur)
  //CHERCHER([WebConnexions];[WebConnexions]CodeConnexion=$CodeConnexion;*)
  //CHERCHER([WebConnexions]; & [WebConnexions]Campagne=<>NumCampagneEnCoursSaisie)
QUERY:C277([WebConnexions:13]; & [WebConnexions:13]UUIDParticipation:12=UUIDParticipation)
If (Records in selection:C76([WebConnexions:13])>0)
	ORDER BY:C49([WebConnexions:13];[WebConnexions:13]NumEnvoi:9;<)  // Le dernier envoi est en mémoire
	ZBlobVersVariable (->[WebConnexions:13]BlobConnexion:11;->TbAncNumEch;->TbAncNumEchT;->$TbAncNumEnrRaemaRetenu;->TbAncNomsP2;->TbAncValeursP2;->TbAncNomsP3;->TbAncValeursP3;->TbAncTexteResume;->TbAncPJMailRaema)
	ZBlobVersVariable (->[WebConnexions:13]BlobConnexion:11;->TbNumEch;->TbNumEchT;->$TbNumEnrRaemaRetenu;->TbNomsP2;->TbValeursP2;->TbNomsP3;->TbValeursP3;->TbTexteResume;->TbPJMailRaema)
End if 