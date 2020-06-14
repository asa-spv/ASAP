C_LONGINT:C283($TT)

$TT:=Size of array:C274(PUMClassifRetour)
If (PUMClassifRetour=$TT)  // elle demande à ajouter une valeur
	$DerValeur:=PUMClassifRetour{$TT-1}
	$Pos:=Position:C15("-";$DerValeur)
	$Index:=Num:C11(Substring:C12($DerValeur;1;($pos-1)))
	$Valeur:=$DerValeur[[1]]+String:C10($Index+1)+"-"
	$Dem:=Request:C163("Quelle valeur ajouter ??";$Valeur)
	If (OK=1)
		If ($Dem=($Valeur+"@"))
			READ WRITE:C146([XData:1])
			QUERY:C277([XData:1];[XData:1]XNom:2="Classification des retours";*)
			QUERY:C277([XData:1]; & [XData:1]XType:3="ClassificationRetours")
			
			Case of 
				: ([RetoursFiches:24]Domaine:6="Administratif")
					INSERT IN ARRAY:C227(PUMClassAdmi;$TT)
					PUMClassAdmi{$TT}:=$Dem
					OB SET ARRAY:C1227([XData:1]XObjet:18;"Administratif";PUMClassAdmi)
					COPY ARRAY:C226(PUMClassAdmi;PUMClassifRetour)
					
				: ([RetoursFiches:24]Domaine:6="Informatique")
					INSERT IN ARRAY:C227(PUMClassInfo;$TT)
					PUMClassInfo{$TT}:=$Dem
					OB SET ARRAY:C1227([XData:1]XObjet:18;"Informatique";PUMClassInfo)
					COPY ARRAY:C226(PUMClassInfo;PUMClassifRetour)
					
				: ([RetoursFiches:24]Domaine:6="Qualité")
					INSERT IN ARRAY:C227(PUMClassQual;$TT)
					PUMClassQual{$TT}:=$Dem
					OB SET ARRAY:C1227([XData:1]XObjet:18;"Qualité";PUMClassQual)
					COPY ARRAY:C226(PUMClassQual;PUMClassifRetour)
					
					
				: ([RetoursFiches:24]Domaine:6="Statistique")
					INSERT IN ARRAY:C227(PUMClassStat;$TT)
					PUMClassStat{$TT}:=$Dem
					OB SET ARRAY:C1227([XData:1]XObjet:18;"Statistique";PUMClassStat)
					COPY ARRAY:C226(PUMClassStat;PUMClassifRetour)
					
					
				: ([RetoursFiches:24]Domaine:6="Technique")
					INSERT IN ARRAY:C227(PUMClassTech;$TT)
					PUMClassTech{$TT}:=$Dem
					OB SET ARRAY:C1227([XData:1]XObjet:18;"Technique";PUMClassTech)
					COPY ARRAY:C226(PUMClassTech;PUMClassifRetour)
					
			End case 
			PUMClassifRetour:=$TT
			[RetoursFiches:24]Classification:8:=$Dem
			
			$ListeAdm:=New list:C375
			ARRAY TO LIST:C287(PUMClassAdmi;$ListeAdm)
			$ListeInfo:=New list:C375
			ARRAY TO LIST:C287(PUMClassInfo;$ListeInfo)
			$ListeQual:=New list:C375
			ARRAY TO LIST:C287(PUMClassQual;$ListeQual)
			$ListeStat:=New list:C375
			ARRAY TO LIST:C287(PUMClassStat;$ListeStat)
			$ListeTech:=New list:C375
			ARRAY TO LIST:C287(PUMClassTech;$ListeTech)
			
			$ListeClass:=New list:C375
			APPEND TO LIST:C376($ListeClass;"Administratif";1;$ListeAdm;False:C215)
			APPEND TO LIST:C376($ListeClass;"Informatique";2;$ListeInfo;False:C215)
			APPEND TO LIST:C376($ListeClass;"Qualité";3;$ListeQual;False:C215)
			APPEND TO LIST:C376($ListeClass;"Statistique";4;$ListeTech;False:C215)
			APPEND TO LIST:C376($ListeClass;"Technique";5;$ListeTech;False:C215)
			LIST TO BLOB:C556($ListeClass;[XData:1]XBlob:13)
			
			SAVE RECORD:C53([XData:1])
			ZAmnistiePartielle (->[XData:1])
			
		Else 
			ALERT:C41("Désolé, la ligne doit commencer par "+$Valeur)
		End if 
	End if 
	
Else 
	[RetoursFiches:24]Classification:8:=PUMClassifRetour{PUMClassifRetour}
End if 
$LignePermise:=Size of array:C274(PUMClassifRetour)-1
OBJECT SET VISIBLE:C603(*;"BouDelClass";(PUMClassifRetour=$LignePermise))