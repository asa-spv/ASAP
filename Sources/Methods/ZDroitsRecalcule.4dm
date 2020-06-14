//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 26/01/18, 06:16:41
  // ----------------------------------------------------
  // 0 param = Affiche le tableau des droits
  // 1 param = Actualisation des [XAttributions] et [XDroits]
  // 2 param = Recalcul des droits 
  // Pas d'incidence de la nature des paramètres
  // ----------------------------------------------------
  // Méthode : ZCalculDroits
  // Description
  // Méthode qui à partir des [XAttributions] et des [XProfils] des [XFonctions]
  //  recalcule les [XDroits] de la personne courante [XUtilisateurs]
  //  utilise <>TbNumTable le tableau des n° de table des tables sensibles 
  //  définis dans le formulaire projet "DlgTablesSensibles"
  // Paramètre : {$1} = si existe enregistre les [XDroits]  
  // ----------------------------------------------------

Case of 
	: (Count parameters:C259=0)
		QUERY WITH ARRAY:C644([XFonctions:3]UUID:1;TbUUIDFonction)
		ZDroitsFabriqueTbDroits 
		
	: (Count parameters:C259=1)  // simple actualisation des [XAttributions] et [XDroits]
		
		  // actualisation des attributions
		$FT:=Size of array:C274(TbUUIDFonction)
		ARRAY TEXT:C222(TbUUIDUtilisateur;$FT)
		ARRAY TEXT:C222($TbDescriptif;$FT)
		For ($Salé;1;$FT)
			TbUUIDUtilisateur{$Salé}:=[XUtilisateurs:2]UUID:1
			
			$TbDescriptif{$Salé}:=ZDroitsDecritAttribution ([XUtilisateurs:2]UUID:1;TbUUIDFonction{$Salé})
		End for 
		
		ARRAY TO SELECTION:C261(TbUUIDFonction;[XAttributions:5]UUIDFonction:3\
			;TbUUIDUtilisateur;[XAttributions:5]UUIDUtilisateur:2\
			;$TbDescriptif;[XAttributions:5]Descriptif:4)
		
		  // actualisation des droits
		ZDroitsActualiseDroits 
		
	: (Count parameters:C259=2)  // recalcul des droits  partir de l'enregistrement courant de [XUtilisateurs]
		RELATE MANY:C262([XUtilisateurs:2]UUID:1)  // Rapel des [XDroits] et [XAttributions]
		READ WRITE:C146([XDroits:7])
		  // Suppression des anciens droits
		DELETE SELECTION:C66([XDroits:7])
		ZAmnistiePartielle (->[XDroits:7])
		  // Rappel des fonctions liées
		RELATE ONE SELECTION:C349([XAttributions:5];[XFonctions:3])
		ZDroitsFabriqueTbDroits   // Fabrication des tableaux
		ZDroitsActualiseDroits   // Création des bons droits
		
End case 
