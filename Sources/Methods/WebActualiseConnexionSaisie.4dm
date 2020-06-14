//%attributes = {}
  // WebActualiseConnexionSaisie
  // Crée ou actualise la fiche de[WebConnexions] incluant le détail de chaque connexion Web
  //  $1 = n° de RAEMA du labo     
  //  $2 = Stade de la saisie
  // {$3} = Mail d'envoi de l'AR
  // $0 = chaine(numero d'ordre de la connexion)

C_TEXT:C284($1;$NumLaboRAEMA)
C_LONGINT:C283($2;$NumLaboRAEMAN)
ARRAY LONGINT:C221($TbNumEnrRaemaRetenu;0)

$NumLaboRAEMA:=$1
$NumLaboRAEMAN:=Num:C11($NumLaboRAEMA)
$Stade:=$2
$EmailAR:=""
If (Count parameters:C259=3)
	$EmailAR:=$3
End if 
$NumCampagne:=<>NumCampagneEnCoursSaisie
$UUID:=WebTrouveValeurParNom ($NumLaboRAEMA;-><>TbPerNumLaboRAEMAA;-><>TbPerUUID)
$CodeConnexion:=WebTrouveValeurParNom ($NumLaboRAEMA;-><>TbPerNumLaboRAEMAA;-><>TbPerIdentificateur)
READ WRITE:C146([CampagneParticipations:17])
  //CHERCHER([CampagneParticipations];[CampagneParticipations]UUIDPersonne=$UUID;*)
  //CHERCHER([CampagneParticipations]; & [CampagneParticipations]NumCampagne=$NumCampagne)
QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUID:1=UUIDParticipation)
If (Records in selection:C76([CampagneParticipations:17])=0)
	CREATE RECORD:C68([CampagneParticipations:17])
	[CampagneParticipations:17]NumCampagne:3:=$NumCampagne
	[CampagneParticipations:17]UUIDPersonne:2:=$UUID
	OB SET:C1220([CampagneParticipations:17]Arguments:5;"Sauvage";True:C214)
	SAVE RECORD:C53([CampagneParticipations:17])
End if 
WebHistoireConnexionSaisie (NumLaboActuelA;$Stade;$EmailAR)
  // ZAmnistiePartielle (->[CampagneParticipations];Vrai)

  //CHERCHER([WebConnexions];[WebConnexions]CodeConnexion=$UUID;*)
  //CHERCHER([WebConnexions]; & [WebConnexions]Campagne=$NumCampagne)
QUERY:C277([WebConnexions:13];[WebConnexions:13]UUIDParticipation:12=UUIDParticipation)
If (Records in selection:C76([WebConnexions:13])=0)  // première connexion
	CREATE RECORD:C68([WebConnexions:13])
	[WebConnexions:13]DateConnexion:2:=Current date:C33
	[WebConnexions:13]HeureConnexion:3:=Current time:C178
	[WebConnexions:13]CodeConnexion:4:=$CodeConnexion
	[WebConnexions:13]NumEnvoi:9:=1  // compteur de connexion
	[WebConnexions:13]Campagne:5:=$NumCampagne  // compteur de mail
	[WebConnexions:13]LangueConnexion:10:=LangueCourante
	[WebConnexions:13]NavigateurConnexion:13:=WebRenseigneNavigateur 
	[WebConnexions:13]UUIDParticipation:12:=[CampagneParticipations:17]UUID:1
	  // [WebConnexions]XAlpha:=LangueCourante 
	ZVariableVersBlob (->[WebConnexions:13]BlobConnexion:11;->TbNumEch;->TbNumEchT;->$TbNumEnrRaemaRetenu;->TbNomsP2;->TbValeursP2;->TbNomsP3;->TbValeursP3;->TbTexteResume;->TbPJMailRaema)
Else   // connexions suivantes
	$NumDerEnvoi:=Records in selection:C76([WebConnexions:13])
	CREATE RECORD:C68([WebConnexions:13])
	[WebConnexions:13]DateConnexion:2:=Current date:C33
	[WebConnexions:13]HeureConnexion:3:=Current time:C178
	[WebConnexions:13]CodeConnexion:4:=$CodeConnexion
	[WebConnexions:13]NumEnvoi:9:=$NumDerEnvoi+1  // compteur de connexion
	[WebConnexions:13]Campagne:5:=$NumCampagne  // compteur de mail
	[WebConnexions:13]LangueConnexion:10:=LangueCourante
	[WebConnexions:13]NavigateurConnexion:13:=WebRenseigneNavigateur 
	[WebConnexions:13]UUIDParticipation:12:=[CampagneParticipations:17]UUID:1
	ZVariableVersBlob (->[WebConnexions:13]BlobConnexion:11;->TbNumEch;->TbNumEchT;->$TbNumEnrRaemaRetenu;->TbNomsP2;->TbValeursP2;->TbNomsP3;->TbValeursP3;->TbTexteResume;->TbPJMailRaema)
	[WebConnexions:13]TexteMail:6:=ZTableauVersTexte (->TbTexteResume)
	[WebConnexions:13]TextePJ:7:=ZTableauVersTexte (->TbPJMailRaema;<>ZTab)
	If ($Stade=4)  // on a validé avec succès la page 3 de saisie des résultats
		[WebConnexions:13]BoolEnvoi:8:=True:C214  // pour indiquer que le laboratoire a envoyé le résultat
		[WebConnexions:13]Commentaire:14:=WebTrouveValeurParNom ("commentaires";->TbNomsP3;->TbValeursP3)
		
	End if 
End if 
SAVE RECORD:C53([WebConnexions:13])

ZAmnistiePartielle (->[WebConnexions:13];True:C214)
