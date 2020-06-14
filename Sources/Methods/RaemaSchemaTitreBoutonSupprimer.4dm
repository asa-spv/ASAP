//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 27/07/18, 09:33:59
  // ----------------------------------------------------
  // Paramètre : $1=Pointeur sur la LB
  // ----------------------------------------------------
  // Méthode : RaemaSchemaTitreBoutonSupprimer
  // Description
  // // Méthode générique d'attribution du nom des 3 boutons Supprimer

C_LONGINT:C283($Table;$Champ)
C_POINTER:C301($Pt;$1)

$Pt:=$1
RESOLVE POINTER:C394($Pt;$NomVar;$Table;$Champ)
$Radical:=Substring:C12($NomVar;8;(Length:C16($NomVar)-8))
$NomBouton:=$Radical+"BouSup"
$L:=0
$Compteur:=0
$FT:=Size of array:C274($Pt->)
For ($Salé;1;$FT)
	$L:=Find in array:C230($Pt->;True:C214;($L+1))
	If ($L<0)
		$Salé:=$FT
	Else 
		$Compteur:=$Compteur+1
	End if 
End for 
Case of 
	: ($Compteur=0)
		OBJECT SET VISIBLE:C603(*;$NomBouton;False:C215)
		
	: ($Compteur=1)
		OBJECT SET VISIBLE:C603(*;$NomBouton;True:C214)
		$Titre:=(Num:C11($Radical="Germe")*"Supprimer le germe sélectionné")+(Num:C11($Radical#"Germe")*("Supprimer la "+$Radical+" sélectionnée"))
		OBJECT SET TITLE:C194(*;$NomBouton;$Titre)
		
	Else 
		OBJECT SET VISIBLE:C603(*;$NomBouton;True:C214)
		$Titre:="Supprimer les "+String:C10($Compteur)+" "+$Radical+"s sélectionné"+(Num:C11($Radical#"Germe")*"e")+"s"
		OBJECT SET TITLE:C194(*;$NomBouton;$Titre)
End case 

Case of 
	: ($Radical="Germe")
		OBJECT SET VISIBLE:C603(*;"Ligne@";($Compteur=1))
		OBJECT SET VISIBLE:C603(*;"Valeur@";False:C215)
		
	: ($Radical="Ligne")
		OBJECT SET VISIBLE:C603(*;"Valeur@";($Compteur=1))
		OBJECT SET VISIBLE:C603(*;"@prec";False:C215)
		OBJECT SET VISIBLE:C603(*;"@lien";False:C215)
End case 