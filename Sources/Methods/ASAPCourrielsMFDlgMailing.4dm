//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 13/01/19, 06:57:49
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPCourrielsMFDlgMailing
  // Description
  //   // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 22/12/16, 05:39:13
  // ----------------------------------------------------
  // Méthode : ZMFDlgMailings
  // Description
  // MF du dialogue "DlgMailing"
  //  appelé soit par [Personnes] soit par [Factures]
  // ----------------------------------------------------



$evt:=Form event code:C388

Case of 
		
	: ($evt=Sur chargement:K2:1)
		C_OBJECT:C1216(ObjetFAM)
		CREATE SET:C116(ZPtTable->;"AvantEdition")  // Conservation de la sélection courante de la table de travail
		  // Détermination de la table de travail
		RESOLVE POINTER:C394(ZPtTable;$Var;$NumTable;$NumChamp)
		MailAdherent:=($NumTable=12)  // si vrai la table d'appel est [Adhérents]
		ZVarCom:=""  // le commentaire du courriel
		ZVarDatLet:=Current date:C33
		OBJECT SET VISIBLE:C603(*;"@CourrielsPJ";Macintosh command down:C546)
		VarTailleMax:=3
		
		ASAPCourrielsAfficheCT   // selection et affichage des courriers-types
		
		If (MailAdherent=False:C215)
			CREATE SELECTION FROM ARRAY:C640([Factures:15];TbNumEnr)
			RELATE ONE SELECTION:C349([Factures:15];[Personnes:12])
		Else 
			CREATE SELECTION FROM ARRAY:C640([Personnes:12];TbNumEnr)
			ZViderSelectionCourante (->[Factures:15])
		End if 
		
		
		ASAPCourrielsTbDestinataires 
		LISTBOX SELECT ROW:C912(*;"DestLBCourrielAdh";0;lk supprimer de sélection:K53:3)
		VarAdresse:=""
		
		  // Visibilité des Zones de texte et du bouton d'envoi
		$PtrRichTextArea:=OBJECT Get pointer:C1124(Objet nommé:K67:5;"RTA_Text")
		$PtrRichTextArea1:=OBJECT Get pointer:C1124(Objet nommé:K67:5;"RTA_Text1")
		OBJECT SET VISIBLE:C603(*;"RTA_Text";True:C214)
		OBJECT SET VISIBLE:C603(*;"RTA_Text1";False:C215)
		OBJECT SET VISIBLE:C603(LeMessageBrut;False:C215)
		OBJECT SET VISIBLE:C603(*;"BouEnvoi";False:C215)
		
		  // les PJ au courriel envoyé
		ARRAY TEXT:C222(TbCourrielsCDPJ;0)
		ARRAY TEXT:C222(TbCourrielsNomPJ;0)
		OBJECT SET VISIBLE:C603(*;"BouMoinsPJ";False:C215)
		
		
		  // les tableaux de valeurs pour le Mailing
		ARRAY TEXT:C222(TbValeursCourrielChamp;0)
		ARRAY TEXT:C222(TbTableCourriel;0)
		ARRAY TEXT:C222(TbContexteCourriel;0)
		ARRAY TEXT:C222(TbExpressionsCourriel;0)
		QUERY:C277([XData:1];[XData:1]XNom:2="Champs pour Courriels-types";*)
		QUERY:C277([XData:1]; & [XData:1]XType:3="ChampsCourrielsTypes")
		OB GET ARRAY:C1229([XData:1]XObjet:18;"Intitulé";TbValeursCourrielChamp)
		OB GET ARRAY:C1229([XData:1]XObjet:18;"Table";TbTableCourriel)
		OB GET ARRAY:C1229([XData:1]XObjet:18;"Contexte";TbContexteCourriel)
		OB GET ARRAY:C1229([XData:1]XObjet:18;"Expression";TbExpressionsCourriel)
		  // Variable de changement de forme
		ModifForme:=False:C215
		
		QUERY:C277([XData:1];[XData:1]XNom:2="Données courriel";*)
		QUERY:C277([XData:1]; & [XData:1]XType:3="MWb")
		NumEnrXDataCourriel:=Record number:C243([XData:1])
		
	: (ModifForme)
		ZVerrouAttendre (->[CourrielsTypes:28])
		$PtrRichTextArea:=OBJECT Get pointer:C1124(Objet nommé:K67:5;"RTA_Text")
		[CourrielsTypes:28]TexteType:5:=$PtrRichTextArea->
		SAVE RECORD:C53([CourrielsTypes:28])
		ZAmnistiePartielle (->[CourrielsTypes:28];True:C214)
		ModifForme:=False:C215
		
	: ($evt=Sur libération:K2:2)
		USE SET:C118("AvantEdition")
		
End case 
