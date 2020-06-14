//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/06/18, 08:31:37
  // ----------------------------------------------------
  // Méthode : ASAPSurValidationSaisieAdh
  // Description
  // Méthode appelée lors de la validation 
  //   d'un enregistrement de [Personnes]
  // ----------------------------------------------------


C_LONGINT:C283($Salé;$Fumé;$FT)

If (NouveauAdh)
	DerNumPersonne:=VarNumPersonne
End if 
  // Le nom du contact
OB SET:C1220([Personnes:12]Arguments:7;"NomContact";VarNomContact)

  // Gestion des adresses mail qui sont dans [Personnes]Arguments (EMail, EmailRAEMA, EmailCompta
OB REMOVE:C1226([Personnes:12]Arguments:7;"EMail")
OB REMOVE:C1226([Personnes:12]Arguments:7;"EMailBis")

$FT:=Size of array:C274(TbMails)
$MailInfo:=""
$MailRapport:=""
$MailCompta:=""
For ($Salé;1;$FT)
	$MailCourant:=TbMails{$Salé}
	$MailInfo:=$MailInfo+","+$MailCourant
End for 
  //TbPerMel{LigneClic}:=""
If (Length:C16($MailInfo)>0)
	OB SET:C1220([Personnes:12]Arguments:7;"EMail";Substring:C12($MailInfo;2))
	  //TbPerMel{LigneClic}:=Sous chaîne($Mailinfo;2)  // actualisation du TbPerMel
End if 


  //TbPerAdr{LigneClic}:=[PersonnesAdresses]CodePostal+"-"+[PersonnesAdresses]Ville
  //TbPerPay{LigneClic}:=[PersonnesAdresses]Pays

  // Enregistrement des données modifiées d'adresses
$H1:=Milliseconds:C459
SAVE RECORD:C53([PersonnesAdresses:11])
If (Macintosh command down:C546)
	ASAPFabriqueTbParticipe 
End if 

  // Courriels
  // Paramétrage du texte brut
$MailTexteBrutB:=(BaCMailTexteBrut=1)
OB SET:C1220([Personnes:12]Arguments:7;"MailTexteBrut";$MailTexteBrutB)


  // Actualisation de [Personnes]ChampRecherche
[Personnes:12]ChampRecherche:6:=ASAPPerCreationChampRecherche 
$H2:=Milliseconds:C459
  // ALERTE(Chaîne($H2-$H1))
<>ActualiseTbPersonne:=True:C214