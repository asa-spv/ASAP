//%attributes = {}
  // RaemaInfEcritP2  <= RaemaInfEcritP2
  // Ecrit la page Web avec le tableau des contaminations 
  // Germes en colonne (11 lignes de Colonne1), 
  // N° d'échantillon 5 colonnes suivantes, contamination

C_TEXT:C284($NiveauGel)

$NumRaema:=<>NumCampagneEnCoursInfoOK
QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$NumRaema)
$Niveau:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"Niveaux de contamination";Est un texte:K8:3)
If (Length:C16($Niveau)<60)
	$NumRaema:=String:C10(Num:C11($NumRaema)-1)
End if 
QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$NumRaema)
$TbContaTexte:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"Niveaux de contamination";Est un texte:K8:3)

  // traitement du Raema Gel : ajout cgm du 9 septembre 2016
  // initialisation des variables
$TexteConta:=""  // valeurs à afficher
$Gel:=0  // pas de valeurs cibles pour les deux derniers RAEMA gel
$Poudre:=True:C214  // participation au Raema poudre`
$OC:=True:C214
$NumRaemaGel:=""  // le bon raema gel
  // Quel Raema gel faire apparaître ?

  // Test du RAEMA gel suivant le Raema poudre courant ($NumRaema)
$Test:=$NumRaema+"A"
QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$Test)
$Niveau:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"Niveaux de contamination";Est un texte:K8:3)
If (Length:C16($Niveau)>10)  // Il existe des valeurs cibles pour le Gel suivant
	$Gel:=1  // Le bon raema gel est le suivant
Else 
	  // Test du RAEMA gel précédant le Raema poudre courant ($NumRaema)
	$NR:=String:C10(Num:C11($NumRaema)-1)
	$Test:=$NR+"A"
	QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$Test)
	$NiveauGel:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"Niveaux de contamination";Est un texte:K8:3)
	If (Length:C16($Niveau)>10)  // Il existe des valeurs cibles pour le Gel précédent
		$Gel:=2  // Le bon raema gel est le précédant
	End if 
End if 
$NumRaemaGel:=$Test



$UUID:=WebTrouveValeurParNom (MotDePasseActuel;-><>TbPerIdentificateur;-><>TbPerUUID)
QUERY:C277([WebConnexions:13];[WebConnexions:13]Campagne:5=$NumRaema;*)
QUERY:C277([WebConnexions:13]; & [WebConnexions:13]BoolEnvoi:8=True:C214;*)
QUERY:C277([WebConnexions:13]; & [WebConnexions:13]CodeConnexion:4=$UUID)
ORDER BY:C49([WebConnexions:13];[WebConnexions:13]NumEnvoi:9;<)  // très évangélique : met le dernier en premier
ARRAY TEXT:C222(TbNumEch;0)
ARRAY TEXT:C222(TbNumEchT;0)
ARRAY LONGINT:C221($TbNumEnrRaemaRetenu;0)
ARRAY TEXT:C222($TbNomsP2;0)
ARRAY TEXT:C222($TbValeursP2;0)
ARRAY TEXT:C222($TbNomsP3;0)
ARRAY TEXT:C222($TbValeursP3;0)
ARRAY TEXT:C222($TbTexteResume;0)
ARRAY TEXT:C222($TbPJMailRaema;0)

