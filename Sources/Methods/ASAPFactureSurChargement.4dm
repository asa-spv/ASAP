//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 24/09/19, 11:21:31
  // ----------------------------------------------------
  // Méthode : ASAPFactureSurChargement
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
ARRAY DATE:C224($TbDateReglement;0)
If (Is new record:C668([Factures:15]))
	ARRAY TEXT:C222(PUMTypeFacture;4)
	PUMTypeFacture{1}:="Cotisation individuelle"
	PUMTypeFacture{2}:="RAEMA poudre"
	PUMTypeFacture{3}:="RAEMA gel"
	PUMTypeFacture{4}:="Autres"
End if 
OBJECT SET VISIBLE:C603(*;"NouvFac@";(Is new record:C668([Factures:15])))

RELATE MANY:C262([Factures:15]NumFacture:3)
SELECTION TO ARRAY:C260([Ventes:16]DateReglement:12;$TbDateReglement\
;[Ventes:16]NumCheque:11;$TbNumCheque\
;[Ventes:16]Banque:10;$TbBanque)
If ([Factures:15]SommeReglee:13=0)
	VarSommeRéglée:=[Factures:15]TotalTTC:10
Else 
	VarSommeRéglée:=[Factures:15]SommeReglee:13
End if 
$UUIDPersonneFacture:=[Factures:15]UUIDPersonne:2
CodeBeneficiaire:=ASAPTrouveNumeroLaboParUUID ($UUIDPersonneFacture)
  //Si (CodeBeneficiaire="0")
  //Laboratoire:=Faux
  //$L:=Chercher dans tableau(<>TBPERUUID;$UUIDPersonneFacture)
  //$Mdp:=<>TbPerIdentificateur{$L}
  //CodeBeneficiaire:=RAEMADemoduleMdPWeb ($Mdp;Vrai)
  //Sinon 
  //Laboratoire:=Vrai
  //Fin de si 
$TT:=Size of array:C274($TbDateReglement)
$Reglé:=False:C215
For ($Salé;1;$TT)
	If ($TbDateReglement{$Salé}#!00-00-00!)
		  // Je remplis les variables
		VarNumCheque:=$TbNumCheque{$Salé}
		VarBanque:=$TbBanque{$Salé}
		VarDateReglement:=$TbDateReglement{$Salé}
		  // je régle l'interface
		$Reglé:=True:C214
		
		  // je sors de la boucle
		$Salé:=$TT
	End if 
	
End for 

OBJECT SET VISIBLE:C603(*;"regle@";$Reglé)
$Titre:=(Num:C11($Reglé)*"Enregistrer les données")+(Num:C11(Not:C34($Reglé))*"Entrer un réglement")
OBJECT SET TITLE:C194(*;"BouEntreReglement@";$Titre)

