//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 05/05/18, 08:12:23
  // ----------------------------------------------------
  // Pas de paramètres
  // ----------------------------------------------------
  // Méthode : Configure_ListeCompteMail
  // Description
  //  

Case of 
		
	: (Form event code:C388=Sur clic:K2:4)
		
		  // Construction du menu contextuel
		C_OBJECT:C1216($Config)
		C_TEXT:C284($Liste)
		C_LONGINT:C283($Pos)
		
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
		OB GET ARRAY:C1229($Config;"TbSSL";$TbSSL)
		OB GET ARRAY:C1229($Config;"TbKeepOnServer";$TbKeepOnServer)
		OB GET ARRAY:C1229($Config;"TbVerifPeriodique";$TbVerifPeriodique)
		OB GET ARRAY:C1229($Config;"TbPOP_Port";$TbPOP_Port)
		OB GET ARRAY:C1229($Config;"TbSMTP_Port";$TbSMTP_Port)
		
		
		  // Construction de la liste
		$Liste:=""
		For ($Pos;1;Size of array:C274($TbAccount))
			$Liste:=$liste+$TbAccount{$Pos}
			If ($Pos<Size of array:C274($TbAccount))
				$Liste:=$Liste+";"+Char:C90(1)
			End if 
		End for 
		
		  //  // Affichons le pop up
		$Pos:=Pop up menu:C542($Liste)
		
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
		
		
End case 