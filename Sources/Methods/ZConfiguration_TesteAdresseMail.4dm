//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 04/05/18, 20:07:25
  // ----------------------------------------------------
  // Pas de Paramètres
  // ----------------------------------------------------
  // Méthode : ML_Configure_Host
  // Description
  // Adresse de manière automatique les paramètres des fournisseurs d'accès déclarés
  // La méthode peut être modifiée de manière à intégrer de nouveaux fournisseurs


Case of 
		
	: (Form event code:C388=Sur perte focus:K2:8)
		
		  // Test de l'adresse Email saisie
		
		$AdresseEmail:=(OBJECT Get pointer:C1124(Objet nommé:K67:5;"Email_Address_t"))->
		ZCapitaliseChamp (->$AdresseEmail;False:C215)
		
		If ((Not:C34(ZfCheck_Email ($AdresseEmail)) & ($AdresseEmail#"")))
			ALERT:C41("Adresse mail non valide.\nVérifier votre saisie.")
			GOTO OBJECT:C206(*;"Email_Address_t")
			OBJECT SET VISIBLE:C603(*;"checkOK_Email";False:C215)
			
		Else 
			OBJECT SET VISIBLE:C603(*;"checkOK_Email";True:C214)
			
			ZObjet_Set_Num ("SSL_b";1)
			ZObjet_Set_Num ("rb_pop";0)
			ZObjet_Set_Num ("rb_imap";1)
			
			  // Ajouter autres fournisseurs dans le Au cas où
			
			Case of 
				: (Match regex:C1019("(.*)@gmail.com";$AdresseEmail))
					ZObjet_Set_Info ("Username_t";Replace string:C233($AdresseEmail;"@gmail.com";""))
					ZObjet_Set_Info ("SMTP_Host_t";"smtp.gmail.com")
					ZObjet_Set_Info ("POP_Host";"imap.gmail.com")  // Plus raPide que POP
					ZObjet_Set_Num ("SMTP_Port_l";465)  // 25 en standard
					ZObjet_Set_Num ("POP_Port";993)  // 143 en sTandrad et 995 / 110 pour POP
					
				: (Match regex:C1019("(.*)@outlook.com";$AdresseEmail))
					ZObjet_Set_Info ("Username_t";Replace string:C233($AdresseEmail;"@outlook.com";""))
					ZObjet_Set_Info ("SMTP_Host_t";"smtp-mail.outlook.com")
					ZObjet_Set_Info ("POP_Host";"imap-mail.outlook.com")  // Plus raPide que POP
					ZObjet_Set_Num ("SMTP_Port_l";587)  // 25 en sTandard
					ZObjet_Set_Num ("POP_Port";993)  // 143 en sTandrad et 995 / 110 pour POP
					
					
				: (Match regex:C1019("(.*)@yahoo.com";$AdresseEmail)) | (Match regex:C1019("(.*)@yahoo.fr";$AdresseEmail)) | (Match regex:C1019("(.*)@yahoo.de";$AdresseEmail))
					ZObjet_Set_Info ("Username_t";Replace string:C233($AdresseEmail;"@yahoo.com";""))
					ZObjet_Set_Info ("Username_t";Replace string:C233($AdresseEmail;"@yahoo.fr";""))
					ZObjet_Set_Info ("Username_t";Replace string:C233($AdresseEmail;"@yahoo.de";""))
					ZObjet_Set_Info ("SMTP_Host_t";"smtp.mail.yahoo.com")
					ZObjet_Set_Info ("POP_Host";"imap.mail.yahoo.com")
					ZObjet_Set_Num ("SMTP_Port_l";465)
					ZObjet_Set_Num ("POP_Port";993)
					
					
				: (Match regex:C1019("(.*)@hotmail.com";$AdresseEmail)) | (Match regex:C1019("(.*)@live.com";$AdresseEmail)) | (Match regex:C1019("(.*)@outlook.com";$AdresseEmail))
					ZObjet_Set_Info ("Username_t";Replace string:C233($AdresseEmail;"@outlook.com";""))
					ZObjet_Set_Info ("Username_t";Replace string:C233($AdresseEmail;"@live.com";""))
					ZObjet_Set_Info ("Username_t";Replace string:C233($AdresseEmail;"@hotmail.com";""))
					ZObjet_Set_Info ("SMTP_Host_t";"smtp.live.com")
					ZObjet_Set_Info ("POP_Host";"pop.live.com")
					ZObjet_Set_Num ("SMTP_Port_l";587)
					ZObjet_Set_Num ("POP_Port";995)
					ZObjet_Set_Num ("rb_pop";1)
					ZObjet_Set_Num ("rb_imap";0)
					
				Else   // PreNots la définition des ports sTandard POP3
					ZObjet_Set_Num ("SMTP_Port_l";25)
					ZObjet_Set_Num ("POP_Port";110)
					
			End case 
			
			ZObjet_Set_Num ("SMTP_Verify_Every";15)
			
		End if 
		
End case 