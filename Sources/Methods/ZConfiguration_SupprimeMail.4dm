//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 04/05/18, 20:53:53
  // ----------------------------------------------------
  // Pas de paramètres
  // ----------------------------------------------------
  // Méthode : Configuration_SupprimeMail
  // Description
  //  

C_OBJECT:C1216($Config)
C_LONGINT:C283($Indice)
C_BOOLEAN:C305($Continue)

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

$Config:=(OBJECT Get pointer:C1124(Objet nommé:K67:5;"EnCours"))->

OB GET ARRAY:C1229($Config;"TbAccount";$TbAccount)
OB GET ARRAY:C1229($Config;"TbDescription";$TbDescription)
OB GET ARRAY:C1229($Config;"TbEmail";$TbEmail)
OB GET ARRAY:C1229($Config;"TbUsername";$TbUsername)
OB GET ARRAY:C1229($Config;"TbPassword";$TbPassword)
OB GET ARRAY:C1229($Config;"TbPOPHost";$TbPOPHost)
OB GET ARRAY:C1229($Config;"TbSMTPHost";$TbSMTPHost)
OB GET ARRAY:C1229($Config;"TbPOP";$TbPOP)
OB GET ARRAY:C1229($Config;"TbComptePrincipal";$TbComptePrincipal)
OB GET ARRAY:C1229($Config;"TbKeepOnServer";$TbKeepOnServer)
OB GET ARRAY:C1229($Config;"TbVerifPeriodique";$TbVerifPeriodique)
OB GET ARRAY:C1229($Config;"TbPOP_Port";$TbPOP_Port)
OB GET ARRAY:C1229($Config;"TbSMTP_Port";$TbSMTP_Port)
OB GET ARRAY:C1229($Config;"TbSSL";$TbSSL)

$Indice:=ZObjet_Get_Num ("indice")
If (Size of array:C274($TbAccount)>1)
	
	$Continue:=True:C214
	If ($TbComptePrincipal{$Indice}=1)
		CONFIRM:C162("Vous allez supprimer le compte mail principal.\rEtes-vous sur de vouloir continuez ?")
		$Continue:=(OK=1)
	End if 
	
	If ($Continue)
		DELETE FROM ARRAY:C228($TbAccount;$Indice)
		DELETE FROM ARRAY:C228($TbDescription;$Indice)
		DELETE FROM ARRAY:C228($TbEmail;$Indice)
		DELETE FROM ARRAY:C228($TbUsername;$Indice)
		DELETE FROM ARRAY:C228($TbPassword;$Indice)
		DELETE FROM ARRAY:C228($TbPOPHost;$Indice)
		DELETE FROM ARRAY:C228($TbSMTPHost;$Indice)
		DELETE FROM ARRAY:C228($TbPOP;$Indice)
		DELETE FROM ARRAY:C228($TbComptePrincipal;$Indice)
		DELETE FROM ARRAY:C228($TbKeepOnServer;$Indice)
		DELETE FROM ARRAY:C228($TbVerifPeriodique;$Indice)
		DELETE FROM ARRAY:C228($TbPOP_Port;$Indice)
		DELETE FROM ARRAY:C228($TbSMTP_Port;$Indice)
		DELETE FROM ARRAY:C228($TbSSL;$Indice)
		
		  // Réattribution des tableaux dans l'objet
		OB SET ARRAY:C1227($Config;"TbAccount";$TbAccount)
		OB SET ARRAY:C1227($Config;"TbDescription";$TbDescription)
		OB SET ARRAY:C1227($Config;"TbEmail";$TbEmail)
		OB SET ARRAY:C1227($Config;"TbUsername";$TbUsername)
		OB SET ARRAY:C1227($Config;"TbPassword";$TbPassword)
		OB SET ARRAY:C1227($Config;"TbPOPHost";$TbPOPHost)
		OB SET ARRAY:C1227($Config;"TbSMTPHost";$TbSMTPHost)
		OB SET ARRAY:C1227($Config;"TbPOP";$TbPOP)
		OB SET ARRAY:C1227($Config;"TbComptePrincipal";$TbComptePrincipal)
		OB SET ARRAY:C1227($Config;"TbSSL";$TbSSL)
		OB SET ARRAY:C1227($Config;"TbKeepOnServer";$TbKeepOnServer)
		OB SET ARRAY:C1227($Config;"TbVerifPeriodique";$TbVerifPeriodique)
		OB SET ARRAY:C1227($Config;"TbPOP_Port";$TbPOP_Port)
		OB SET ARRAY:C1227($Config;"TbSMTP_Port";$TbSMTP_Port)
		
		(OBJECT Get pointer:C1124(Objet nommé:K67:5;"EnCours"))->:=$Config
		
		  // Assignation des infos à l'écran
		$Indice:=1
		ZObjet_Set_Num ("indice";$Indice)
		
		ZObjet_Set_Info ("Account_Name_t";$TbAccount{$Indice})
		ZObjet_Set_Info ("Description_t";$TbDescription{$Indice})
		ZObjet_Set_Info ("Email_Address_t";$TbEmail{$Indice})
		ZObjet_Set_Info ("Username_t";$TbUsername{$Indice})
		ZObjet_Set_Info ("Password_t";$TbPassword{$Indice})
		ZObjet_Set_Info ("POP_Host";$TbPOPHost{$Indice})
		ZObjet_Set_Info ("SMTP_Host_t";$TbSMTPHost{$Indice})
		ZObjet_Set_Num ("rb_POP";$TbPOP{$Indice})
		ZObjet_Set_Num ("rb_IMAP";Choose:C955($TbPOP{$Indice}=0;1;0))
		ZObjet_Set_Num ("SMTP_Port_l";$TbSMTP_Port{$Indice})
		ZObjet_Set_Num ("POP_Port";$TbPOP_Port{$Indice})
		ZObjet_Set_Num ("CptPrincipal";$TbComptePrincipal{$Indice})
		ZObjet_Set_Num ("SSL_b";$TbSSL{$Indice})
		ZObjet_Set_Num ("MailServeur";$TbKeepOnServer{$Indice})
		ZObjet_Set_Num ("SMTP_Verify_Every";$TbVerifPeriodique{$Indice})
		
		ZObjet_Set_Info ("ChoixCompteMail";$TbAccount{$Indice})
		
	End if 
	
	OBJECT SET ENABLED:C1123(*;"CTM_MailMoins";(Size of array:C274($TbAccount)>1))
End if 