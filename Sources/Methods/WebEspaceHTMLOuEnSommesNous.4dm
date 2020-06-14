//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 08/02/19, 04:14:20
  // ----------------------------------------------------
  // Paramètre : $1 = objet qui décrit les circonstances
  // ----------------------------------------------------
  // Méthode : WebEspaceHTMLOuEnSommesNous
  // Description
  // Méthode qui écrit le HTML en fonction du statut du laboratoire
  // vis à vis de son inscription et de sa facturation
  // ainsi que de la date de login par rapport aux phases du RAEMA
  // Les propriéts de l'objet sont : "Participe", {"TbNumLaboRaemaLiés"},
  //  "PayeAnPrécedent", "PayeAnActuel","CodePériode" 1= saisie, 2=conta, 3=rapport
  // Le résultat a la structure suivante 
  //$THTML:=$THTML+"            <p class="+<>ZGuil+"Informations"+<>ZGuil+">"+Les niveaux anticipés de contamination sont à présent disponible :+"</p>"+<>ZCR
  //$THTML:=$THTML+"            <p class="+<>ZGuil+"LienAcces"+<>ZGuil+">"+<>ZCR
  //$THTML:=$THTML+"              <img src="+<>ZGuil+"images/NiveauConta.png"+<>ZGuil+" alt="+<>ZGuil+"Saisie résultats"+<>ZGuil
  //$THTML:=$THTML+" width="+<>ZGuil+"40px"+<>ZGuil+"/><br />"+<>ZCR
  //$THTML:=$THTML+"                Accéder au niveaux anticipés de contamination"+<>ZCR

C_LONGINT:C283($CodePériode;$Salé;$TT)
C_BOOLEAN:C305($Participe;$PayeAnPrécedent;$PayeAnActuel)
ARRAY TEXT:C222(TbNumLaboRaemaLiés;0)
C_OBJECT:C1216($Objet)

$Objet:=$1
$Langue:=$2
$Participe:=$Objet.Participe
$CodePériode:=$Objet.CodePériode
$PayeAnPrécedent:=$Objet.PayeAnPrécedent
$PayeAnActuel:=$Objet.PayeAnActuel
OB GET ARRAY:C1229($Objet;"TbNumLaboRaemaLiés";TbNumLaboRaemaLiés)
$TT:=Size of array:C274(TbNumLaboRaemaLiés)
$THTMLAutre:=""
If ($Participe=False:C215)  // il ne participe pas, le vilain
	$THTMLInformations:="Vous ne semblez pas être inscrit à la campagne "+<>NumCampagneEnCoursSaisie+"."
	$THTMLInformations:=WebTraduitTexte ("Vous ne semblez pas être inscrit à la campagne";$Langue)+<>NumCampagneEnCoursSaisie+"."
