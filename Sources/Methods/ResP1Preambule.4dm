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
$Récupération:=(Count parameters:C259=1)

  // vérification du code raema
$L:=Find in array:C230(<>TbPerIdentificateur;MotDePasseActuel)
Case of 
		
	: (TestLabo13)
		$0:=True:C214
		
	: ($L<0) | (MotDePasseActuel="")
		MotifRefus:=RaemaTraducUtiliseTableau (77)
		$0:=False:C215
		
	: (<>TbPerNumLaboRAEMA{$L}#Num:C11(NumLaboActuelA)) | (NumLaboActuelA="")
		MotifRefus:=RaemaTraducUtiliseTableau (78)
		$0:=False:C215
		
	: (<>TbPerCaduc{$L}) & (Count parameters:C259=0)  // Laisse passer les caducs pour la récupération des rapports
		MotifRefus:=RaemaTraducUtiliseTableau (78)
		$0:=False:C215
		
	Else   // On a trouvé un adhérent qui a tapé le bon mot de passe qui correspond au n° RAEMA
		If ($Récupération)  // récup rapport - pas encore de traduction
			LangueCourante:="F"
		End if 
		
End case 
