//%attributes = {"publishedWeb":true}


  // ZBaseNombreHasardEncadré
  //Retourne un nombre au hasard entre BorneSup et BorneInf
  //le 22/08/99
C_LONGINT:C283($1)  //Borne inf
C_LONGINT:C283($2)  // Borne sup
C_LONGINT:C283($0)

C_LONGINT:C283($Max;$Min)
$Min:=$1
$Max:=$2

$0:=(Random:C100%($Max-$Min+1))+$Min