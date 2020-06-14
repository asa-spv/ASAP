//%attributes = {}
  // ResP3EcritListeLaboInternet

C_TEXT:C284($Texte;$Sep;$Guill;$CR)
C_LONGINT:C283($DernierNum;$NbMaxPages;$NbValeurs;$salé;$Fumé;$FT;$rang)
  // initialisation de variables
$CR:=<>ZCR
$Sep:=Séparateur dossier:K24:12
$Guill:=<>ZGuil
$NomCourt:="Labos_Internet"
$Extension:="shtml"
$DocChemin:=Get 4D folder:C485(Dossier racine HTML:K5:20)+$Nomcourt+"."+$extension
If (Test path name:C476($DocChemin)=Est un document:K24:1)  //Si le document existe
	DELETE DOCUMENT:C159($DocChemin)
End if 
  //Création du début de la page HTML
$DocRef:=Create document:C266($DocChemin)

  //Si (<>ZPC)
  //$DocRef:=Créer document($Dossier+$NomCourt;$Extension)
  //Sinon 
  //$DocRef:=Créer document($DocChemin;"TEXT")
  //Fin de si 

$texte:=ResRaemaCréationET ("Liste des laboratoires";True:C214)
$Texte:=$Texte+"       <br /><br />"
$Texte:=$Texte+"       <p class="+$guill+"titrepage"+$guill+">LISTE DES LABORATOIRES AYANT REPONDU PAR INTERNET AU RAEMA "+<>NumCampagneEnCoursSaisie+"</p>"
QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=<>NumCampagneEnCoursSaisie;*)
QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17]; & [CampagneParticipations:17]Arguments:5;"RéponseEnvoyée";=;True:C214)
SELECTION TO ARRAY:C260([CampagneParticipations:17]UUIDPersonne:2;$TbUUIDPersonne)
$FT:=Records in selection:C76([CampagneParticipations:17])
ARRAY LONGINT:C221($TbNumlaboInternet;$FT)
For ($Salé;1;$FT)
	$TbNumlaboInternet{$salé}:=Num:C11(WebTrouveValeurParNom ($TbUUIDPersonne{$salé};-><>TbPerUUID;-><>TbPerNumLaboRAEMA))
End for 
SORT ARRAY:C229($TbNumlaboInternet;>)

  //Si (Enregistrements trouvés([CampagneParticipation])>0)
  //$Texte:=$Texte+"<p class="+$guill+"textecentre"+$guill+">pour les laboratoires ayant envoyé une disquette"+" ou un courrier à l'ASA, cliquer sur le lien "
  //$Texte:=$Texte+"<a href="+$guill+"accuse_reception.html"+$guill+">disquette ou courrier</a></p> "+$CR+"<br />"
  //Fin de si 
$Texte:=$Texte+"       <table align="+$guill+"center"+$guill+" width="+$guill+"100%"+$guill+" border="+$guill+"1"+$guill+">"+$CR
$reste:=$FT%10
If ($reste=0)
	$SFT:=($FT\10)
Else 
	$SFT:=($FT\10)+1
End if 
For ($salé;1;$SFT)
	$Texte:=$Texte+"        <tr>"+$CR
	For ($Fumé;1;10)
		$rang:=(($salé-1)*10)+$fumé
		If ($Rang>$FT)
			$Texte:=$Texte+$CR+"        <td class="+$guill+"cellulebord"+$guill+" width="+$guill+"9%"+$guill+"> </td>"+$CR
		Else 
			If (String:C10($TbNumlaboInternet{$rang})=NumLaboActuelA)
				$NumLabo:="<span class="+<>ZGuil+"rouge textecentre plus"+<>ZGuil+">"+String:C10($TbNumlaboInternet{$rang})+"</span>"
			Else 
				$NumLabo:=String:C10($TbNumlaboInternet{$rang})
			End if 
			$Texte:=$Texte+$CR+"         <td class="+$guill+"cellulebord textecentre plus"+$guill+" width="+$guill+"9%"+$guill+"> "+$NumLabo+"</td>"+$CR
		End if 
	End for 
	$Texte:=$Texte+"        </tr>"+$CR
End for 

$Texte:=$Texte+"       </table>"+$CR
$Texte:=$Texte+ResRaemaCréationPied 
  // FIXER TEXTE DANS CONTENEUR($Texte)
  //$texte:=Mac vers ISO($texte)
SEND PACKET:C103($DocRef;$Texte)
CLOSE DOCUMENT:C267($DocRef)  //Fin de création du document