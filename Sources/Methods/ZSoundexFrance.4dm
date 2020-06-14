//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 29/04/18, 06:26:23
  // ----------------------------------------------------
  // Méthode : ZSoundexFrance
  // Description
  //  Permet d'obtenir le soundex d'un mot
  // Origine : 4DTour 2017
  // Paramètre : $1= Mot à soundexer  $0= soundex
  // ----------------------------------------------------
$name:=$1
$result:=""
$ok:=False:C215
$name:=Replace string:C233($name;"h";"")
$name:=Replace string:C233($name;"w";"")  //Rule 1 & 3
If (Length:C16($name)>1)
	$result:=Uppercase:C13($name[[1]])
	$name:=Substring:C12($name;2)
	
	$previous:=$result
	Repeat 
		$letter:=$name[[1]]
		Case of 
			: (Position:C15($letter;"aehiouwy")>0)  //Rule 1
				  // nothing
			: ($letter=$previous)  //Rule 3
				  // nothing
			: (Position:C15($letter;"bp")>0)  //Rule 2
				$result:=$result+"1"
			: (Position:C15($letter;"ckq")>0)
				$result:=$result+"2"
			: (Position:C15($letter;"dt")>0)
				$result:=$result+"3"
			: (Position:C15($letter;"l")>0)
				$result:=$result+"4"
			: (Position:C15($letter;"mn")>0)
				$result:=$result+"5"
			: (Position:C15($letter;"r")>0)
				$result:=$result+"6"
			: (Position:C15($letter;"gj")>0)
				$result:=$result+"7"
			: (Position:C15($letter;"xzs")>0)
				$result:=$result+"8"
			: (Position:C15($letter;"fv")>0)
				$result:=$result+"9"
		End case 
		$previous:=$letter
		$name:=Substring:C12($name;2)
		$flStop:=(Length:C16($result)>3) | (Length:C16($name)<1)
	Until ($flStop)
	
	$result:=Substring:C12($result+"0000";1;4)
End if 
$0:=$result
