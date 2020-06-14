//%attributes = {}
  //ZDocNomFichier V11 du 14/08/2010
  //$1= chemin du document
  //$2 (numérique) = 0 ou 1 selon le résultat escompté
  //si $2 = 0 le résultat est le nom court du fichier 
  //si $2 = 1 le résultat est le chemin du dossier incluant le document 

  //Voir notes techniques de janvier 92
  //récupéré de PoleContact, de MIMOSA

  // Modifié par : ASA (09/05/12)



C_LONGINT:C283($i;$2)
C_TEXT:C284($1;$0;$CheminAcces)

$CheminAcces:=$1
$i:=Length:C16($CheminAcces)

If ($i#0)
	If ($CheminAcces[[$i]]=<>ZSéparateur)  //On enlève les deux points finaux ou le slash
		$i:=$i-1
		$CheminAcces:=Substring:C12($CheminAcces;1;$i)
	End if 
	
	While ((Substring:C12($CheminAcces;$i;1)#<>ZSéparateur) & ($i#0))
		$i:=$i-1
	End while 
	
	If ($2=0)
		$0:=Substring:C12($CheminAcces;$i+1)  //On retourne le nom du document
	Else 
		$0:=Substring:C12($CheminAcces;1;$i)  //On retourne le chemin d'accès
	End if 
	
Else   //Chaîne vide
	$0:=""
End if 