//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 04/05/18, 20:51:20
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ZLBFonctionSurValidation
  // Description
  // permet d'enregistrer les modifications d'une page à l'autre
  //
C_OBJECT:C1216($Objet)

If (ModificationProfil)
	ARRAY TO SELECTION:C261(TbAjouter;[XProfils:4]Ajouter:5\
		;TbImprimer;[XProfils:4]Imprimer:8\
		;TbModifier;[XProfils:4]Modifier:6\
		;TbNumTableSensible;[XProfils:4]NumTableSensible:3\
		;TbSpecial1;[XProfils:4]Special1:9\
		;TbSpecial2;[XProfils:4]Special2:10\
		;TbSupprimer;[XProfils:4]Supprimer:7\
		;TbVoir;[XProfils:4]Voir:4\
		;TbUUIDFonction;[XProfils:4]UUIDFonction:2)
	
	OB SET:C1220($Objet;"NomTâche";"Actualisation des droits de utilisateurs"\
		;"NomMéthode";"ZTachedeFondMAJDroits"\
		;"NumTable";ZNumTable\
		;"NumEnr";NumEnrFonction)
	ZTacheDeFondLancer ($Objet)
	  //TABLEAU VERS SÉLECTION(TbAjouter;[XProfils]Ajouter\
		;TbImprimer;[XProfils]Imprimer\
		;TbModifier;[XProfils]Modifier\
		;TbNumTableSensible;[XProfils]NumTableSensible\
		;TbSpecial1;[XProfils]Special1\
		;TbSpecial2;[XProfils]Special2\
		;TbSupprimer;[XProfils]Supprimer\
		;TbVoir;[XProfils]Voir\
		;TbUUIDFonction;[XProfils]UUIDFonction)
	  //C_ENTIER LONG($Salé;$FT)
	  //SÉLECTION RETOUR([XAttributions]UUIDFonction)
	  //JOINTURE([XAttributions];[XUtilisateurs])
	  //$FT:=Enregistrements trouvés([XUtilisateurs])
	  //DÉBUT SELECTION([XUtilisateurs])
	  //Boucle ($Salé;1;$FT)
	  //ZDroitsRecalcule (Vrai;Vrai)
	  //ENREGISTREMENT SUIVANT([XUtilisateurs])
	  //Fin de boucle 
End if 

  // Actualisation des tableaux généraux
If (Find in array:C230(<>TbFonctionsUUID;[XFonctions:3]UUID:1)<0)
	APPEND TO ARRAY:C911(<>TbFonctionsDescription;[XFonctions:3]Description:3)
	APPEND TO ARRAY:C911(<>TbFonctionsNomFonction;[XFonctions:3]NomFonction:2)
	APPEND TO ARRAY:C911(<>TbFonctionsUUID;[XFonctions:3]UUID:1)
End if 