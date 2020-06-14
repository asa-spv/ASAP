//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 24/07/19, 11:03:28
  // ----------------------------------------------------
  // Paramètres $1= code de la prestation vendue
  // $2 = quantité 
  // ----------------------------------------------------
  // Méthode : ASAPCreerTbLigneFactureRaemaP
  // Description
  //   Méthode qui crée les lignes du tableau 
  //     sauf date et numéro de facture pour gérer les rééditions
  //   correspondantes aux prestations RAEMA Poudre
  //   réalisées pour un laboratoire

$Code:=$1
$Quantité:=$2
QUERY:C277([Prestations:26];[Prestations:26]AnneePrestation:6=Year of:C25(Current date:C33);*)
QUERY:C277([Prestations:26]; | [Prestations:26]AnneePrestation:6=0;*)
QUERY:C277([Prestations:26]; & [Prestations:26]CodePrestation:2=$Code)
APPEND TO ARRAY:C911(TbLFCodePrestation;$Code)
APPEND TO ARRAY:C911(TbLFIntitule;[Prestations:26]NomPrestation:3)
APPEND TO ARRAY:C911(TbLFPrixHT;[Prestations:26]PrixPrestation:4)
$TVA:=OB Get:C1224([Personnes:12]Arguments:7;"NonSoumisTVA";Est un texte:K8:3)
If ($TVA="Faux") & ($Code#"COT")
	APPEND TO ARRAY:C911(TbLFTauxTVA;[Prestations:26]TauxTVAPrestation:5)
Else 
	APPEND TO ARRAY:C911(TbLFTauxTVA;0)
End if 
APPEND TO ARRAY:C911(TbLFQuantité;$Quantité)
APPEND TO ARRAY:C911(TbLFPrixTotalHT;[Prestations:26]PrixPrestation:4*$Quantité)
