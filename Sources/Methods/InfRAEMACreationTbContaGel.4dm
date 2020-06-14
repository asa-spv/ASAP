//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 09/09/16, 08:15:46
  // ----------------------------------------------------
  // Méthode : InfRAEMACreationTbContaGel <= RaemaInfEcritP2  <= RaemaInfEcritP2
  // Description
  // Ecrit le HTML de la contamination d'un RAEMA gel
  //
  // Paramètres : 
  // $1 [XDonnees]XTexte contenant les contaminations
  // $2 n° du RaemaGel
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT;$Fumé)
$Texte:=$1
$NumRaemaGel:=$2

If (LangueCourante="F")
	$TitrePage:="Niveau de contamination des échantillons du RAEMA Gel "
	$NomGermes:="Noms des germes"
Else 
	$TitrePage:="Level of contamination of samples RAEMA "
	$NomGermes:="Names of germs"
End if 
$THTML:="<div align="+<>ZGuil+"center"+<>ZGuil+">"+<>ZCR
$TitrePage:=$TitrePage+$NumRaemaGel
$THTML:=$THTML+"<br />"
  // $THTML:="<br /> <br /> <br /> <br /> <br /> <br /> "+<>ZCR
$THTML:=$THTML+"<p class="+<>ZGuil+"titrepage"+<>ZGuil+">"+$TitrePage+"</p>"+"<br />"+<>ZCR
$THTML:=$THTML+"<p class="+<>ZGuil+"textedecale"+<>ZGuil+">"+<>ZCR
QUERY:C277([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3=($NumRaemaGel+"@"))
ORDER BY:C49([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3;>)
ARRAY TEXT:C222($TbNomGermeConta;0)
If (LangueCourante="F")
	SELECTION TO ARRAY:C260([RAEMAGermes:21]NomFr:4;$TbNomGermeConta)
Else 
	SELECTION TO ARRAY:C260([RAEMAGermes:21]NomEn:5;$TbNomGermeConta)
End if 
DELETE FROM ARRAY:C228($TbNomGermeConta;1)

  //SÉLECTION VERS TABLEAU([RAEMA]Intitule;$Colonne1)
  //SUPPRIMER DANS TABLEAU($Colonne1;1)
  //$Colonne1{Taille tableau($Colonne1)}:="LEVURES SEPAREMENT"
  //AJOUTER À TABLEAU($Colonne1;"MOISISSURES SEPAREMENT")
  //AJOUTER À TABLEAU($Colonne1;"CAMPYLOBACTER RECHERCHE")
  //AJOUTER À TABLEAU($Colonne1;"CAMPYLOBACTER DENOMBREMENT")
  //TABLEAU TEXTE($Colonne1;8)
  //$colonne1{1}:="BACILLUS CEREUS"
  //$colonne1{2}:="BACTERIES LACTIQUES"
  //$colonne1{3}:="PSEUDOMONAS"
  //$colonne1{4}:="LEVURES-MOISISSURES ENSEMBLE"
  //$colonne1{5}:="MOISISSURES SEPAREMENT"
  //$colonne1{6}:="LEVURES SEPAREMENT"
  //$colonne1{7}:="CAMPYLOBACTER DENOMBREMENT"
  //$colonne1{8}:="CAMPYLOBACTER RECHERCHE"
$THTML:=$THTML+"  <table width="+<>ZGuil+"50%"+<>ZGuil+">"+<>ZCR
$Pair:=True:C214
$TT:=Size of array:C274($TbNomGermeConta)
For ($Salé;1;$TT)
	$Pos:=Position:C15(<>ZCR;$Texte)
	$Ligne:=Substring:C12($Texte;1;($Pos-1))
	$Texte:=Substring:C12($Texte;($Pos+1))
	$Pos:=Position:C15(<>ZTab;$Ligne)
	$Cellule:=Substring:C12($Ligne;1;($Pos-1))
	$Pair:=Not:C34($Pair)
	$CouleurLigne:="ligne"+(Num:C11($Pair)*"in")+"paire"
	$THTML:=$THTML+"    <tr class="+<>ZGuil+$CouleurLigne+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"<td>"+$TbNomGermeConta{$salé}+"</td>"+<>ZCR
	If ($Salé=8)
		$THTML:=$THTML+"<td>"+$Cellule+" /25g"+"</td>"+<>ZCR
	Else 
		$THTML:=$THTML+"<td>"+$Cellule+" UFC/g"+"</td>"+<>ZCR
	End if 
	$THTML:=$THTML+"    </tr>"+<>ZCR
End for 

$0:=$THTML+"</table>"+<>ZCR+"</div>"+"<br />"+<>ZCR


