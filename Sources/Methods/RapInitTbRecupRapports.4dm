//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 15/08/18, 14:25:55
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : RapInitTbRecupRapports 
  // Description
  // Méthode projet qui remplit les tableau de suivi (RapportInitZonesLabMail)
  // et renseigne les manques en email et en rapports (RapportTesteDossier)
  // Paramètre: {$1}= si existe donne le n° de la campagne 
  // ----------------------------------------------------

$H1:=Current time:C178
C_LONGINT:C283($Salé;1;$FT;$NumLaboRaemaN;$Pos;$NumCampagneEMA;$TT)
C_TEXT:C284($CodeRaemalié;$NumLaboRaema)
C_BOOLEAN:C305($MailRapportDisponibleEnvoyé;$RapportPris;$ParticipeKO)
  //Mise à zéro des tableaux et étiquettes de gestion du suivi 
  // les UUID de paricipation
ARRAY TEXT:C222(TbRapMailNonParticipationU;0)  // Tableau des n° de RAEMA des laboratoires non participants
ARRAY TEXT:C222(TbRapMailEnvoiU;0)  // Tableau des n° de RAEMA des mails envoyés
ARRAY TEXT:C222(TbRapMailNonEnvoiU;0)  // Tableau des n° de RAEMA des mails non envoyés
ARRAY TEXT:C222(TbRapportsNonPrisU;0)  // Tableau des n° de RAEMA n'ayant pas récupéré leur rapport
ARRAY TEXT:C222(TbRapportsRetenusU;0)  // Tableau des n° de RAEMA ayant leurs rapports bloqués
ARRAY TEXT:C222(TbRapportsPrisU;0)  // Tableau des n° de RAEMA ayant récupéré leurs rapports

  // les tableaux textes
ARRAY TEXT:C222(TbRapMailNonParticipation;0)  // Tableau des n° de RAEMA des laboratoires non participants
ARRAY TEXT:C222(TbRapMailEnvoi;0)  // Tableau des n° de RAEMA des mails envoyés
ARRAY TEXT:C222(TbRapMailNonEnvoi;0)  // Tableau des n° de RAEMA des mails non envoyés
ARRAY TEXT:C222(TbRapportsNonPris;0)  // Tableau des n° de RAEMA n'ayant pas récupéré leur rapport
ARRAY TEXT:C222(TbRapportsRetenus;0)  // Tableau des n° de RAEMA ayant leurs rapports bloqués
ARRAY TEXT:C222(TbRapportsPris;0)  // Tableau des n° de RAEMA ayant récupéré leurs rapports

  // les tableaux entier longs (pour tri naturel)
ARRAY LONGINT:C221(TbRapMailNonParticipationN;0)  // Tableau des n° de RAEMA des mails envoyés (numérique)
ARRAY LONGINT:C221(TbRapMailEnvoiN;0)  // Tableau des n° de RAEMA des mails envoyés (numérique)
ARRAY LONGINT:C221(TbRapMailNonEnvoiN;0)  // Tableau des n° de RAEMA des mails non envoyés (numérique)
ARRAY LONGINT:C221(TbRapportsNonPrisN;0)  // Tableau des n° de RAEMA n'ayant pas récupéré leur rapport (numérique)
ARRAY LONGINT:C221(TbRapportsRetenusN;0)  // Tableau des n° de RAEMA ayant leurs rapports bloqués (numérique)
ARRAY LONGINT:C221(TbRapportsPrisN;0)  // Tableau des n° de RAEMA ayant récupéré leurs rapports (numérique)


  // Quelle campagne ?
If (Count parameters:C259=1)  //  & (<>PUMCampagne{<>PUMCampagne}#<>NumCampagneEnCoursSaisie)
	$NumCampagne:=<>PUMCampagne{<>PUMCampagne}
Else   // Appel depuis l'écran principal ou campagne en cours
	$NumCampagne:=<>NumCampagneEnCoursRecup
	<>PUMCampagne:=Find in array:C230(<>PUMCampagne;$NumCampagne)
End if 



  // Informations sur l'existence ou non des rapports (RG et RI)
VarValDosRap:=""  // Champ texte du Préalable rapport RAEMA



  // Les rapports individuels
VarRapRetenus:=""  // Etiquette des rapports retenus
  // RecruteLaboParticipants ($NumCampagne)  // tous ceux qui ont participé au RAEMA

QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$NumCampagne;*)
VarTesteur:=WebTrouveValeurParNom ("testeur";-><>TbPerNomLong;-><>TbPerUUID)
QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2#VarTesteur)  // Elimination du 13
QUERY:C277([WebConnexions:13];[WebConnexions:13]Campagne:5=$NumCampagne;*)
QUERY:C277([WebConnexions:13];[WebConnexions:13]BoolEnvoi:8=True:C214)

Case of 
		
	: (Records in selection:C76([WebConnexions:13])=0)
		VarEtaMailRap:="Aucun laboratoire n'a répondu au RAEMA "+$NumCampagne+", les adresses de courriel ne peuvent donc pas être testées..."
		VarValDosRap:="Aucun rapport n'est, a fortiri, présent sur le site Web"
		OBJECT SET RGB COLORS:C628(VarEtaMailRap;0x00FF0000;0x00FFFFFF)
		OBJECT SET FONT SIZE:C165(VarEtaMailRap;18)
		
	: (Records in selection:C76([CampagneParticipations:17])=0)
		VarValDosRap:="Aucun rapport n'est présent sur le site Web"
		VarEtaMailRap:="Aucun laboratoire n'est encore prévu au RAEMA "+$NumCampagne+", les adresses de courriel ne peuvent donc pas être testées..."
		VarEtaMailRap:=VarEtaMailRap+" : NOTEZ LES PARTICIPANTS sur le logiciel ASAP"
		OBJECT SET RGB COLORS:C628(VarEtaMailRap;0x00FF0000;0x00FFFFFF)
		OBJECT SET FONT SIZE:C165(VarEtaMailRap;18)
		
	Else 
		OBJECT SET RGB COLORS:C628(VarEtaMailRap;0x0000;0x00FFFFFF)
		OBJECT SET FONT SIZE:C165(VarEtaMailRap;12)
		$Compteur:=0  // Compteur des RI manquants
		$CompteurMail:=0  // Compteur des adresses mails manquantes
		  // LECTURE ÉCRITURE([CampagneParticipation])
		ARRAY TEXT:C222($TbMA;0)  // initalisation du tableau des mails absents
		$PasDeRapportDuTout:=True:C214
		
		$FT:=Records in selection:C76([CampagneParticipations:17])
		ARRAY TEXT:C222($TbUUIDPersonne;$FT)
		ARRAY TEXT:C222($TbUUIDParticipation;$FT)
		ARRAY TEXT:C222($TbTexteParticipation;$FT)
		ARRAY OBJECT:C1221($TbArgumentsCampagne;$FT)
		
		SELECTION TO ARRAY:C260([CampagneParticipations:17]UUIDPersonne:2;$TbUUIDPersonne;[CampagneParticipations:17]UUID:1;$TbUUIDParticipation;[CampagneParticipations:17]TexteParticipation:4;$TbTexteParticipation;[CampagneParticipations:17]Arguments:5;$TbArgumentsCampagne)
		
		For ($Salé;1;$FT)  // Pour chaque participation
			$ArgumentCourant:=$TbArgumentsCampagne{$Salé}
			$UUIDLaboCourant:=$TbUUIDPersonne{$Salé}
			$UUIDParticipationCourant:=$TbUUIDParticipation{$Salé}
			$NumLaboRaemaA:=ASAPTrouveNumeroLaboParUUID ($UUIDLaboCourant)
			$NumLaboRaemaN:=Num:C11($NumLaboRaemaA)
			$MailLaboRaema:=WebTrouveValeurParNom ($UUIDLaboCourant;-><>TbPerUUID;-><>TbPAEMailRaema)
			$CodeRaemalié:=OB Get:C1224($ArgumentCourant;"CodeRaemaLié";Est un texte:K8:3)
			If ($CodeRaemalié#"")  // envoi lié à un laboratoire principal = $NumLaboRaemaA
				$NumRaemaLié:=String:C10(RAEMADemoduleMdPWeb ($CodeRaemalié))
				$NumLaboRaemaA:=$NumLaboRaemaA+"-"+$NumRaemaLié
			End if 
			$NomFichierRapport:="RI"+$NumCampagne+"_"+$NumLaboRaemaA+".pdf"
			  //$CDRapportLabo:=<>PermCheDosRap+$NumLaboRaemaA+Séparateur dossier+$NomFichierRapport
			$RapportEsTuLà:=(OB Get:C1224($ArgumentCourant;"CheminDocument";Est un texte:K8:3)#"")
			$RapportPris:=OB Get:C1224($TbArgumentsCampagne{$Salé};"RapportPris";Est un booléen:K8:9)
			  //$RapportPris:=$ArgumentCourant.RapportPris
			$MailRapportDisponibleEnvoyé:=OB Get:C1224($TbArgumentsCampagne{$Salé};"MailDisponibilitéEnvoyé";Est un booléen:K8:9)
			  //$MailRapportDisponibleEnvoyé:=$ArgumentCourant.MailDisponibilitéEnvoyé
			$ParticipeKO:=OB Get:C1224($TbArgumentsCampagne{$Salé};"ParticipeKO";Est un booléen:K8:9)
			  //$ParticipeKO:=$ArgumentCourant.ParticipeKO
			
			  // Prise des rapports
			If ($RapportEsTuLà)  // Présence du rapport dans le dossier adéquat du site Web
				$PasDeRapportDuTout:=False:C215
				If ($RapportPris)
					APPEND TO ARRAY:C911(TbRapportsPris;$NumLaboRaemaA)
					APPEND TO ARRAY:C911(TbRapportsPrisN;$NumLaboRaemaN)
					APPEND TO ARRAY:C911(TbRapportsPrisU;$UUIDParticipationCourant)
					
				Else 
					APPEND TO ARRAY:C911(TbRapportsNonPris;$NumLaboRaemaA)
					APPEND TO ARRAY:C911(TbRapportsNonPrisN;$NumLaboRaemaN)
					APPEND TO ARRAY:C911(TbRapportsNonPrisU;$UUIDParticipationCourant)
				End if 
				
				  // Envoi des mails
				If ($MailRapportDisponibleEnvoyé)
					APPEND TO ARRAY:C911(TbRapMailEnvoi;$NumLaboRaemaA)
					APPEND TO ARRAY:C911(TbRapMailEnvoiN;$NumLaboRaemaN)
					APPEND TO ARRAY:C911(TbRapMailEnvoiU;$UUIDParticipationCourant)
				Else 
					APPEND TO ARRAY:C911(TbRapMailNonEnvoi;$NumLaboRaemaA)
					APPEND TO ARRAY:C911(TbRapMailNonEnvoiN;$NumLaboRaemaN)
					APPEND TO ARRAY:C911(TbRapMailNonEnvoiU;$UUIDParticipationCourant)
				End if 
				
			Else   // Il existe une participation sans rapport = labo KO ou rapport retenu
				If ($NumLaboRaemaN>0)  // évite les connexion fantômes
					$Compteur:=$Compteur+1
					VarValDosRap:=VarValDosRap+<>ZCR+$NomFichierRapport
				End if 
				If ($ParticipeKO)
					APPEND TO ARRAY:C911(TbRapMailNonParticipation;$NumLaboRaemaA)
					APPEND TO ARRAY:C911(TbRapMailNonParticipationN;$NumLaboRaemaN)
					APPEND TO ARRAY:C911(TbRapMailNonParticipationU;$UUIDParticipationCourant)
				Else 
					APPEND TO ARRAY:C911(TbRapportsRetenus;$NumLaboRaemaA)
					APPEND TO ARRAY:C911(TbRapportsRetenusN;$NumLaboRaemaN)
					APPEND TO ARRAY:C911(TbRapportsRetenusU;$UUIDParticipationCourant)
				End if 
			End if 
			
			  //  remplissage des tableaux de suivi et test des mails absents
			If ($MailLaboRaema="")  // Le mail n'existe pas
				$CompteurMail:=$CompteurMail+1
				APPEND TO ARRAY:C911($TbMA;String:C10($NumLaboRaema))
				$L:=Find in array:C230(TbRapMailNonEnvoi;$NumLaboRaema)
				If ($L>0)
					DELETE FROM ARRAY:C228(TbRapMailNonEnvoi;$L)
				End if 
			End if   // Fin de l'existence d'une adresse mail de rapport
			
		End for 
		
		  // Renseignement de la zone des emails
		If ($CompteurMail=0)
			VarEtaMailRap:="Données courriel complètes"
		Else 
			$s:=Num:C11($CompteurMail>1)*"s"
			VarEtaMailRap:=String:C10($CompteurMail)+" email absent"+$s+<>ZCR+ZTableauVersTexte (->$TbMA;", ")
		End if 
		
		  // Renseignement de la zone des rapports
		If (VarValDosRap="")  // & ($VarValDosRap="")
			VarValDosRap:="Tous les rapports sont présents sur le site Web"
		Else 
			If ($PasDeRapportDuTout)
				VarValDosRap:="Aucun rapport n'est présent sur le site Web"
			Else 
				$S:=Num:C11($Compteur>1)*"s"
				VarValDosRap:="Il manque : "+String:C10($Compteur)+" rapport"+$S+" individuel"+$S+" : "+VarValDosRap
			End if 
		End if 
		
		
End case 
MULTI SORT ARRAY:C718(TbRapportsPrisN;>;TbRapportsPris;>;TbRapportsPrisU)
MULTI SORT ARRAY:C718(TbRapportsNonPrisN;>;TbRapportsNonPris;>;TbRapportsNonPrisU)
MULTI SORT ARRAY:C718(TbRapMailEnvoiN;>;TbRapMailEnvoi;>;TbRapMailEnvoiU)
MULTI SORT ARRAY:C718(TbRapMailNonEnvoiN;>;TbRapMailNonEnvoi;>;TbRapMailNonEnvoiU)
MULTI SORT ARRAY:C718(TbRapportsRetenusN;>;TbRapportsRetenus;>;TbRapportsRetenusU)
MULTI SORT ARRAY:C718(TbRapMailNonParticipationN;>;TbRapMailNonParticipation;>;TbRapMailNonParticipationU)


  // renseignement des variables associées (étiquettes et cadrans)
RapSuiviVarTableaux 



  // déselection dans les tableaux d'avancement
TbRapMailNonParticipation:=0
TbRapMailNonEnvoi:=0
TbRapMailEnvoi:=0
TbRapportsRetenus:=0
TbRapportsNonPris:=0
TbRapportsPris:=0

  // Visibilité du bouton d'envoi des mails
QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$NumCampagne)
$EnvoiPossible:=((([RAEMACampagnes:20]DateEnvoiColis:3+90)>Current date:C33) & (([RAEMACampagnes:20]DateEnvoiColis:3+30)<Current date:C33)) | (Macintosh command down:C546)
OBJECT SET VISIBLE:C603(*;"mail@";$EnvoiPossible)
If ($EnvoiPossible)
	  // recheche du texte du dernier mail envoyé
	QUERY:C277([XData:1];[XData:1]XNom:2="Texte du courriel";*)
	QUERY:C277([XData:1]; & [XData:1]XType:3="Rap")
	If (Records in selection:C76([XData:1])=0)
		CREATE RECORD:C68([XData:1])
		[XData:1]XNom:2:="Texte du courriel"
		[XData:1]XType:3:="Rap"
		[XData:1]XDate:4:=Current date:C33
		SAVE RECORD:C53([XData:1])
	End if 
	VarTexteCourriel:=[XData:1]XTexte:9
	VarObjetCourriel:=[XData:1]XTexteSup:10
	If (Length:C16(VarTexteCourriel)<600)
		ALERT:C41("Le texte du mail "+<>ZGuil+"Laboratoire OK"+<>ZGuil+" est incomplet.")
	End if 
	
	QUERY:C277([XData:1];[XData:1]XNom:2="Texte du courriel2";*)
	QUERY:C277([XData:1]; & [XData:1]XType:3="Rap")
	If (Records in selection:C76([XData:1])=0)
		CREATE RECORD:C68([XData:1])
		[XData:1]XNom:2:="Texte du courriel2"
		[XData:1]XType:3:="Rap"
		[XData:1]XDate:4:=Current date:C33
		SAVE RECORD:C53([XData:1])
	End if 
	VarTexteCourriel2:=[XData:1]XTexte:9
	VarObjetCourriel2:=[XData:1]XTexteSup:10
End if 



$H2:=Current time:C178
  //ALERTE("La méthode RapportTesteDossier a mis "+Chaine($H2-$H1)+" pour s'exécuter")
  //APPELER PROCESS(-1)
ZAmnistiePartielle (->[CampagneParticipations:17])
