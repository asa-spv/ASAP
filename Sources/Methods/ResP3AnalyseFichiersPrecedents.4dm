//%attributes = {}
  // RaemaAnalyseFichiersPrecedents
  // Appelée par ResP3EnvoiMailAsa <- ResP3TraitePage3 <- ResP3MF de la page 3 
  // ou par ResP3MF si formulaire incomplet (page 3')
  // Renvoie l'historique des envois précédents

C_LONGINT:C283($Salé;$FT)
C_TEXT:C284($FichierActuel;$Com;$0;$1)
$FichierActuel:=[WebConnexions:13]TextePJ:7
$NumEnrConnexionActuelle:=Record number:C243([WebConnexions:13])
$UUID:=WebTrouveValeurParNom (MotDePasseActuel;-><>TbPerIdentificateur;-><>TbPerUUID)
QUERY:C277([WebConnexions:13];[WebConnexions:13]CodeConnexion:4=$UUID;*)
QUERY:C277([WebConnexions:13]; & [WebConnexions:13]Campagne:5=<>NumCampagneEnCoursSaisie;*)
QUERY:C277([WebConnexions:13]; & [WebConnexions:13]BoolEnvoi:8=True:C214)
If (Records in selection:C76([WebConnexions:13])=1)  // c'est le premier
	$Com:="Premier fichier envoyé par ce laboratoire"+<>ZCR
Else 
	SELECTION TO ARRAY:C260([WebConnexions:13]NumEnvoi:9;$TbNumEnvoi;[WebConnexions:13]TextePJ:7;$TbPJ)
	SORT ARRAY:C229($TbNumEnvoi;$TbPJ;>)
	$AnciennePJ:=$TbPJ{2}
	If ($AnciennePJ=$FichierActuel)
		$Com:="Le fichier joint est identique à celui du précédent envoi"+<>ZCR
	Else 
		$Com:="Le fichier joint est différent de celui du précédent envoi"+<>ZCR
	End if 
End if 
$0:=$Com