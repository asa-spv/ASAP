//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 20/10/19, 18:10:14
  // ----------------------------------------------------
  // Méthode : WebEcritHTMLEspaceClient
  // Description
  // Méthode qui écrit le HTML de lespace client
  //
  // Paramètres : $1 = UUID du laboratoire  $2 = langue
  // ----------------------------------------------------
C_OBJECT:C1216($Objet)

$UUIDLabo:=$1
$Langue:=$2
WebInitTraductionsEC 
NumLaboActuelA:=ASAPTrouveNumeroLaboParUUID ($UUIDLabo)
$LigneTbGnx:=Find in array:C230(<>TbPerNumLaboRAEMAA;NumLaboActuelA)

$NomLabo:=<>TBPERNOMLONG{$LigneTbGnx}
$ProchNumCampagne:=<>NumCampagneEnCoursSaisie  // Numéro de prochain RAEMA : <>NumCampagneEnCoursSaisie  (InitPUMCampagne)

  // Calcul de $OuEnSommesNous

  // est-il dans le tableau de participation ?
$TestParticipe:=NumLaboActuelA+"_"+$ProchNumCampagne+"_"
$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$TestParticipe)
OB SET:C1220($Objet;"Participe";($L>0))
If ($L>0)
	OB SET:C1220($Objet;"UUIDParticipeLaboPrincipal";<>TbLotoUUIDParticipation{$L})
	$SansPathogène:=<>TbLotoSansPathogene{$L}
	$ColisSuppAR:=<>TbLotoNbColisPoudreAR{$L}
	$ColisSuppSR:=<>TbLotoNbColisPoudreSR{$L}
	  // Peut-on faire plus simple ?
	$PotsSupp:=<>TbLotoLevMoisSepNCGAR{$L}+<>TbLotoLevMoisSepNCGSR{$L}+<>TbLotoLevMoisEnsNCGAR{$L}\
		+<>TbLotoLevMoisEnsNCGSR{$L}+<>TbLotoLactiquesNCGAR{$L}+<>TbLotoLactiquesNCGSR{$L}\
		+<>TbLotoPseudoNCGAR{$L}+<>TbLotoPseudoNCGSR{$L}+<>TbLotoBacillusNCGAR{$L}+<>TbLotoBacillusNCGSR{$L}
End if 

  // a t'il des colis sup avec rapport
ARRAY LONGINT:C221($TbCSAR;0)
ARRAY TEXT:C222($TbUUIDParticipation;0)
Repeat 
	$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$TestParticipe;($L+1))
	If ($L>0)
		$NumlaboRaema:=RAEMADemoduleMdPWeb (<>TbLotoCodeRaemaLié{$L})
		APPEND TO ARRAY:C911($TbCSAR;$NumlaboRaema)
		APPEND TO ARRAY:C911($TbUUIDParticipation;<>TbLotoUUIDParticipation{$L})
	End if 
Until ($L<0)
If (Size of array:C274($TbCSAR)=0)
	OB REMOVE:C1226($Objet;"TbNumLaboRaemaLiés")
	OB REMOVE:C1226($Objet;"TbUUIDParticipation")
Else 
	OB SET ARRAY:C1227($Objet;"TbNumLaboRaemaLiés";$TbCSAR)
	OB SET ARRAY:C1227($Objet;"TbUUIDParticipation";$TbUUIDParticipation)
End if 


  // où en est-on de la facturation poudre ?
