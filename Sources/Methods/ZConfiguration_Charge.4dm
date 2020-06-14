//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 04/05/18, 14:17:11
  // ----------------------------------------------------
  // Pas de paramètres 
  // ----------------------------------------------------
  // Méthode : Configuration_Charge
  // Description
  //  Charge les paramètres de configuration à afficher dans le formulaire
  //  et attribut chacune des valeurs aux variables / objets dédiés
  // Tout ajout de variables globales a un impact sur les méthodes :
  // - ZConfiguration_Annule
  // - ZConfiguration_MAJ_EnCours


C_LONGINT:C283($Pos)
C_PICTURE:C286($logo)

ARRAY TEXT:C222($TbAccount;1)
ARRAY TEXT:C222($TbDescription;1)
ARRAY TEXT:C222($TbEmail;1)
ARRAY TEXT:C222($TbUsername;1)
ARRAY TEXT:C222($TbPassword;1)
ARRAY TEXT:C222($TbPOPHost;1)
ARRAY TEXT:C222($TbSMTPHost;1)
ARRAY LONGINT:C221($TbPOP;1)
ARRAY LONGINT:C221($TbComptePrincipal;1)
ARRAY LONGINT:C221($TbSSL;1)
ARRAY LONGINT:C221($TbKeepOnServer;1)
ARRAY LONGINT:C221($TbVerifPeriodique;1)
ARRAY LONGINT:C221($TbPOP_Port;1)
ARRAY LONGINT:C221($TbSMTP_Port;1)
$TbComptePrincipal{1}:=1  // Pour définir entant que compte principal

$Pos:=1
ZObjet_Set_Num ("indice";$Pos)


  // Récupère tous les comptes mails
OB GET ARRAY:C1229(Form:C1466;"TbAccount";$TbAccount)
OB GET ARRAY:C1229(Form:C1466;"TbDescription";$TbDescription)
OB GET ARRAY:C1229(Form:C1466;"TbEmail";$TbEmail)
OB GET ARRAY:C1229(Form:C1466;"TbUsername";$TbUsername)
OB GET ARRAY:C1229(Form:C1466;"TbPassword";$TbPassword)
OB GET ARRAY:C1229(Form:C1466;"TbPOPHost";$TbPOPHost)
OB GET ARRAY:C1229(Form:C1466;"TbSMTPHost";$TbSMTPHost)
OB GET ARRAY:C1229(Form:C1466;"TbPOP";$TbPOP)
OB GET ARRAY:C1229(Form:C1466;"TbComptePrincipal";$TbComptePrincipal)
OB GET ARRAY:C1229(Form:C1466;"TbSSL";$TbSSL)
OB GET ARRAY:C1229(Form:C1466;"TbKeepOnServer";$TbKeepOnServer)
OB GET ARRAY:C1229(Form:C1466;"TbVerifPeriodique";$TbVerifPeriodique)
OB GET ARRAY:C1229(Form:C1466;"TbPOP_Port";$TbPOP_Port)
OB GET ARRAY:C1229(Form:C1466;"TbSMTP_Port";$TbSMTP_Port)

  // Cherche le compte principal
$Pos:=Find in array:C230($TbComptePrincipal;1)  // $Pos = indice de tableau de tous les paramètres

If ($Pos=-1)  // Il n'y a plus de compte principal. Il a du être supprimé.
	  //  Prenons le premier et mettons à jour la fiche
	$Pos:=1
	$TbComptePrincipal{$Pos}:=1
	OB SET ARRAY:C1227(Form:C1466;"TbComptePrincipal";$TbComptePrincipal)
	
	READ WRITE:C146([XData:1])
	QUERY:C277([XData:1];[XData:1]XType:3="Configuration";*)
	QUERY:C277([XData:1]; & [XData:1]XNom:2="Configuration")
	[XData:1]XObjet:18:=OB Copy:C1225(Form:C1466)
	SAVE RECORD:C53([XData:1])
	ZAmnistiePartielle (->[XData:1])
	
End if 


  // ----- Affichage des informations
  // ----------------------------------

  // ---- Param Généraux
