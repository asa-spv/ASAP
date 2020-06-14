//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 17/07/18, 06:04:42
  // ----------------------------------------------------
  // Paramètres
  //  $1=intitulé de l'échantillon
  //  $2=rang du n° champ 
  //  $3=rang de la première boite à cocher  
  //  $4=intitulé de la première boite
  //  $5=rang de la deuxième boite à cocher  
  //  $6=intitulé de la deuxième boite
  // ----------------------------------------------------
  // Méthode : ResP1EcritLigneP2
  // Description
  // Ecrit la ligne comprenant 
  //      l'intitulé de l'échantillon et le champ pour son n°  (première colonne)
  //      l'intitulé du germe de la première colonne et sa case à cocher
  //      l'intitulé du germe de la deuxième colonne et sa case à cocher

C_TEXT:C284($Texte;$IntituléEchantillon;$RangChampA;$RangPremCBA;$IntituléPremBoite;$RangDeuxCBA;$IntituléDeuxBoite;$1;$2;$3;$4;$5;$6)
$IntituléEchantillon:=$1
$RangChampA:=$2
$RangPremCBA:=$3
$IntituléPremBoite:=$4
$RangDeuxCBA:=$5
$IntituléDeuxBoite:=$6

$CR:=<>ZCR
$Guill:=<>ZGuil
  // le n° d'échantillon
$Texte:="          <tr>"+$CR+"            <td class="+$Guill+"raematradcol1p1"+$Guill+">"+$IntituléEchantillon+$CR
$Texte:=$Texte+"              <input "+" class="+$guill+"raematradcasep1"+$guill+" name="+$guill+"textfield"+$RangChampA+$guill+" type="+$guill+"text"+$guill+" size="+$guill+"5"+$guill
$ValeurChamp:=ResP1SortValeurChampP2 ($RangChampA)
$Texte:=$Texte+" value="+$guill+$ValeurChamp+$guill+" maxlength="+$guill+"6"+$guill+" />"+$CR+"            </td>"
  // la première case à cocher de la ligne
$Texte:=$Texte+$CR+"            <td class="+$Guill+"raematradcol2p1"+$Guill+">"+$CR+"              <input name="+$guill+"CB"+$RangPremCBA+$guill+" type="+$guill+"checkbox"+$guill
$ValeurBoiteACocher:=ResP1SortValeurBoiteP2 ($RangPremCBA)
$Texte:=$Texte+" id="+$guill+"CB"+$RangPremCBA+$guill+" value="+$guill+"checkbox"+$guill+$ValeurBoiteACocher+" />"+$CR+"              "+$IntituléPremBoite+$CR+"            </td>"
  // la deuxième case à cocher de la ligne
$Texte:=$Texte+$CR+"            <td class="+$Guill+"raematradcol3p1"+$Guill+">"+$CR+"              <input name="+$guill+"CB"+$RangDeuxCBA+$guill+" type="+$guill+"checkbox"+$guill
$ValeurBoiteACocher:=ResP1SortValeurBoiteP2 ($RangDeuxCBA)
$Texte:=$Texte+" id="+$guill+"CB"+$RangDeuxCBA+$guill+" value="+$guill+"checkbox"+$guill+$ValeurBoiteACocher+" />"+$CR+"              "+$IntituléDeuxBoite+$CR+"            </td>"+$CR+"          </tr>"+$CR

$0:=$Texte