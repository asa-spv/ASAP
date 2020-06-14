//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/04/18, 07:11:08
  // ----------------------------------------------------
  // Méthode : ZGereClicBoutonNavigationSaisie
  // Description
  // Méthode qui permet de gérer la navigation dans la sélection
  //    à partir du formulaire projet SaisieStandard 
  //    commun à une gestion séléection ou tableau
  // Paramètre : $1 = Nom du bouton cliqué
  // ----------------------------------------------------

$NomBouton:=$1
$ListeIncluse:=False:C215
If (Count parameters:C259=2)
	$ListeIncluse:=True:C214
	C_POINTER:C301($2)
	LigneClic:=$2->
End if 
If (ZApresProc#"")
	EXECUTE METHOD:C1007(ZApresProc)
End if 
SAVE RECORD:C53(ZPtTable->)

If (GestionTableau)
	If ($ListeIncluse)
		
	Else 
		Case of 
			: ($NomBouton="BouPrem")
				LigneClic:=1
				
			: ($NomBouton="BouPrec")
				LigneClic:=LigneClic-1
				
			: ($NomBouton="BouSuiv")
				LigneClic:=LigneClic+1
				
			: ($NomBouton="BouDernier")
				LigneClic:=Size of array:C274(TbNumEnr)
				
		End case 
		If ($ListeIncluse)
			$2->:=LigneClic
		End if 
	End if 
	
	GOTO RECORD:C242(ZPtTable->;TbNumEnr{LigneClic})
	
Else 
	
	Case of 
		: ($NomBouton="BouPrem")
			FIRST RECORD:C50(ZPtTable->)
			
		: ($NomBouton="BouPrec")
			PREVIOUS RECORD:C110(ZPtTable->)
			
		: ($NomBouton="BouSuiv")
			NEXT RECORD:C51(ZPtTable->)
			
		: ($NomBouton="BouDernier")
			LAST RECORD:C200(ZPtTable->)
			
	End case 
	
End if 
If (ZAvantProc#"")
	EXECUTE METHOD:C1007(ZAvantProc)
End if 
ZGereVisuBoutonNavigationSaisie 


