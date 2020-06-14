//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 17/10/14, 16:16:01
  // ----------------------------------------------------
  // Méthode : UTIL_DedoublonneTableau
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
  // UTIL_DedoublonneTableau(->Tableau)-> Taille du tableau dédoublonné

  // VALEURS DISTINCTES POUR TOUT TYPE DE TABLEAU

  // Le tableau n'est pas triÈ mais ne contient plus de doublon
  //$1= Pointeur vers tout type de tableau souhaitÈ
  //$0= Taille du tableau nettoyÈ de ses doublons Èventuels



  // Ecrit par Jurgen von Hirschheydt

  // First, we take the first element, and check si it occurs again in the array.
  // si so, we mark each occurance, but we also check si the occurance has already
  // been marked. Additionally, we don't need to check doubled elements again, so
  // before running into the second loop which checks from i+1 to array fin de boucle
  // occurances, we check whether the actual element has been marked boucle deletion
  // si so, we can just skip it. At the end, we sort of"deletion" array, so that
  // the highest value is fist, which ensures we're deleting the original array
  // from back, so no more checking needed here, the element always exists, and the
  // position is not changed relatively...

C_POINTER:C301($1)  //Pointeur vers tout type de tableau souhaitÈ
C_LONGINT:C283($i;$j;$n;$0)
ARRAY LONGINT:C221($TableauIndicesASupprimer;0)

$n:=Size of array:C274($1->)

If ($n>1)  //Il faut au moins 2 ÈlÈments pour avoir des doublons possibles
	
	For ($i;1;$n-1)
		
		If (Find in array:C230($TableauIndicesASupprimer;$i)<0)  //N'est pas dans la liste ‡ supprimer, on doit vÈrifier qu'il est unique
			
			For ($j;$i+1;$n)  //On compare avec les ÈlÈments restants du tableau
				
				If (($1->{$i}=$1->{$j}))  //$i possËde un doublon ‡ la position $j
					
					If (Find in array:C230($TableauIndicesASupprimer;$j)<0)  //Et ce doublon n'est pas encore rÈfÈrencÈ
						
						INSERT IN ARRAY:C227($TableauIndicesASupprimer;1)  //On l'ajoute donc
						$TableauIndicesASupprimer{1}:=$j  //au tableau des indices ‡ supprimer dans le tableau soumis
						
					End if 
					
				End if 
				
			End for 
			
		End if 
		
	End for 
	
	If (Size of array:C274($TableauIndicesASupprimer)>0)  //Il y a des doublons ‡ supprimer
		
		SORT ARRAY:C229($TableauIndicesASupprimer;<)  //Les premiËres valeurs sont les plus gros indices
		
		For ($i;1;Size of array:C274($TableauIndicesASupprimer))
			
			DELETE FROM ARRAY:C228($1->;$TableauIndicesASupprimer{$i})  //Suppression du doublon
			
		End for 
		
	End if 
	
End if 

$0:=Size of array:C274($1->)