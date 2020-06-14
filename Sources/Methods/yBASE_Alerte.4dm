//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 19/03/12
  // ----------------------------------------------------
  // Méthode : BASE_Alerte
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

C_TEXT:C284($1;MessAlerte)

ASSERT:C1129($1#"";"Il manque le texte de l'alerte")

If (Count parameters:C259=1)
	MessAlerte:=$1
	  // ZFenetreCeintree (490;300)
	$Window:=Open form window:C675("DLG_Alerte";Form dialogue modal:K39:7;Centrée horizontalement:K39:1;Centrée verticalement:K39:4)
	DIALOG:C40("DLG_Alerte")
	CLOSE WINDOW:C154($Window)
	MessAlerte:=""
End if 