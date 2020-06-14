//%attributes = {}
  // WebActualiseConnexion
  // Crée ou actualise la fiche de[WebConnexions] incluant le détail de chaque connexion Web
  //  $1 = n° de RAEMA du labo     
  //  $2= vrai si on stocke les tb dans le blob
  //  $3= vrai si on charge les tb à partir du blob
  // {$4} = vrai si on est en identification et faux si on a envoyé le mail
  // $0 = chaine(numero d'ordre de la connexion)

ARRAY LONGINT:C221($TbNumEnrRaemaRetenu;0)
C_LONGINT:C283($1;$NumRaema)
C_BOOLEAN:C305($2;$3;$4)

$0:=""
$NumRaema:=$1
$NumCampagne:=<>NumCampagneEnCoursSaisie
$L:=Find in array:C230(<>TbPerNumLaboRAEMA;$NumRaema)
$UUID:=<>TbPerUUID{$L}
$CodeConnexion:=<>TbPerIdentificateur{$L}
READ WRITE:C146([CampagneParticipations:17])
QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUIDPersonne:2=$UUID;*)
QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]NumCampagne:3=$NumCampagne)
If (Records in selection:C76([CampagneParticipations:17])=0)
	[CampagneParticipations:17]NumCampagne:3:=$NumCampagne
	[CampagneParticipations:17]UUIDPersonne:2:=$UUID
	OB SET:C1220([CampagneParticipations:17]Arguments:5;"Sauvage";True:C214)
	SAVE RECORD:C53([CampagneParticipations:17])
End if 
WebHistoireConnexionSaisie (NumLaboActuelA;1)

QUERY:C277([WebConnexions:13];[WebConnexions:13]CodeConnexion:4=$UUID;*)
QUERY:C277([WebConnexions:13]; & [WebConnexions:13]Campagne:5=$NumCampagne)
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
	ResInitTbPersistants 
	ZVariableVersBlob (->[WebConnexions:13]BlobConnexion:11;->TbNumEch;->TbNumEchT;->$TbNumEnrRaemaRetenu;->TbNomsP2;->TbValeursP2;->TbNomsP3;->TbValeursP3;->TbTexteResume;->TbPJMailRaema)
	SAVE RECORD:C53([WebConnexions:13])
Else   // connexions suivantes
	ORDER BY:C49([WebConnexions:13];[WebConnexions:13]NumEnvoi:9;<)  // très évangélique : met le dernier en premier
	If (Count parameters:C259=4)
		C_BOOLEAN:C305($4)
		If ($4)  // on a validé avec succès la page 1 d'identification ou on a navigué dans les pages et renvoyé un mail
			ZBlobVersVariable (->[WebConnexions:13]BlobConnexion:11;->TbNumEch;->TbNumEchT;->$TbNumEnrRaemaRetenu;->TbNomsP2;->TbValeursP2;->TbNomsP3;->TbValeursP3;->TbTexteResume;->TbPJMailRaema)
			$Rang:=[WebConnexions:13]NumEnvoi:9+1
			CREATE RECORD:C68([WebConnexions:13])
			[WebConnexions:13]DateConnexion:2:=Current date:C33
			[WebConnexions:13]HeureConnexion:3:=Current time:C178
			[WebConnexions:13]CodeConnexion:4:=$CodeConnexion
			[WebConnexions:13]NumEnvoi:9:=1  // compteur de connexion
			[WebConnexions:13]Campagne:5:=$NumCampagne  // compteur de mail
			[WebConnexions:13]LangueConnexion:10:=LangueCourante
			[WebConnexions:13]NavigateurConnexion:13:=WebRenseigneNavigateur 
			[WebConnexions:13]UUIDParticipation:12:=[CampagneParticipations:17]UUID:1
			ZVariableVersBlob (->[WebConnexions:13]BlobConnexion:11;->TbNumEch;->TbNumEchT;->$TbNumEnrRaemaRetenu;->TbNomsP2;->TbValeursP2;->TbNomsP3;->TbValeursP3;->TbTexteResume;->TbPJMailRaema)
			[WebConnexions:13]TexteMail:6:=ZTableauVersTexte (->TbTexteResume)
			[WebConnexions:13]TextePJ:7:=ZTableauVersTexte (->TbPJMailRaema;<>ZTab)
			SAVE RECORD:C53([WebConnexions:13])
		Else   // on a envoyé avec succès le courriel à l'ASA
			ZVerrouAttendre (->[WebConnexions:13])
			[WebConnexions:13]BoolEnvoi:8:=True:C214  // pour indiquer qu'on a envoyé le mail
			SAVE RECORD:C53([WebConnexions:13])
		End if 
	End if 
	
	If ($2)
		ZVerrouAttendre (->[WebConnexions:13])
		ZVariableVersBlob (->[WebConnexions:13]BlobConnexion:11;->TbNumEch;->TbNumEchT;->$TbNumEnrRaemaRetenu;->TbNomsP2;->TbValeursP2;->TbNomsP3;->TbValeursP3;->TbTexteResume;->TbPJMailRaema)
		SAVE RECORD:C53([WebConnexions:13])
	End if 
	
	If ($3)
		ZVariableVersBlob (->[WebConnexions:13]BlobConnexion:11;->TbNumEch;->TbNumEchT;->$TbNumEnrRaemaRetenu;->TbNomsP2;->TbValeursP2;->TbNomsP3;->TbValeursP3;->TbTexteResume;->TbPJMailRaema)
	End if 
	RangPointeur:=1+Num:C11(LangueCourante="A")
	$0:=String:C10([WebConnexions:13]NumEnvoi:9)
End if 
ZAmnistiePartielle (->[WebConnexions:13];True:C214)