ZObjet_Set_Info ("Nom";OB Get:C1224(Form:C1466;"desc_nom";Est un texte:K8:3))
ZObjet_Set_Info ("Adresse1";OB Get:C1224(Form:C1466;"desc_adresse1";Est un texte:K8:3))
ZObjet_Set_Info ("Adresse2";OB Get:C1224(Form:C1466;"desc_adresse2";Est un texte:K8:3))
ZObjet_Set_Info ("CP";OB Get:C1224(Form:C1466;"desc_cp";Est un texte:K8:3))
ZObjet_Set_Info ("Ville";OB Get:C1224(Form:C1466;"desc_ville";Est un texte:K8:3))
ZObjet_Set_Info ("Telephone";OB Get:C1224(Form:C1466;"desc_telephone";Est un texte:K8:3))
ZObjet_Set_Info ("FAX";OB Get:C1224(Form:C1466;"desc_fax";Est un texte:K8:3))
ZObjet_Set_Info ("Email_adresse";OB Get:C1224(Form:C1466;"desc_email";Est un texte:K8:3))
ZObjet_Set_Info ("Website";OB Get:C1224(Form:C1466;"desc_website";Est un texte:K8:3))
ZObjet_Set_Info ("SIRET";OB Get:C1224(Form:C1466;"desc_siret";Est un texte:K8:3))
ZObjet_Set_Info ("SIREN";OB Get:C1224(Form:C1466;"desc_siren";Est un texte:K8:3))
ZObjet_Set_Info ("APE";OB Get:C1224(Form:C1466;"desc_ape";Est un texte:K8:3))
ZObjet_Set_Info ("NumIntraComm";OB Get:C1224(Form:C1466;"desc_intracommunautaire";Est un texte:K8:3))

  //  Récupération du logo, s'il existe
QUERY:C277([XData:1];[XData:1]XType:3="Configuration";*)
QUERY:C277([XData:1]; & [XData:1]XNom:2="Logo")
If (Records in selection:C76([XData:1])=1)
	$logo:=[XData:1]XImage:11
End if 
(OBJECT Get pointer:C1124(Objet nommé:K67:5;"Logo"))->:=$logo


  // ---- Param Mails

ZObjet_Set_Num ("indice";$Pos)  // Pour s'en souvenir dans le formulaire

ZObjet_Set_Info ("Account_Name_t";$TbAccount{$Pos})
ZObjet_Set_Info ("Description_t";$TbDescription{$Pos})
ZObjet_Set_Info ("Email_Address_t";$TbEmail{$Pos})
ZObjet_Set_Info ("Username_t";$TbUsername{$Pos})
ZObjet_Set_Info ("Password_t";$TbPassword{$Pos})
ZObjet_Set_Info ("POP_Host";$TbPOPHost{$Pos})
ZObjet_Set_Info ("SMTP_Host_t";$TbSMTPHost{$Pos})
ZObjet_Set_Num ("rb_POP";$TbPOP{$Pos})
ZObjet_Set_Num ("rb_IMAP";Choose:C955($TbPOP{$Pos}=0;1;0))
ZObjet_Set_Num ("SMTP_Port_l";$TbSMTP_Port{$Pos})
ZObjet_Set_Num ("POP_Port";$TbPOP_Port{$Pos})
ZObjet_Set_Num ("CptPrincipal";$TbComptePrincipal{$Pos})
ZObjet_Set_Num ("SSL_b";$TbSSL{$Pos})
ZObjet_Set_Num ("MailServeur";$TbKeepOnServer{$Pos})
ZObjet_Set_Num ("SMTP_Verify_Every";$TbVerifPeriodique{$Pos})

ZObjet_Set_Info ("ChoixCompteMail";$TbAccount{$Pos})
OBJECT SET ENABLED:C1123(*;"CTM_MailMoins";(Size of array:C274($TbAccount)>1))


  // ---- Param Sécurité

<>ZPermDuréeInactif:=OB Get:C1224(Form:C1466;"sec_inactivité";Est un entier long:K8:6)
ZObjet_Set_Info ("CheminCloud";OB Get:C1224(Form:C1466;"sec_cloud";Est un texte:K8:3))
ZObjet_Set_Info ("MdpCloud";OB Get:C1224(Form:C1466;"sec_password_cloud";Est un texte:K8:3))
ZObjet_Set_Info ("De";OB Get:C1224(Form:C1466;"sec_de";Est un texte:K8:3))
ZObjet_Set_Info ("A";OB Get:C1224(Form:C1466;"sec_a";Est un texte:K8:3))
ZObjet_Set_Num ("verrou";0)  // Verrou
OBJECT SET ENTERABLE:C238(*;"CheminCloud";False:C215)

<>ZNews:=(OB Get:C1224(Form:C1466;"option_news";Est un entier long:K8:6)=1)
<>ZNewsActifs:=(OB Get:C1224(Form:C1466;"option_news_actifs";Est un entier long:K8:6)=1)
ZObjet_Set_Num ("News_Delais";OB Get:C1224(Form:C1466;"option_news_delais";Est un entier long:K8:6))

OBJECT SET VISIBLE:C603(*;"@2";<>ZNewsActifs)
