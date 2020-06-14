//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 11/08/18, 05:53:09
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : RapImprimeAttestation <= RapP2MF
  // Description
  // Imprime le PDF de l'attestation de [CampagneParticipation] courant
  // ----------------------------------------------------



  // Cherchons l'identité du labo (<>TbNumAdh et <>TbNumRae de FabriqueTableauCorrespondance)
$L:=Find in array:C230(<>TbPANumRAEMALiés;NumLaboActuelA)

If ($L>0)
	UUIDLabo:=<>TbPerUUID{$L}
End if 
QUERY:C277([Personnes:12];[Personnes:12]UUID:1=UUIDLabo)
QUERY:C277([PersonnesAdresses:11];[PersonnesAdresses:11]UUIDPersonne:2=UUIDLabo;*)
QUERY:C277([PersonnesAdresses:11]; & [PersonnesAdresses:11]TypeAdresse:9="Livraison")
VarNomAd:=[Personnes:12]NomLong:2+<>ZCR+[PersonnesAdresses:11]CodePostal:6+"-"+[PersonnesAdresses:11]Ville:7


$NumP:=Num:C11(NumCampagne)
If (NumCampagne="@a")
	$Mois:=(Num:C11($NumP%2=0)*"Mai ")+(Num:C11($NumP%2=1)*"Décembre ")
Else 
	$Mois:=(Num:C11($NumP%2=0)*"Mars ")+(Num:C11($NumP%2=1)*"Octobre ")
End if 
If ($NumP%2=0)
	$An:=String:C10(2009+(($NumP-48)/2))
Else 
	$An:=String:C10(2009+(($NumP-49)/2))
End if 
VarNumCamp:=NumCampagne+" ("+$Mois+$An+") sous le numéro "+NumLaboActuelA+"."
VarDateJour:=String:C10(Current date:C33;3)
$H:=Print form:C5("Attestation")
  // SAUT DE PAGE