ZBlobVersVariable (->[WebConnexions:13]BlobConnexion:11;->TbNumEch;->TbNumEchT;->$TbNumEnrRaemaRetenu;->$TbNomsP2;->$TbValeursP2;->$TbNomsP3;->$TbValeursP3;->$TbTexteResume;->$TbPJMailRaema)
VarNomTableau:="Niveau de contamination du RAEMA "+$NumRaema
QUERY:C277([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3=($NumRaema+"@"))
ORDER BY:C49([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3;>)
ARRAY TEXT:C222(TbNomGermeConta;0)
If (LangueCourante="F")
	SELECTION TO ARRAY:C260([RAEMAGermes:21]NomFr:4;TbNomGermeConta)
Else 
	SELECTION TO ARRAY:C260([RAEMAGermes:21]NomEn:5;TbNomGermeConta)
End if 
RaemaFabriqueLBContamination ($TbContaTexte;$NumRaema)


  // L'en-tete
$Texte:=ResRaemaCréationET ("Tableau des niveaux de contamination")

If ($Gel=1)  // le suivant RAEMA gel a des contaminations
	$Texte:=$Texte+"        <br /><br />"+InfRAEMACreationTbContaGel ($TexteConta;$NumRaemaGel)
End if 
$Texte:=$Texte+InfRAEMACreationTitreConta ($NumRaema)
$Texte:=$Texte+InfRAEMACreationTbConta 
  // Le questionnaire
$THTML:=""
$THTML:=$THTML+"<form action="+<>ZGuil+"mw2RaemaInfP2"+<>ZGuil+" method="+<>ZGuil+"post"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+" <input type="+<>ZGuil+"hidden"+<>ZGuil+" name="+<>ZGuil+"Hiddenfield"+<>ZGuil+" value="+<>ZGuil+MotDePasseActuel+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"            <br> <br> "+<>ZCR
$THTML:=$THTML+"            <p class="+<>ZGuil+"titrepage"+<>ZGuil+">Si vous désirez avoir le niveau de contamination d'échantillons d'après leur n°,"+<>ZCR
$THTML:=$THTML+"                <br />"+<>ZCR
$THTML:=$THTML+"                prière de les saisir ci-dessous et de cliquer sur le bouton "+<>ZGuil+"Obtenir"+<>ZGuil
$THTML:=$THTML+"            </p>"+<>ZCR
$THTML:=$THTML+"            <div align="+<>ZGuil+"center"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"                <table width="+<>ZGuil+"40%"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"                    <tr class="+<>ZGuil+"hauttb2"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"                        <td>"+<>ZCR
$THTML:=$THTML+"                           N° du premier échantillon"+<>ZCR
$THTML:=$THTML+"                        </td>"+<>ZCR
$THTML:=$THTML+"                        <td >"+<>ZCR
$THTML:=$THTML+"                           <input class="+<>ZGuil+"textebanalgrand"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" name="+<>ZGuil+"Ech1"+<>ZGuil+" size="+<>ZGuil+"5"+<>ZGuil+" maxlength="+<>ZGuil+"6"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"                        </td>"+<>ZCR
$THTML:=$THTML+"                    </tr>"+<>ZCR
$THTML:=$THTML+"                    <tr class="+<>ZGuil+"hauttb2"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"                        <td>"+<>ZCR
$THTML:=$THTML+"                           N° du deuxième échantillon"+<>ZCR
$THTML:=$THTML+"                        </td>"+<>ZCR
$THTML:=$THTML+"                        <td >"+<>ZCR
$THTML:=$THTML+"                           <input class="+<>ZGuil+"textebanalgrand"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" name="+<>ZGuil+"Ech2"+<>ZGuil+" size="+<>ZGuil+"5"+<>ZGuil+" maxlength="+<>ZGuil+"6"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"                        </td>"+<>ZCR
$THTML:=$THTML+"                    </tr>"+<>ZCR
$THTML:=$THTML+"                    <tr class="+<>ZGuil+"hauttb2"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"                        <td>"+<>ZCR
$THTML:=$THTML+"                           N° du troisième échantillon"+<>ZCR
$THTML:=$THTML+"                        </td>"+<>ZCR
$THTML:=$THTML+"                        <td >"+<>ZCR
$THTML:=$THTML+"                           <input class="+<>ZGuil+"textebanalgrand"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" name="+<>ZGuil+"Ech3"+<>ZGuil+" size="+<>ZGuil+"5"+<>ZGuil+" maxlength="+<>ZGuil+"6"+<>ZGuil+"/ >"+<>ZCR
$THTML:=$THTML+"                        </td>"+<>ZCR
$THTML:=$THTML+"                    </tr>"+<>ZCR
$THTML:=$THTML+"                    <tr>"+<>ZCR
$THTML:=$THTML+"                    </tr>"+<>ZCR
$THTML:=$THTML+"                    <tr class="+<>ZGuil+"hauttb2"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"                        <td>"+<>ZCR
$THTML:=$THTML+"                           N° du quatrième échantillon"+<>ZCR
$THTML:=$THTML+"                        </td>"+<>ZCR
$THTML:=$THTML+"                        <td >"+<>ZCR
$THTML:=$THTML+"                           <input class="+<>ZGuil+"textebanalgrand"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" name="+<>ZGuil+"Ech4"+<>ZGuil+" size="+<>ZGuil+"5"+<>ZGuil+" maxlength="+<>ZGuil+"6"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"                        </td>"+<>ZCR
$THTML:=$THTML+"                    </tr>"+<>ZCR
$THTML:=$THTML+"                    <tr class="+<>ZGuil+"hauttb2"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"                        <td>"+<>ZCR
$THTML:=$THTML+"                           N° du cinquième échantillon"+<>ZCR
$THTML:=$THTML+"                        </td>"+<>ZCR
$THTML:=$THTML+"                        <td >"+<>ZCR
$THTML:=$THTML+"                           <input class="+<>ZGuil+"textebanalgrand"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" name="+<>ZGuil+"Ech5"+<>ZGuil+" size="+<>ZGuil+"5"+<>ZGuil+" maxlength="+<>ZGuil+"6"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"                        </td>"+<>ZCR
$THTML:=$THTML+"                    </tr>"+<>ZCR
$THTML:=$THTML+"                </table>"+<>ZCR
$THTML:=$THTML+"            <br />"+<>ZCR
$THTML:=$THTML+"            <p>"+<>ZCR
$THTML:=$THTML+"                <input class="+<>ZGuil+"titrepage"+<>ZGuil+" type="+<>ZGuil+"submit"+<>ZGuil+" value="+<>ZGuil+"Obtenir"+<>ZGuil+" name="+<>ZGuil+"OK"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"            </p>  "+<>ZCR
$THTML:=$THTML+"            </div>"+<>ZCR

$THTML:=$THTML+"        </form>"+<>ZCR
$THTML:=$THTML+"        <br /><br />"+<>ZCR
  //Fin de si 

If ($Gel=2)  // le RAEMA gel précédent a des contaminations
	$THTML:=$THTML+"        <br /><br />"+InfRAEMACreationTbContaGel ($TexteConta;$NumRaemaGel)
End if 

  // le pied
$Texte:=$Texte+$THTML+ResRaemaCréationPied 


WEB SEND TEXT:C677($Texte)
  // FIXER TEXTE DANS CONTENEUR($Texte)
  //Fin de si 