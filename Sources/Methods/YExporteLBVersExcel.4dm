//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Admin
  // Date et heure : 31/08/16, 16:28:24
  // ----------------------------------------------------
  // Méthode : YExporteLBVersExcel
  // Description
  // 
  //Paramètre : $1 =Pt vers ListBox à exporter
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)
C_TIME:C306($Doc)
ARRAY POINTER:C280($tabVarCols;0)
ARRAY POINTER:C280($tabVarEntêtes;0)
ARRAY TEXT:C222($tabNomsEntêtes;0)
ARRAY TEXT:C222($tabNomsCols;0)
ARRAY BOOLEAN:C223($tabColsVisibles;0)
ARRAY POINTER:C280($tabStyles;0)

$Pt:=$1
$SepEnr:=Char:C90(13)  // Le séparateur d'enregistrement = retour chariot
$SepChamp:=Char:C90(9)  // Le séparateur de champ = tabulation
$CE:=Windows Ctrl down:C562
If ($CE)
	$Doc:=Create document:C266("")  // Création d'un document vide
Else 
	OK:=1
End if 
If (OK=1)  // On a validé le document
	  // Il faut remplir le document avec $Envoi
	
	LISTBOX GET ARRAYS:C832($Pt->;$tabNomsCols;$tabNomsEntêtes;$tabVarCols;$tabVarEntêtes;$tabColsVisibles;$tabStyles)
	$TT:=LISTBOX Get number of columns:C831($Pt->)
	  // Ecrivons la première ligne
	$envoi:=""
	For ($fumé;1;$TT)  //Autant que de colonnes
		If ($tabColsVisibles{$fumé})
			$envoi:=$envoi+OBJECT Get title:C1068(*;$tabNomsEntêtes{$fumé})+$SepChamp
		End if 
	End for 
	$envoi:=$envoi+$SepEnr
	
	  //$envoi:="Labo"+$SepChamp+"FAM"+$SepChamp+"Entéro"+$SepChamp+"CT"+$SepChamp+"CF"+$SepChamp+"E Coli"+$SepChamp+"ASR"+$SepChamp+"CLP"+$SepChamp+"Staph"+$SepChamp+"SR"+$SepChamp+"LR"+$SepChamp+"LM dmt"+$SepChamp+$SepEnr\
		
	
	$Ft:=LISTBOX Get number of rows:C915($Pt->)  // Le nombre de lignes
	For ($Salé;1;$FT)  // pour chaque ligne
		$TT:=LISTBOX Get number of columns:C831($Pt->)
		For ($fumé;1;$TT)  //Autant que de colonnes
			If ($tabColsVisibles{$fumé})
				$envoi:=$envoi+String:C10($tabVarCols{$fumé}->{$Salé})+$SepChamp
			End if 
		End for 
		$envoi:=$envoi+$SepEnr
		
		  //$envoi:=$envoi+Chaine(Colonne1N{$Salé})+$SepChamp+Chaine(Colonne2{$Salé})+$SepChamp
		  //$envoi:=$envoi+Chaine(Colonne3{$Salé})+$SepChamp+Chaine(Colonne4{$Salé})+$SepChamp
		  //$envoi:=$envoi+Chaine(Colonne5{$Salé})+$SepChamp+Chaine(Colonne6{$Salé})+$SepChamp
		  //$envoi:=$envoi+Chaine(Colonne7{$Salé})+$SepChamp+Chaine(Colonne8{$Salé})+$SepChamp
		  //$envoi:=$envoi+Chaine(Colonne9{$Salé})+$SepChamp+Chaine(Colonne10{$Salé})+$SepChamp
		  //$envoi:=$envoi+Chaine(Colonne11{$Salé})+$SepChamp+Chaine(Colonne12{$Salé})+$SepEnr
	End for 
	If ($CE)
		SEND PACKET:C103($Doc;$Envoi)
	Else 
		  //  FIXER TEXTE DANS CONTENEUR($envoi)
		ALERT:C41("Bonne nouvelle ! \nVotre tableau est dans le presse-papier")
	End if 
End if 
If ($CE)
	CLOSE DOCUMENT:C267($Doc)
End if 