//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 07/05/18, 16:19:08
  // ----------------------------------------------------
  // Paramètres
  // $1 = Texte à mettre en Camel Case Espacé
  // {$2} = Si passé
  // ----------------------------------------------------
  // Méthode : ZTexteEnCamelCaseEspacé
  // Description
  //  
  // Bob MILLER

  // Transform "CamelCaseFieldName123" to "Camel Case Field Name 123"
  // Link to LB_ResizeHeader method, same discussion on the 4D Forum.
  // http://forums.4d.com/Post/FR/23867797/1/23916554#23916554

  // How to:
  // In LB_ResizeHeader, I added one line after you assign $tLabel:
  //$tLabel:=Replace string(OBJECT Get title(*;$atHeadNames{$x});"\r";" ")
  //$tLabel:=Choose(Position(" ";$tLabel)>0;$tLabel;AddSpacesToCamelCase($tLabel))  //add spaces to Text To Array can do its business

  //RLM 4/21/2018 - AddSpacesToCamelCase takes text as $1 that is in CamelCase. Inserts a space before each
  //capital letter or start of a numeric sequence, or instead of any underscore character, returns result as $0

C_TEXT:C284($1;$0;$InputText;$OutputText)
$InputText:=$1

C_TEXT:C284($CurrentChar;$PrevChar)
C_LONGINT:C283($L;$Length;$CountSinceLastCamel;$CurrentCharCode;$PrevCharCode;$MinStringLength)
$MinStringLength:=2  //this is the min length we will break out, so if there are two capitalized characters in a row, we keep them together
$Length:=Length:C16($InputText)

For ($L;1;$Length)
	
	$CurrentChar:=$InputText[[$L]]
	$CurrentCharCode:=Character code:C91($CurrentChar)
	
	Case of 
		: ($L=1)
			  //do nothing else, definitely don't want to add space before first char if capitalized
			
		: ($L=$Length)  //we're on the last character, do nothing
			  //
			
		: ($CurrentCharCode=Espacement:K15:42)
			$CountSinceLastCamel:=0  //reset counter
			
			
		: ($CurrentChar="_")  //underscore
			$CurrentChar:=" "  //replace underscore with a space character
			$CountSinceLastCamel:=0  //reset counter
			
			
		: (($CurrentCharCode>=48) & ($CurrentCharCode<=57))  //if true, this is a numeral
			
			If ($CountSinceLastCamel>=$MinStringLength)
				
				$PrevChar:=$InputText[[$L-1]]  //we don't want to add a space between numerals; check previous char
				$PrevCharCode:=Character code:C91($PrevChar)
				
				If (($PrevCharCode>=48) & ($PrevCharCode<=57))  //if true, prev char is also a number
					  //do nothing
				Else 
					$OutputText:=$OutputText+" "
					$CountSinceLastCamel:=0
				End if 
			End if 
			
		: (($CurrentCharCode>=65) & ($CurrentCharCode<=90))  //if true, this is uppercase
			If (Count parameters:C259=1)
				If ($CountSinceLastCamel>=$MinStringLength)
					$OutputText:=$OutputText+" "
					$CountSinceLastCamel:=0
				End if 
			End if 
			
		Else 
			  //do nothing
	End case 
	
	$OutputText:=$OutputText+$CurrentChar
	$CountSinceLastCamel:=$CountSinceLastCamel+1
	
End for 
$0:=$OutputText