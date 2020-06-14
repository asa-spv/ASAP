//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 17/06/18, 19:26:42
  // ----------------------------------------------------
  // Méthode : ASAPImporteConnexions
  // Description
  // méthode pour récupérer les [XDonnees] de Biblio
  //  incluant les connexions Web de réponse des laboratoires
  // ----------------------------------------------------


C_TEXT:C284($Var;$NumLaboA)
C_DATE:C307($Date)
C_TIME:C306($Heure)
C_LONGINT:C283($Rang;$NumLaboN)
C_BLOB:C604($Blob)

PAUSE INDEXES:C1293([WebConnexions:13])

READ WRITE:C146([WebConnexions:13])
ALL RECORDS:C47([WebConnexions:13])
DELETE SELECTION:C66([WebConnexions:13])

SET CHANNEL:C77(13;"")
If (OK=1)
	
	  // Gestion des manques
	$Rapport:=""
	ARRAY LONGINT:C221($TbNumLaboPb;0)
	ARRAY TEXT:C222($TbComLaboPb;0)
	
	RECEIVE VARIABLE:C81($Var)  // encore
	While ($Var="Encore")
		RECEIVE VARIABLE:C81($Var)
		$Pos:=Position:C15("&";$Var)
		$Nom:=Substring:C12($Var;1;($Pos-1))
		$Var:=Substring:C12($Var;($Pos+1))
		
		$Pos:=Position:C15("&";$Var)
		$Langue:=Substring:C12($Var;1;($Pos-1))
		$Var:=Substring:C12($Var;($Pos+1))
		
		$Pos:=Position:C15("&";$Var)
		$Envoi:=Substring:C12($Var;1;($Pos-1))
		$Var:=Substring:C12($Var;($Pos+1))
		
		$Pos:=Position:C15("&";$Var)
		$Date:=Date:C102(Substring:C12($Var;1;($Pos-1)))
		$Var:=Substring:C12($Var;($Pos+1))
		
		$Pos:=Position:C15("&";$Var)
		$Heure:=Time:C179(Substring:C12($Var;1;($Pos-1)))
		$Var:=Substring:C12($Var;($Pos+1))
		
		$Pos:=Position:C15("&";$Var)
		$Rang:=Num:C11(Substring:C12($Var;1;($Pos-1)))
		$Var:=Substring:C12($Var;($Pos+1))
		
		$Pos:=Position:C15("&";$Var)
		  //$Envoi:=Sous chaîne($Var;1;($Pos-1)) // XValeur = ???
		$Var:=Substring:C12($Var;($Pos+1))
		
		$Pos:=Position:C15("&";$Var)
		$Type:=Substring:C12($Var;1;($Pos-1))
		$Var:=Substring:C12($Var;($Pos+1))
		
		$Pos:=Position:C15("&";$Var)
		$TexteMail:=Substring:C12($Var;1;($Pos-1))
		$TexteMail:=Replace string:C233($TexteMail;"§";<>ZCR)
		
		$TextePJ:=Substring:C12($Var;($Pos+1))
		
		  // détermination de la campagne et du n° de labo alpha et entier long
		If ($Type="@A@")  // C'est un RGel"
			$NumCampagne:=Substring:C12($Type;1;3)
			$NumLaboA:=Substring:C12($Type;4)
		Else 
			$NumCampagne:=Substring:C12($Type;1;2)
			$NumLaboA:=Substring:C12($Type;3)
		End if 
		$NumLaboN:=Num:C11($NumLaboA)
		
		RECEIVE VARIABLE:C81($Blob)
		
		  // Tout est reçu : testons le tout
		If ($Nom="connexion web n°@") & (BLOB size:C605($Blob)>0) & ($NumLaboN#13) & ($NumLaboN#0) & ($NumCampagne>="62")  // inutile d'encombrer le disque du de données insignifiantes
			
			  // trouve t'on le numéro de labo dans les tableaux généraux des personnes
			$L:=Find in array:C230(<>TbPerNumLaboRAEMA;$NumLaboN)  // Test pour un laboratoire normal ou maître
			$L2:=ASAPTestLaboRaemaLié ($NumLaboA)  // Test pour un n° de rapport lié
			If ($L>0) | ($L2>0)  // Recherche fructueuse
				  // il reste à trouver les [WebConnexions]UUIDParticipation, [WebConnexions]CodeConnexion
				If ($L>0)  // c'est un laboratoire maître
					$CodeConnexion:=<>TbPerIdentificateur{$L}
					$UUIDLabo:=<>TbPerUUID{$L}
					$Test:=$NumLaboA+"_"+$NumCampagne+"_"
				Else   // c'est un n° de rapport lié
					$CodeConnexion:=ASAPTrouveCodeRaemaLié ($L2;$NumLaboA)
					$UUIDLabo:=<>TbPerUUID{$L2}
					$Test:=<>TbPerNumLaboRAEMAA{$L2}+"_"+$NumCampagne+"_"+$CodeConnexion
				End if 
				$L3:=Find in array:C230(<>TbLotoIdentifiantParticipation;$Test)
				If ($L3>0)  // il a trouvé l'Identifiant de Participation
					$UUIDParticipation:=<>TbLotoUUIDParticipation{$L3}
					
					  // Tout baigne : créons renseignons et stockons l'enregistrement
					CREATE RECORD:C68([WebConnexions:13])
					[WebConnexions:13]LangueConnexion:10:=$Langue
					[WebConnexions:13]Campagne:5:=$NumCampagne
					[WebConnexions:13]CodeConnexion:4:=$CodeConnexion
					[WebConnexions:13]DateConnexion:2:=$Date
					[WebConnexions:13]HeureConnexion:3:=$Heure
					[WebConnexions:13]TexteMail:6:=$TexteMail
					[WebConnexions:13]TextePJ:7:=$TextePJ
					[WebConnexions:13]BlobConnexion:11:=$Blob
					ASAPFabriqueObjetConnexion   // Renseignement de [WebConnexions]Arguments avec Tb du blob
					[WebConnexions:13]BoolEnvoi:8:=($Envoi="Vrai")
					[WebConnexions:13]UUIDParticipation:12:=$UUIDParticipation
					SAVE RECORD:C53([WebConnexions:13])
					
				Else   // il ne l'a pas trouvé : signlons l'anomalie
					$Com:="La connexion "+<>ZGuil+$Nom+<>ZGuil+" n'a pas pu être rattachée à un enregistrement"
					$Com:=$Com+" de [CampagneParticipations] car la ligne "+$Test+" n'a pas été trouvée."
					$LCom:=Find in array:C230($TbNumLaboPb;$NumLaboN)
					If ($LCom<0)
						APPEND TO ARRAY:C911($TbNumLaboPb;$NumLaboN)
						APPEND TO ARRAY:C911($TbComLaboPb;$Com)
					Else 
						$TbComLaboPb{$LCom}:=$TbComLaboPb{$LCom}+<>ZCR+$Com
					End if 
				End if 
			Else   // Le laboratoire n'existe pas
				
				$Com:="Le laboratoire qui existait lors de la campagne "+$NumCampagne+" avec le n° de RAEMA "+$NumLaboA+" n'est plus dans la liste ASAP."
				$LCom:=Find in array:C230($TbNumLaboPb;$NumLaboN)
				If ($LCom<0)
					APPEND TO ARRAY:C911($TbNumLaboPb;$NumLaboN)
					APPEND TO ARRAY:C911($TbComLaboPb;$Com)
				Else 
					$TbComLaboPb{$LCom}:=$TbComLaboPb{$LCom}+<>ZCR+$Com
				End if 
				
			End if 
		End if 
		
		RECEIVE VARIABLE:C81($Var)  // encore ou fin
	End while 
	SET CHANNEL:C77(11)
End if 
ZAmnistieInternationale 
ALERT:C41("Import des connexions achevée")
RESUME INDEXES:C1294([WebConnexions:13])

  // Ecriture du rapport des manques
SORT ARRAY:C229($TbNumLaboPb;$TbComLaboPb;>)
$FT:=Size of array:C274($TbComLaboPb)
$Rapport:=""
For ($Salé;1;$FT)
	$Rapport:=$Rapport+String:C10($TbNumLaboPb{$Salé})+<>ZCR+$TbComLaboPb{$Salé}+<>ZCR2
End for 

SET TEXT TO PASTEBOARD:C523($Rapport)

