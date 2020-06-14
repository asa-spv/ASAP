//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 19/06/17, 14:52:05
  // ----------------------------------------------------
  // Méthode : RetourTop5Generique
  // Description
  // 
  //
  // Paramètres $1 = type de retour
  // ----------------------------------------------------
QUERY:C277([RetoursFiches:24];[RetoursFiches:24]TypeRetour:5=$1;*)
QUERY:C277([RetoursFiches:24]; & [RetoursFiches:24]DateRetour:3>=VarDateDebut;*)
QUERY:C277([RetoursFiches:24]; & [RetoursFiches:24]DateRetour:3<=VarDateFin)
ARRAY TEXT:C222($TbA;0)
ARRAY TEXT:C222($TbT;0)
ARRAY TEXT:C222($TbS;0)
ARRAY TEXT:C222($TbI;0)
ARRAY TEXT:C222($TbQ;0)
ARRAY LONGINT:C221($TbScoreA;0)
ARRAY LONGINT:C221($TbScoreT;0)
ARRAY LONGINT:C221($TbScoreS;0)
ARRAY LONGINT:C221($TbScoreI;0)
ARRAY LONGINT:C221($TbScoreQ;0)
SELECTION TO ARRAY:C260([RetoursFiches:24]Classification:8;$TbClass)
$TT:=Size of array:C274($TbClass)
For ($salé;1;$TT)
	$ClassifCourante:=$TbClass{$salé}
	If ($ClassifCourante#"")
		$Pos:=Position:C15("-";$ClassifCourante)
		$Type:=Substring:C12($ClassifCourante;1;$Pos)
		$PtT:=Get pointer:C304("$Tb"+$ClassifCourante[[1]])
		$PtS:=Get pointer:C304("$TbScore"+$ClassifCourante[[1]])
		$L:=Find in array:C230($PtT->;$ClassifCourante)
		If ($L=-1)
			APPEND TO ARRAY:C911($PtT->;$ClassifCourante)
			APPEND TO ARRAY:C911($PtS->;1)
		Else 
			$PtS->{$L}:=$PtS->{$L}+1
		End if 
	End if 
End for 
  // L'année précédente
QUERY:C277([RetoursFiches:24];[RetoursFiches:24]TypeRetour:5=$1;*)
QUERY:C277([RetoursFiches:24]; & [RetoursFiches:24]DateRetour:3>=(VarDateDebut-365);*)
QUERY:C277([RetoursFiches:24]; & [RetoursFiches:24]DateRetour:3<=(VarDateFin-365))
ARRAY TEXT:C222($TbAP;0)
ARRAY TEXT:C222($TbTP;0)
ARRAY TEXT:C222($TbSP;0)
ARRAY TEXT:C222($TbIP;0)
ARRAY TEXT:C222($TbQP;0)
ARRAY LONGINT:C221($TbScoreAP;0)
ARRAY LONGINT:C221($TbScoreTP;0)
ARRAY LONGINT:C221($TbScoreSP;0)
ARRAY LONGINT:C221($TbScoreIP;0)
ARRAY LONGINT:C221($TbScoreQP;0)
SELECTION TO ARRAY:C260([RetoursFiches:24]Classification:8;$TbClassP)
$TT:=Size of array:C274($TbClassP)
For ($salé;1;$TT)
	$ClassifCourante:=$TbClassP{$salé}
	If ($ClassifCourante#"")
		$Pos:=Position:C15("-";$ClassifCourante)
		$Type:=Substring:C12($ClassifCourante;1;$Pos)
		$PtTP:=Get pointer:C304("$Tb"+$ClassifCourante[[1]]+"P")
		$PtSP:=Get pointer:C304("$TbScore"+$ClassifCourante[[1]]+"P")
		$L:=Find in array:C230($PtTP->;$ClassifCourante)
		If ($L=-1)
			APPEND TO ARRAY:C911($PtTP->;$ClassifCourante)
			APPEND TO ARRAY:C911($PtSP->;1)
		Else 
			$PtSP->{$L}:=$PtSP->{$L}+1
		End if 
	End if 
End for 

$texte:=RetourTop5RemplitTb (->$TbScoreT;->$TbT;->$TbScoreTP;->$TbTP)
$texte:=$texte+RetourTop5RemplitTb (->$TbScoreS;->$TbS;->$TbScoreTP;->$TbTP)
$texte:=$texte+RetourTop5RemplitTb (->$TbScoreA;->$TbA;->$TbScoreTP;->$TbTP)
$texte:=$texte+RetourTop5RemplitTb (->$TbScoreI;->$TbI;->$TbScoreTP;->$TbTP)
$texte:=$texte+RetourTop5RemplitTb (->$TbScoreQ;->$TbQ;->$TbScoreTP;->$TbTP)
$0:=$texte