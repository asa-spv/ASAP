//%attributes = {}
OBJECT SET VISIBLE:C603(*;"@FTNC";False:C215)
Case of 
	: (RadRI=1)
		[RetoursFiches:24]TypeRetour:5:="Retour d'information"
	: (RadDI=1)
		[RetoursFiches:24]TypeRetour:5:="Demande d'information"
	: (RadR=1)
		[RetoursFiches:24]TypeRetour:5:="Réclamation"
		OBJECT SET VISIBLE:C603(*;"@FTNC";True:C214)
		
End case 