//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 21/07/18, 07:02:58
  // ----------------------------------------------------
  // Paramètre : aucun
  // ----------------------------------------------------
  // Méthode : ResP2Preambule <= ResP2MF = traitement de la page 2
  // Vérifie la validité des n° d'échantillons  
  // ----------------------------------------------------

$0:=True:C214  // Optimisme naturel et justifié ici par le captage de ces erreurs par JavaScript
If (RaemaPoudre)
	If (Not:C34(ResP2PoudreNumEchantillonsOK ))
		MotifRefus:=RaemaTraducUtiliseTableau (70)
		$0:=False:C215
	End if 
Else   // RAEMA Gel
	If (Not:C34(ResP2GelNumEchantillonsOK ))
		MotifRefus:="Les germes choisis ne correspondent pas aux n° d'échantillons notés"
		$0:=False:C215
	End if 
End if 