QUERY:C277([Factures:15];[Factures:15]UUIDPersonne:2=$UUIDLaBO;*)  // Les factures du laboratoire
QUERY:C277([Factures:15]; & [Factures:15]NumFacture:3="@/RT@";*)  // Raema poudre
QUERY:C277([Factures:15]; & [Factures:15]NumFacture:3#"@D";*)  // sans les devis
QUERY:C277([Factures:15]; & [Factures:15]NumFacture:3#"@A")  // sans compter les avoirs
SELECTION TO ARRAY:C260([Factures:15]NumFacture:3;$TbNumDeLaFacture)

RELATE MANY SELECTION:C340([Ventes:16]NumFacture:2)
QUERY SELECTION:C341([Ventes:16];[Ventes:16]DateVente:4=!00-00-00!)  // les non payées
SELECTION TO ARRAY:C260([Ventes:16]NumFacture:2;$TbNumFacture;[Ventes:16]DateVente:4;$TbDateF)

  // l'année dernière
$AnPrécedentA:="20"+String:C10(Num:C11(<>ZPermMille)-1)
$RaemaMarsAnPrécedent:=RaemaTrouveNumCampagneParAn (Num:C11($AnPrécedentA);1)
$RaemaOctobreAnPrécedent:=RaemaTrouveNumCampagneParAn (Num:C11($AnPrécedentA);3)
$TestMars:=NumLaboActuelA+"_"+$RaemaMarsAnPrécedent+"_@"
$TestOctobre:=NumLaboActuelA+"_"+$RaemaOctobreAnPrécedent+"_@"
$ParticipeAnDernier:=((Find in array:C230(<>TbLotoIdentifiantParticipation;$TestMars)>0) | (Find in array:C230(<>TbLotoIdentifiantParticipation;$TestOctobre)>0))

$L:=Find in array:C230($TbNumFacture;($AnPrécedentA+"/RT@"))
If ($L<0) & ($ParticipeAnDernier)
	$PayeAnPrécedent:=False:C215
Else 
	$PayeAnPrécedent:=True:C214
	If ($L>0)
		OB SET:C1220($Objet;"NumFactureAnPrécedent";$TbNumFacture{$L})
	Else 
		OB REMOVE:C1226($Objet;"NumFactureAnPrécedent")
	End if 
End if 
OB SET:C1220($Objet;"PayeAnPrécedent";$PayeAnPrécedent)

  // Cette année
$L:=Find in array:C230($TbNumFacture;(<>ZPermMille+"/RT@"))
$L2:=Find in array:C230($TbNumDeLaFacture;(<>ZPermMille+"/RT@"))
$PayeAnActuel:=($L<0) | ($L2<0)
If ($L2>0)
	OB SET:C1220($Objet;"NumFactureAnCourant";$TbNumDeLaFacture{$L2})
End if 
OB SET:C1220($Objet;"PayeAnActuel";$PayeAnActuel)

  // Où en est-on de la période :  1=saisie des résultats, 2=disponibilité des contaminations, 3=disponibilité des rapports
C_TEXT:C284($CDRapport)
QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUIDPersonne:2=$UUIDLaBO;*)
QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]NumCampagne:3=<>NumCampagneEnCoursSaisie)
$CDRapport:=[CampagneParticipations:17]Arguments:5.CheminDocument
$RapportDispo:=($CDRapport#"")
$CodePériode:=1+Num:C11(<>NumCampagneEnCoursSaisie=<>NumCampagneEnCoursInfoOK)+Num:C11($RapportDispo)
OB SET:C1220($Objet;"CodePériode";$CodePériode)
$OuEnSommesNous:=WebEspaceHTMLOuEnSommesNous ($Objet;$Langue)
$THTML:=""
$THTML:=$THTML+"<!DOCTYPE html>"+<>ZCR
$THTML:=$THTML+"<html>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+"  <head>"+<>ZCR
$THTML:=$THTML+"    <!--4dinclude HeaderRaema.shtml-->"+<>ZCR
$THTML:=$THTML+"    <link href="+<>ZGuil+"styles/style-espace-participants.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/raema.js"+<>ZGuil+"></script>"+<>ZCR

$THTML:=$THTML+"    <title>Accès participants</title>"+<>ZCR
$THTML:=$THTML+"  </head>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+"  <body>"+<>ZCR
$THTML:=$THTML+"    <input type="+<>ZGuil+"hidden"+<>ZGuil+" id="+<>ZGuil+"UUIDLabo"+<>ZGuil+" value="+<>ZGuil+$UUIDLabo+<>ZGuil+" />  "+<>ZCR
$THTML:=$THTML+"    <div id="+<>ZGuil+"header"+<>ZGuil+" align="+<>ZGuil+"center"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <a href="+<>ZGuil+"../index.shtml"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <img src="+<>ZGuil+"../images/bandeau.jpg"+<>ZGuil+"alt="+<>ZGuil+"logo"+<>ZGuil+" width="+<>ZGuil+"1009"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"      </a>"+<>ZCR
$InitialeInverse:=(Num:C11($Langue="F")*"A")+(Num:C11($Langue="A")*"F")
$THTML:=$THTML+"      <a id="+<>ZGuil+"flagA"+<>ZGuil+" href="+<>ZGuil+"espaceclient"+$InitialeInverse+$UUIDLabo+<>ZGuil+">"+<>ZCR
$Pays:=(Num:C11($Langue="F")*"français")+(Num:C11($Langue="A")*"anglais")
$THTML:=$THTML+"        <img src="+<>ZGuil+"../images/Drapeau"+$InitialeInverse+".gif"+<>ZGuil+" alt="+<>ZGuil+"drapeau "+$Pays+<>ZGuil+" width="+<>ZGuil+"30px"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"      </a>"+<>ZCR
$THTML:=$THTML+"      <p class="+<>ZGuil+"hautpage"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        Pour revenir au site de l'ASA, cliquer sur le dessin ci-dessus"+<>ZCR
$THTML:=$THTML+"      </p>"+<>ZCR
$THTML:=$THTML+"    </div>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+"    <div id="+<>ZGuil+"corps"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <div class="+<>ZGuil+"TitreRenseignements"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <br />"+WebTraduitTexte ("Bienvenue";$Langue)+" "+$NomLabo+"<br />"+<>ZCR
$THTML:=$THTML+"      </div>"+<>ZCR2


  // le bloc de gauche = bandeau des accès
$THTML:=$THTML+"      <div class="+<>ZGuil+"acces"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"          <div class="+<>ZGuil+"TitreEncadre"+<>ZGuil+">"+<>ZCR+WebTraduitTexte ("Accès";$Langue)+<>ZCR+"</div><br />"+<>ZCR
$THTML:=$THTML+"          <br />"+<>ZCR
$THTML:=$THTML+"          <div class="+<>ZGuil+"LienAcces"+<>ZGuil+">"+<>ZCR
  // $THTML:=$THTML+"            <a href="+<>ZGuil+"DonneesPersonnelles"+Chaîne($LigneTbGnx)+<>ZGuil+">"
$THTML:=$THTML+"            <a href="+<>ZGuil+"DonneesPersonnelles"+$Langue+$UUIDLabo+String:C10($LigneTbGnx)+<>ZGuil+">"
$THTML:=$THTML+"              <img src="+<>ZGuil+"images/DonneesPerso.png"+<>ZGuil+" alt="+<>ZGuil+WebTraduitTexte ("Accéder à vos données personnelles";$Langue)+<>ZGuil
$THTML:=$THTML+" width="+<>ZGuil+"30px"+<>ZGuil+" /><br />"+<>ZCR
$THTML:=$THTML+"                "+WebTraduitTexte ("Accéder à vos données personnelles";$Langue)+<>ZCR
$THTML:=$THTML+"            </a>"
$THTML:=$THTML+"          </div>"+<>ZCR
$THTML:=$THTML+"          <br />"+<>ZCR2

$THTML:=$THTML+"          <div class="+<>ZGuil+"TitreEncadre"+<>ZGuil+">"+<>ZCR+WebTraduitTexte ("Commande";$Langue)+<>ZCR+"</div><br />"+<>ZCR

$THTML:=$THTML+"            <div class="+<>ZGuil+"LienAcces"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"              <a href="+<>ZGuil+"DevisGel"+$UUIDLabo+<>ZGuil+">"
$THTML:=$THTML+"                <img src="+<>ZGuil+"images/DevisRaemaGel.png"+<>ZGuil+" alt="+<>ZGuil+"Devis RAEMA Gel"+<>ZGuil
$THTML:=$THTML+" width="+<>ZGuil+"30px"+<>ZGuil+"/><br />"+<>ZCR
$THTML:=$THTML+"                <br />"+WebTraduitTexte ("Générer mon devis RAEMA Gel";$Langue)+"<br />"+<>ZCR
$THTML:=$THTML+"              </a>"
$THTML:=$THTML+"            </div>"+<>ZCR2

$THTML:=$THTML+"          <div class="+<>ZGuil+"LienAcces"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"            <a href="+<>ZGuil+"pdf/BoitesIsoRaemafr.pdf"+<>ZGuil+">"
$THTML:=$THTML+"              <img src="+<>ZGuil+"images/BoiteIsotherme.png"+<>ZGuil+" alt="+<>ZGuil+"Boite isotherme"+<>ZGuil
$THTML:=$THTML+" width="+<>ZGuil+"30px"+<>ZGuil+"/><br />"+<>ZCR
$THTML:=$THTML+"              <br />"+WebTraduitTexte ("Télécharger BdC des boites isothermes";$Langue)+"<br />"+<>ZCR
$THTML:=$THTML+"            </a>"
$THTML:=$THTML+"          </div>"+<>ZCR2

$THTML:=$THTML+"          <div class="+<>ZGuil+"LienAcces"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"            <a href="+<>ZGuil+"pdf/ColisSuppRaemafr.pdf"+<>ZGuil+">"
$THTML:=$THTML+"              <img src="+<>ZGuil+"images/ColisSupplementaire.png"+<>ZGuil+" alt="+<>ZGuil+"Colis supplémentaire"+<>ZGuil+" width="+<>ZGuil+"30px"+<>ZGuil+"/><br />"+<>ZCR
$THTML:=$THTML+"              <br />"+WebTraduitTexte ("Télécharger BdC des colis supplémentaires";$Langue)+"<br />"+<>ZCR
$THTML:=$THTML+"            </a>"
$THTML:=$THTML+"          </div>"+<>ZCR2

$THTML:=$THTML+"          <div class="+<>ZGuil+"TitreEncadre"+<>ZGuil+">"+<>ZCR+WebTraduitTexte ("Documents";$Langue)+<>ZCR+"</div><br />"+<>ZCR
$THTML:=$THTML+"          <div class="+<>ZGuil+"LienAcces"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"            <a href="+<>ZGuil+"PGtéléchargementsRap_"+$UUIDLabo+".pdf"+<>ZGuil+">"
$THTML:=$THTML+"              <img src="+<>ZGuil+"images/TelechargerRapport.png"+<>ZGuil+" alt="+<>ZGuil+"Téléchargement rapport"+<>ZGuil+" width="+<>ZGuil+"30px"+<>ZGuil+"/><br />"+<>ZCR
$THTML:=$THTML+"              <br />"+WebTraduitTexte ("Télécharger un rapport antérieur";$Langue)+"<br />"+<>ZCR
$THTML:=$THTML+"            </a>"
$THTML:=$THTML+"          </div>"+<>ZCR2

$THTML:=$THTML+"          <div class="+<>ZGuil+"LienAcces"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"            <a href="+<>ZGuil+"PGtéléchargementsAtt_"+$UUIDLabo+".pdf"+<>ZGuil+">"
$THTML:=$THTML+"              <img src="+<>ZGuil+"images/TelechargerAttestation.jpg"+<>ZGuil+" alt="+<>ZGuil+"Téléchargement attestation"+<>ZGuil+" width="+<>ZGuil+"30px"+<>ZGuil+"/><br />"+<>ZCR
$THTML:=$THTML+"              <br />"+WebTraduitTexte ("Télécharger une attestation";$Langue)+"<br />"+<>ZCR
$THTML:=$THTML+"            </a>"
$THTML:=$THTML+"          </div>"+<>ZCR2

$THTML:=$THTML+"          <div class="+<>ZGuil+"LienAcces"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"            <a href="+<>ZGuil+"pdf/PROG0701EN02.pdf"+<>ZGuil+">"
$THTML:=$THTML+"              <img src="+<>ZGuil+"images/Reclamation.png"+<>ZGuil+" alt="+<>ZGuil+"Fiche de réclamation"+<>ZGuil+" width="+<>ZGuil+"30px"+<>ZGuil+"/><br />"+<>ZCR
$THTML:=$THTML+"              <br />"+WebTraduitTexte ("Télécharger la fiche de réclamation";$Langue)+"<br />"+<>ZCR
$THTML:=$THTML+"            </a>"
$THTML:=$THTML+"          </div>"+<>ZCR2

$THTML:=$THTML+"          <div class="+<>ZGuil+"LienAcces"+<>ZGuil+">"+<>ZCR

Case of 
		  // Colis sans pathogène
	: ($SansPathogène)
		$THTML:=$THTML+"            <a href="+<>ZGuil+"pdf/LettreAccompSansPatho.pdf"+<>ZGuil+">"
		
		  // Colis supp
	: ((($ColisSuppSR) | ($ColisSuppAR))>0)
		$THTML:=$THTML+"            <a href="+<>ZGuil+"pdf/LettreAccompColisSup.pdf"+<>ZGuil+">"
		
	Else 
		  // Colis normal
		$THTML:=$THTML+"            <a href="+<>ZGuil+"pdf/LettreAccompNormal.pdf"+<>ZGuil+">"
		
End case 
$THTML:=$THTML+"              <img src="+<>ZGuil+"images/DocumentAccompagnement.png"+<>ZGuil+" alt="+<>ZGuil+"Document d'accompagnement"+<>ZGuil+" width="+<>ZGuil+"30px"+<>ZGuil+"/><br />"+<>ZCR
$THTML:=$THTML+"                <br />"+WebTraduitTexte ("Télécharger les documents d’accompagnement";$Langue)+"<br />"+<>ZCR
$THTML:=$THTML+"            </a>"
$THTML:=$THTML+"          </div>"+<>ZCR2

$THTML:=$THTML+"            <div class="+<>ZGuil+"LienAcces"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"              <a href="+<>ZGuil+"PGtéléchargementsFac_"+$UUIDLabo+".pdf"+<>ZGuil+">"
$THTML:=$THTML+"                <img src="+<>ZGuil+"images/Facturation.png"+<>ZGuil+" alt="+<>ZGuil+"Facturation"+<>ZGuil+" width="+<>ZGuil+"30px"+<>ZGuil+"/><br />"+<>ZCR
$THTML:=$THTML+"                <br />"+WebTraduitTexte ("Télécharger vos factures";$Langue)+"<br />"+<>ZCR
$THTML:=$THTML+"              </a>"
$THTML:=$THTML+"            </div>"+<>ZCR2

$THTML:=$THTML+"      </div>"+<>ZCR2


  // le bloc de droite = les RAEMA
$THTML:=$THTML+"      <div class="+<>ZGuil+"AccesRapideNews"+<>ZGuil+">"+<>ZCR2

$THTML:=$THTML+"          <div class="+<>ZGuil+"news"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"            <p class="+<>ZGuil+"TitreEncadreNews"+<>ZGuil+" id="+<>ZGuil+"OuEnSommesNous"+<>ZGuil+">"+<>ZCR+WebTraduitTexte ("Où en sommes-nous";$Langue)+<>ZCR+"?"+"</p>"+<>ZCR
$THTML:=$THTML+"            "+$OuEnSommesNous+<>ZCR
$THTML:=$THTML+"            </p>"+<>ZCR
$THTML:=$THTML+"          </div>"+<>ZCR2


  // Ou en est-on dans le cycle du point de vue des téléchargements ?
ARRAY TEXT:C222($TbNumCampagne;4)
$Moinsse:=-Num:C11($CodePériode#3)  // si la campagne actuelle a produit son rapport, on se base sur elle pour avoir les 3 autres
$L:=Find in array:C230(<>TbCampagnesNumCampagne;<>NumCampagneEnCoursSaisie)  // <>TbCampagnesNumCampagne est initialisé dans ASAPFabriqueTbToutesCampagnes

$TbNumCampagne{1}:=<>TbCampagnesNumCampagne{$L+$Moinsse}
$TbNumCampagne{2}:=<>TbCampagnesNumCampagne{$L+$Moinsse-1}
$TbNumCampagne{3}:=<>TbCampagnesNumCampagne{$L+$Moinsse-2}
$TbNumCampagne{4}:=<>TbCampagnesNumCampagne{$L+$Moinsse-3}


  // Division "Accès rapide au téléchargement"
$THTML:=$THTML+"          <div class="+<>ZGuil+"news"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"            <p class="+<>ZGuil+"TitreEncadreNews"+<>ZGuil+">"+<>ZCR+WebTraduitTexte ("Accès rapide aux  téléchargements";$Langue)+<>ZCR+"</p>"+<>ZCR
$THTML:=$THTML+"            <p class="+<>ZGuil+"Informations"+<>ZGuil+">"+<>ZCR+WebTraduitTexte ("Cliquez sur les boutons des documents désirés";$Langue)+<>ZCR+":"+"</p>"+<>ZCR
$THTML:=$THTML+"              <table class="+<>ZGuil+"Tableau"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"                <tr>"+<>ZCR
$THTML:=$THTML+"                  <th>"+<>ZCR+WebTraduitTexte ("Campagne";$Langue)+<>ZCR+"</th>"+<>ZCR
$THTML:=$THTML+"                  <th>"+<>ZCR+WebTraduitTexte ("Rapport individuel";$Langue)+<>ZCR+"</th>"+<>ZCR
$THTML:=$THTML+"                  <th>"+<>ZCR+WebTraduitTexte ("Rapport général";$Langue)+<>ZCR+"</th>"+<>ZCR
$THTML:=$THTML+"                  <th>"+<>ZCR+WebTraduitTexte ("Attestation";$Langue)+<>ZCR+"</th>"+<>ZCR
$THTML:=$THTML+"                </tr>"+<>ZCR2

  // Le rapport individuel
$TT:=Size of array:C274(TbNumLaboRaemaLiés)  // ajoutons les éventuels RAEMA liés
For ($Salé;1;4)
	$NumCampagneCourante:=$TbNumCampagne{$Salé}
	
	  // test des raema liés
	$Test:=NumLaboActuelA+"_"+$NumCampagneCourante+"_@"
	ARRAY TEXT:C222($TbNumRaemaLiésA;0)
	$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$Test)  // Le laboratoire maître ou normal
	Repeat 
		$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$Test;($L+1))  // Les éventuels suivants
		If ($L>0)
			APPEND TO ARRAY:C911($TbNumRaemaLiésA;String:C10(RAEMADemoduleMdPWeb (<>TbLotoCodeRaemaLié{$L})))
		End if 
	Until ($L<0)
	$TTT:=Size of array:C274($TbNumRaemaLiésA)
	
	  // Le HTML du tableau
	$THTML:=$THTML+"                <tr>"+<>ZCR
	$THTML:=$THTML+"                  <td class="+<>ZGuil+"Plus"+<>ZGuil+">"+$NumCampagneCourante+"</td>"+<>ZCR
	$THTML:=$THTML+"                  <td class="+<>ZGuil+"LienAcces"+<>ZGuil+">"+<>ZCR
	  // Le RI principal
	$CD:=<>PermCheDosRap+NumLaboActuelA+Séparateur dossier:K24:12+"RI"+$NumCampagneCourante+"_"+NumLaboActuelA+".pdf"
	If (Test path name:C476($CD)=Est un document:K24:1)
		$CDDoc:="telechargementRI"+$NumCampagneCourante+"_"+$UUIDLaBO+".pdf"
		$THTML:=$THTML+"                    <a href="+<>ZGuil+$CDDoc+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"                      <img src="+<>ZGuil+"images/TelechargerRapport.png"+<>ZGuil+" alt="+<>ZGuil+"Téléchargement rapport individuel"+<>ZGuil
		$THTML:=$THTML+" width="+<>ZGuil+"30px"+<>ZGuil+"/>"+(Num:C11($TTT>0)*(NumLaboActuelA+"   "))
		$THTML:=$THTML+"                    </a>"+<>ZCR
	Else 
		$THTML:=$THTML+"                      <img src="+<>ZGuil+"images/TelechargerRapportNB.png"+<>ZGuil+" alt="+<>ZGuil+"Téléchargement rapport individuel non disponible"+<>ZGuil
		$THTML:=$THTML+" width="+<>ZGuil+"30px"+<>ZGuil+"/>"
	End if 
	
	
	  // RI liés
	For ($Fumé;1;$TTT)
		$CD:=<>PermCheDosRap+$TbNumRaemaLiésA{$Fumé}+Séparateur dossier:K24:12+"RI"+$NumCampagneCourante+"_"+$TbNumRaemaLiésA{$Fumé}+".pdf"
		If (Test path name:C476($CD)=Est un document:K24:1)
			$CDDoc:="telechargementRI"+$TbNumCampagne{$Salé}+"_"+$TbNumRaemaLiésA{$Fumé}+".pdf"
			$THTML:=$THTML+"                       <a href="+<>ZGuil+$CDDoc+<>ZGuil+">"+<>ZCR
			$THTML:=$THTML+"                      <img src="+<>ZGuil+"images/TelechargerRapport.png"+<>ZGuil+" alt="+<>ZGuil+"Téléchargement rapport individuel"+<>ZGuil
			$THTML:=$THTML+" width="+<>ZGuil+"30px"+<>ZGuil+"/>"+$TbNumRaemaLiésA{$Fumé}+<>ZCR
			$THTML:=$THTML+"                    </a>"+<>ZCR
		Else 
			$THTML:=$THTML+"                      <img src="+<>ZGuil+"images/TelechargerRapportNB.png"+<>ZGuil+" alt="+<>ZGuil+"Téléchargement rapport individuel non disponible"+<>ZGuil
			$THTML:=$THTML+" width="+<>ZGuil+"30px"+<>ZGuil+"/>"+$TbNumRaemaLiésA{$Fumé}
		End if 
	End for 
	$THTML:=$THTML+"                  </td>"+<>ZCR
	
	  // Le rapport général
	$THTML:=$THTML+"                  <td>"+<>ZCR
	$CD:=<>PermCheDosPdf+"RG"+$TbNumCampagne{$Salé}+".pdf"
	If (Test path name:C476($CD)=Est un document:K24:1)
		$THTML:=$THTML+"                    <a href="+<>ZGuil+"PDF/RG"+$TbNumCampagne{$Salé}+".pdf"+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"                      <img src="+<>ZGuil+"images/RapportGeneral.png"+<>ZGuil+" alt="+<>ZGuil+"Téléchargement rapport général"+<>ZGuil
		$THTML:=$THTML+" width="+<>ZGuil+"30px"+<>ZGuil+" />"+<>ZCR
		$THTML:=$THTML+"                    </a>"+<>ZCR
	Else 
		$THTML:=$THTML+"                      <img src="+<>ZGuil+"images/RapportGeneralNB.png"+<>ZGuil+" alt="+<>ZGuil+"Téléchargement rapport général non disponible"+<>ZGuil
		$THTML:=$THTML+" width="+<>ZGuil+"30px"+<>ZGuil+" />"+<>ZCR
	End if 
	$THTML:=$THTML+"                  </td>"+<>ZCR
	
	
	  // les attestations
	$THTML:=$THTML+"                  <td class="+<>ZGuil+"LienAcces"+<>ZGuil+">"+<>ZCR
	$CD:=<>PermCheDosRap+NumLaboActuelA+Séparateur dossier:K24:12+"RI"+$TbNumCampagne{$Salé}+"_"+NumLaboActuelA+".pdf"
	If (Test path name:C476($CD)=Est un document:K24:1)
		$THTML:=$THTML+"                    <a href="+<>ZGuil+"telechargementAt"+$TbNumCampagne{$Salé}+"_"+$UUIDLabo+".pdf"+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"                      <img src="+<>ZGuil+"images/TelechargerAttestation.png"+<>ZGuil+" alt="+<>ZGuil+"Téléchargement attestation"+<>ZGuil
		$THTML:=$THTML+" width="+<>ZGuil+"30px"+<>ZGuil+" />"+(Num:C11($TTT>0)*(NumLaboActuelA+"   "))+<>ZCR
		$THTML:=$THTML+"                    </a>"+<>ZCR
	Else 
		$THTML:=$THTML+"                      <img src="+<>ZGuil+"images/TelechargerAttestationNB.png"+<>ZGuil+" alt="+<>ZGuil+"Téléchargement attestation non disponible"+<>ZGuil+" width="+<>ZGuil+"30px"+<>ZGuil+" />"+<>ZCR
	End if 
	For ($Fumé;1;$TTT)
		$CD:=<>PermCheDosRap+$TbNumRaemaLiésA{$Fumé}+Séparateur dossier:K24:12+"RI"+$TbNumCampagne{$Salé}+"_"+$TbNumRaemaLiésA{$Fumé}+".pdf"
		If (Test path name:C476($CD)=Est un document:K24:1)
			$THTML:=$THTML+"                    <a href="+<>ZGuil+"telechargementAt"+$TbNumCampagne{$Salé}+"_"+$TbNumRaemaLiésA{$Fumé}+".pdf"+<>ZGuil+">"+<>ZCR
			$THTML:=$THTML+"                      <img src="+<>ZGuil+"images/TelechargerAttestation.png"+<>ZGuil+" alt="+<>ZGuil+"Téléchargement attestation"+<>ZGuil
			$THTML:=$THTML+" width="+<>ZGuil+"30px"+<>ZGuil+"/>"+$TbNumRaemaLiésA{$Fumé}+<>ZCR
			$THTML:=$THTML+"                    </a>"+<>ZCR
		Else 
			$THTML:=$THTML+"                      <img src="+<>ZGuil+"images/TelechargerAttestationNB.png"+<>ZGuil+" alt="+<>ZGuil+"Téléchargement attestation non disponible"+<>ZGuil
			$THTML:=$THTML+" title="+<>ZGuil+"Téléchargement attestation non disponible"+<>ZGuil+" width="+<>ZGuil+"30px"+<>ZGuil+"/>"+<>ZCR
		End if 
	End for 
	$THTML:=$THTML+"                  </td>"+<>ZCR
	$THTML:=$THTML+"                </tr>"+<>ZCR2
