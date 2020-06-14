//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 09/05/18, 09:01:50
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ZSauveTablesSensibles
  // Description
  // Enregistre les modifications des tables sensibles
  //

READ WRITE:C146([XData:1])
QUERY:C277([XData:1];[XData:1]XType:3="Tables sensibles")

C_OBJECT:C1216($Ob)
OB SET ARRAY:C1227($Ob;"Sensible";TbSensible)
OB SET ARRAY:C1227($Ob;"NumTable";TbNumTable)
[XData:1]XObjet:18:=$ob
SAVE RECORD:C53([XData:1])
ZAmnistiePartielle (->[XData:1])

COPY ARRAY:C226(TbSensible;<>TbSensible)
COPY ARRAY:C226(TbNumTable;<>TbNumTableSensible)

  //ZVariableVersBlob (->[XData]XBlob;->TbSensible;->TbNumTable)
  //[XData]TailleBlob:=BLOB size([XData]XBlob)
  //SAVE RECORD([XData])

  //ZBlobVersVariable (->[XData]XBlob;-><>TbSensible;-><>TbNumTableSensible)
  //ZAmnistiePartielle (->[XData])
CANCEL:C270

If (ModificationTS)
	  // Comparaison des tableaux TbNumTable et AncTbNumTable en cas de sensibilité
	C_LONGINT:C283($Salé;$FT;$L;$Fumé;$SFT)
	$FT:=Size of array:C274(AncTbNumTable)
	For ($Salé;1;$FT)  // Pour toutes les tables
		$TableCourante:=AncTbNumTable{$Salé}  // Quelle table ?
		$SensibiliteAncienne:=AncTbSensible{$Salé}  // Etait-elle sensible ?
		$L:=Find in array:C230(TbNumTable;$TableCourante)  // Recherche de la ligne de $TableCourante dans TbNumTable
		If ($SensibiliteAncienne) & (TbSensible{$L}=False:C215)  // la table était sensible et ne l'est plus
			  // Il faut alors supprimer tous [XProfils] concernés
			READ WRITE:C146([XProfils:4])
			QUERY:C277([XProfils:4];[XProfils:4]NumTableSensible:3=$TableCourante)
			DELETE SELECTION:C66([XProfils:4])
			ZAmnistiePartielle (->[XProfils:4])
			  // Pareil pour les [XDroits]
			READ WRITE:C146([XDroits:7])
			QUERY:C277([XDroits:7];[XDroits:7]NumTableSensible:3=$TableCourante)
			DELETE SELECTION:C66([XDroits:7])
			ZAmnistiePartielle (->[XDroits:7])
		End if 
		
		If ($SensibiliteAncienne=False:C215) & (TbSensible{$L})  // la table n'était pas sensible mais le devient
			  // Il faut alors créer tous [XProfils] concernés
			ALL RECORDS:C47([XFonctions:3])
			ARRAY TEXT:C222($TbUUIDFonction;0)
			SELECTION TO ARRAY:C260([XFonctions:3]UUID:1;$TbUUIDFonction)
			ZViderSelectionCourante (->[XProfils:4])  // Vidons les profils
			$SFT:=Size of array:C274($TbUUIDFonction)
			ARRAY LONGINT:C221($TbNumTableSensible;$SFT)
			For ($Fumé;1;$SFT)  // Pour chaque fonction
				$TbNumTableSensible{$Fumé}:=$TableCourante  // Créons le tableau de la table courante
			End for 
			  // Création des [XProfils]
			ARRAY TO SELECTION:C261($TbUUIDFonction;[XProfils:4]UUIDFonction:2;$TbNumTableSensible;[XProfils:4]NumTableSensible:3)
			
			  // Pareil pour les [XDroits]
			ALL RECORDS:C47([XUtilisateurs:2])
			SELECTION TO ARRAY:C260([XUtilisateurs:2]UUID:1;$TbUUIDUtilisateurs)
			$SFT:=Size of array:C274($TbUUIDUtilisateurs)
			ARRAY LONGINT:C221($TbNumTableSensible;0)  // remise à 0
			ARRAY LONGINT:C221($TbNumTableSensible;$SFT)  // Allongement sur le nombre d'utilisateur
			ZViderSelectionCourante (->[XDroits:7])  // Vidons les droits
			For ($Fumé;1;$SFT)  // Pour chaque utilisateur
				$TbNumTableSensible{$Fumé}:=$TableCourante  // Créons le tableau de la table courante
			End for 
			  // Création des [XDroits]
			ARRAY TO SELECTION:C261($TbUUIDUtilisateurs;[XDroits:7]UUIDUtilisateur:2;$TbNumTableSensible;[XDroits:7]NumTableSensible:3)
			
			
		End if 
		
	End for 
	
	
End if 