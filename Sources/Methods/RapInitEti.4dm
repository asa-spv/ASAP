//%attributes = {}
  // RapInitEti
  // permet d'afficher l'entête des colonnes de la gestion des rapports
  // $1 = Pt sur tableau à remplir
$Pt:=$1
RESOLVE POINTER:C394($Pt;NomVar;NumTable;NumChamp)
$TT:=Size of array:C274($Pt->)
$S:=Num:C11($TT>1)*"s"
$Nb:=String:C10($TT)
If (NomVar="@retenus@")
	$0:=$Nb+" retenu"+$s
Else 
	If (NomVar="@particip")  // Non participants
		$0:=$Nb+" annulé"+$s
	Else 
		$Non:=Num:C11(NomVar="@non@")*" non"
		
		If (NomVar="@Pris")  // le tableau concerne les rapports
			$0:=$Nb+$Non+" obtenu"+$s
		Else   // le tableau concerne les mails
			$0:=$Nb+$Non+" envoyé"+$s
		End if 
	End if 
End if 