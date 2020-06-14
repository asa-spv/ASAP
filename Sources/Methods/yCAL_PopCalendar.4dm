//%attributes = {}
  // ----------------------------------------------------
  // Methode : PopCalendar_Call
  // Description
  // 
  // Syntaxe : PopCalendar_Call(Pointeur sur le champ date;Ref de la fenetre qui contier le champ)
  // Parametres :
  // $1 Pointeur sur le champ date
  // $2 Entier long référence de la fenêtre
  // ----------------------------------------------------
  // Auteur : Bertrand SOUBEYRAND soub@soub.org
  // Date et heure : ven. 7 nov. 2008
  // Modifié par PE le 02/01/2011
  // Modifié par PE le 22/12/2011
  // Modifié par PE (05/04/2012)
  // ----------------------------------------------------

C_POINTER:C301($1;P_ObjetDate)

C_TEXT:C284($T_Var)
C_LONGINT:C283($L_Table;$L_Champ;$L_ChampG;$L_ChampH;$L_ChampD;$L_ChampB;$L_FenG;$L_FenH;$L_FenD;$L_FenB;$L_Ref)

P_ObjetDate:=$1  // Pointeur sur le champs date
$L_Ref:=$2  // La référence de la fenêtre qui contient le champs date

  // Récupération des coordonnées du champs date
RESOLVE POINTER:C394(P_ObjetDate;$T_Var;$L_Table;$L_Champ)
OBJECT GET COORDINATES:C663(P_ObjetDate->;$L_ChampG;$L_ChampH;$L_ChampD;$L_ChampB)
  // Coordonnées de la fenêtre
GET WINDOW RECT:C443($L_FenG;$L_FenH;$L_FenD;$L_FenB;$L_Ref)

$L_Ref:=Open window:C153($L_FenG+$L_ChampG;$L_FenH+$L_ChampB;$L_FenG+$L_ChampG+152;$L_FenH+$L_ChampB+173;Fenêtre pop up:K34:14)
DIALOG:C40("PopCalendar";*)
$1->:=$1->
GOTO OBJECT:C206($1->)
POST KEY:C465(Tabulation:K15:37)

  // Maintenant, repositionnons la fenêtre correctement à cause de sa dimension
GET WINDOW RECT:C443($gauche;$haut;$droite;$bas;Frontmost window:C447)

If ($gauche<$L_FenG)
	SET WINDOW RECT:C444($gauche;$haut;$droite+($L_FenG-$gauche);$bas;Frontmost window:C447)
	GET WINDOW RECT:C443($gauche;$haut;$droite;$bas;Frontmost window:C447)
End if 

If ($droite>$L_FenD)
	SET WINDOW RECT:C444($L_FenG-($L_FenD-$droite);$haut;$droite;$bas;Frontmost window:C447)
	GET WINDOW RECT:C443($gauche;$haut;$droite;$bas;Frontmost window:C447)
End if 

If ($haut<$L_FenH)
	SET WINDOW RECT:C444($gauche;$haut;$L_FenD;$L_FenB+($haut-$L_FenH);Frontmost window:C447)
	GET WINDOW RECT:C443($gauche;$haut;$droite;$bas;Frontmost window:C447)
End if 

If ($bas>$L_FenB)
	SET WINDOW RECT:C444($gauche;$haut-($bas-$L_FenB-10);$droite;$L_FenB-10;Frontmost window:C447)
	GET WINDOW RECT:C443($gauche;$haut;$droite;$bas;Frontmost window:C447)
End if 