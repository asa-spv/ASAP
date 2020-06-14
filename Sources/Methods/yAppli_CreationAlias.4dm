//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // ----------------------------------------------------
  // Méthode : Appli_CreationAlias
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

$chemin:=Application file:C491
$CheminCible:=System folder:C487(Bureau:K41:16)+<>SoftName
CREATE ALIAS:C694($chemin;$CheminCible)

Case of 
		
	: (<>ZPC)
		
		CONFIRM:C162("Voulez-vous créer un raccourci dans le menu Démarrer ?";"Créer le raccourci";"Non merci")
		If (OK=1)
			$CheminCible:=System folder:C487(Menu Démarrer Win_Tous:K41:9)+<>SoftName
			CREATE ALIAS:C694($chemin;$CheminCible)
		End if 
		
End case 