End for 

$THTML:=$THTML+"              </table>"+<>ZCR2

$THTML:=$THTML+"          </div>"+<>ZCR2  // fin de la division "Accès rapide au téléchargement"

  // Division "Calendrier des RAEMA" : attente des propositions de l'ASA
$L:=Find in array:C230(<>TbCampagnesNumCampagne;<>NumCampagneEnCoursSaisie)
$TT:=Size of array:C274(<>TbCampagnesNumCampagne)
If ($TT>$L)  // on n'affiche l'avenir que s'il eiste
	$THTML:=$THTML+"          <div class="+<>ZGuil+"news"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"              <p class="+<>ZGuil+"TitreEncadreNews"+<>ZGuil+">"+<>ZCR+WebTraduitTexte ("Calendrier des RAEMA";$Langue)+<>ZCR+"</p>"+<>ZCR
	
	For ($Salé;$L;$TT)
		$NumCampagne:=<>TbCampagnesNumCampagne{$Salé}
		QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$NumCampagne)
		If ([RAEMACampagnes:20]DateEnvoiColis:3<Current date:C33)
			$infos:=WebTraduitTexte ("Les échantillons ont été envoyés le";$Langue)+" "+String:C10(<>TbCampagnesDateEnvoiColis{$Salé};3)+"</b><br />"+<>ZCR
		Else 
			$infos:=WebTraduitTexte ("Les échantillons seront envoyés le";$Langue)+" "+String:C10(<>TbCampagnesDateEnvoiColis{$Salé};3)+"</b><br />"+<>ZCR
		End if 
		$infos:=$infos+WebTraduitTexte ("La date limite de rendu des résultats est fixée au";$Langue)+" "+String:C10(<>TbCampagnesDateLimiteReponse{$Salé};3)+"</b>"+<>ZCR
		$THTML:=$THTML+"            <div class="+<>ZGuil+"Bloc"+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"              <p class="+<>ZGuil+"Informations"+<>ZGuil+">"+<>ZCR+WebTraduitTexte ("Campagne";$Langue)+<>ZCR+$NumCampagne+" :</p>"+<>ZCR
		$THTML:=$THTML+"              <p class="+<>ZGuil+"TextGris"+<>ZGuil+">"+$infos
		$THTML:=$THTML+"              </p>"+<>ZCR
		$THTML:=$THTML+"              <br />"+<>ZCR
		$THTML:=$THTML+"            </div>"+<>ZCR
	End for 
	
	
	$THTML:=$THTML+"          </div>"+<>ZCR2
