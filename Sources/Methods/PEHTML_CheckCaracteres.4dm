//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 28/02/16, 11:20:07
  // ----------------------------------------------------
  // Méthode : HTML_CheckCaracteres
  // Description
  // Converti certains caractères accentués en code HTML
  //
  // Paramètres
  // ----------------------------------------------------
C_TEXT:C284($1;$0;$texte)

$texte:=$1

$texte:=Replace string:C233($texte;"ä";"&auml;";*)
$texte:=Replace string:C233($texte;"ö";"&ouml;";*)
$texte:=Replace string:C233($texte;"ü";"&uuml;";*)
$texte:=Replace string:C233($texte;"Ä";"&Auml;";*)
$texte:=Replace string:C233($texte;"Ö";"&Ouml;";*)
$texte:=Replace string:C233($texte;"Ü";"&Uuml;";*)
$texte:=Replace string:C233($texte;"ß;";"&szlig";*)

$texte:=Replace string:C233($texte;"&";"&amp;";*)
$texte:=Replace string:C233($texte;"\"";"&quot;";*)
$texte:=Replace string:C233($texte;"'";"&#039;";*)

$texte:=Replace string:C233($texte;"&nbsp;";" ")

$texte:=Replace string:C233($texte;"<";"&lt;")
$texte:=Replace string:C233($texte;">";"&gt;")
$texte:=Replace string:C233($texte;"\n\r";"<br/>")
$texte:=Replace string:C233($texte;"\r\n";"<br/>")
$texte:=Replace string:C233($texte;"\n";"<br/>")
$texte:=Replace string:C233($texte;"\r";"<br/>")

$0:=$texte


