//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 04/05/18, 22:24:57
  // ----------------------------------------------------
  // Pas de paramètres
  // ----------------------------------------------------
  // Méthode : Configuration_MAJ_EnCours
  // Description
  //  Mets à jour la "variable" objet à chaque modification

  // On parse l'ensemble des variables pour mettre à jour l'objet EnCours

C_TEXT:C284($Old;$New)

  //Form:=(OBJET Lire pointeur(Objet nommé;"EnCours"))->

  // ---- Param Généraux
OB SET:C1220(Form:C1466;"desc_nom";ZObjet_Get_Info ("Nom"))
OB SET:C1220(Form:C1466;"desc_adresse1";ZObjet_Get_Info ("Adresse1"))
OB SET:C1220(Form:C1466;"desc_adresse2";ZObjet_Get_Info ("Adresse2"))
OB SET:C1220(Form:C1466;"desc_cp";ZObjet_Get_Info ("CP"))
OB SET:C1220(Form:C1466;"desc_ville";ZObjet_Get_Info ("Ville"))
OB SET:C1220(Form:C1466;"desc_telephone";ZObjet_Get_Info ("Telephone"))
OB SET:C1220(Form:C1466;"desc_fax";ZObjet_Get_Info ("FAX"))
OB SET:C1220(Form:C1466;"desc_email";ZObjet_Get_Info ("Email_adresse"))
OB SET:C1220(Form:C1466;"desc_website";ZObjet_Get_Info ("Website"))
OB SET:C1220(Form:C1466;"desc_siret";ZObjet_Get_Info ("SIRET"))
OB SET:C1220(Form:C1466;"desc_siren";ZObjet_Get_Info ("SIREN"))
OB SET:C1220(Form:C1466;"desc_ape";ZObjet_Get_Info ("APE"))
OB SET:C1220(Form:C1466;"desc_intracommunautaire";ZObjet_Get_Info ("NumIntraComm"))

  // ---- Définition des titres




  // ---- Paramètres de sauvegarde






  // ---- Mail
  // Lecture des tableaux
ARRAY TEXT:C222($TbAccount;0x0000)
ARRAY TEXT:C222($TbDescription;0x0000)
ARRAY TEXT:C222($TbEmail;0x0000)
ARRAY TEXT:C222($TbUsername;0x0000)
ARRAY TEXT:C222($TbPassword;0x0000)
ARRAY TEXT:C222($TbPOPHost;0x0000)
ARRAY TEXT:C222($TbSMTPHost;0x0000)
ARRAY LONGINT:C221($TbPOP;0x0000)
ARRAY LONGINT:C221($TbComptePrincipal;0x0000)
ARRAY LONGINT:C221($TbSSL;0x0000)
ARRAY LONGINT:C221($TbKeepOnServer;0x0000)
ARRAY LONGINT:C221($TbVerifPeriodique;0x0000)
ARRAY LONGINT:C221($TbPOP_Port;0x0000)
ARRAY LONGINT:C221($TbSMTP_Port;0x0000)

OB GET ARRAY:C1229(Form:C1466;"TbAccount";$TbAccount)
OB GET ARRAY:C1229(Form:C1466;"TbDescription";$TbDescription)
OB GET ARRAY:C1229(Form:C1466;"TbEmail";$TbEmail)
OB GET ARRAY:C1229(Form:C1466;"TbUsername";$TbUsername)
OB GET ARRAY:C1229(Form:C1466;"TbPassword";$TbPassword)
OB GET ARRAY:C1229(Form:C1466;"TbPOPHost";$TbPOPHost)
OB GET ARRAY:C1229(Form:C1466;"TbSMTPHost";$TbSMTPHost)
OB GET ARRAY:C1229(Form:C1466;"TbPOP";$TbPOP)
OB GET ARRAY:C1229(Form:C1466;"TbComptePrincipal";$TbComptePrincipal)
OB GET ARRAY:C1229(Form:C1466;"TbKeepOnServer";$TbKeepOnServer)
OB GET ARRAY:C1229(Form:C1466;"TbVerifPeriodique";$TbVerifPeriodique)
OB GET ARRAY:C1229(Form:C1466;"TbPOP_Port";$TbPOP_Port)
OB GET ARRAY:C1229(Form:C1466;"TbSMTP_Port";$TbSMTP_Port)
OB GET ARRAY:C1229(Form:C1466;"TbSSL";$TbSSL)

  // Assignation des nouvelles valeurs
$Indice:=ZObjet_Get_Num ("Indice")

