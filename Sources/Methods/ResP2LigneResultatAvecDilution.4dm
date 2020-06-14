//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/07/18, 15:15:12
  // ----------------------------------------------------
  // Paramètre $1= Compteur de boucle  ($Fumé)
  // ----------------------------------------------------
  // Méthode : ResP2LigneResultatAvecDilution <= ResP2HtmlResultats  <=  ResP2CreationLignesOKP3 <= ResP2FabriqueRaemaRestreint <=  ResP2MF = traitement de la page 2
  // Description : Ecrit le HTML des lignes de résultats avec diution


$Fumé:=$1

$ClasseColonne3Parité:=(Num:C11($Fumé%2=1)*"colonne3impaire")+(Num:C11($Fumé%2=0)*"colonne3paire")
$ClasseLigneParité:=(Num:C11($Fumé%2=1)*"ligneimpaire")+(Num:C11($Fumé%2=0)*"lignepaire")
$NumEchantillon:=TbNumEch{$Fumé}
$Rang:=Compteur+$Fumé-1
$IDLigneDilution:=Substring:C12(<>TbRefLigne{$Rang};3)
$IDLigneConcentration:=Substring:C12(<>TbRefLigne{$Rang+5};3)
$DilutionAntérieure:=WebTrouveValeurParNom (("champ"+$IDLigneDilution);->TbAncNomsP3;->TbAncValeursP3)
$ConcentrationAntérieure:=WebTrouveValeurParNom (("champ"+$IDLigneConcentration);->TbAncNomsP3;->TbAncValeursP3)
$THTML:=""
$THTML:=$THTML+"                   <tr class="+<>ZGuil+$ClasseLigneParité+<>ZGuil+" id="+<>ZGuil+"Ligne"+$IDLigneConcentration+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"                        <td class="+<>ZGuil+"colonne1"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"                             Echantillon n°"+$NumEchantillon+<>ZCR
$THTML:=$THTML+"                        </td>"+<>ZCR
$THTML:=$THTML+"                        <td class="+<>ZGuil+"colonne2res"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"                            <div class="+<>ZGuil+"blocdil"+<>ZGuil+"> <span class="+<>ZGuil+"petitnum"+<>ZGuil+">(1)</span> "+<>ZCR
$THTML:=$THTML+"                   Dilution: "+<>ZCR
$THTML:=$THTML+"                   <input name="+<>ZGuil+"Champ"+$IDLigneDilution+<>ZGuil+" id="+<>ZGuil+"Champ"+$IDLigneDilution+<>ZGuil
$THTML:=$THTML+" class="+<>ZGuil+"champdil dilech"+<>ZGuil+" value="+<>ZGuil+$DilutionAntérieure+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"                            </div>"+<>ZCR
$THTML:=$THTML+"                            <div class="+<>ZGuil+"concentration"+<>ZGuil+">                  "+<>ZCR
$THTML:=$THTML+"                   <span class="+<>ZGuil+"petitnum"+<>ZGuil+">(2)</span> "+<>ZCR
$THTML:=$THTML+"                     Concentration <span class="+<>ZGuil+"rouge"+<>ZGuil+">(ufc/g)"+<>ZCR
$THTML:=$THTML+"                   </span>"+<>ZCR
$THTML:=$THTML+"                            </div>"+<>ZCR
$THTML:=$THTML+"                            <div id="+<>ZGuil+"alert"+$IDLigneDilution+<>ZGuil+" class="+<>ZGuil+"alertedil"+<>ZGuil+"> "+<>ZCR
$THTML:=$THTML+"                            </div>"+<>ZCR
$THTML:=$THTML+"                         </td>"+<>ZCR
$THTML:=$THTML+"                         <td class="+<>ZGuil+$ClasseColonne3Parité+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"                              <input name="+<>ZGuil+"Champ"+$IDLigneConcentration+<>ZGuil+" id="+<>ZGuil+"Champ"+$IDLigneConcentration+<>ZGuil
$THTML:=$THTML+" rang="+<>ZGuil+String:C10($Fumé)+<>ZGuil+" class="+<>ZGuil+"champech champ dilech"+<>ZGuil+" value="+<>ZGuil+$ConcentrationAntérieure+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"                          </td>"+<>ZCR
$THTML:=$THTML+"                   </tr>"+<>ZCR2
$0:=$THTML
