//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 06/05/18, 20:36:48
  // ----------------------------------------------------
  // Paramètres
  // $1 = texte à découper
  // $2 = pointeur sur le tableau à remplir
  // {$3} = valeur du séparateur entre les ligne du tableau
  // ----------------------------------------------------
  // Méthode : ZBaseDecoupeTableau
  // Description
  //  ---------------------------------------------------

C_TEXT:C284($1;$Texte)
C_POINTER:C301($2)
C_TEXT:C284($3;$Sep)
C_LONGINT:C283($p;$p_old)

$texte:=$1
$array:=$2
$sep:=$3
$p_old:=1
$counter:=0

INSERT IN ARRAY:C227($array->;1;1000)  // To speed the process
Repeat 
	
	$p:=Position:C15($sep;$texte;$p_old)
	$counter:=$counter+1
	If ($counter>Size of array:C274($array->))
		INSERT IN ARRAY:C227($array->;$counter;1000)  // Add 1000 rows from $counter row
	End if 
	
	If ($p>0)
		$array->{$counter}:=Substring:C12($texte;$p_old;$p-$p_old)
		$p_old:=$p+1
	Else 
		$array->{$counter}:=Substring:C12($texte;$p_old)
		$texte:=""
	End if 
	
Until ($texte="")

If (($Counter+1)<=Size of array:C274($array->))
	DELETE FROM ARRAY:C228($array->;$Counter+1;Size of array:C274($array->))
End if 