//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 17/02/16, 14:50:40
  // ----------------------------------------------------
  // Méthode : RAEMADemoduleMdPWeb
  // Description
  // Extrait le mot de passe ou le n° de labo 
  // Paramètres : 
  // $1 = chaine à décoder = le mot de passe 10 caractères
  // $0 = n° labo raema (numérique) si nombre de paramètre = 1
  // {$2} si existe renvoie le numéro d'adhérent (numérique)
  // ----------------------------------------------------


C_LONGINT:C283($0)

$Chiffre:=""
If (Count parameters:C259=2)  // on cherche le n° d'adhérent
	$A:=Substring:C12($1;1;5)
	Case of 
		: ($A="H@")  // le code adherent n'a qu'un seul caractère
			$Chiffre:=String:C10(Character code:C91($A[[2]])-112)
			
		: ($A="U@")  // le code adherent 2 caractères
			$Chiffre:=String:C10(((Character code:C91($A[[2]])-112)*10)+(Character code:C91($A[[3]])-80))
			
		: ($A="F@")  // le code adherent 3 caractères
			$Chiffre:=String:C10(((Character code:C91($A[[2]])-112)*100)+((Character code:C91($A[[3]])-80)*10)+(Character code:C91($A[[4]])-80))
			
		: ($A="G@")  // le code adherent 4 caractères
			$Chiffre:=String:C10(((Character code:C91($A[[2]])-112)*1000)+((Character code:C91($A[[3]])-80)*100)+((Character code:C91($A[[4]])-80)*10)+(Character code:C91($A[[5]])-80))
	End case 
	
Else   // on cherche le n° de RAEMA
	
	$R:=Substring:C12($1;6;5)
	Case of 
		: ($R="R@")  // le code raema n'a qu'un seul caractère
			$Chiffre:=String:C10(Character code:C91($R[[2]])-112)
			
		: ($R="P@")  // le code raema 2 caractères
			$Chiffre:=String:C10(((Character code:C91($R[[2]])-112)*10)+(Character code:C91($R[[3]])-80))
			
		: ($R="S@")  // le code raema 3 caractères
			$Chiffre:=String:C10(((Character code:C91($R[[2]])-112)*100)+((Character code:C91($R[[3]])-80)*10)+(Character code:C91($R[[4]])-80))
			
		: ($R="Z@")  // le code raema 4 caractères
			$Chiffre:=String:C10(((Character code:C91($R[[2]])-112)*1000)+((Character code:C91($R[[3]])-80)*100)+((Character code:C91($R[[4]])-80)*10)+(Character code:C91($R[[5]])-80))
	End case 
	
End if 
$0:=Num:C11($Chiffre)