//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/07/18, 19:20:05
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ResP2HtmlLigneMultiple <= ResP2CreationLignesOKP3 <= ResP2FabriqueRaemaRestreint <=  ResP2MF = traitement de la page 2
  // Description
  // 
C_LONGINT:C283($Salé;$FT;$Compteur)
$Compteur:=Compteur
$IdTableau:=<>TbRefLigne{$Compteur}  // Type "671009"
$An:=Num:C11($IdTableau="@a@")
$IdLigne:=Substring:C12($IdTableau;(3+$An))  // Type "1009"
$IDLigneGerme:=Substring:C12($IdLigne;1;2)
$IDLigneWeb:="PUM"+$IdLigne
  // $LigneMéthode:=Sous chaîne($IdLigne;1;2)+"01"  // Type "1001" car la méthode est toujours en premier
$IdLigneN:=Num:C11(<>TbRefLigne{$Compteur})
$ClassePaireImpaire:=(Num:C11($IdLigneN%2=1)*"impair")+(Num:C11($IdLigneN%2=0)*"pair")
$ClassePaireImpaire2:=$ClassePaireImpaire+"e"


  // On créé les class de l'escamotage

If (<>TbEscamotage{$Compteur}="X")
	$ClassSelect:="escamotage"
Else 
	$ClassSelect:=""
End if 

If (<>TbEscamotable{$Compteur}="X")
	$ClassSelectCache:="trPUM"+$IDLigneGerme
Else 
	$ClassSelectCache:=""
End if 




  // class du tr (tr+id PUM)




  // // Escamotage de la ligne
  //$Escamotage:=""  // apriori, non.
  //Si (<>TbEscamotable{$Compteur}="X")  // sinon inutile de vérifier quoique ce soit
  //$ValeurAntérieureMéthode:=WebTrouveValeurParNom (("PUM"+$LigneMéthode);->TbAncNomsP3;->TbAncValeursP3)
  //Si ($ValeurAntérieureMéthode#"")  // si pas de valeur notée, inutile de vérifier quoique ce soit
  //$L:=Chercher dans tableau(<>TbRefLigne;(NumCampagneCourante+$LigneMéthode))  // recherche de la première ligne de description du germe
  //$FT:=Num(<>TbNbValeurs{$L})  // boucle sur les valeurs
  //Boucle ($Salé;1;$FT)
  //$Rang:=$L+$Salé-1  // indice des rangs dans le tableau général
  //Si (<>TbNomValeurF{$Rang}=$ValeurAntérieureMéthode) | (<>TbNomValeurA{$Rang}=$ValeurAntérieureMéthode)  // tient compte de la langue
  //Si (<>TbEscamotage{$Rang}="X")
  //$Escamotage:=" style="+<>ZGuil+"display: none;"+<>ZGuil  // on escamote !
  //$Salé:=$FT  // La messe est dite : on sort de la boucle
  //Fin de si 
  //Fin de si 
  //Fin de boucle 
  //Fin de si 
  //Fin de si 

  // Restitution de la valeur antérieure du champ de la colonne 3
$ValeurAntérieureChamp:=WebTrouveValeurParNom (("Champ"+$IdLigne);->TbAncNomsP3;->TbAncValeursP3)


  // Le texte de la première colonne