Else 
	If ($CodePériode=3)
		$THTMLInformations:=<>ZCR+(16*" ")+WebTraduitTexte ("Vous pouvez télécharger les rapports";$Langue)
		$THTMLInformations:=$THTMLInformations+WebTraduitTexte ("dans le tableau de la partie";$Langue)+<>ZGuil+WebTraduitTexte ("Accès rapide au téléchargement";$Langue)+<>ZGuil+WebTraduitTexte ("placé ci-dessous";$Langue)
	Else 
		$THTMLInformations:=(16*" ")+WebTraduitTexte ("Vous êtes inscrit à la campagne";$Langue)+" "+<>NumCampagneEnCoursSaisie+".<br />"
		$MessSasie:=WebTraduitTexte ("saisir vos résultats";$Langue)
		$MessNiveaux:=WebTraduitTexte ("accéder aux niveaux anticipés de contamination";$Langue)
		$Message:=(Num:C11($CodePériode=1)*$MessSasie)+(Num:C11($CodePériode=2)*$MessNiveaux)
		  //$image:=(Num($TT=0)*"l'image")+(Num($TT>0)*("l'une des "+Chaîne($TT+1)+" images"))
		$image:=(Num:C11($TT=0)*WebTraduitTexte ("l'image";$Langue))+(Num:C11($TT>0)*WebTraduitTexte ("l'une des images";$Langue))
		$THTMLInformations:=$THTMLInformations+<>ZCR+(16*" ")+WebTraduitTexte ("Vous pouvez dès à présent";$Langue)+" "+$Message+WebTraduitTexte ("en cliquant sur";$Langue)+$image+" "+WebTraduitTexte ("ci-dessous";$Langue)+" :"
	End if 
	
	If ($CodePériode<3)  // uniquement si on n'est pas en période calme ( téléchargement de rapport pur
		$Image:=(Num:C11($CodePériode=1)*"SaisieResultat")+(Num:C11($CodePériode=2)*"NiveauConta")
		$Saisie:=WebTraduitTexte ("Saisir les résultats";$Langue)
		$NiveauxConta:=WebTraduitTexte ("Accéder aux niveaux de contamination";$Langue)
		$Alt:=(Num:C11($CodePériode=1)*$Saisie)+(Num:C11($CodePériode=2)*$NiveauxConta)
		$SuffixeId:=(Num:C11($CodePériode=1)*"Rap")+(Num:C11($CodePériode=2)*"Cta")
		$THTMLAutre:=$THTMLAutre+(14*" ")+"<p class="+<>ZGuil+"LienAcces"+<>ZGuil+">"+<>ZCR
		If ($TT=0)  // Le rapport principal
			$THTMLAutre:=$THTMLAutre+(16*" ")+"<a href="+<>ZGuil+"EC_ResP1MF_"+NumLaboActuelA+<>ZGuil+" alt="+<>ZGuil+$Alt+<>ZGuil+">"+<>ZCR
			$THTMLAutre:=$THTMLAutre+(18*" ")+"<img src="+<>ZGuil+"images/"+$Image+".png"+<>ZGuil+" alt="+<>ZGuil+$Alt+<>ZGuil
			$THTMLAutre:=$THTMLAutre+" id=EspCli"+$SuffixeId+NumLaboActuelA+" width="+<>ZGuil+"40px"+<>ZGuil+"/>"+<>ZCR
			$THTMLAutre:=$THTMLAutre+(18*" ")+WebTraduitTexte ("Saisir les résultats";$Langue)+<>ZCR
			$THTMLAutre:=$THTMLAutre+(16*" ")+"</a>"+<>ZCR
		Else 
			  // Le rapport principal
			$THTMLAutre:=$THTMLAutre+(16*" ")+"<a href="+<>ZGuil+"EC_ResP1MF_"+NumLaboActuelA+<>ZGuil+" alt="+<>ZGuil+$Alt+<>ZGuil+">"+<>ZCR
			$THTMLAutre:=$THTMLAutre+(18*" ")+"<img src="+<>ZGuil+"images/"+$Image+".png"+<>ZGuil+" alt="+<>ZGuil+$Alt+<>ZGuil
			$THTMLAutre:=$THTMLAutre+" id=EspCli"+$SuffixeId+NumLaboActuelA+" width="+<>ZGuil+"40px"+<>ZGuil+"/>"+<>ZCR
			$THTMLAutre:=$THTMLAutre+(18*" ")+WebTraduitTexte ("Rapport n° ";$Langue)+NumLaboActuelA+"        "+<>ZCR
			$THTMLAutre:=$THTMLAutre+(16*" ")+"</a>"+<>ZCR
			ARRAY TEXT:C222($TbUUIDParticipation;0)
			OB GET ARRAY:C1229($Objet;"TbUUIDParticipation";$TbUUIDParticipation)
			For ($Salé;1;$TT)  // Les autres rapports
				$NumLaboLiéCourantA:=String:C10(TbNumLaboRaemaLiés{$Salé})
				$UUIDParticipationCourante:=$TbUUIDParticipation{$Salé}
				$THTMLAutre:=$THTMLAutre+(16*" ")+"<a href="+<>ZGuil+"EC_ResP1MF_"+$NumLaboLiéCourantA+<>ZGuil+" alt="+<>ZGuil+$Alt+<>ZGuil+">"+<>ZCR
				$THTMLAutre:=$THTMLAutre+(18*" ")+"<img src="+<>ZGuil+"images/"+$Image+".png"+<>ZGuil+" alt="+<>ZGuil+$Alt+<>ZGuil
				$THTMLAutre:=$THTMLAutre+" id=EspCli"+$SuffixeId+$NumLaboLiéCourantA+<>ZGuil+" width="+<>ZGuil+"40px"+<>ZGuil+"/>"+<>ZCR
				$THTMLAutre:=$THTMLAutre+WebTraduitTexte ("Rapport n° ";$Langue)+$NumLaboLiéCourantA+"        "+<>ZCR
				$THTMLAutre:=$THTMLAutre+(16*" ")+"</a>"+<>ZCR
			End for 
			$THTMLAutre:=$THTMLAutre+"<br />"
		End if 
		
		$THTMLAutre:=$THTMLAutre+(14*" ")+"</p>"+<>ZCR
	End if 
	Case of 
		: ($PayeAnPrécedent=False:C215)
			$NumFacture:=OB Get:C1224($Objet;"NumFactureAnPrécedent";Est un texte:K8:3)
			If ($NumFacture#"")
				$THTMLAutre:=$THTMLAutre+WebTraduitTexte ("A pas réglé la facture";$Langue)
				$CDFacture:=<>PermCheDosFac+WebTraduitTexte ("Année 20";$Langue)+String:C10(Num:C11(<>ZPERMMILLE)-1)+Séparateur dossier:K24:12+Replace string:C233($NumFacture;"_";"/")+".pdf"
				$THTMLAutre:=$THTMLAutre+WebTraduitTexte ("Vous pouvez la télécharger en cliquant sur ce lien";$Langue)
				$THTMLAutre:=$THTMLAutre+"<a href="+<>ZGuil+$CDFacture+<>ZGuil+">"+WebTraduitTexte ("Votre facture à régler";$Langue)+"</a>"
			End if 
			
		: ($PayeAnActuel=False:C215)
			$NumFacture:=OB Get:C1224($Objet;"NumFactureAnCourant";Est un texte:K8:3)
			If ($NumFacture#"")
				$CDFacture:=<>PermCheDosFac+"Année 20"+<>ZPERMMILLE+Séparateur dossier:K24:12+Replace string:C233($NumFacture;"_";"/")+".pdf"
				$THTMLAutre:=$THTMLAutre+WebTraduitTexte ("A pas réglé la facture";$Langue)
				$THTMLAutre:=$THTMLAutre+WebTraduitTexte ("Vous pouvez la télécharger en cliquant sur ce lien";$Langue)
				$THTMLAutre:=$THTMLAutre+"<a href="+<>ZGuil+$CDFacture+<>ZGuil+">"+WebTraduitTexte ("Votre facture à régler";$Langue)+"</a>"
			End if 
			
		Else 
			$NumFacture:=OB Get:C1224($Objet;"NumFactureAnCourant";Est un texte:K8:3)
			If ($NumFacture#"")
				$CDFacture:=<>PermCheDosFac+WebTraduitTexte ("Année 20";$Langue)+<>ZPERMMILLE+Séparateur dossier:K24:12+Replace string:C233($NumFacture;"_";"/")+".pdf"
				$THTMLAutre:=$THTMLAutre+WebTraduitTexte ("Remerciement facture poudre réglée";$Langue)+".<br />"+<>ZCR
				$THTMLAutre:=$THTMLAutre+WebTraduitTexte ("Vous pouvez la télécharger en cliquant sur ce lien";$Langue)
				$THTMLAutre:=$THTMLAutre+"<a href="+<>ZGuil+$CDFacture+<>ZGuil+">"+WebTraduitTexte ("Votre facture acquitée";$Langue)+".</a>"
			End if 
	End case 
End if 

$THTML:=(14*" ")+"<p class="+<>ZGuil+"Informations"+<>ZGuil+">"
$THTML:=$THTML+$THTMLInformations
$THTML:=$THTML+(14*" ")+"</p>"+<>ZCR
$THTML:=$THTML+$THTMLAutre
$0:=$THTML
