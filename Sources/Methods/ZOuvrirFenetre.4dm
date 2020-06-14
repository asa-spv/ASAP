//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 03/05/18, 12:37:13
  // ----------------------------------------------------
  // Paramètres
  // $1 = Nom du formulaire
  // {$2} = Type de fenetre
  // {$3} = Pointeur sur l'Objet à passer au formulaire
  // ----------------------------------------------------
  // Méthode : ZOuvrirFenetre
  // Description
  // Fenetre centrée H et V
  // Fenetre sans titre
  // Fenetre modale par défaut
  //

C_TEXT:C284($1;$NomFormulaire)
C_LONGINT:C283($TypeFenetre)
C_LONGINT:C283($Fenetre)
C_OBJECT:C1216($Param)

$NomFormulaire:=$1
$TypeFenetre:=Form dialogue modal:K39:7


If (Count parameters:C259=2)
	C_LONGINT:C283($2)
	$TypeFenetre:=$2
End if 

If (Count parameters:C259=3)
	C_POINTER:C301($3)
	$Param:=$3->
End if 

$Fenetre:=Open form window:C675($NomFormulaire;$TypeFenetre;Centrée horizontalement:K39:1;Centrée verticalement:K39:4)
DIALOG:C40($NomFormulaire;$Param)
CLOSE WINDOW:C154($Fenetre)

If (Count parameters:C259=3)
	$3->:=$Param
End if 
