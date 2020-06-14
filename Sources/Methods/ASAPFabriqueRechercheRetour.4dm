//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 14/03/19, 14:17:39
  // ----------------------------------------------------
  // Méthode : ASAPFabriqueRechercheRetour
  // Description
  // Met dans le champ [RetoursFiches]Recherche
  //  la description de la fiche
  // ----------------------------------------------------
$Recherche:=[RetoursFiches:24]Campagne:7+" "+[RetoursFiches:24]Classification:8+" "+[RetoursFiches:24]Domaine:6+" "
$Recherche:=$Recherche+[RetoursFiches:24]Motif:9+" "+[RetoursFiches:24]NumFiche:2+" "+[RetoursFiches:24]TypeRetour:5+" "
$Recherche:=$Recherche+[RetoursFiches:24]NumFTNC:10
RELATE MANY SELECTION:C340([RetoursAdherents:27]IDFiche:2)
SELECTION TO ARRAY:C260([RetoursAdherents:27]IDAdherent:3;$TbIDAdh)
$TT:=Size of array:C274($TbIDAdh)
For ($Salé;1;$TT)
	$Recherche:=$Recherche+ASAPTrouveNumeroLaboParUUID ($TbIDAdh{$Salé})+" "
End for 
$0:=$Recherche