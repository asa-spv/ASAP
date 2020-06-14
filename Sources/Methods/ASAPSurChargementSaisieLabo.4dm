//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 16/06/18, 18:39:33
  // ----------------------------------------------------
  // Méthode : ASAPSurChargementSaisieLabo
  // Description
  // Méthode à effectuer avant le chargement
  //  d'un enregistrement [Personnes] de type laboratoire
  // ----------------------------------------------------

C_LONGINT:C283($L;$NumProchAdherentN;$NumProchRaemaN;$Salé;$FT)
C_BOOLEAN:C305($MailTexteBrutB)
C_TEXT:C284(VarTransPart)

  // L'objet descriptif de la personne qui permet de noter une différence due à la saisie au moment de la vadidation
C_OBJECT:C1216(VarObjetDescriptifInitial)
  // Vidage de l'objet
OB GET PROPERTY NAMES:C1232(VarObjetDescriptifInitial;$TbNomX)
$FT:=Size of array:C274($TbNomX)
For ($Salé;1;$FT)
	OB REMOVE:C1226(VarObjetDescriptifInitial;$TbNomX{$Salé})
End for 

  // Affichage de la colonne de gauche
LISTBOX SELECT ROW:C912(*;"ListBoxNumLabo";TbPerNum)
OBJECT SET SCROLL POSITION:C906(*;"ListBoxNumLabo";TbPerNum)
VarNumLabo:=TbPerNum{TbPerNum}
VarAnnonceLabo:=[Personnes:12]NomLong:2
OBJECT SET VISIBLE:C603(VarAnnonceLabo;(FORM Get current page:C276#1))

  // gestion d'un nouvel enregistrement et de l'affichage de la bare de titre
If (Is new record:C668([Personnes:12]))
	  // gestion des N° de RAEMA et d'adhérent
	  // TbNumPersonne et TbNumRAEMA initialisées dans le bouton d'ajout de LBTableauxPerso
	VarNumAdhérent:=DerNumPersonne+1
	VarNumLaboRAEMA:=DerNumRAEMA+1
	  // renseignement de base
	[Personnes:12]TypePersonne:5:="Laboratoire"
	[Personnes:12]Identificateur:4:=GAInitIdentificateurPersonne 
	VarMdPRAEMA:=""
	VarAssociation:=""
	VarRemarque:=""
	NouveauLabo:=True:C214
	  // drapeau pour signaler que le courrier d'information n'est pas encore envoyé
	OB SET:C1220([Personnes:12]Arguments:7;"LettreCodeMdPAEnvoyer";True:C214)
	  // Tip pour le bouton figurant une imprimante
	OBJECT SET HELP TIP:C1181(*;"BouImpLettreCodeMdP";"Imprimer la lettre contenant le code et le mot de passe")
Else   // gestion d'un enregistrement déjà créé
	VarNumLaboRAEMA:=RAEMADemoduleMdPWeb ([Personnes:12]Identificateur:4)
	VarNumPersonne:=RAEMADemoduleMdPWeb ([Personnes:12]Identificateur:4;True:C214)
	SET WINDOW TITLE:C213([Personnes:12]NomLong:2)
	NouveauLabo:=False:C215
End if 

  // OBJET FIXER VISIBLE(*;"@NumLabo";Non(NouveauLabo))
  // L'imprimante n'est visible que si le courrier n'a pas encoré été édité
$LettrePasEnvoyée:=OB Get:C1224([Personnes:12]Arguments:7;"LettreCodeMdPAEnvoyer";Est un booléen:K8:9)
OBJECT SET VISIBLE:C603(*;"BouImpLettreCodeMdP";$LettrePasEnvoyée)

  // les téléphones et fax
VarPhoneF:=OB Get:C1224([Personnes:12]Arguments:7;"PhonePro";Est un texte:K8:3)
  // Formatage du n° de téléphone
If (VarPhoneF#"")
	If (VarPhoneF[[1]]#"0")
		VarPhoneF:="0"+VarPhoneF
	End if 
	If (Length:C16(VarPhoneF)=10)
		OBJECT SET FORMAT:C236(VarPhoneF;"00 00 00 00 00")
	End if 
End if 

VarPhoneP:=OB Get:C1224([Personnes:12]Arguments:7;"Portable";Est un texte:K8:3)
  // Formatage du n° de portable
If (VarPhoneP#"")
	If (VarPhoneP[[1]]#"0")
		VarPhoneP:="0"+VarPhoneP
	End if 
	If (Length:C16(VarPhoneP)=10)
		OBJECT SET FORMAT:C236(VarPhoneP;"00 00 00 00 00")
	End if 
End if 

VarFax:=OB Get:C1224([Personnes:12]Arguments:7;"FaxPro";Est un texte:K8:3)
  // Formatage du n° de fax
If (VarFax#"")
	If (VarFax[[1]]#"0")
		VarFax:="0"+VarFax
	End if 
	If (Length:C16(VarFax)=10)
		OBJECT SET FORMAT:C236(VarFax;"00 00 00 00 00")
	End if 
End if 

VarEORI:=OB Get:C1224([Personnes:12]Arguments:7;"EORI";Est un texte:K8:3)

  // Le contact
VarNomContact:=OB Get:C1224([Personnes:12]Arguments:7;"NomContact";Est un texte:K8:3)
OBJECT SET ENTERABLE:C238(VarNomContact;ZModif)

  // Les mails
ARRAY TEXT:C222(TbMails;0)
ARRAY BOOLEAN:C223(TbMailInfo;0)
ARRAY BOOLEAN:C223(TbMailRapport;0)
ARRAY BOOLEAN:C223(TbMailCompta;0)
  // Transformons les propriétés (adresse mails avec virgules) en tableaux
ASAPPerFabriqueTbMailsLabo ("EMail";True:C214;False:C215;False:C215)
ASAPPerFabriqueTbMailsLabo ("EMailBis";True:C214;False:C215;False:C215)
ASAPPerFabriqueTbMailsLabo ("EmailRAEMA";False:C215;True:C214;False:C215)
ASAPPerFabriqueTbMailsLabo ("EmailCompta";False:C215;False:C215;True:C214)

VarRemarque:=OB Get:C1224([Personnes:12]Arguments:7;"Remarques";Est un texte:K8:3)

RELATE MANY:C262([Personnes:12]UUID:1)
ASAPCreationTbParticipations 


  // Les adresses ...  et les argument pour VarObjetDescriptifInitial
If (NouveauLabo=False:C215)
	ASAPLaboObjetDescriptifFabrique (->VarObjetDescriptifInitial)
End if 

READ WRITE:C146([PersonnesAdresses:11])
ARRAY TEXT:C222(PUMAdresse;2)
PUMAdresse{1}:="Livraison"
PUMAdresse{2}:="Facturation"
SORT ARRAY:C229(PUMAdresse;<)
If (Records in selection:C76([PersonnesAdresses:11])>0)
	PUMAdresse:=1
	QUERY:C277([PersonnesAdresses:11];[PersonnesAdresses:11]UUIDPersonne:2=[Personnes:12]UUID:1;*)
	QUERY:C277([PersonnesAdresses:11]; & [PersonnesAdresses:11]TypeAdresse:9=PUMAdresse{PUMAdresse})
	[PersonnesAdresses:11]Pays:8:=Uppercase:C13([PersonnesAdresses:11]Pays:8)
Else 
	PUMAdresse:=0
End if 
$L:=Find in array:C230(<>TbNomPays;[PersonnesAdresses:11]Pays:8)
If ($L>0)
	VarCodepays:=<>TbCodeIsoASA{$L}
Else 
	VarCodepays:=""
End if 


  // La facturation
CaCTVA:=Num:C11(OB Get:C1224([Personnes:12]Arguments:7;"NonSoumisTVA";Est un texte:K8:3)="Vrai")
CaCCotis:=Num:C11(OB Get:C1224([Personnes:12]Arguments:7;"NonSoumisCotisation";Est un texte:K8:3)="Vrai")

VarAssociation:=OB Get:C1224([Personnes:12]Arguments:7;"Association";Est un texte:K8:3)
VarTransporteur:=OB Get:C1224([Personnes:12]Arguments:7;"ModeEnvoiColis";Est un texte:K8:3)
CaCTransportPayant:=Num:C11(OB Get:C1224([Personnes:12]Arguments:7;"TransportPayant";Est un texte:K8:3)="Vrai")
VarPrixTransport:=Num:C11(OB Get:C1224([Personnes:12]Arguments:7;"PrixTransporteur";Est un texte:K8:3))
  //VarBdCPoudre:=OB Lire([Personnes]Arguments;"NumBonCommandePoudre";Est un texte)
  //VarBdCGel:=OB Lire([Personnes]Arguments;"NumBonCommandeGel";Est un texte)
VarTVAIntra:=OB Get:C1224([Personnes:12]Arguments:7;"NumTVAIntraCom";Est un texte:K8:3)
CaCFactureMultiple:=Num:C11(OB Get:C1224([Personnes:12]Arguments:7;"PayeDeuxFois";Est un texte:K8:3)="Vrai")
$CodeFacturation:=OB Get:C1224([Personnes:12]Arguments:7;"CodeFacturation";Est un texte:K8:3)

  // Repérage des mois d'envoi des factures multiples
$Pos:=Position:C15(" X";$CodeFacturation)
If ($Pos>0)  // il y a des mois d'envoi de la facture qui sont notés
	$Calendrier:=Substring:C12($CodeFacturation;($Pos+2))
	If ($Calendrier="2")
		$Calendrier:="000010000001"
		$CodeFacturation:=Substring:C12($CodeFacturation;1;($Pos+1))+$Calendrier
	End if 
	For ($Salé;1;12)
		$Test:=Num:C11($Calendrier[[$Salé]])
		$Pt:=Get pointer:C304("FSCasa"+String:C10($Salé))
		$Pt->:=$Test
	End for 
End if 
OBJECT SET VISIBLE:C603(*;"FSCasa@";($Pos>0))

  // Facturation spéciale
CaCFactureSpéciale:=Num:C11(OB Get:C1224([Personnes:12]Arguments:7;"FacturationSpeciale";Est un texte:K8:3)="Vrai")


  // rappel des ventes
RELATE MANY SELECTION:C340([Ventes:16]NumFacture:2)
SELECTION TO ARRAY:C260([Ventes:16]NumFacture:2;TbNumFacture;[Ventes:16]DateVente:4;TbDateF;[Ventes:16]Intitule:3;TbIntituleF;[Ventes:16]PrixTotalHT:7;TbPrixF)
LONGINT ARRAY FROM SELECTION:C647([Ventes:16];TbNumEnrF)

  // Affichage des lignes de factures avec réglement flashy
$FT:=Size of array:C274(TbNumFacture)
ARRAY TEXT:C222(TbPayeF;$FT)
SORT ARRAY:C229(TbNumFacture;TbDateF;TbIntituleF;TbPrixF;TbNumEnrF;TbPayeF;<)

ARRAY LONGINT:C221(TbCouleursF;$FT)
ARRAY LONGINT:C221(TbCouleursRegle;$FT)
$GrisClair:=0x00D0CECE  // Gris clair
$BleuClair:=0x00E0EBF6  // Bleu clair
$BleuFoncé:=0x00A4C2E4  //  Bleu foncé
$OrangeSombre:=0x00FF8000  // Orange sombre
$Vert:=0xFF00  // Vert franc
For ($Salé;1;$FT)
	If ($Salé=1)
		TbCouleursF{$Salé}:=$BleuFoncé
	Else 
		If (TbNumFacture{$Salé}=TbNumFacture{$Salé-1})  // même facture
			TbCouleursF{$Salé}:=TbCouleursF{$Salé-1}  // même couleur
		Else 
			If (TbCouleursF{$Salé-1}=$BleuClair)
				TbCouleursF{$Salé}:=$BleuFoncé  //  couleur alterne
			Else 
				TbCouleursF{$Salé}:=$BleuClair  //  couleur alterne
			End if 
		End if 
	End if 
	
	Case of 
		: (TbNumFacture{$Salé}="@A") | (TbNumFacture{$Salé}="@D")
			TbPayeF{$Salé}:="NC"
			TbCouleursRegle{$Salé}:=$GrisClair
			
		: (TbDateF{$Salé}=!00-00-00!)
			TbPayeF{$Salé}:="NON"
			TbCouleursRegle{$Salé}:=$OrangeSombre
			
		Else 
			TbPayeF{$Salé}:="OUI"
			TbCouleursRegle{$Salé}:=$Vert
	End case 
End for 

  // La périodicité des RAEMA réglé sur [Personnes]Arguments;"ProchParticipe";Année de la prochaine campagne
C_LONGINT:C283($AnCourant)
ARRAY LONGINT:C221(PUMAnProchRAEMA;3)
PUMAnProchRAEMA{1}:=Year of:C25(Current date:C33)+1
PUMAnProchRAEMA{2}:=Year of:C25(Current date:C33)+2
PUMAnProchRAEMA{3}:=Year of:C25(Current date:C33)+3
$AnCourant:=OB Get:C1224([Personnes:12]Arguments:7;"ProchParticipe";Est un entier long:K8:6)
If ($AnCourant=0)
	$AnCourant:=Year of:C25(Current date:C33)+1
End if 
PUMAnProchRAEMA:=Find in array:C230(PUMAnProchRAEMA;$AnCourant)
VarProchParticipe:=PUMAnProchRAEMA{PUMAnProchRAEMA}
VarAlerteProchAn:=""
If (VarProchParticipe#(Year of:C25(Current date:C33)+1))
	VarAlerteProchAn:="Ce laboratoire ne participe pas tous les ans et doit donc être relancé l'année indiquée ci-contre"
End if 

  // Les RAEMA poudre
$An:="20"+<>ZPermMille  // l'année en cours en alpha
If (Size of array:C274(<>PUMAnRaemaPoudre)>0)  // <>PUMAnRaemaPoudre est initalisé dans ASAPFabriqueTbParticipe
	SORT ARRAY:C229(<>PUMAnRaemaPoudre;<)
	<>PUMAnRaemaPoudre:=Find in array:C230(<>PUMAnRaemaPoudre;$An)
	ASAPPerAfficheTbRaemaPoudre 
End if 

  // Les RAEMA gel
ARRAY TEXT:C222(PUMAnRaemaGel;0)
COPY ARRAY:C226(<>PUMAnRaemaPoudre;PUMAnRaemaGel)
If (Size of array:C274(<>PUMAnRaemaPoudre)>0)
	PUMAnRaemaGel:=Find in array:C230(PUMAnRaemaGel;$An)
	ASAPPerAfficheTbRaemaGel (True:C214)
End if 

  //  VarRaemaGelAvant:=GA13RaemaGelResume

  // Les participations
ARRAY TEXT:C222(PUMRaemaParticipeLié;0)
OBJECT SET VISIBLE:C603(PUMRaemaParticipeLié;False:C215)
PUMRaemaParticipe:=0
VarParticipe:=""
If (Size of array:C274(<>PUMAnRaemaPoudre)>0)
	GAFabriquePUMParticipe 
End if 

VarArguments:=""
ZViderSelectionCourante (->[WebConnexions:13])

  // Les transports particuliers
VarTransPart:=OB Get:C1224([Personnes:12]Arguments:7;"TransPart";Est un texte:K8:3)
OBJECT SET VISIBLE:C603(VarTransPart;(VarTransPart#""))
CaCTransPart:=Num:C11(VarTransPart#"")

  // Les courriels
  // Envoi des mails en texte brut (case à cocher BaCMailTexteBrut page 4)
$MailTexteBrutB:=OB Get:C1224([Personnes:12]Arguments:7;"MailTexteBrut";Est un booléen:K8:9)
BaCMailTexteBrut:=Num:C11($MailTexteBrutB)
LISTBOX SELECT ROW:C912(*;"ListBoxPersonnesCourriels";0;lk supprimer de sélection:K53:3)
ORDER BY:C49([PersonnesCourriels:31];[PersonnesCourriels:31]DateCourriel:4;<)
PREVIOUS RECORD:C110([PersonnesCourriels:31])
BouCadenas:=0

