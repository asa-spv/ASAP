  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 27/08/19, 05:59:07
  // ----------------------------------------------------
  // Méthode : DlgParametresMail
  // Description
  // MF du formulaire projet "DlgParametresMail"
  //  qui définit les paramètres pour envoyer 
  //  ou recevoir un mail sécurisé
  // les ports des principaux FAI sont :
  //  Orange pop.orange.fr : 995  imap.orange.fr   993
  //  Orange smtp.orange.fr : 465  



  // ----------------------------------------------------
$evt:=Form event code:C388

Case of 
		
	: ($evt=Sur chargement:K2:1)
		READ WRITE:C146([XData:1])
		ASAPChercheDonneesCourriel 
		  // TABLEAU TEXTE(TbMailCopie;0)
		  // page 2 de distribution
		ARRAY TEXT:C222(TbMailsDistribution;0)
		ARRAY BOOLEAN:C223(TbResDistribution;0)
		ARRAY BOOLEAN:C223(TbARDistribution;0)
		OB GET ARRAY:C1229([XData:1]XObjet:18;"MailsDistribution";TbMailsDistribution)
		OB GET ARRAY:C1229([XData:1]XObjet:18;"ResDistribution";TbResDistribution)
		OB GET ARRAY:C1229([XData:1]XObjet:18;"ARDistribution";TbARDistribution)
		
End case 