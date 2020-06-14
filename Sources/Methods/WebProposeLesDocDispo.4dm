//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 23/04/20, 14:11:54
  // ----------------------------------------------------
  // Méthode : WebProposeLesDocDispo
  // Description :
  // Permet d'affiche les documents disponibles (attestation ou rapport)
  // et de les télécharger
  //
  // Paramètres : $1 : message du type PGtelechargementAtt(ou Rap)_UUIDLabo
  // ----------------------------------------------------

C_LONGINT:C283($L)
$Mess:=$1
$UUIDLabo:=Substring:C12($Mess;22;32)
$NumLabo:=Num:C11(ASAPTrouveNumeroLaboParUUID ($UUIDLabo))

$L:=Find in array:C230(<>TbPerUUID;$UUIDLabo)
$MDPActuel:=<>TbPerIdentificateur{$L}
  // Est-ce une demande d'attestation ou de rapport
TypeDemande:=Substring:C12($mess;18;3)
If (TypeDemande#"Fac")
	ARRAY TEXT:C222($TbListeDocuments;0)
	$TT:=Size of array:C274(<>TbLotoUUIDLabo)
	For ($Salé;1;$TT)
		
		QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=<>TbLotoNumCampagne{$Salé};*)
		  // $RapportDispo:=OB Lire([RAEMACampagnes]Arguments;"Disponibilité du rapport individuel";Est un booléen)
		QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]DateMiseEnLigne:5#!00-00-00!)
		If (Records in selection:C76([RAEMACampagnes:20])>0)
			$RapportDispo:=True:C214
		Else 
			$RapportDispo:=False:C215
		End if 
		
		If (<>TbLotoNumLaboRAEMA{$Salé}=$NumLabo) & ($RapportDispo=True:C214)
			APPEND TO ARRAY:C911($TbListeDocuments;<>TbLotoNumCampagne{$Salé})
		End if 
	End for 
Else 
	$L:=Find in array:C230(<>TbPerUUID;$UUIDLabo)
	$NumAdhA:=<>TbPerNumPersonneA{$L}
	QUERY:C277([Factures:15];[Factures:15]UUIDPersonne:2=$UUIDLabo)
	$CDLabo:=<>PermCheDosFac+$NumAdhA+Séparateur dossier:K24:12
	If (Test path name:C476($CDLabo)=Est un dossier:K24:2)  // Existe t'il un dossier au nom du laboratoire ?
		DOCUMENT LIST:C474($CDLabo;$TbListeDocuments)
	End if 
End if 

If (Size of array:C274($TbListeDocuments)>0)  // Existe t'il un dossier au nom du laboratoire ?
	RapP1ConstruitP2 (->$TbListeDocuments;$MDPActuel;$NumAdhA)
End if 

