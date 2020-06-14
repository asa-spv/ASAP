//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 14/02/19, 18:20:01
  // ----------------------------------------------------
  // Paramètre : $1 = message envoyé par l'espace client
  // ----------------------------------------------------
  // Méthode : WebTelechargeEspaceClient
  // Description
  // Méthode qui trapse les demande de téléchargement 
  // nécessitant de noter l'action (rapport)
  // ou de fabriquer l'attestation à la volée

$Mess:=$1  // type PDF/Téléchargements/RI67A_2.pdf (rapport)  ou PDF/Téléchargements/At67A_2.pdf  (Attestation)

$Rapport:=($Mess="@RI@")


$Pos:=Position:C15("/";$Mess)  // PDF/Téléchargements/RI67A_2.pdf
$Mess:=Substring:C12($Mess;($Pos+1))  // Téléchargements/RI67A_2.pdf
$Pos:=Position:C15("/";$Mess)
$NomFichier:=Substring:C12($Mess;($Pos+1))  // RI67A_2.pdf ou At67A_2.pdf
$Pos:=Position:C15("_";$NomFichier)
$Fin:=Substring:C12($NomFichier;$Pos)
$NumLaboA:=String:C10(Num:C11($Fin))
$NumCampagne:=Substring:C12($NomFichier;3;($Pos-3))
If ($Rapport)
	  // copions le fichier de PDF/Rapports/2/RI67A_2.pdf dans PDF/Téléchargements/RI67A_2.pdf
	$CDSource:=<>PermCheDosRap+$NumLaboA+Séparateur dossier:K24:12+$NomFichier
	$CDCible:=<>PermCheDosTel+$NomFichier
	If (Test path name:C476($CDCible)=Est un document:K24:1)
		DELETE DOCUMENT:C159($CDCible)
	End if 
	COPY DOCUMENT:C541($CDSource;$CDCible)
	  // ENDORMIR PROCESS(Numéro du process courant;60)  // le temps de la copie
	
	  //Allons actualiser la participation
	  // test dans les RAEMA liés
	$Test:=$NumLaboA+"_"+$NumCampagne
	$L:=Find in array:C230(<>TbLotoNumLaboRapportCampagne;$Test)  // si $L >0 => c'est un RAEMA lié
	If ($L<0)  // test dans les RAEMA principaux
		$Test:=$Test+"_"
		$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$Test)
	End if 
	If ($L>0)
		READ WRITE:C146([CampagneParticipations:17])
		GOTO RECORD:C242([CampagneParticipations:17];<>TbLotoNumEnrParticipation{$L})
		$TP:="Le "+String:C10(Current date:C33)+" à "+String:C10(Current time:C178)+" : récupération du rapport par un clic sur le lien"+<>ZCR
		[CampagneParticipations:17]TexteParticipation:4:=[CampagneParticipations:17]TexteParticipation:4+<>ZCR2+$TP
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"RapportPris";True:C214)
		SAVE RECORD:C53([CampagneParticipations:17])
	End if 
	
Else   // Attestation : donnée sensible puisque faisant le lien entre n° de laboratoire et son identitié
	
	$CDAttestation:=<>PermCheDosTel+$NomFichier
	If (Test path name:C476($CDAttestation)=Est un document:K24:1)
		DELETE DOCUMENT:C159($CDAttestation)
	End if   // test de l'existence du document antérieur
	UUIDLabo:=ASAPTrouveUUIDLaboParNumero (Num:C11($NumLaboA))
	NumCampagne:=$NumCampagne
	NumLaboActuelA:=$NumLaboA
	ZPDFImprimer ($NomFichier;<>PermCheDosTel;"RapImprimeAttestation")
	
End if 

ZAmnistieInternationale 
