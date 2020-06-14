//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 11/04/14, 20:45:06
  // ----------------------------------------------------
  // Méthode : BASE_BytesToSTR
  // Description
  // http://forums.4d.fr/Post/FR/14504984/1/14504985#14504985
  //
  // Paramètres
  // ----------------------------------------------------
  //BASE_BytesToSTR(nombreOctets_r)-> txt
  //Description
  //convertit nombreOctets_r en chaine avec unité:
  //kilooctet ko
  //mégaoctet Mo
  //gigaoctet Go
  //téraoctet To
  //pétaoctet Po
  //* la méthode s'arrête là, on laisse tomber les pourtant passionnants:
  //exaoctet Eo
  //zettaoctet Zo
  //yottaoctet Yo

C_TEXT:C284($0)
C_REAL:C285($1)

C_LONGINT:C283($base_l)
C_LONGINT:C283($expo_l)
C_REAL:C285($in_r)
C_REAL:C285($nbre_r)
C_REAL:C285($seuil_r)
C_TEXT:C284($nmc_t)
C_TEXT:C284($out_t)
C_TEXT:C284($unit_t)

  //_

$nmc_t:=Current method name:C684
$out_t:=""

Case of 
	: (Not:C34(Asserted:C1132(Count parameters:C259>0;$nmc_t+" $1 number missing")))
	Else 
		$in_r:=$1
		$base_l:=1024
		$expo_l:=5  //on commence aux pétaoctets
		Repeat 
			$seuil_r:=$base_l^$expo_l
			If ($in_r>=$seuil_r)
				$unit_t:=Choose:C955($expo_l;"o";"Ko";"Mo";"Go";"To";"Po")
				$nbre_r:=$in_r/$seuil_r
				$out_t:=$out_t+String:C10(Round:C94($nbre_r;1))+" "+$unit_t
				$expo_l:=0
			End if 
			$expo_l:=$expo_l-1
		Until ($expo_l<0)
		$0:=$out_t
End case 