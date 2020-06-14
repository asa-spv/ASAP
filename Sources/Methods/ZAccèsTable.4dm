//%attributes = {}
  // ----------------------------------------------------
  // nom utilisateur : cgm
  // date et heure : 30/01/18, 07:15:02
  // ----------------------------------------------------
  // paramètre :
  // $1:= Pointeur sur la table principale
  // ----------------------------------------------------
  // méthode : ZAccèsTable
  // description
  // historique : ZAccèsTableV11 du mardi 20 juillet 2010
  //
  // applique aux tables indiquées dans ZMAJPrivilèges les mêmes [XDroits]
  // que ceux de la table passée en paramètre

C_POINTER:C301($1)
C_LONGINT:C283($NumTable)
$NumTable:=Table:C252($1)

If (<>ZToutNeuf)  // pas d'utilisateur défini = ouvrons tout grand les fichiers
	
	ZAjout:=True:C214
	ZSupprime:=True:C214
	ZImprime:=True:C214
	ZAccès:=True:C214
	ZModif:=True:C214
	ZSpecial1:=True:C214
	ZSpécial2:=True:C214
	
Else   // au moins une personne avec un mot de passe existe…
	
	  // plaçons nous sur son enregistrement des droits
	QUERY:C277([XDroits:7];[XDroits:7]UUIDUtilisateur:2=<>ZQuiCodeUUID;*)
	QUERY:C277([XDroits:7]; & [XDroits:7]NumTableSensible:3=$NumTable)
	
	  // recueillons dans les variables gestion les valeurs appropriées
	ZAjout:=[XDroits:7]Ajouter:5
	ZSupprime:=[XDroits:7]Supprimer:7
	ZImprime:=[XDroits:7]Imprimer:8
	ZAccès:=[XDroits:7]Voir:4
	ZModif:=[XDroits:7]Modifier:6
	ZSpécial1:=[XDroits:7]Special1:9
	ZSpécial2:=[XDroits:7]Special2:10
	
End if 
