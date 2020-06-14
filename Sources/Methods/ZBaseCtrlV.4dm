//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // ----------------------------------------------------
  // Méthode : BASE_CtrlV
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

$pointeur:=OBJECT Get pointer:C1124(Objet avec focus:K67:3)  // Obtenir le pointeur vers le dernier objet 
Case of 
	: (Is nil pointer:C315($pointeur))  // Aucun objet n'a le focus
		
	: ((Type:C295($pointeur->)=Est un champ alpha:K8:1) | (Type:C295($pointeur->)=Est un texte:K8:3))
		  // S'il s'agit d'un objet de type Texte ou Alpha 
		$Texte:=Get text from pasteboard:C524
		$texte:=ZCapitaliseChaine ($texte;3)
		$pointeur->:=$Texte
End case 


