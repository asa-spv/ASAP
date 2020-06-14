//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 16/08/19, 09:08:01
  // ----------------------------------------------------
  // Paramètre : aucun
  // ----------------------------------------------------
  // Méthode : ASAPPerPoudreModifColisSupAR
  // Description
  // Méthode qui ajuste des [CampagneParticipations]
  //   en fonction du nombre demandé 
  //   de colis supplémentaire avec rapport

C_LONGINT:C283($Salé;$FT;$NbreColisARCDemandé;$NbColisARCExistant)
ARRAY OBJECT:C1221($TbArg;0)
C_POINTER:C301($PtObjetCourant;$Pt)

$PtObjetCourant:=OBJECT Get pointer:C1124(Objet courant:K67:2)
RESOLVE POINTER:C394($PtObjetCourant;$NomVariable;$T;$C)
If ($NomVariable="@octobre@")
	$Mois:="Octobre"
Else 
	$Mois:="Mars"
End if 
$Pt:=Get pointer:C304("Campagne"+$Mois)
$CampagneCourante:=$Pt->
$NbreColisARCDemandé:=$PtObjetCourant->
QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$CampagneCourante;*)
QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1;*)
QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17]; & ;[CampagneParticipations:17]Arguments:5;"CodeRaemaLié";#;Null:C1517)
$NbColisARCExistant:=Records in selection:C76([CampagneParticipations:17])
Case of 
	: ($NbreColisARCDemandé>$NbColisARCExistant)  // il veut ajouter des colis sup
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1)
		SELECTION TO ARRAY:C260([CampagneParticipations:17]NumCampagne:3;$TbNumCampagne\
			;[CampagneParticipations:17]Arguments:5;$TbArg)
		LONGINT ARRAY FROM SELECTION:C647([CampagneParticipations:17];$TbNumEnr)
		$FT:=Size of array:C274($TbArg)
		ARRAY TEXT:C222($TbCodesUtilisés;$FT)  // Tous les codes utilisés
		ARRAY LONGINT:C221($TbNumLaboUtilisés;$FT)  // Tous les n° de laboratoire associés
		ARRAY TEXT:C222($TbCodesUtilisésCampagne;0)  // Les codes utilisés dans la campagne en cours
		ARRAY LONGINT:C221($TbNumLaboUtilisésCampagne;0)  // Les n° de laboratoire associés
		$NumEnrLaboRef:=0
		  // Quels codes sont possibles ($TbCodesPossibles) et interdits ($TbCodesInterdits) ?
		ARRAY TEXT:C222($TbCodesPossibles;0)
		ARRAY LONGINT:C221($TbNumLaboPossibles;0)
		ARRAY TEXT:C222($TbCodesInterdits;0)
		ARRAY LONGINT:C221($TbNumLaboInterdits;0)
		
		For ($Salé;1;$FT)
			$CodeCourant:=OB Get:C1224($TbArg{$Salé};"CodeRaemaLié";Est un texte:K8:3)
			$NumLabo:=RAEMADemoduleMdPWeb ($CodeCourant)
			If ($CodeCourant#"") & (Find in array:C230($TbNumLaboPossibles;$NumLabo)<0)
				APPEND TO ARRAY:C911($TbCodesPossibles;$CodeCourant)
				APPEND TO ARRAY:C911($TbNumLaboPossibles;$NumLabo)
			End if 
			If ($TbNumCampagne{$Salé}=$CampagneCourante)
				If ($CodeCourant="")  // laboratoire principal
					$NumEnrLaboRef:=$TbNumEnr{$Salé}
				Else   // Raema lié
					APPEND TO ARRAY:C911($TbCodesInterdits;$CodeCourant)
					$NumLabo:=RAEMADemoduleMdPWeb ($CodeCourant)
					APPEND TO ARRAY:C911($TbNumLaboInterdits;$NumLabo)
				End if 
			End if 
		End for 
		
		  // Codes permis ($TbNumLaboPossibles)
		$TT:=Size of array:C274($TbNumLaboInterdits)
		For ($Salé;1;$TT)
			$L:=Find in array:C230($TbNumLaboPossibles;$TbNumLaboInterdits{$Salé})
			If ($L>0)
				DELETE FROM ARRAY:C228($TbNumLaboPossibles;$L)
				DELETE FROM ARRAY:C228($TbCodesPossibles;$L)
			End if 
		End for 
		
		
		  // Créons les [CampagneParticipations]
		$NbNumColisSupAFaire:=$NbreColisARCDemandé-$NbColisARCExistant
		READ WRITE:C146([CampagneParticipations:17])
		For ($Salé;1;$NbNumColisSupAFaire)
			GOTO RECORD:C242([CampagneParticipations:17];$NumEnrLaboRef)
			OB SET:C1220([CampagneParticipations:17]Arguments:5;"NbreColisSupAvecRapport";$NbreColisARCDemandé)
			SAVE RECORD:C53([CampagneParticipations:17])
			DUPLICATE RECORD:C225([CampagneParticipations:17])
			[CampagneParticipations:17]UUID:1:=Generate UUID:C1066
			
			If (Size of array:C274($TbCodesPossibles)>0)  // on attribue un ancien code
				$Code:=$TbCodesPossibles{1}
				DELETE FROM ARRAY:C228($TbCodesPossibles;1)
			Else   // On a épuisé la réserve de codes supplémentaires : inventons-en d'autres
				READ WRITE:C146([XData:1])
				QUERY:C277([XData:1];[XData:1]XNom:2="Compteur N° de RAEMA liés";*)
				QUERY:C277([XData:1]; & [XData:1]XType:3="CompteurRAEMAliés")
				[XData:1]XEntier:6:=[XData:1]XEntier:6+1
				$DerNum:=[XData:1]XEntier:6
				SAVE RECORD:C53([XData:1])
				ZAmnistiePartielle (->[XData:1])
				  // Fabrication du nouveau code
				$VarNumLaboRAEMA:=VarNumLaboRAEMA  // Stockage de VarNumLaboRAEMA = n° de labo affiché dans [Personnes];"SaisieLabo"
				VarNumLaboRAEMA:=$DerNum  // Mofidification provisoire de VarNumLaboRAEMA
				$Code:=GAInitIdentificateurPersonne 
				VarNumLaboRAEMA:=$VarNumLaboRAEMA  // Restitution de VarNumLaboRAEMA
			End if 
			OB SET:C1220([CampagneParticipations:17]Arguments:5;"CodeRaemaLié";$Code)
			SAVE RECORD:C53([CampagneParticipations:17])
		End for 
		
	: ($NbreColisARCDemandé<$NbColisARCExistant)  // il veut supprimer des colis sup
		$NbSuppression:=$NbColisARCExistant-$NbreColisARCDemandé
		SET QUERY LIMIT:C395($NbSuppression)
		READ WRITE:C146([CampagneParticipations:17])
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$CampagneCourante;*)
		QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1;*)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17]; & ;[CampagneParticipations:17]Arguments:5;"CodeRaemaLié";#;Null:C1517)
		SET QUERY LIMIT:C395(0)
		DELETE SELECTION:C66([CampagneParticipations:17])
		