End if 

  // Division "Participation" : on affiche les RAEMA de l'année uniquement
$RaemaAnnuel1:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);1)
$Test:=NumLaboActuelA+"_"+$RaemaAnnuel1+"_"
$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$Test)
$NomImage1:=(Num:C11($L>0)*"Valider")+(Num:C11($L<0)*"Annuler")
$Alt1:=(Num:C11($L<0)*"Ne participe pas")+(Num:C11($L>0)*"Participe")

$RaemaAnnuel2:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);2)
$Test:=NumLaboActuelA+"_"+$RaemaAnnuel2+"_"
$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$Test)
$NomImage2:=(Num:C11($L>0)*"Valider")+(Num:C11($L<0)*"Annuler")
$Alt2:=(Num:C11($L<0)*"Ne participe pas")+(Num:C11($L>0)*"Participe")

$RaemaAnnuel3:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);3)
$Test:=NumLaboActuelA+"_"+$RaemaAnnuel3+"_"
$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$Test)
$NomImage3:=(Num:C11($L>0)*"Valider")+(Num:C11($L<0)*"Annuler")
$Alt3:=(Num:C11($L<0)*"Ne participe pas")+(Num:C11($L>0)*"Participe")

$RaemaAnnuel4:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);4)
$Test:=NumLaboActuelA+"_"+$RaemaAnnuel4+"_"
$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$Test)
$NomImage4:=(Num:C11($L>0)*"Valider")+(Num:C11($L<0)*"Annuler")
$Alt4:=(Num:C11($L<0)*"Ne participe pas")+(Num:C11($L>0)*"Participe")

