//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 22/04/18, 16:06:25
  // ----------------------------------------------------
  // Méthode : ZLBUtilSurValidation
  // Description
  // Méthode déclenchée Sur validation
  // du formulaire [XUtilisateurs];"Entrée"
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)
  // Stockage de [XLocalisations] affiché
SAVE RECORD:C53([XLocalisations:8])

  // ZGestion des utilisateur 4D
If (VarNomUtil="")
	CHANGE CURRENT USER:C289(2;"qs")
	  //TRACE
	  //ALERTE(Utilisateur courant)
	GET USER LIST:C609($NomUtil;$RefUtil)
	$L:=Find in array:C230($NomUtil;[XUtilisateurs:2]Initiales:4)
	If ($L<0)
		  //ALERTE("Ses initiales ne sont pas dns la liste")
		$L:=Find in array:C230($RefUtil;[XUtilisateurs:2]ID4DUtilisateur:11)
		ARRAY LONGINT:C221($TbNumGroupe;1)
		If ($L<0)
			  //ALERTE("Il n' a pas d'ID")
			
			$TbNumGroupe{1}:=15002-Num:C11([XUtilisateurs:2]AccesStructure:12)
			$Actuel:=Current user:C182
			$ID4DUtil:=Set user properties:C612(-1;[XUtilisateurs:2]Initiales:4;"";*;1;Current date:C33;$TbNumGroupe)
			  // ALERTE("Son ID est "+Chaîne($ID4DUtil))
			
			$L:=Find in array:C230($NomUtil;$Actuel)
			  // ALERTE(Utilisateur courant)
			[XUtilisateurs:2]ID4DUtilisateur:11:=$ID4DUtil
		End if 
	End if 
	CHANGE CURRENT USER:C289($RefUtil{$l};"")
End if 

  // Actualisation de [XUtilisateurs]MotsClefs
$MotsClefs:=[XUtilisateurs:2]Initiales:4+" "+(Num:C11([XUtilisateurs:2]Mec:7)*"Mec")+(Num:C11(Not:C34([XUtilisateurs:2]Mec:7))*"Nana")+" "
$MotsClefs:=$MotsClefs+[XUtilisateurs:2]Nom:2+" "+[XUtilisateurs:2]Prenom:3+" "+[XUtilisateurs:2]NomJeuneFille:8+" "
RELATE MANY:C262([XUtilisateurs:2]UUID:1)
SELECTION TO ARRAY:C260([XAttributions:5]UUIDFonction:3;$TbUUIDAttributions)
$FT:=Size of array:C274($TbUUIDAttributions)
For ($Salé;1;$FT)
	$L:=Find in array:C230(<>TbFonctionsUUID;$TbUUIDAttributions{$Salé})
	$MotsClefs:=$MotsClefs+<>TbFonctionsNomFonction{$L}+" "
End for 
SELECTION TO ARRAY:C260([XLocalisations:8]Adresse1:3;$TbAdresse1;[XLocalisations:8]Adresse2:4;$TbAdresse2\
;[XLocalisations:8]Adresse3:5;$TbAdresse3;[XLocalisations:8]CodePostal:6;$TbCP;[XLocalisations:8]Ville:7;$TbLocalité\
;[XLocalisations:8]Pays:16;$TbPays;[XLocalisations:8]Remarques:14;$TbRemarques;[XLocalisations:8]EMail1:10;$TbMail1\
;[XLocalisations:8]EMail2:11;$TbMail2)
$FT:=Size of array:C274($TbAdresse1)
For ($Salé;1;$FT)
	$MotsClefs:=$MotsClefs+$TbAdresse1{$Salé}+" "+$TbAdresse2{$Salé}+" "+$TbAdresse3{$Salé}+" "
	$MotsClefs:=$MotsClefs+$TbCP{$Salé}+" "+$TbLocalité{$Salé}+" "+$TbPays{$Salé}+" "
	$MotsClefs:=$MotsClefs+$TbRemarques{$Salé}+" "+$TbMail1{$Salé}+" "+$TbMail2{$Salé}+" "
End for 
GET TEXT KEYWORDS:C1141($MotsClefs;$TbClefs)
$FT:=Size of array:C274($TbClefs)
For ($Salé;1;$FT)
	$MotsClefs:=$MotsClefs+ZSoundexFrance ($TbClefs{$Salé})+" "
End for 
[XUtilisateurs:2]MotsClefs:10:=$MotsClefs

  // Actualisation des tableaux généraux
$L:=Find in array:C230(<>TbUtilUUID;[XUtilisateurs:2]UUID:1)
If ($L<0)
	APPEND TO ARRAY:C911(<>TbUtilAnniversaire;[XUtilisateurs:2]Anniversaire:6)
	APPEND TO ARRAY:C911(<>TbUtilEmail;[XUtilisateurs:2]Email:9)
	APPEND TO ARRAY:C911(<>TbUtilInitiales;[XUtilisateurs:2]Initiales:4)
	APPEND TO ARRAY:C911(<>TbUtilMec;[XUtilisateurs:2]Mec:7)
	APPEND TO ARRAY:C911(<>TbUtilNom;[XUtilisateurs:2]Nom:2)
	APPEND TO ARRAY:C911(<>TbUtilNomJeuneFille;[XUtilisateurs:2]NomJeuneFille:8)
	APPEND TO ARRAY:C911(<>TbUtilPassoire;[XUtilisateurs:2]Passoire:5)
	APPEND TO ARRAY:C911(<>TbUtilPrenom;[XUtilisateurs:2]Prenom:3)
	APPEND TO ARRAY:C911(<>TbUtilUUID;[XUtilisateurs:2]UUID:1)
End if 
READ WRITE:C146([XAttributions:5])
RELATE MANY:C262([XUtilisateurs:2]Initiales:4)
DELETE SELECTION:C66([XAttributions:5])
ZDroitsRecalcule (True:C214)
ZAmnistiePartielle (->[XAttributions:5])

  // Le serveur de mail
If (PUMFAM{PUMFAM}="Orange")
	OB REMOVE:C1226([XUtilisateurs:2]ObjetUtilisateur:13;"ServeurFAM")
Else 
	OB SET:C1220([XUtilisateurs:2]ObjetUtilisateur:13;"ServeurFAM";PUMFAM{PUMFAM})
End if 

