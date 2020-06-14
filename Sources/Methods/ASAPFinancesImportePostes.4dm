//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 12/01/19, 09:58:31
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPFinancesImportePostes
  // Description
  // Permet d'importer les postes budgétaires de EPB

C_LONGINT:C283($Salé;$Fumé;$Sec;$NbCompte)
READ WRITE:C146([PostesBudgetaires:18])
ALL RECORDS:C47([PostesBudgetaires:18])
DELETE SELECTION:C66([PostesBudgetaires:18])
USE CHARACTER SET:C205("Macintosh";1)
$Doc:=Open document:C264("";Mode lecture:K24:5)

ARRAY TEXT:C222(TbBilanFCode;0)
ARRAY TEXT:C222(TbBilanFIntitule;0)
ARRAY TEXT:C222(TbBilanFChapitre;0)
ARRAY TEXT:C222(TbBilanFSousChapitre;0)
ARRAY BOOLEAN:C223(TbBilanFUtilisé;0)

RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
$Ligne:=Replace string:C233($Ligne;Char:C90(10);"")
If ($Ligne="N° du Compte@")
	$NbCompte:=0
	$NomChapitre:=""
	$NomSousChapitre:=""
	For ($Salé;1;10000)
		$Ligne:=Replace string:C233($Ligne;Char:C90(10);"")
		$Pos:=Position:C15(<>ZTab;$Ligne)
		$ValeurA:=Substring:C12($Ligne;1;($Pos-1))
		$ValeurN:=Num:C11($ValeurA)
		If ($ValeurA=String:C10($ValeurN))
			$Lo:=Length:C16($ValeurA)
			If ($Lo<5)  // C'est un Chapitre ou sous chapitre
				$Ligne:=Substring:C12($Ligne;($Pos+1))  // Colonne 2 = libéllé
				$Pos:=Position:C15(<>ZTab;$Ligne)
				$NomChapitre:=Substring:C12($Ligne;1;($Pos-1))
				If ($Lo=1)
					$NomChapitre:=$NomChapitre
					$NomSousChapitre:=""
				Else 
					$NomSousChapitre:=$NomChapitre
				End if 
				
			Else 
				APPEND TO ARRAY:C911(TbBilanFCode;$ValeurA)
				APPEND TO ARRAY:C911(TbBilanFChapitre;$NomChapitre)
				APPEND TO ARRAY:C911(TbBilanFSousChapitre;$NomSousChapitre)
				
				$Ligne:=Substring:C12($Ligne;($Pos+1))  // Colonne 2 = libéllé
				$Pos:=Position:C15(<>ZTab;$Ligne)
				$ValeurA:=Substring:C12($Ligne;1;($Pos-1))
				APPEND TO ARRAY:C911(TbBilanFIntitule;$ValeurA)
				
				$Ligne:=Substring:C12($Ligne;($Pos+1))  // Colonne 3 = compte bloqué (ignoré)
				$Pos:=Position:C15(<>ZTab;$Ligne)
				
				$Ligne:=Substring:C12($Ligne;($Pos+1))  // Colonne 4 = crédit
				$Pos:=Position:C15(<>ZTab;$Ligne)
				$ValeurA:=Substring:C12($Ligne;1;($Pos-1))
				$ValeurN:=Num:C11($ValeurA)
				APPEND TO ARRAY:C911(TbBilanFUtilisé;($ValeurN#0))
				
			End if 
		End if 
		RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
		$Ligne:=Replace string:C233($Ligne;Char:C90(10);"")
		If ($Ligne=((<>ZTab*2)+"@"))
			$Salé:=10000
		End if 
	End for 
End if 
CLOSE DOCUMENT:C267($Doc)
USE CHARACTER SET:C205(*;1)

ARRAY TO SELECTION:C261(TbBilanFCode;[PostesBudgetaires:18]NumPoste:2\
;TbBilanFIntitule;[PostesBudgetaires:18]IntitulePoste:3\
;TbBilanFChapitre;[PostesBudgetaires:18]ChapitrePoste:4\
;TbBilanFUtilisé;[PostesBudgetaires:18]PosteUlil:8\
;TbBilanFSousChapitre;[PostesBudgetaires:18]SousChapitrePoste:5)