//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // ----------------------------------------------------
  // Méthode : BASE_CtrlC
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

$pointeur:=OBJECT Get pointer:C1124(Objet avec focus:K67:3)  // Obtenir le pointeur vers le dernier objet 
Case of 
	: (Is nil pointer:C315($pointeur))  // Aucun objet n'a le focus
		
	: ((Type:C295($pointeur->)=Est un champ alpha:K8:1) | (Type:C295($pointeur->)=Est un texte:K8:3))
		GET HIGHLIGHT:C209($pointeur->;$deb;$fin)
		$texte:=ZCapitaliseChaine (Substring:C12($pointeur->;$deb;$fin);3)
		  //FIXER TEXTE DANS CONTENEUR($texte)
End case 