End case 

  // Recalcul du champ affiché 
$Pt:=Get pointer:C304("Var"+$Mois+"NRL")
$Pt->:=""
If ($NbreColisARCDemandé#$NbColisARCExistant)
	QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$CampagneCourante;*)
	QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1;*)
	QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17]; & ;[CampagneParticipations:17]Arguments:5;"CodeRaemaLié";#;Null:C1517)
	$FT:=Records in selection:C76([CampagneParticipations:17])
	SELECTION TO ARRAY:C260([CampagneParticipations:17]Arguments:5;$TbArg)
	
	If ($NbreColisARCDemandé>0)  // Il y a un ou plusieurs colis avec rapport
		For ($Salé;1;$FT)
			$CodeLié:=OB Get:C1224($TbArg{$Salé};"CodeRaemaLié";Est un texte:K8:3)
			$Pt->:=$Pt->+","+String:C10(RAEMADemoduleMdPWeb ($CodeLié))
		End for 
		If ($Pt->#"")
			$Pt->:=Substring:C12($Pt->;2)  // élimination du premier ","
		End if 
	End if 
Else 
	OnAChangéParticipation:=False:C215
End if 
OBJECT SET VISIBLE:C603(*;"MarsNRL@";(VarMarsPAR>0))
OBJECT SET VISIBLE:C603(*;"OctobreNRL@";(VarOctobrePAR>0))
ZAmnistiePartielle (->[CampagneParticipations:17])