$THTML:=$THTML+"          <div class="+<>ZGuil+"news"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"            <p class="+<>ZGuil+"TitreEncadreNews"+<>ZGuil+">"+<>ZCR+WebTraduitTexte ("Participation";$Langue)+<>ZCR+"</p>"+<>ZCR
$THTML:=$THTML+"            <p class="+<>ZGuil+"Informations"+<>ZGuil+">"+<>ZCR+WebTraduitTexte ("Vous êtes inscrit aux RAEMA";$Langue)+<>ZCR+":"+"</p>"+<>ZCR
$THTML:=$THTML+"            <table class="+<>ZGuil+"Tableau"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"              <tr>"+<>ZCR
$THTML:=$THTML+"                <td class="+<>ZGuil+"Plus"+<>ZGuil+">"+<>ZCR+WebTraduitTexte ("Campagne";$Langue)+<>ZCR+"</td>"+<>ZCR
$THTML:=$THTML+"                <td>"+$RaemaAnnuel1+"</td>"+<>ZCR
$THTML:=$THTML+"                <td>"+$RaemaAnnuel2+"</td>"+<>ZCR
$THTML:=$THTML+"                <td>"+$RaemaAnnuel3+"</td>"+<>ZCR
$THTML:=$THTML+"                <td>"+$RaemaAnnuel4+"</td>"+<>ZCR
$THTML:=$THTML+"              </tr>"+<>ZCR
$THTML:=$THTML+"              <tr>"+<>ZCR
$THTML:=$THTML+"                <td class="+<>ZGuil+"Plus"+<>ZGuil+">"+<>ZCR+WebTraduitTexte ("Inscription";$Langue)+<>ZCR+"</td>"+<>ZCR
$THTML:=$THTML+"                <td><img src="+<>ZGuil+"images/"+$NomImage1+".png"+<>ZGuil+" alt="+<>ZGuil+$Alt1+<>ZGuil+" width="+<>ZGuil+"30px"+<>ZGuil+"/> </td>"+<>ZCR
$THTML:=$THTML+"                <td><img src="+<>ZGuil+"images/"+$NomImage2+".png"+<>ZGuil+" alt="+<>ZGuil+$Alt2+<>ZGuil+" width="+<>ZGuil+"30px"+<>ZGuil+"/> </td>"+<>ZCR
$THTML:=$THTML+"                <td><img src="+<>ZGuil+"images/"+$NomImage3+".png"+<>ZGuil+" alt="+<>ZGuil+$Alt3+<>ZGuil+" width="+<>ZGuil+"30px"+<>ZGuil+"/> </td>"+<>ZCR
$THTML:=$THTML+"                <td><img src="+<>ZGuil+"images/"+$NomImage4+".png"+<>ZGuil+" alt="+<>ZGuil+$Alt4+<>ZGuil+" width="+<>ZGuil+"30px"+<>ZGuil+"/> </td>"+<>ZCR
$THTML:=$THTML+"              </tr>"+<>ZCR
$THTML:=$THTML+"            </table>"+<>ZCR
$THTML:=$THTML+"          </div>"+<>ZCR
$THTML:=$THTML+ResRaemaCréationPied 
$0:=$THTML