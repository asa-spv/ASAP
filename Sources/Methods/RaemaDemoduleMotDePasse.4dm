//%attributes = {}
  // ResP1Preambule
  // vérifie la validité du code raema et du mot de passe
  // appelée par ResP1MF <- dialogue identification (raemaaccueil.shtml)
  // {$1} = existe si récupération des rapports

C_TEXT:C284($Code)
C_BOOLEAN:C305($B;$NonTest;$0)
C_LONGINT:C283($Valeur)
MotifRefus:=""  // Initialisation de la variable qui recueille le motif du refus
$0:=True:C214  // optimiste avec ça


  // vérification du code raema
$NonTest:=(MotDePasseActuel#"FuQPRPqSYE") & ($Code#"13")
  // Booléen de non test : Raema n°#13 et mot de passe # FuQPRPqSYE
If ($NonTest)  // ce n'est pas un test
	$L:=Find in array:C230(<>TbPerIdentificateur;MotDePasseActuel)
	Case of 
		: ($l<0)  // aucune personne n'a ce code
			MotifRefus:=RaemaTraducUtiliseTableau (77)
			$0:=False:C215
			
			
		: (NumLaboActuelA#String:C10(<>TbPerNumLaboRAEMA{$L}))  //incohérence entre n° Raema saisi et n° Raema déduit du code
			MotifRefus:=RaemaTraducUtiliseTableau (78)
			$0:=False:C215
			
		: (<>TbPerCaduc{$L}) & (Count parameters:C259=0)  // Mince, il est caduc !
			MotifRefus:=RaemaTraducUtiliseTableau (78)
			$0:=False:C215
			
		Else 
			$Valeur:=1+Num:C11(Count parameters:C259>0)
			If ($Valeur=1)  // récup rapport - pas encore de traduction
				LangueCourante:="F"
			End if 
			
	End case 
End if 