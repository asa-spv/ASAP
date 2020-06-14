//%attributes = {"invisible":true}
  //Ptr_empty (->obj1{;...;->objN)
C_POINTER:C301(${1})
C_LONGINT:C283($lType;$i)
  //_
For ($i;1;Count parameters:C259)
	If (Not:C34(Is nil pointer:C315(${$i})))
		$lType:=Type:C295(${$i}->)
		
		Case of 
				
			: ($lType=Est un texte:K8:3) | ($lType=Est un champ alpha:K8:1) | ($lType=Est une variable chaîne:K8:2)
				${$i}->:=""
				
			: (($lType=Est un numérique:K8:4) | ($lType=Est un entier:K8:5) | ($lType=Est un entier long:K8:6))
				${$i}->:=0
				
			: ($lType=Est une date:K8:7)
				${$i}->:=!00-00-00!
				
			: ($lType=Est un booléen:K8:9)
				${$i}->:=False:C215
				
			: ($lType=Est une heure:K8:8)
				${$i}->:=?00:00:00?
				
			: ($lType=Est une image:K8:10)
				C_PICTURE:C286($im)
				${$i}->:=$im
				
			: ($lType>=Est un tableau numérique:K8:17) & ($lType<=Est un tableau booléen:K8:21)  //13 à 22
				If (Size of array:C274(${$i}->)>0)
					DELETE FROM ARRAY:C228(${$i}->;1;Size of array:C274(${$i}->))
				End if 
				
			: ($lType=Est un pointeur:K8:14)
				C_POINTER:C301($p)
				${$i}->:=$p
				
			: ($lType=Est un BLOB:K8:12)
				SET BLOB SIZE:C606(${$i}->;0)
				
			Else   //indéfinie ou non traité
				C_TEXT:C284($sNomVar)
				C_LONGINT:C283($ltable;$lChamp)
				RESOLVE POINTER:C394(${$i};$sNomVar;$lTable;$lChamp)
				ALERT:C41(Current method name:C684+" type non traité "+String:C10($lType)+"\r"+$sNomVar)
		End case 
		
	End if 
End for 
  //_

