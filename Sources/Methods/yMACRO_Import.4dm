//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 05/02/12, 16:37:08
  // ----------------------------------------------------
  // Méthode : MACRO_Import
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

C_TEXT:C284($Text_t)
C_TIME:C306($vDocRef)
C_BLOB:C604($methodName_b)

$vDocRef:=Open document:C264("")
If (Document#"")
	DOCUMENT TO BLOB:C525(Document;$methodName_b)
	CLOSE DOCUMENT:C267($vDocRef)
	
	  // Le blob est en UTF8. Mais la variable $Text_t est en UTF16 dans 4D
	$Text_t:=Convert to text:C1012($methodName_b;"UTF-8")
	
	SET MACRO PARAMETER:C998(Texte méthode:K5:17;$Text_t)
End if 

  //A mettre dans le fichier MACRO

  //<macro name="save method"method_event="on_save"in_menu="false"type_ahead="false"Version ="2">
  //<text><method>Y_Export ("<method_name/>")</method></text>
  //</macro>
  //
  //<macro name="import"in_menu="false"type_ahead="false"Version ="2">
  //<text><method>Y_Import </method></text>
  //</macro>