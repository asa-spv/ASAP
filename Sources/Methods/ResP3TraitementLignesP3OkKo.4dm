//%attributes = {}
  // ResP3TraitementLignesP3OkKo = fabrication du formulaire de confirmation des manques
  // appelée par ResP3TraitePage3 <- ResP3MF de la page 3
  // création et envoi du formulaire P3' de validation des données incomplètes 

C_LONGINT:C283($NbreTitre;$NbValeurs)
C_TEXT:C284($Sep;$Guill;$CR)
$CR:=<>ZCR+Char:C90(Retour à la ligne:K15:40)
$Sep:=<>Sep
$Guill:=<>ZGuil
  //Création de l'en-tete du formulaire à remplir
$Texte:=ResRaemaCréationET ("Données incomplètes")
$Texte:=$Texte+"<br /> <br /> <table width="+$Guill+"99%"+$Guill+"border="+$Guill+"0"+$Guill+">"
$Texte:=$Texte+$CR+"<tr>"+$CR+"<td>"
$Texte:=$Texte+$CR+"<p class="+$Guill+"titrepage"+$Guill+">"+$CR+RaemaTraducUtiliseTableau (42)+"</p><br />"
$Texte:=$Texte+$CR+"<p class="+$guill+"textebanal plus"+$guill+"> "+RaemaTraducUtiliseTableau (43)
$Texte:=$Texte+$CR+ZTableauVersTexte (->TbMotifAttention;" <br /> ")+$CR+"</p><br /><br />"
$Texte:=$Texte+$CR+"<p class="+$Guill+"titrepage rouge"+$Guill
$Texte:=$Texte+">"+RaemaTraducUtiliseTableau (44)+" <br />"+$CR+RaemaTraducUtiliseTableau (45)+"</p>"
$Texte:=$texte+$CR+"</td>"+$cr+"</tr>"+$cr+"</table>"+$CR

  //Création du début du formulaire à remplir
$Texte:=$Texte+$cr+"<form name="+$Guill+"form1"+$Guill+" method="+$guill+"Post"+$Guill
$Texte:=$Texte+" action="+$guill+"/mw2ResP3bEnvoiResultats"+$Guill+">"+$CR
$Texte:=$texte+"<p class="+$guill+"textecentre"+$guill+" > <input type="+$guill
$Texte:=$texte+"hidden"+$guill+" name="+$guill+"hiddenField"+$guill+" value="+$guill+UUIDParticipation+$guill+" /> <br /> "
$Texte:=$texte+$CR+"<input type="+$guill+"submit"+$guill+" name="+$guill+"Submit"+$guill+" value="
$Texte:=$texte+$guill+RaemaTraducUtiliseTableau (46)+$guill+" class="+$guill+"titrepage"+$guill+" />"+$cr
$Texte:=$Texte+"          <input type="+$Guill+"hidden"+$Guill+" name="+$Guill+"langage"+$Guill+" value="+$Guill+LangueCourante+$Guill+" />"

$Texte:=$texte+$CR+"</p>"+$CR+"</form>"+$CR+"<br />"+$CR+ResRaemaCréationPied 

WEB SEND TEXT:C677($Texte)

