//%attributes = {"publishedWeb":true}
  //ZCouleurFeu
  // V11 du 10/08/2010
  //Retourne la couleur (Verte ou Bleu) du feu correspondant à $1
  //$1 : Champ concerné
  // {$2} : si existe vrai = Date; Faux = Numérique  sinon texte

C_PICTURE:C286($0)
C_BOOLEAN:C305($2)

$0:=<>FeuRouge  //Par défaut
If (Count parameters:C259=2)
	If ($2)
		If ($1->#!00-00-00!)
			$0:=<>FeuVert
		End if 
		
	Else   //$2=faux    
		If ($1->#0)
			$0:=<>FeuVert
		End if 
	End if 
	
Else   //C'est du Texte
	If ($1->#"")
		$0:=<>FeuVert
	End if 
End if 