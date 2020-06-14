//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 01/02/19, 17:52:53
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : RapPlaceDocumentsDansWeb
  // Description
  // Méthode qui scrute le dossier de la DropBox 
  //  qui contient les nouveaux rapports ou factures
  // pour les mettre dans les dossiers correspondant 
  // du dossier PDF inclus dans le dossier Web 

  // Incorporation des rapports et des factures
$VarValDosRap:=""
ARRAY TEXT:C222($TbFR;0)  // Tableau des noms des fichiers présents dans "Dossier Rapports"
DOCUMENT LIST:C474(<>PermCheDosRapIni;$TbFR)
AlerteD:=""
$TT:=Size of array:C274($TbFR)
READ WRITE:C146([CampagneParticipations:17])
For ($Salé;1;$TT)
	$NomDoc:=$TbFR{$Salé}
	Case of 
			
		: ($NomDoc=("RG@"))  // Le rapport général (RG)
			$CheminSource:=<>PermCheDosPDF+$NomDoc
			$CheminCible:=<>PermCheDosRap+$NomDoc
			If (Test path name:C476($CheminCible)=Est un document:K24:1)  // il existe déjà un document de même nom dans le dossier
				DELETE DOCUMENT:C159($CheminCible)  // supprimons l'ancien
			End if 
			MOVE DOCUMENT:C540($CheminSource;$CheminCible)
			
			
		: ($NomDoc=("RI@"))  // Gueule de fichier du rapport déplaçable : RI + N°Campagne + _ + N°labo + .pdf
			$Pos:=Position:C15("_";$NomDoc)
			$Campagne:=Substring:C12($NomDoc;3;$Pos-3)  // N°campagne
			$Reste:=Substring:C12($NomDoc;($Pos+1))  // N°Labo.pdf
			$Pos:=Position:C15(".pdf";$Reste)
			$NumLaboRaema:=Substring:C12($Reste;1;($Pos-1))  // n°Labo alpha
			$NumLaboRaemaN:=Num:C11($NumLaboRaema)  // n°Labo alpha
			
			$UUID:=ASAPTrouveUUIDLaboParNumero ($NumLaboRaemaN)
			
			  // $L:=Chercher dans tableau(
			  //Si (Enregistrements trouvés([CampagneParticipations])>0)
			$CheminSource:=<>PermCheDosRapIni+$NomDoc
			$CheminCible:=<>PermCheDosRap+$NumLaboRaema+Séparateur dossier:K24:12+$TbFR{$Salé}
			If (Test path name:C476($CheminCible)=Est un document:K24:1)  // il existe déjà un document de même nom dans le dossier
				DELETE DOCUMENT:C159($CheminCible)  // supprimons l'ancien
			End if 
			MOVE DOCUMENT:C540($CheminSource;$CheminCible)
			
			  //Fin de si 
			
		: ($NomDoc=("Fac@"))  // Gueule de fichier de la facture déplaçable : Fac + N°facture +"_"+ N°labo + ".pdf"
			$NomDoc:=Substring:C12($NomDoc;4)
			$Pos:=Position:C15("_";$NomDoc)
			$Numfacture:=Substring:C12($NomDoc;3;$Pos-3)  // N°de la facture
			$AnA:=Substring:C12($Numfacture;1;2)
			$Reste:=Substring:C12($NomDoc;($Pos+1))  // N°Labo.pdf
			$Pos:=Position:C15(".pdf";$Reste)
			$NumLaboRaema:=Substring:C12($Reste;1;($Pos-1))  // n°Labo
			$CheminSource:=<>PermCheDosRapIni+$NomDoc
			$CheminCible:=<>PermCheDosFac+$AnA+Séparateur dossier:K24:12+$Numfacture+".pdf"
			If (Test path name:C476($CheminCible)=Est un document:K24:1)  // il existe déjà un document de même nom dans le dossier
				DELETE DOCUMENT:C159($CheminCible)  // supprimons l'ancien
			End if 
			MOVE DOCUMENT:C540($CheminSource;$CheminCible)
	End case 
	
End for 
ZAmnistiePartielle (->[CampagneParticipations:17])