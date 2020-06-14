//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/01/19, 14:39:49
  // ----------------------------------------------------
  // Paramètres $1= code de la prestation vendue
  // $2 = quantité 
  // ----------------------------------------------------
  // Méthode : ASAPCreerLigneFacture
  // Description
  // Crée la ligne de facture correspondant au code passé en paramètre

  // ----------------------------------------------------
$Code:=$1
$Quantité:=$2
CREATE RECORD:C68([Ventes:16])  // la cotis'
  //[Ventes]CodeBénéficiaire:=[Adhérents]NumAdhérent
[Ventes:16]NumFacture:2:=[Factures:15]NumFacture:3
  //[Ventes]Labo:=Vrai
QUERY:C277([Prestations:26];[Prestations:26]AnneePrestation:6=Year of:C25(Current date:C33);*)
QUERY:C277([Prestations:26]; | [Prestations:26]AnneePrestation:6=0;*)
QUERY:C277([Prestations:26]; | [Prestations:26]CodePrestation:2=$Code)
[Ventes:16]Intitule:3:=[Prestations:26]NomPrestation:3
[Ventes:16]PrixUHT:5:=[Prestations:26]PrixPrestation:4
$TVA:=OB Get:C1224([Personnes:12]Arguments:7;"NonSoumisTVA";Est un texte:K8:3)
If ($TVA="Faux") & ($Code#"COT")
	[Ventes:16]TauxTVA:8:=[Prestations:26]TauxTVAPrestation:5
End if 
[Ventes:16]Quantité:6:=$Quantité
[Ventes:16]PrixTotalHT:7:=[Ventes:16]PrixUHT:5*[Ventes:16]Quantité:6
[Ventes:16]DateVente:4:=Current date:C33
SAVE RECORD:C53([Ventes:16])
