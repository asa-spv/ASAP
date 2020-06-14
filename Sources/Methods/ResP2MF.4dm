//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 17/02/16, 14:28:34
  // ----------------------------------------------------
  // Méthode : ResP2MF
  // Description
  // appelée par la validation de P2 = page des programmes
  // prend les renseignements d'identification 
  // pour les transbahuter dans la page 3
  // ----------------------------------------------------

C_BOOLEAN:C305(MCE)
C_LONGINT:C283($Salé;$FT)

  // Acquisition des valeurs saises par le laboratoire dans la page 2 sur le Web
ResInitTbPersistants 
WEB GET VARIABLES:C683(TbNomsP2;TbValeursP2)  // lecture des variables du formulaire courant
COPY ARRAY:C226(TbNomsP2;$TbNomsP2Actuels)
COPY ARRAY:C226(TbValeursP2;$TbValeursP2Actuelles)
  // Repérage du n° de labo concerné et des numéros des échantillons
UUIDParticipation:=WebTrouveValeurParNom ("hiddenField";->TbNomsP2;->TbValeursP2)  // mot de passe
NumLaboActuelA:=String:C10(WebTrouveValeurParNom (UUIDParticipation;-><>TbLotoUUIDParticipation;-><>TbLotoNumLaboRAEMA))
MotDePasseActuel:=WebTrouveValeurParNom (NumLaboActuelA;-><>TbPerNumLaboRAEMAA;-><>TbPerIdentificateur)
LangueCourante:=WebTrouveValeurParNom ("langage";->TbNomsP2;->TbValeursP2)

If (ResP3ChasseLaboFantomes )  // Le mdp caché est correct
	NumCampagneCourante:=<>NumCampagneEnCoursSaisie
	LigneRaemaCourant:=Find in array:C230(<>TbCampagnesNumCampagne;NumCampagneCourante)
	RaemaPoudre:=(NumCampagneCourante#"@A")  // si Vrai RAEMA poudre, gel si Faux
	WebLireTableauxAnterieurs 
	  // Restitution des valeurs des tableaux de la page Web
	COPY ARRAY:C226($TbNomsP2Actuels;TbNomsP2)
	COPY ARRAY:C226($TbValeursP2Actuelles;TbValeursP2)
	ResP2FabriqueTbCaseCochees 
	ResP2FabriqueTbEch   // Fabrication des tableaux des n° des échantillons
	WebActualiseConnexionSaisie (NumLaboActuelA;2)  // MAJ de [CampagneParticipation] et stockage des données actuelles du formulaire Web dans [WebConnexions]
	
	  // testons la validité de tout ça
	If (ResP2Preambule )  // les n° d'échantillons sont OK
		ResP2FabriqueRaemaRestreint 
	Else 
		If (LangueCourante="F")
			TitrePage:="Erreur de saisie"
			WEB SEND FILE:C619("DlgErreurDataFr.shtml")
		Else 
			TitrePage:="Imput error"
			WEB SEND FILE:C619("DlgErreurDataEn.shtml")
		End if 
	End if 
End if 

