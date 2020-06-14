//%attributes = {}
  //  RapChangeColonne
  // $1 = Pt sur le tableau ZoneRapLabNonPris ou ZoneRapLabPris
$MOE:=Macintosh option down:C545
$Pt:=$1
RESOLVE POINTER:C394($1;$vaNomVar;$vlNumTable;$vlNumChamp)
$Gauche:=($vaNomVar="@non@")
$NumRaemaActuel:=<>PUMCampagne{<>PUMCampagne}
If ($Pt->>0)
	$Lab:=String:C10($Pt->{$Pt->})
	If (Not:C34($MOE))
		$mess:="Déplacer le laboratoire n°"+$Lab+" vers la liste de "+(Num:C11($Gauche)*"droite")+(Num:C11(Not:C34($Gauche))*"gauche")
		CONFIRM:C162($mess)
	Else 
		OK:=1
	End if 
	If (OK=1)
		$NumLaboA:=$Pt->{$Pt->}  // N°du laboratoire double-cliqué
		$Pos:=Position:C15("-";$NumLaboA)
		If ($Pos=0)
			$Ident:=$NumLaboA+"_"+<>PUMCampagne{<>PUMCampagne}+"_"
			$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$Ident)
		Else 
			  // allons chercher dans <>TbLotoNumLaboRapportCampagne type "615_66" la ligne adéquate
			$test:=Substring:C12($NumLaboA;($Pos+1))+"_"+<>PUMCampagne{<>PUMCampagne}
			$L:=Find in array:C230(<>TbLotoNumLaboRapportCampagne;$test)
		End if 
		If ($L>0)
			READ WRITE:C146([CampagneParticipations:17])
			QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUID:1=<>TbLotoUUIDParticipation{$L})
			OB SET:C1220([CampagneParticipations:17]Arguments:5;"RapportPris";$Gauche)
			SAVE RECORD:C53([CampagneParticipations:17])
			WebHistoireConnexion ($Lab;6;$Gauche;$NumRaemaActuel)
			ZAmnistiePartielle (->[CampagneParticipations:17];True:C214)
		Else 
			TRACE:C157
		End if 
		
		  //$NumLabo:=ASAPTrouveUUIDLaboParNumero(
		  //CHERCHER([CampagneParticipations]
		  // ;[ParticipationRAEMA]\
			NumLaboRaema=$Lab;*)
		  //CHERCHER([ParticipationRAEMA]\
			; & [ParticipationRAEMA]\
			NumCampagne=$NumRaemaActuel)
		  //[ParticipationRAEMA]\
			RapportsPris:=$Gauche
		  //STOCKER ENREGISTREMENT([ParticipationRAEMA]\
			)
		  //RapInitZoneLabNonPris(Vrai)
		RapInitTbRecupRapports (True:C214)
		
	End if 
Else 
	ALERT:C41("Désignez un laboratoire dans la colonne des rapports "+(Num:C11($Gauche)*"non")+" obtenus")
End if 
