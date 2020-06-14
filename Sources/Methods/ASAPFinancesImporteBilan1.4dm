//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 12/01/19, 09:58:31
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPFinancesImporteBilan
  // Description
  // Permet de transformer l'export de EPB en bilan annuel

C_LONGINT:C283($Salé;$Fumé;$Sec;$NbCompte)

USE CHARACTER SET:C205("Macintosh";1)
$Doc:=Open document:C264("";Mode lecture:K24:5)

ARRAY TEXT:C222(TbBilanFCode;0)
ARRAY TEXT:C222(TbBilanFIntitule;0)
ARRAY TEXT:C222(TbBilanFVentilation;0)
ARRAY REAL:C219(TbBilanFSoldeN;0)
ARRAY REAL:C219(TbBilanFSoldeNMoinsUN;0)
READ WRITE:C146([PostesBudgetaires:18])
APPLY TO SELECTION:C70([PostesBudgetaires:18];[PostesBudgetaires:18]PosteUlil:8:=False:C215)
$NbCompte:=0
For ($Salé;1;10000)
	RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
	$Ligne:=Replace string:C233($Ligne;Char:C90(10);"")
	If ($Ligne="Compte@")
		$NbCompte:=$NbCompte+1
		RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
		$Ligne:=Replace string:C233($Ligne;Char:C90(10);"")
		For ($Fumé;1;10000)
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$ValeurA:=Substring:C12($Ligne;1;($Pos-1))
			$ValeurN:=Num:C11($ValeurA)
			If ($ValeurA=String:C10($ValeurN))
				APPEND TO ARRAY:C911(TbBilanFCode;$ValeurA)
				QUERY:C277([PostesBudgetaires:18];[PostesBudgetaires:18]NumPoste:2=$ValeurA)
				[PostesBudgetaires:18]PosteUlil:8:=($ValeurN#0)
				SAVE RECORD:C53([PostesBudgetaires:18])
				
				$Ligne:=Substring:C12($Ligne;($Pos+1))  // Colonne 2 ignorée
				$Pos:=Position:C15(<>ZTab;$Ligne)
				
				$Ligne:=Substring:C12($Ligne;($Pos+1))  // Colonne 3 ignorée
				$Pos:=Position:C15(<>ZTab;$Ligne)
				
				$Ligne:=Substring:C12($Ligne;($Pos+1))  // Colonne 4 = libéllé
				$Pos:=Position:C15(<>ZTab;$Ligne)
				$ValeurA:=Substring:C12($Ligne;1;($Pos-1))
				APPEND TO ARRAY:C911(TbBilanFIntitule;$ValeurA)
				
				
				C_LONGINT:C283($Salé;$FT)
				
				For ($Sec;1;9)  // Colonne 5 à 13
					$Pos:=Position:C15(<>ZTab;$Ligne)
					$Ligne:=Substring:C12($Ligne;($Pos+1))
				End for 
				$Pos:=Position:C15(<>ZTab;$Ligne)
				$ValeurA:=Substring:C12($Ligne;1;($Pos-1))
				$ValeurN:=Num:C11($ValeurA)
				APPEND TO ARRAY:C911(TbBilanFSoldeN;$ValeurN)
				
				$Pos:=Position:C15(<>ZTab;$Ligne)
				$Ligne:=Substring:C12($Ligne;($Pos+1))  // Colonne 14 ignorée
				
				$Pos:=Position:C15(<>ZTab;$Ligne)
				$Ligne:=Substring:C12($Ligne;($Pos+1))  // Colonne 15 N-1
				
				$Pos:=Position:C15(<>ZTab;$Ligne)
				$ValeurA:=Substring:C12($Ligne;1;($Pos-1))
				
				$ValeurN:=Num:C11($ValeurA)
				APPEND TO ARRAY:C911(TbBilanFSoldeNMoinsUN;$ValeurN)
				
				APPEND TO ARRAY:C911(TbBilanFVentilation;"")
				
			End if 
			RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
			$Ligne:=Replace string:C233($Ligne;Char:C90(10);"")
			If ($Ligne=((<>ZTab*12)+"@"))
				$Fumé:=10000
			End if 
		End for 
	End if 
	If ($NbCompte=3)
		$Salé:=10000
	End if 
End for 


ZAmnistieInternationale 
CLOSE DOCUMENT:C267($Doc)
USE CHARACTER SET:C205(*;1)