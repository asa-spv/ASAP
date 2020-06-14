//%attributes = {"invisible":true}
  // BASE_filtrerTexte ( "texte" ;  { "filtre" } ) -> "texte filtré"
  // Cette méthode permet de filtrer une chaîne avec un filtre passé en second paramètre
  // Les caractères ne seront retournés que s'ils sont présent dans le filtre
  // Note: Cette méthode est diacritique ("a" # "A")

  //BASE_filtrerTexte ("0123456789";"02468")  `==>  "02468"
  //BASE_filtrerTexte ("012";"02468")  `==>  "02"
  //BASE_filtrerTexte ("0a12";"02468")  `==>  "02"
  //BASE_filtrerTexte ("0,1";"02468")  `==>  "0"
  //BASE_filtrerTexte ("0.1";"02468")  `==>  "0"
  //BASE_filtrerTexte ("a";"02468")  `==>  ""
  //BASE_filtrerTexte ("";"02468")  `==>  ""
  //BASE_filtrerTexte ("02468")  `==>  ""

C_TEXT:C284($0;$ChaineFiltree)  //texte filtré
C_TEXT:C284($1;$texte)  //chaine à tester
C_TEXT:C284($2;$filtre)  //chaine contenant le filtre
C_LONGINT:C283($i;$n;$code)

$texte:=$1

If (Count parameters:C259>=2)
	$filtre:=$2
Else 
	$filtre:="01234567890"
End if 

  // On met dans un tableau les codes composant le filtre :

$n:=Length:C16($filtre)
ARRAY LONGINT:C221($TableauFiltreAscii;$n)

For ($i;1;$n)
	$TableauFiltreAscii{$i}:=Character code:C91($filtre[[$i]])
End for 

  // On va boucler pour filtrer la chaîne :

$ChaineFiltree:=""

For ($i;1;Length:C16($texte))
	$code:=Character code:C91($texte[[$i]])
	
	If (Find in array:C230($TableauFiltreAscii;$code)=Aucun enregistrement courant:K29:2)
		  // éliminé
		
	Else   //Le code ascii est bien dans le tableau du filtre, on le garde
		$ChaineFiltree:=$ChaineFiltree+Char:C90($code)
	End if 
End for 

$0:=$ChaineFiltree
