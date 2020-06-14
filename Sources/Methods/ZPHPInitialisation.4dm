//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 04/03/18, 08:45:21
  // ----------------------------------------------------
  // Méthode : PHP_Setup
  // Description
  // Written in train, direction Roma
  //
  // Paramètres
  // ----------------------------------------------------

C_BOOLEAN:C305($OK)

  // Specification if PHP interpreter
  // 0 - interne / 1 - externe

SET DATABASE PARAMETER:C642(PHP utiliser interpréteur externe:K37:58;0)
PHP SET OPTION:C1059(PHP résultat brut:K64:2;True:C214)
  // Restart the PHP interpreter -> set to 0 the number of request
$OK:=PHP Execute:C1058("";"quit_4d_php")
$OK:=PHP Execute:C1058("";"relaunch_4d_php")
DELAY PROCESS:C323(Current process:C322;15)