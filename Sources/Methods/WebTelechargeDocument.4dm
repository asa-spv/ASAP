//%attributes = {"publishedWeb":true}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 16/02/19, 08:13:02
  // ----------------------------------------------------
  // Paramètres : $1 = numéro du laboratoire (alphanumérique)
  // $2 = type de document  (Rap, Att ou Fac)
  // ----------------------------------------------------
  // Méthode : WebTelechargeDocument
  // Description
  // Méthode qui affiche le dialogue de choix des camapagnes pertinentes
  // pour pouvoir télécharger les rapports, attestations ou factures liées 

C_LONGINT:C283($L)
ARRAY TEXT:C222($TbNomsDocuments;0)
$L:=Find in array:C230(<>TbPerNumlaboRAEMAA;NumLaboActuelA)
NumAdhA:=String:C10(<>TbPerNumPersonne{$L})
$UUIDLabo:=<>TbPerNumlaboRAEMAA{$L}
TitrePage:="Choix des campagnes concernées"

Case of 
	: (TypeDemande="Fac")
		QUERY:C277([Factures:15];[Factures:15]UUIDPersonne:2=$UUIDLabo)
		$CDLabo:=<>PermCheDosFac+NumAdhA+Séparateur dossier:K24:12
		
	: (TypeDemande="Att")
		$CDLabo:=<>PermCheDosAtt+NumLaboActuelA+Séparateur dossier:K24:12
		
	: (TypeDemande="Rap")
		$CDLabo:=<>PermCheDosRap+NumLaboActuelA+Séparateur dossier:K24:12
		
	Else 
		$CDLabo:=<>PermCheDosRap+NumLaboActuelA+Séparateur dossier:K24:12
End case 

If (Test path name:C476($CDLabo)=Est un dossier:K24:2)  // Existe t'il un dossier au nom du laboratoire ?
	DOCUMENT LIST:C474($CDLabo;$TbNomsDocuments)
	RapP1ConstruitP2 (->$TbNomsDocuments)
End if 