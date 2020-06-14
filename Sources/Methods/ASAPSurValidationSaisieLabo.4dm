//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/06/18, 08:31:37
  // ----------------------------------------------------
  // Méthode : ASAPSurValidationSaisieLabo
  // Description
  // Méthode appelée lors de la validation 
  //   d'un enregistrement de [Personnes]
  // ----------------------------------------------------


C_LONGINT:C283($Salé;$Fumé;$FT)

C_OBJECT:C1216(VarObjetDescriptifFinal)
  // Vidage de l'objet
OB GET PROPERTY NAMES:C1232(VarObjetDescriptifFinal;$TbNomX)
$FT:=Size of array:C274($TbNomX)
For ($Salé;1;$FT)
	OB REMOVE:C1226(VarObjetDescriptifFinal;$TbNomX{$Salé})
End for 


If (NouveauLabo)  // actualisation des tableaux des N° d'dhérent et de RAEMA
	DerNumPersonne:=VarNumAdhérent
	DerNumRAEMA:=VarNumLaboRAEMA
End if 

  // les téléphones et fax
OB SET:C1220([Personnes:12]Arguments:7;"PhonePro";VarPhoneF)
OB SET:C1220([Personnes:12]Arguments:7;"Portable";VarPhoneP)
OB SET:C1220([Personnes:12]Arguments:7;"FaxPro";VarFax)

  // Le nom du contact
OB SET:C1220([Personnes:12]Arguments:7;"NomContact";VarNomContact)

  // Le n° EORI 
OB SET:C1220([Personnes:12]Arguments:7;"EORI";VarEORI)

  // Gestion des adresses mail qui sont dans [Personnes]Arguments (EMail, EmailRAEMA, EmailCompta
OB REMOVE:C1226([Personnes:12]Arguments:7;"EMail")
OB REMOVE:C1226([Personnes:12]Arguments:7;"EmailRAEMA")
OB REMOVE:C1226([Personnes:12]Arguments:7;"EmailCompta")

$FT:=Size of array:C274(TbMails)
$MailInfo:=""
$MailRapport:=""
$MailCompta:=""
For ($Salé;1;$FT)
	$MailCourant:=TbMails{$Salé}
	If (TbMailInfo{$Salé})
		$MailInfo:=$MailInfo+","+$MailCourant
	End if 
	If (TbMailRapport{$Salé})
		$MailRapport:=$MailRapport+","+$MailCourant
	End if 
	If (TbMailCompta{$Salé})
		$MailCompta:=$MailCompta+","+$MailCourant
	End if 
End for 
  // TbPerMel{LigneClic}:=""
If (Length:C16($MailInfo)>0)
	OB SET:C1220([Personnes:12]Arguments:7;"EMail";Substring:C12($MailInfo;2))
	  // TbPerMel{LigneClic}:=Sous chaîne($Mailinfo;2)  // actualisation du TbPerMel
End if 
If (Length:C16($MailRapport)>0)
	OB SET:C1220([Personnes:12]Arguments:7;"EmailRAEMA";Substring:C12($MailRapport;2))
	  //Si (TbPerMel{LigneClic}="")
	  // TbPerMel{LigneClic}:=Remplacer chaîne($MailRapport;",";"")  // actualisation du TbPerMel
	  //Fin de si 
End if 
If (Length:C16($MailCompta)>0)
	OB SET:C1220([Personnes:12]Arguments:7;"EmailCompta";Substring:C12($MailCompta;2))
	  //Si (TbPerMel{LigneClic}="")
	  // TbPerMel{LigneClic}:=Remplacer chaîne($MailCompta;",";"")  // actualisation du TbPerMel
	  //Fin de si 
End if 

  //TbPerAdr{LigneClic}:=[PersonnesAdresses]CodePostal+"-"+[PersonnesAdresses]Ville
  //TbPerPay{LigneClic}:=[PersonnesAdresses]Pays

  // Enregistrement des données modifiées d'adresses
$H1:=Milliseconds:C459
SAVE RECORD:C53([PersonnesAdresses:11])
$L:=Find in array:C230(TbPerNum;VarNumLabo)  // ligne dernièrement sélectionnée dans le tableau de [Personnes];"SaisieLabo"
TbPerAdr{$L}:=[PersonnesAdresses:11]CodePostal:6+" - "+[PersonnesAdresses:11]Ville:7
$Pays:=[PersonnesAdresses:11]Pays:8
If (OnAChangéParticipation)
	$Prc:=Execute on server:C373("ASAPFabriqueTbParticipations";0)
	OnAChangéParticipation:=False:C215
End if 

  // Courriels
  // Paramétrage du texte brut
$MailTexteBrutB:=(BaCMailTexteBrut=1)
OB SET:C1220([Personnes:12]Arguments:7;"MailTexteBrut";$MailTexteBrutB)


  // Actualisation de [Personnes]ChampRecherche
[Personnes:12]ChampRecherche:6:=ASAPPerCreationChampRecherche 
$H2:=Milliseconds:C459
  // ALERTE(Chaîne($H2-$H1))

If (NouveauLabo=False:C215)
	ASAPLaboObjetDescriptifFabrique (->VarObjetDescriptifFinal)
	$TexteComparaison:=ASAPLaboObjetDescriptifCompare 
	If ($TexteComparaison)
		QUERY:C277([PersonnesModifications:29];[PersonnesModifications:29]UUIDPersonne:2=[Personnes:12]UUID:1)
		$NumVersion:=Records in selection:C76([PersonnesModifications:29])+1
		CREATE RECORD:C68([PersonnesModifications:29])
		[PersonnesModifications:29]DateModification:3:=Current date:C33
		[PersonnesModifications:29]HeureModification:4:=Current time:C178
		[PersonnesModifications:29]TexteModification:6:=VarRapportComparaison
		[PersonnesModifications:29]UUIDPersonne:2:=[Personnes:12]UUID:1
		[PersonnesModifications:29]VersionModification:5:=$NumVersion
		OB SET:C1220([PersonnesModifications:29]ObjetModification:7;"DescriptifFinal";VarObjetDescriptifFinal)
		OB SET:C1220([PersonnesModifications:29]ObjetModification:7;"DescriptifInital";VarObjetDescriptifInitial)
		SAVE RECORD:C53([PersonnesModifications:29])
		RELATE MANY:C262([Personnes:12]UUID:1)
		ORDER BY:C49([PersonnesModifications:29];[PersonnesModifications:29]VersionModification:5;>)
	End if 
End if 
  // Actualisation des tableaux du formulaire projet LBTableauxPerso
  // TbPerNum, TbPerNom, TbPerAdr, TbPerPay, TbPerMel
  // inspiré de ASAPPerFabriqueTb
If ([Personnes:12]NomCourt:3#"")
	TbPerNom{$L}:=[Personnes:12]NomCourt:3
Else 
	TbPerNom{$L}:=[Personnes:12]NomLong:2
End if 


If ($Pays="")
	$Pays:="FRANCE"
End if 
TbPerPay{$L}:=$Pays
TbPerMel{$L}:=OB Get:C1224([Personnes:12]Arguments:7;"EMail";Est un texte:K8:3)
