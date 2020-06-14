//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/07/18, 18:04:37
  // ----------------------------------------------------
  // Paramètre aucun
  // ----------------------------------------------------
  // Méthode : ResP2HtmlLigneSimple <= ResP2CreationLignesOKP3 <= ResP2FabriqueRaemaRestreint <=  ResP2MF = traitement de la page 2
  // Description
  //  Permet d'écrire les lignes sans proposition dans la colonne 2 et avec un champ permanent dans la colonne 3

$RangBCGel:=$1
$Compteur:=Compteur
$IdLigne:=Replace string:C233(<>TbRefLigne{$Compteur};NumCampagneCourante;"")
$IdLigneGerme:=Substring:C12($IdLigne;1;2)
$IdLigneN:=Num:C11($IdLigne)
$ClasseLignePaireImpaire:=(Num:C11($IdLigneN%2=1)*"ligneimpaire")+(Num:C11($IdLigneN%2=0)*"lignepaire")
$ClassePrecPaireImpaire:=(Num:C11($IdLigneN%2=1)*"colonne3impair")+(Num:C11($IdLigneN%2=0)*"colonne3pair")
  // Traitons les masquage démasquage des champs 

$Escamotable:=<>TbEscamotable{$Compteur}
$ClasstrPUM:=""
If ($Escamotable="X")
	$ClasstrPUM:="trPUM"+$IdLigneGerme
End if 
  // traitement des données antérieures
$ValeurAntérieure:=WebTrouveValeurParNom (("Champ"+$IdLigne);->TbNomsP3;->TbValeursP3)


  // Le texte de la première colonne
$Intitulé:=(Num:C11(LangueCourante="A")*<>TbNomLigneA{$Compteur})+(Num:C11(LangueCourante#"A")*<>TbNomLigneF{$Compteur})
If ($Intitulé="@xxx@")  // C'est un échantillon de RAEMA Gel
	$Pos:=Position:C15("xxx";$Intitulé)
	$xxx:=$Intitulé[[$Pos-1]]+"xxx"
	$Intitulé:=Replace string:C233($Intitulé;$xxx;TbNumEch{$RangBCGel-1})
End if 
  // La classe JavaScript pour le contrôle de la saisie 
$Classe:=(Num:C11($Intitulé="@date@")*"champdate")+(Num:C11($Intitulé#"@date@")*"champnum")

  // Le HTML
$THTML:=""
$THTML:=$THTML+"           <tr class="+<>ZGuil+$ClasseLignePaireImpaire+" "+$ClasstrPUM+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"            <td class="+<>ZGuil+"colonne1"+<>ZGuil+">"+<>ZCR
  // Scinder l'intitulé s'il existe une parenthèse ouvrante
$Pos:=Position:C15("(";$Intitulé)
If ($Pos>0)
	$intitule1:=Substring:C12($Intitulé;1;($Pos-1))  // en noir
	$Intitule2:=Substring:C12($Intitulé;$Pos)  // en rouge
	$THTML:=$THTML+"               "+$intitule1+"<span class="+<>ZGuil+"rouge"+<>ZGuil+">"+$Intitule2+"</span>"+<>ZCR
Else 
	$THTML:=$THTML+"               "+$Intitulé
End if 
$THTML:=$THTML+"            </td>"+<>ZCR
$THTML:=$THTML+"            <td class="+<>ZGuil+"colonne2"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"            </td>"+<>ZCR
$THTML:=$THTML+"            <td class="+<>ZGuil+$ClassePrecPaireImpaire+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"              <div id="+<>ZGuil+"precision"+$IdLigne+<>ZGuil+" class="+<>ZGuil+"rouge plus"+<>ZGuil+"></div>"+<>ZCR
$THTML:=$THTML+"              <input type="+<>ZGuil+"text"+<>ZGuil+" name="+<>ZGuil+"Champ"+$IdLigne+<>ZGuil+" id="+<>ZGuil+"Champ"+$IdLigne+<>ZGuil
$THTML:=$THTML+" class="+<>ZGuil+$Classe+" champ"+<>ZGuil+" value="+<>ZGuil+$ValeurAntérieure+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"            </td>"+<>ZCR
$THTML:=$THTML+"          </tr>"+<>ZCR
$0:=$THTML
