//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur : er + cgm 
  // Date et heure : 08/02/19, 04:25:51
  // ----------------------------------------------------
  // Paramètre : aucun
  // ----------------------------------------------------
  // Méthode : WebClicParticipant
  // Description
  //  Permet de gérer le clic sur un le bouton de demande d'accès 
  //  à l'espace client

ARRAY TEXT:C222($TbNoms;0)  // les noms récoltés sur le formulaire Web P1
ARRAY TEXT:C222($TbValeurs;0)  // les valeurs récoltées sur le formulaire Web P1
WEB GET VARIABLES:C683($TbNoms;$TbValeurs)
NumLaboActuelA:=WebTrouveValeurParNom ("CodeRaema";->$TbNoms;->$TbValeurs)
MotDePasseActuel:=WebTrouveValeurParNom ("MdP";->$TbNoms;->$TbValeurs)
TestLabo13:=(MotDePasseActuel="FuQPRPqSYE") & (NumLaboActuelA="13")
$UUIDLabo:=ASAPTrouveUUIDLaboParNumero (Num:C11(NumLaboActuelA))
WebInitTraductionsEC 
RaemaInitPUMCampagne 
If (Find in array:C230($TbNoms;"Imag@")<0)  // il n'a pas cliqué sur le drapeau
	LangueCourante:=WebTrouveValeurParNom ("hiddenField";->$TbNoms;->$TbValeurs)  // F pour français et A pour Anglais = champ caché de la P1 
	$Langue:=LangueCourante
	  // testons la validité de tout ça
	If (ResP1Preambule )  // les données ont-elles été correctement renseignées ??
		If (Find in array:C230($TbNoms;"validecode")>0)
			$THTML:=WebEcritHTMLEspaceClient ($UUIDLabo;$Langue)
			  // FIXER TEXTE DANS CONTENEUR($THTML)
			WEB SEND TEXT:C677($THTML)
		End if 
	Else   // Les données ne sont pas correctes
		If (LangueCourante="F")
			TitrePage:="Erreur de saisie"
			WEB SEND FILE:C619("DlgErreurDataFr.shtml")
		Else 
			TitrePage:="Imput error"
			WEB SEND FILE:C619("DlgErreurDataEn.shtml")
		End if 
	End if 
Else 
	If (TbValeurs{3}="F")
		WEB SEND FILE:C619("saisieraema.shtml")
	Else 
		WEB SEND FILE:C619("saisieraemaA.shtml")
	End if 
End if 