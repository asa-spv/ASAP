//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 16/06/18, 18:39:33
  // ----------------------------------------------------
  // Méthode : ASAPSurChargementSaisieAdh
  // Description
  // Méthode à effectuer avant le chargement
  //  d'un enregistrement [Personnes] de type laboratoire
  // ----------------------------------------------------

C_LONGINT:C283($L;$NumProchAdherentN;$NumProchRaemaN)
C_BOOLEAN:C305($MailTexteBrutB)

  //VarContenuExportAvant:=RapConcateneAdhérent  // permet de noter une différence due à la saisie au moment de la vadidation
  // FORM ALLER À PAGE(1)
$H1:=Milliseconds:C459


LISTBOX SELECT ROW:C912(*;"ListBoxAdh";TbPerNom)
OBJECT SET SCROLL POSITION:C906(*;"ListBoxAdh";TbPerNom)
VarPrénom:=OB Get:C1224([Personnes:12]Arguments:7;"Prénom";Est un texte:K8:3)
VarAnnonceAdh:=VarPrénom+" "+[Personnes:12]NomLong:2

  // gestion d'un nouvel enregistrement et de l'affichage de la barre de titre
If (Is new record:C668([Personnes:12]))
	VarNumPersonne:=DerNumPersonne+1
	VarNumLaboRAEMA:=0
	[Personnes:12]TypePersonne:5:="Individu"
	[Personnes:12]Identificateur:4:=GAInitIdentificateurPersonne 
	VarRemarque:=""
	NouveauAdh:=True:C214
	OBJECT SET VISIBLE:C603(*;"@ListBoxAdh";False:C215)
Else 
	VarNumPersonne:=RAEMADemoduleMdPWeb ([Personnes:12]Identificateur:4;True:C214)
	SET WINDOW TITLE:C213(VarPrénom+" "+[Personnes:12]NomLong:2)
	NouveauAdh:=False:C215
	OBJECT SET VISIBLE:C603(*;"@ListBoxAdh";True:C214)
End if 

  // Participation aux instances et groupes de travail :
$Pt:=OBJECT Get pointer:C1124(Objet nommé:K67:5;"CacCA")
$Pt->:=Num:C11(OB Get:C1224([Personnes:12]Arguments:7;"CA";Est un booléen:K8:9))

$Pt:=OBJECT Get pointer:C1124(Objet nommé:K67:5;"CacBureau")
$Pt->:=Num:C11(OB Get:C1224([Personnes:12]Arguments:7;"Bureau";Est un booléen:K8:9))

$Pt:=OBJECT Get pointer:C1124(Objet nommé:K67:5;"CacAD")
$Pt->:=Num:C11(OB Get:C1224([Personnes:12]Arguments:7;"AsaDia";Est un booléen:K8:9))

$Pt:=OBJECT Get pointer:C1124(Objet nommé:K67:5;"CacADG")
$Pt->:=Num:C11(OB Get:C1224([Personnes:12]Arguments:7;"AsaDia Gibier";Est un booléen:K8:9))

  // Les mails
ARRAY TEXT:C222(TbMails;0)
ARRAY BOOLEAN:C223(TbMailInfo;0)
ARRAY BOOLEAN:C223(TbMailRapport;0)
ARRAY BOOLEAN:C223(TbMailCompta;0)
ASAPPerFabriqueTbMailsLabo ("EMail";True:C214;False:C215;False:C215)
ASAPPerFabriqueTbMailsLabo ("EMailBis";True:C214;False:C215;False:C215)

VarRemarque:=OB Get:C1224([Personnes:12]Arguments:7;"Remarques";Est un texte:K8:3)


  // Les adresses
READ WRITE:C146([PersonnesAdresses:11])
ARRAY TEXT:C222(PUMAdresse;2)
PUMAdresse{1}:="Professionnelle"
PUMAdresse{2}:="Personnelle"
SORT ARRAY:C229(PUMAdresse;<)
If (Records in selection:C76([PersonnesAdresses:11])>0)
	PUMAdresse:=1
	QUERY:C277([PersonnesAdresses:11];[PersonnesAdresses:11]UUIDPersonne:2=[Personnes:12]UUID:1;*)
	QUERY:C277([PersonnesAdresses:11]; & [PersonnesAdresses:11]TypeAdresse:9=PUMAdresse{PUMAdresse})
Else 
	PUMAdresse:=0
End if 

  // La facturation
CaCTVA:=Num:C11(OB Get:C1224([Personnes:12]Arguments:7;"NonSoumisTVA";Est un texte:K8:3)="Vrai")
RELATE MANY:C262([Personnes:12]UUID:1)

  // rappel des ventes
RELATE MANY SELECTION:C340([Ventes:16]NumFacture:2)
SELECTION TO ARRAY:C260([Ventes:16]NumFacture:2;TbNumFacture;[Ventes:16]DateVente:4;TbDateF;[Ventes:16]Intitule:3;TbIntituleF;[Ventes:16]PrixTotalHT:7;TbPrixF)
LONGINT ARRAY FROM SELECTION:C647([Ventes:16];TbNumEnrF)

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






  // Les courriels
  // Envoi des mails en texte brut (case à cocher BaCMailTexteBrut page 4)
$MailTexteBrutB:=OB Get:C1224([Personnes:12]Arguments:7;"MailTexteBrut";Est un booléen:K8:9)
BaCMailTexteBrut:=Num:C11($MailTexteBrutB)
LISTBOX SELECT ROW:C912(*;"ListBoxPersonnesCourriels";0;lk supprimer de sélection:K53:3)
ORDER BY:C49([PersonnesCourriels:31];[PersonnesCourriels:31]DateCourriel:4;<)
PREVIOUS RECORD:C110([PersonnesCourriels:31])

$H2:=Milliseconds:C459
  // ALERTE(Chaîne($H2-$H1))
