//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 30/01/17, 15:25:50
  // ----------------------------------------------------
  // Méthode : ResControleSer
  // Description : contrôle de la compatibilité des séries des numéros échantillons
  // 
  //
  // Paramètre :$1 = message Ajax
  // ----------------------------------------------------
$NumEchA:=Substring:C12($1;12)
QUERY:C277([RAEMACampagnes:20]; & ;[RAEMACampagnes:20]NumCampagne:2=<>NumCampagneEnCoursSaisie)
$rang:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"Rang";Est un numérique:K8:4)
$TT:=Length:C16($NumEchA)/6
$Bool1:=False:C215
$Bool2:=False:C215
$Bool3:=False:C215
$Bool4:=False:C215
$Bool5:=False:C215
$Envoi:=""
For ($salé;1;$TT)
	$RangEch:=Substring:C12($NumEchA;$rang;1)
	Case of 
		: ($RangEch="0") | ($RangEch="1")
			If ($Bool1)
				$Envoi:="N"
			Else 
				$Bool1:=True:C214
			End if 
			
		: ($RangEch="2") | ($RangEch="3")
			If ($Bool2)
				$Envoi:="N"
			Else 
				$Bool2:=True:C214
			End if 
			
		: ($RangEch="4") | ($RangEch="5")
			If ($Bool3)
				$Envoi:="N"
			Else 
				$Bool3:=True:C214
			End if 
			
		: ($RangEch="6") | ($RangEch="7")
			If ($Bool4)
				$Envoi:="N"
			Else 
				$Bool4:=True:C214
			End if 
			
		: ($RangEch="8") | ($RangEch="9")
			If ($Bool5)
				$Envoi:="N"
			Else 
				$Bool5:=True:C214
			End if 
			
	End case 
	If ($Envoi="N")
		$salé:=$TT
	Else 
		$NumEchA:=Substring:C12($NumEchA;7)
	End if 
End for 

WEB SEND TEXT:C677($Envoi)