$Intitulé:=(Num:C11(LangueCourante="A")*<>TbNomLigneA{$Compteur})+(Num:C11(LangueCourante#"A")*<>TbNomLigneF{$Compteur})

  // Le HTML

$THTML:=""
$THTML:=$THTML+"           <tr class="+<>ZGuil+"ligne"+$ClassePaireImpaire2+" "+$ClassSelectCache+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"            <td class="+<>ZGuil+"colonne1"+<>ZGuil+">"+<>ZCR
$Pos:=Position:C15("xxx";$Intitulé)
If ($Pos>0)  // C'est un échantillon à réponse de type présence (Oui Non)
	$RangA:=Substring:C12($Intitulé;($Pos-1);1)
	$Obsolète:=$RangA+"xxx"
	$Intitulé:=Replace string:C233($Intitulé;$Obsolète;TbNumEch{Num:C11($RangA)})
End if 
$THTML:=$THTML+"              "+$Intitulé+<>ZCR
$THTML:=$THTML+"            </td>"+<>ZCR2

  // distinction entre PUM et boîtes à cocher
$FT:=Num:C11(<>TbNbValeurs{$Compteur})  // Le nombre de valeurs multiples
$ChampColonne3Caché:=True:C214  // A priori le champ de précision n'est pas visible
$Affichable:=False:C215  // Est-ce qu'il faut afficher un champ de précision ?

If (<>TbMultiple{$compteur}="M")  // PUM
	
	  // début du PUM
	$THTML:=$THTML+"            <td class="+<>ZGuil+"colonne2"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"             <select class="+<>ZGuil+"pum flipflop "+$ClassSelect+<>ZGuil+" name="+<>ZGuil+"PUM"+$IdLigne+<>ZGuil+" id="+<>ZGuil+"PUM"+$IdLigne+<>ZGuil+">"+<>ZCR
	  // Restitution de la ligne du PUM antérieure du champ
	$ValeurAntérieurePUM:=WebTrouveValeurParNom (("PUM"+$IdLigne);->TbAncNomsP3;->TbAncValeursP3)
	$Selectionné:=""
	If ($ValeurAntérieurePUM#"")
		$NuméroLignePUM:=Num:C11(Substring:C12($ValeurAntérieurePUM;1;3))
		$Selectionné:=""
	Else 
		$Selectionné:=" selected "
		$NuméroLignePUM:=0
	End if 
	$THTML:=$THTML+"               <option value="+<>ZGuil+"0"+<>ZGuil+$Selectionné+<>ZGuil+">"+RaemaTraducUtiliseTableau (36)+"</option>"+<>ZCR  // Choisissez une valeur SVP ...  = Ligne 36 des tableaux de traduction
	
	For ($Salé;1;$FT)
		$Rang:=$Compteur+$Salé-1
		If (<>TbEscamotage{$Rang}="X")
			$ClassOption:="PUM"+$IDLigneGerme
		Else 
			$ClassOption:=""
		End if 
		If (<>TbPrecision{$Rang}="X")
			$Affichable:=True:C214
		End if 
		If ($NuméroLignePUM=$Salé)
			$Selectionné:=" selected "
			If (<>TbPrecision{$Rang}="X")
				$ChampColonne3Caché:=False:C215
				$Affichable:=True:C214
			End if 
		Else 
			$Selectionné:=""
		End if 
		$OptionCourante:=String:C10($Salé)+" - "+(Num:C11(LangueCourante="A")*<>TbNomValeurA{$Rang})+(Num:C11(LangueCourante#"A")*<>TbNomValeurF{$Rang})
		$THTML:=$THTML+"               <option value="+<>ZGuil+$OptionCourante+<>ZGuil+$Selectionné+" class="+<>ZGuil+$ClassOption+<>ZGuil+">"+$OptionCourante+"</option>"+<>ZCR
		  //$THTML:=$THTML+"               <option value="+<>ZGuil+"1 - AFNOR BIO-12/16-09/05 (VIDAS Easy Salmonella)"+<>ZGuil+">1 - AFNOR BIO-12/16-09/05 (VIDAS Easy Salmonella) </option>"+<>ZCR
	End for 
	$THTML:=$THTML+"             </select>"+<>ZCR
	
Else   // Boîtes à cocher = <>TbMultiple{$compteur}="M", la valeur vide a été trapsée avant
	
	$Marge:="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
	$THTML:=$THTML+"            <td class="+<>ZGuil+"colonne2"+<>ZGuil+">"+<>ZCR
	For ($Salé;1;$FT)
		$Rang:=$Compteur+$Salé-1
		If (<>TbPrecision{$Rang}="X")
			$Affichable:=True:C214
		End if 
		$CaseCourante:="Case"+($IdLigne)+String:C10($Salé)
		$ValeurAntérieureCaC:=WebTrouveValeurParNom ($CaseCourante;->TbAncNomsP3;->TbAncValeursP3)
		$Cochée:=""
		If ($ValeurAntérieureCaC#"")
			$Cochée:=" checked "
			If (<>TbPrecision{$Rang}="X")
				$ChampColonne3Caché:=False:C215
			End if 
		End if 
		$HtmlPrecision:=Num:C11((<>TbPrecision{$Rang}="X"))*(" class="+<>ZGuil+"CACFlipFlop"+<>ZGuil+" id="+<>ZGuil+$IdLigne+<>ZGuil)
		$THTML:=$THTML+$Marge+" <input name="+<>ZGuil+"Case"+$IdLigne+String:C10($Salé)+<>ZGuil+" Type="+<>ZGuil+"checkbox"+<>ZGuil+" value="+<>ZGuil+"checkbox"+<>ZGuil
		$NomCase:=(Num:C11(LangueCourante="A")*<>TbNomValeurA{$Rang})+(Num:C11(LangueCourante#"A")*<>TbNomValeurF{$Rang})
		$THTML:=$THTML+$HtmlPrecision+$Cochée+" />"+$NomCase+"<br />"
		  // &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input name="Case11085"Type="checkbox"value="checkbox"/>Compass Listeria<br/>                                         // Pour les cases non déclencheuses
		  // &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input name="Case11086" Type="checkbox" value="checkbox" class="CACFlipFlop" id="1108"  />Autre<br />      // Pour les cases déclencheuses (jusqu'à présent  "Autre")
	End for 
	
End if 
Compteur:=Compteur+$FT-1  // tient compte des lignes du tableau général qui décrivent les options
$Cachée:=Num:C11($ChampColonne3Caché)*(" style="+<>ZGuil+"display: none;"+<>ZGuil)
$THTML:=$THTML+"            </td>"+<>ZCR
$THTML:=$THTML+"            "+<>ZCR
$THTML:=$THTML+"            <td class="+<>ZGuil+"colonne3"+$ClassePaireImpaire+<>ZGuil+">"+<>ZCR
If ($Affichable)
	$THTML:=$THTML+"             <div id="+<>ZGuil+"precision"+$IdLigne+<>ZGuil+" class="+<>ZGuil+"rouge plus"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"             </div>"+<>ZCR
	$THTML:=$THTML+"             <input type="+<>ZGuil+"text"+<>ZGuil+" name="+<>ZGuil+"Champ"+$IdLigne+<>ZGuil+" id="+<>ZGuil+"Champ"+$IdLigne+<>ZGuil+" class="+<>ZGuil+""+<>ZGuil
	$ValeurAntérieureChampCaché:=WebTrouveValeurParNom (("Champ"+$IdLigne);->TbAncNomsP3;->TbAncValeursP3)
	$THTML:=$THTML+" value="+<>ZGuil+$ValeurAntérieureChampCaché+<>ZGuil+$Cachée+" />"+<>ZCR
End if 
$THTML:=$THTML+"            </td>"+<>ZCR
$THTML:=$THTML+"          </tr>"+<>ZCR
$0:=$THTML