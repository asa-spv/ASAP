//%attributes = {}
  // ----------------------------------------------------
  // nom utilisateur : cgm
  // date et heure : 29/01/18, 10:14:18
  // ----------------------------------------------------
  // Paramètres
  // Pas de paramètre
  // ----------------------------------------------------
  // méthode : ZCarousselDeMaugey
  // description
  // méthode qui permet de quitter le dialogue principal "DlgPrincipal"
  // en vidant et libérant toutes les tables
  // ----------------------------------------------------

C_TEXT:C284(ZXCarLaProc;$LaProCour)

While (ZXCarLaProc#"PasDePaniqueLesFemmesEtLesEnfantsDabord")
	
	  // on entre tant qu'on ne veut pas sortir!!!
	ZAmnistieInternationale 
	DISABLE MENU ITEM:C150(1;0)
	
	If (ZXCarLaProc="")  // comme il n'y a rien à foutre, allons toujours dans le dialogue
		
		  // creer fenetre(6;40;1000;710;8;"";"YFinirEnBeauté")  ` 14 pouces fillette
		ZFenetreOuvertureStandard 
		SET WINDOW TITLE:C213("Choix de l'action :")
		DIALOG:C40("DlgPrincipal")
		CLOSE WINDOW:C154
		
	Else   // ah, tiens, du boulot
		
		$LaProCour:=ZXCarLaProc
		ZXCarLaProc:=""  // ben ouais, on va pas recommencer 107 ans
		EXECUTE METHOD:C1007($LaProCour)
		
	End if 
	
	  // doute affreux: et si ...
	  // la procédure"PasDePaniqueLesFemmesEtLesEnfantsDabord" avait été appelée???
	  // en clair, l'utilisateur se serait lassé et demande à partir
	
	If (ZXCarLaProc="PasDePaniqueLesFemmesEtLesEnfantsDabord")
		
		If (Current user:C182="Concepteur") | (Current user:C182="Administrateur")
			
			  // on suppose qu'il veut aller en structure
			ENABLE MENU ITEM:C149(1;0)
			
		Else 
			
			CONFIRM:C162("Désirez-vous VRAIMENT quitter le programme  ?")
			
			If (OK=1)
				ZFinirProprement   // il fallait bien le faire une jour
			Else 
				ZXCarLaProc:=""  // on retournera derechef dans le dialogue
			End if   //  OK=1 : il veut vraiment sortir
			
		End if   // utilisateur courant="Concepteur"
	End if   // XCarLaProc="PasDePaniqueLesFemmesEtLesEnfantsDabord"
End while 