$TbAccount{$Indice}:=ZObjet_Get_Info ("Account_Name_t")
$TbDescription{$Indice}:=ZObjet_Get_Info ("Description_t")
$TbEmail{$Indice}:=ZObjet_Get_Info ("Email_Address_t")
$TbUsername{$Indice}:=ZObjet_Get_Info ("Username_t")
$TbPassword{$Indice}:=ZObjet_Get_Info ("Password_t")
$TbPOPHost{$Indice}:=ZObjet_Get_Info ("POP_Host")
$TbSMTPHost{$Indice}:=ZObjet_Get_Info ("SMTP_Host_t")
$TbPOP{$Indice}:=ZObjet_Get_Num ("rb_POP")
$TbComptePrincipal{$Indice}:=ZObjet_Get_Num ("CptPrincipal")
$TbKeepOnServer{$Indice}:=ZObjet_Get_Num ("MailServeur")
$TbVerifPeriodique{$Indice}:=ZObjet_Get_Num ("SMTP_Verify_Every")
$TbPOP_Port{$Indice}:=ZObjet_Get_Num ("POP_Port")
$TbSMTP_Port{$Indice}:=ZObjet_Get_Num ("SMTP_Port_l")
$TbSSL{$Indice}:=ZObjet_Get_Num ("SSL_b")

  // Verification de l'unicité du compte principal
$n:=Count in array:C907($TbComptePrincipal;1)

If ($n>1)  // Il y en a plus qu'un
	For ($a;1;Size of array:C274($TbComptePrincipal))
		If ($a#$Indice)
			$TbComptePrincipal{$a}:=0
		End if 
	End for 
End if 


  // Réattribution des tableaux dans l'objet
OB SET ARRAY:C1227(Form:C1466;"TbAccount";$TbAccount)
OB SET ARRAY:C1227(Form:C1466;"TbDescription";$TbDescription)
OB SET ARRAY:C1227(Form:C1466;"TbEmail";$TbEmail)
OB SET ARRAY:C1227(Form:C1466;"TbUsername";$TbUsername)
OB SET ARRAY:C1227(Form:C1466;"TbPassword";$TbPassword)
OB SET ARRAY:C1227(Form:C1466;"TbPOPHost";$TbPOPHost)
OB SET ARRAY:C1227(Form:C1466;"TbSMTPHost";$TbSMTPHost)
OB SET ARRAY:C1227(Form:C1466;"TbPOP";$TbPOP)
OB SET ARRAY:C1227(Form:C1466;"TbComptePrincipal";$TbComptePrincipal)
OB SET ARRAY:C1227(Form:C1466;"TbSSL";$TbSSL)
OB SET ARRAY:C1227(Form:C1466;"TbKeepOnServer";$TbKeepOnServer)
OB SET ARRAY:C1227(Form:C1466;"TbVerifPeriodique";$TbVerifPeriodique)
OB SET ARRAY:C1227(Form:C1466;"TbPOP_Port";$TbPOP_Port)
OB SET ARRAY:C1227(Form:C1466;"TbSMTP_Port";$TbSMTP_Port)

  // ---- Sécurité
OB SET:C1220(Form:C1466;"sec_inactivité";<>ZPermDuréeInactif)
OB SET:C1220(Form:C1466;"sec_password_cloud";ZObjet_Get_Info ("MdpCloud"))
OB SET:C1220(Form:C1466;"sec_de";ZObjet_Get_Info ("De"))
OB SET:C1220(Form:C1466;"sec_a";ZObjet_Get_Info ("A"))

$Old:=OB Get:C1224(Form:C1466;"sec_cloud";Est un texte:K8:3)
$New:=ZObjet_Get_Info ("CheminCloud")

If ($Old#$New)
	If (OK=1)
		READ WRITE:C146([XData:1])
		QUERY BY FORMULA:C48([XData:1];([XData:1]XType:3="Configuration") & ([XData:1]XNom:2="Configuration"))
		[XData:1]XBool:14:=False:C215
		[XData:1]XEntier:6:=0
		[XData:1]XTexte:9:=$New
		SAVE RECORD:C53([XData:1])
		ZAmnistiePartielle (->[XData:1])
		
		ZConfiguration_TesteCheminCloud   // Test réalisé sur le serveur
		
		QUERY BY FORMULA:C48([XData:1];([XData:1]XType:3="Configuration") & ([XData:1]XNom:2="Configuration"))
		$Statut:=[XData:1]XBool:14
		$ActionRealisée:=[XData:1]XEntier:6
		ZAmnistiePartielle (->[XData:1])
		
		If (($ActionRealisée=1) & ($Statut))  // On conserve le nouveau chemin et on bloque à nouveau le champ
			OB SET:C1220(Form:C1466;"sec_cloud";$New)
			ZObjet_Set_Num ("verrou";0)
			OBJECT SET ENTERABLE:C238(*;"CheminCloud";False:C215)
			(OBJECT Get pointer:C1124(Objet nommé:K67:5;"BtnVerifChemin"))->:=0
		Else 
			ALERT:C41("Le chemin de sauvegarde a été modifié et n'existe pas sur le poste de l'application. Etes vous sur de son exactitude ?")
			ZObjet_Set_Info ("CheminCloud";$Old)
		End if 
		
	End if 
End if 


  // ---- Options
OB SET:C1220(Form:C1466;"option_news";Num:C11(<>ZNews))
OB SET:C1220(Form:C1466;"option_news_actifs";Num:C11(<>ZNewsActifs))
OB SET:C1220(Form:C1466;"option_news_delais";ZObjet_Get_Num ("news_delais"))
