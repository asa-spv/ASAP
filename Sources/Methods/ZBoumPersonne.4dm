//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 25/02/19, 05:09:02
  // ----------------------------------------------------
  // Méthode : ZBoumPersonne
  // Description
  // Méthode qui assure la destruction des enregistrements 
  // des tables périphériques liées à la personne détruite 
  // ----------------------------------------------------
$LE:=Read only state:C362([Personnes:12])

READ WRITE:C146(*)
RELATE MANY:C262([Personnes:12]UUID:1)
$Fiche:=""
$Facture:=""
$Participe:=""

$FT:=Records in selection:C76([RetoursFiches:24])
If ($FT>0)
	If ($FT=1)
		$Fiche:="une fiche de retour, "
	Else 
		$Fiche:=String:C10($FT)+" fiches de retour, "
	End if 
End if 

$FT:=Records in selection:C76([Factures:15])
If ($FT>0)
	If ($FT=1)
		$Facture:="une facture,"
	Else 
		$Facture:=String:C10($FT)+" factures, "
	End if 
End if 
RELATE MANY SELECTION:C340([Ventes:16]NumFacture:2)


$FT:=Records in selection:C76([Factures:15])
If ($FT>0)
	If ($FT=1)
		$Facture:="une facture,"
	Else 
		$Facture:=String:C10($FT)+" factures, "
	End if 
End if 
RELATE MANY SELECTION:C340([Ventes:16]NumFacture:2)


$FT:=Records in selection:C76([CampagneParticipations:17])
If ($FT>0)
	If ($FT=1)
		$Participe:="une participation,"
	Else 
		$Participe:=String:C10($FT)+" participation, "
	End if 
End if 
RELATE MANY SELECTION:C340([WebConnexions:13]UUIDParticipation:12)
RELATE MANY SELECTION:C340([CampagneGelGermes:25]UUIDParticipation:2)
$OC:=True:C214
If ($Participe+$Facture+$Fiche="")
	CONFIRM:C162("Supprimer "+[Personnes:12]NomLong:2+" et ses adresses ???")
	$OC:=(OK=1)
Else 
	
	ALERT:C41("ATTENTION, supprimer la fiche "+<>ZGuil+[Personnes:12]NomLong:2+<>ZGuil+" qui a "+$Participe+$Facture+$Fiche+" va supprimer aussi toutes ses traces")
	CONFIRM:C162("Vouler-vous VRAIMENT supprimer "+[Personnes:12]NomLong:2+" et ses traces ??")
	If (OK=1)
		DELETE SELECTION:C66([RetoursFiches:24])
		DELETE SELECTION:C66([Factures:15])
		DELETE SELECTION:C66([Ventes:16])
		DELETE SELECTION:C66([PersonnesAdresses:11])
		DELETE SELECTION:C66([CampagneGelGermes:25])
		DELETE SELECTION:C66([WebConnexions:13])
		DELETE SELECTION:C66([CampagneParticipations:17])
	End if 
	ZAmnistieInternationale 
	If ($LE=False:C215)
		READ WRITE:C146([Personnes:12])
	End if 
End if 
