//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 30/01/18, 08:39:18
  // ----------------------------------------------------
  // Méthode : ZFenetreActualiseTitre
  // Description
  //   Historique : ZActualiseTitreFenetre V11 du 10/08/2010
  //   met à jour le bandeau d'une liste
  // ----------------------------------------------------

If (GestionTableau)
	$ZNbEnr:=LISTBOX Get number of rows:C915(*;"Lb_Tableaux")
	$ZVarTotEnr:=Records in table:C83(ZPtTable->)
Else 
	$ZNbEnr:=Records in selection:C76(ZPtTable->)
	$ZVarTotEnr:=Records in table:C83(ZPtTable->)
End if 

If (ZNomTable="x@")
	$NomTable:=Substring:C12(ZNomTable;2)
Else 
	$NomTable:=ZNomTable
End if 
  //Si (ZIciListeH)  //  gestion des liste hiérarchiques
  //$Mess:=ZNomTable+" : Liste hiérarchique de "+Chaîne(ZNbEnr)
  //$Mess:=$Mess+" enregistrements parmi "+Chaîne(ZVarTotEnr)
  //EXÉCUTER FORMULE(ZDerMéthode)  //  permet de mettre la liste hiérarchique à jour
  //Sinon 

Case of 
	: ($ZNbEnr=0)
		$Mess:=$NomTable+" : Aucun enregistrement parmi "+String:C10($ZVarTotEnr)
		
	: ($ZNbEnr=1)
		If (GestionTableau)
			FIRST RECORD:C50(ZPtTable->)
			$ConCerné:=ZPtChamp->
		Else 
			$ConCerné:=""
		End if 
		$Mess:=$NomTable+" : "+"Le seul enregistrement "
		$Mess:=$Mess+$ConCerné+" parmi "+String:C10($ZVarTotEnr)
		
	Else 
		$Mess:=$NomTable+" : "+String:C10($ZNbEnr)
		$Mess:=$Mess+" enregistrements parmi "+String:C10($ZVarTotEnr)
End case 
  //Fin de si 
Case of 
	: (ZSensDuTri="<")
		ORDER BY:C49(ZPtTable->;ZPtChamp->;<)
		
	: (ZSensDuTri=">")
		ORDER BY:C49(ZPtTable->;ZPtChamp->;>)
End case 

SET WINDOW TITLE:C213($Mess)