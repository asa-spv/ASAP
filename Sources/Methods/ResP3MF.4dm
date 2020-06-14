//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 03/08/18, 05:02:56
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ResP3MF
  // Description
  // méthode exécutée après remplissage des résultats (P3)

  // déclarations des variables utilisées
C_BOOLEAN:C305(PasBien;MauvaisSyntaxe;RaemaPoudre)
C_LONGINT:C283(CompteurValeur)

  // initialisation des variables
MauvaisSyntaxe:=False:C215
PasBien:=False:C215
NumCampagneCourante:=<>NumCampagneEnCoursSaisie
RaemaPoudre:=(String:C10(Num:C11(NumCampagneCourante))=NumCampagneCourante)  // si Vrai RAEMA traditionnel, Additionnel si Faux


  // Tableaux de gestion de la page P3
ARRAY TEXT:C222(TbNomsChamps;0)  // recueil du nom des champs (semble inusité)
ARRAY TEXT:C222(TbMotifAttention;0)  // recueille les lignes correpondant aux champs non remplis


  // lecture des données et traitement de la P3

  // Qui s'est logué ?

ARRAY TEXT:C222($TbNomsP3;0)  // recueille les noms de la page 3 saisie
ARRAY TEXT:C222($TbValeursP3;0)  // recueille les valeurs de la page 3 saisie

WEB GET VARIABLES:C683($TbNomsP3;$TbValeursP3)  // lecture des variables
UUIDParticipation:=WebTrouveValeurParNom ("hiddenField";->$TbNomsP3;->$TbValeursP3)  // mot de passe
NumLaboActuelA:=String:C10(WebTrouveValeurParNom (UUIDParticipation;-><>TbLotoUUIDParticipation;-><>TbLotoNumLaboRAEMA))
MotDePasseActuel:=WebTrouveValeurParNom (NumLaboActuelA;-><>TbPerNumLaboRAEMAA;-><>TbPerIdentificateur)
LangueCourante:=WebTrouveValeurParNom ("langage";->$TbNomsP3;->$TbValeursP3)
RaemaPoudre:=(NumCampagneCourante#"@A")  // si Vrai RAEMA poudre, gel si Faux
LigneRaemaCourant:=Find in array:C230(<>TbCampagnesNumCampagne;NumCampagneCourante)

If (ResP3ChasseLaboFantomes )  // Le mdp caché est correct
	
	WebLireTableauxAnterieurs 
	  // Restitution des valeurs des tableaux de la page Web
	COPY ARRAY:C226($TbNomsP3;TbNomsP3)
	COPY ARRAY:C226($TbValeursP3;TbValeursP3)
	ARRAY TEXT:C222(TbTexteResume;0)  // les valeurs du résumé
	ARRAY TEXT:C222(TbPJMailRaema;0)  // les valeurs du courriel
	If (Find in array:C230(TbNomsP3;"submit2")>0)  // il ne demande qu'à enregistrer
		WebActualiseConnexionSaisie (NumLaboActuelA;3)  // écriture la connexion Web sans envoi
		If (LangueCourante="F")
			TitrePage:="Enregistrement des données"
			WEB SEND FILE:C619("RaemaAuRevoir.shtml")
		Else 
			TitrePage:="Recording data"
			WEB SEND FILE:C619("RaemaAuRevoirA.shtml")
		End if 
	Else 
		ResP3TraitePage3   // Va écrire la PJ du mail (TbPJMailRaema), le texte du message (TbTexteResume) 
		
	End if 
End if 