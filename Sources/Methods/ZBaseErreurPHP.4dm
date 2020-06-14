//%attributes = {"invisible":true}
C_TEXT:C284($stdOut;$PHP_Error_Txt)
$PHP_Error_Txt:=""

ARRAY TEXT:C222($errLabels;0)
ARRAY TEXT:C222($errValues;0)
ARRAY TEXT:C222($httpFields;0)
ARRAY TEXT:C222($httpValues;0)

PHP GET FULL RESPONSE:C1061($stdOut;$errLabels;$errValues;$httpFields;$httpValues)
$PHP_Error_Txt:=$stdOut+Char:C90(Retour chariot:K15:38)
For ($i;1;Size of array:C274($errLabels))
	$PHP_Error_Txt:=$PHP_Error_Txt+String:C10($errLabels{$i})+" - "+$errValues{$i}+Char:C90(Retour chariot:K15:38)
End for 

GET LAST ERROR STACK:C1015($arrCodes;$ArrComps;$ArrLabels)
ARRAY LONGINT:C221($arrCodes;0)
ARRAY TEXT:C222($ArrComps;0)
ARRAY TEXT:C222($ArrLabels;0)

For ($i;1;Size of array:C274($arrCodes))
	$PHP_Error_Txt:=$PHP_Error_Txt+String:C10($arrCodes{$i})+" - "+$ArrComps{$i}+" - "+$ArrLabels{$i}+Char:C90(Retour chariot:K15:38)
End for 
  //FIXER TEXTE DANS CONTENEUR($PHP_Error_Txt)

ALERT:C41("PHP error (may you have to clean the 4D Folders for this application before retrying):\r\rAll errors avec been copied into the paste board.")