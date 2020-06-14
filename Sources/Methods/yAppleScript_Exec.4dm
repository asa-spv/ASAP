//%attributes = {}
  // ---------------------------------------------------- 
  // Nom utilisateur (OS) : christophe Keromen 
  // Date et heure : 14/06/05, 08:06:44
  // ---------------------------------------------------- 
  // Methode : AppleScript_Exec 
  // Description :
  // exécute un appleScript $1 par LANCER PROCESS EXTERNE
  // 
  // Parametres :
  // $0:TEXTE:message d'erreur 
  // $1:TEXTE:chemin d'accès au script
  // positionne ok
  // 
  // Version : 1 
  // Appel : $error:=AppleScript_Exec ($_vt_pathScript)
  // ---------------------------------------------------- 

C_TEXT:C284($0)
C_TEXT:C284($1;$_vt_pathScript)
$_vt_pathScript:=$1

C_TEXT:C284($in;$out;$error)
$in:=""
$out:=""
$error:=""

ok:=1
LAUNCH EXTERNAL PROCESS:C811("osascript \""+Convert path system to POSIX:C1106($_vt_pathScript)+"\"";$in;$out;$error)

$0:=$error
