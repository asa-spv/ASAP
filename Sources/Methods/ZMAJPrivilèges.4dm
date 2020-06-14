//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 30/01/18, 07:07:26
  // ----------------------------------------------------
  // Méthode : ZMAJPrivilèges
  // Description
  //     Historique : ZMAJPrivilèges V11 du 15/08/2010
  //  actualise les modalités d'accès à la table passée en en paramètre 
  //   avec les [XDroits] vrai ou faux selon la catégorie d'utilisateur
  //   en associant les tables non sensibles adéquates logiquement liées
  //   (exemple la gestion des [XUtilisateurs] suppose celles de [XAttributions] et [XDroits])
  // Paramètre : $1: = Pt sur table de travail
  //  Appelée (entre autres) par ZGèreListe
  // ----------------------------------------------------


If (Not:C34(<>ZToutNeuf))
	C_LONGINT:C283($NumTable)
	C_POINTER:C301($1)
	$NumTable:=Table:C252($1)
	Case of 
		: (($NumTable=2) | ($NumTable=3))
			  // [XUtilisateurs] = table 2   [XFonctions] = table 3 
			ZAccèsTable (->[XUtilisateurs:2])  // 
			
		: (($NumTable=Table:C252(->[Personnes:12])) | ($NumTable=Table:C252(->[Prestations:26])) | ($NumTable=Table:C252(->[RetoursFiches:24])) | ($NumTable=Table:C252(->[CourrielsTypes:28])) | ($NumTable=Table:C252(->[CampagneParticipations:17])))
			  // Tables 
			ZAccèsTable (->[Personnes:12])  // 
			
		: ($NumTable=Table:C252(->[AsaDiaUtilisateurs:14]))
			ZAjout:=True:C214
			ZSupprime:=False:C215
			ZImprime:=True:C214
			ZAccès:=True:C214
			ZModif:=False:C215
			ZValide:=False:C215
			ZSpecial1:=False:C215
			ZSpécial2:=False:C215
			
		Else 
			ZAjout:=True:C214
			ZSupprime:=True:C214
			ZImprime:=True:C214
			ZAccès:=True:C214
			ZModif:=True:C214
			ZValide:=True:C214
			ZSpecial1:=True:C214
			ZSpécial2:=True:C214
	End case 
	
Else 
	ZAjout:=True:C214
	ZSupprime:=True:C214
	ZImprime:=True:C214
	ZAccès:=True:C214
	ZModif:=True:C214
	ZValide:=True:C214
	ZSpecial1:=True:C214
	ZSpécial2:=True:C214
End if 