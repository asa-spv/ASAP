//%attributes = {}
  // ZAgeAnMois
  //ZAgeAnMois V11 09/08/2010
  //Retourne dans $0 l'âge sous la forme "23 ans 5 mois"
  //$1=DATE DE NAISSANCE
  //{$2}=DATE DE RÉFÉRENCE (date du jour si parametre absent)
  //Écrit à Paris le 20 octobre 1994
  //Ecrit par MIMOSA
  //Syntaxe :   Variable:=ZAgeAnMois([Table]ChampDate)

C_DATE:C307($1;$2)
C_TEXT:C284($0)
C_LONGINT:C283($Jours;$An;$Mois)

If ($1#!00-00-00!)
	  //Calcul du nombre de jours POSITIFS separant les deux dates
	
	If (Count parameters:C259=1)
		$Jours:=Abs:C99(Current date:C33-$1)
	Else 
		$Jours:=Abs:C99($2-$1)
	End if 
	
	$An:=Int:C8($Jours/365.25)  //Nombre d'années
	$Mois:=Int:C8(($Jours-($An*365.25))/30.5)  //Nombre de mois dans la dernière année
	
	If ($An>0)
		$0:=String:C10($An;"##")+" ans"  //23 ans
	Else 
		$0:=""
	End if 
	
	If ($Mois>0)
		$0:=$0+" "+String:C10($Mois;"##")+" mois"  //23 ans 7 mois
	End if 
	
Else   //$1=!00/00/00!
	$0:=""  //Pas de date de naissance
End if 