//%attributes = {}
  // ZBaseErreurIC
  // ******************************
  // Créée le 22 Sep 1999 à 15:21:04
  // Utilisateur 4D: Designer /  Machine: Mac Jean-Luc /  Possesseur: Jean-Luc Pelle
  // $Suite :=  IC_Erreur(nroErreur;"Nom_De_La_Commande";0-1-2;"»Variable)
  //Parametre 3 :  0 -> Pas de message
  //             1 -> afficher une alerte
  //            2 -> valoriser une variable
  // ******************************

C_LONGINT:C283($1)
C_TEXT:C284($2)

$ErrorTxt:=""

If (Count parameters:C259=4)
	$4->:=""
End if 

$ErrorTxt:=": "+IT_ErrorText ($1)
Case of 
	: ($1=0)  //Pas d errreur 
		$0:=True:C214
		
	: (Count parameters:C259<3)  //pour filtrer les erreurs de programmation
		TRACE:C157
		$0:=False:C215
		
	: ($3=1)  // erreur dans une alerte
		$ErrorTxt:="Erreur N° "+String:C10($1)+" sur la commande "+$2+Char:C90(13)+$ErrorTxt
		ALERT:C41($ErrorTxt)
		$0:=False:C215
		
	: ($3=2)  //retour d erreur dans une variable
		$ErrorTxt:="Erreur N° "+String:C10($1)+" sur la commande"+$2+" "+$ErrorTxt
		$4->:=$ErrorTxt
		$0:=False:C215
		
End case 
  //`
