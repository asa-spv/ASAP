//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/07/18, 08:27:58
  // ----------------------------------------------------
  // Paramètre : $1=
  // ----------------------------------------------------
  // Méthode : ResP2LigneTitre
  // Description
  // 
$THTML:=""
$Ref:=<>TbRefGerme{Compteur}
$IdTable:="page"+Substring:C12($Ref;3)
$THTML:=$THTML+"        <table class="+<>ZGuil+"raematbp2"+<>ZGuil+" id="+<>ZGuil+$IdTable+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"         <tr>"+<>ZCR
$THTML:=$THTML+"            <td class="+<>ZGuil+"hauttb"+<>ZGuil+">"+<>ZCR

$THTML:=$THTML+"              <br /> <br />"+RaemaTraductionASAP ($Ref;-><>TbRefGerme;"NomGerme")+<>ZCR
$THTML:=$THTML+"            </td>"+<>ZCR
$THTML:=$THTML+"            <td class="+<>ZGuil+"hauttb2"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"              "+RaemaTraducUtiliseTableau (31)+<>ZCR
$THTML:=$THTML+"            </td>"+<>ZCR
$THTML:=$THTML+"            <td class="+<>ZGuil+"hauttb3"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"              "+RaemaTraducUtiliseTableau (32)+<>ZCR
$THTML:=$THTML+"            </td>"+<>ZCR
$THTML:=$THTML+"          </tr>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$0:=$THTML