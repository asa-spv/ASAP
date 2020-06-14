//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 11/01/19, 08:37:33
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPRetourSurChargement
  // Description
  // Méthode à executer sur chargement d'un enregistrement de [RetoursFiches]

OBJECT SET VISIBLE:C603(ListBoxCamp;True:C214)
OBJECT SET VISIBLE:C603(*;"@FTNC";False:C215)
  // le champ [RetoursFiches]NumFTNC qui a pour nom "ChampFTNC" et son étiquette 
RadRI:=0
RadDI:=0
RadR:=0
Case of 
	: ([RetoursFiches:24]TypeRetour:5="Retour d'information")
		RadRI:=1
	: ([RetoursFiches:24]TypeRetour:5="Demande d'information")
		RadDI:=1
	: ([RetoursFiches:24]TypeRetour:5="Réclamation")
		OBJECT SET VISIBLE:C603(*;"@FTNC";True:C214)
		RadR:=1
End case 

BRI:=0
BRT:=0
BRS:=0
BRA:=0
BRQ:=0
Case of 
	: ([RetoursFiches:24]Domaine:6="Informatique")
		BRI:=1
	: ([RetoursFiches:24]Domaine:6="Technique")
		BRT:=1
	: ([RetoursFiches:24]Domaine:6="Statistique")
		BRS:=1
	: ([RetoursFiches:24]Domaine:6="Administratif")
		BRA:=1
	: ([RetoursFiches:24]Domaine:6="Qualité")
		BRQ:=1
End case 

VarNumLaboA:=""
ASAPRetourAfficheAdh 
  // varNumLabo:=""
If ([RetoursFiches:24]NumFiche:2="")
	VarNouvFiche:=True:C214
	[RetoursFiches:24]NumFiche:2:=Substring:C12(DerNumActuelRetour;1;3)+String:C10(Num:C11(Substring:C12(DerNumActuelRetour;4))+1;"000")
	vDate:=!00-00-00!
	  //[RetoursFiches]DateRetour:=Date du jour
Else 
	vDate:=[RetoursFiches:24]DateRetour:3
	VarNouvFiche:=False:C215
End if 
OBJECT SET VISIBLE:C603(PUMClassifRetour;Not:C34(VarNouvFiche))
OBJECT SET VISIBLE:C603(*;"Champrech@";(Current user:C182="Administrateur"))

vDate:=[RetoursFiches:24]DateRetour:3
START TRANSACTION:C239


  // Reglage des campagnes

RetourAfficheCampagne 

RetourInitTbClassification 


PUMClassifRetour:=0


If ([RetoursFiches:24]Domaine:6="Informatique")
	COPY ARRAY:C226(PUMClassInfo;PUMClassifRetour)
	$L:=Find in array:C230(PUMClassifRetour;[RetoursFiches:24]Classification:8)
	If ($L>0)
		PUMClassifRetour:=$L
	Else 
		PUMClassifRetour:=0
	End if 
	BRI:=1
End if 

If ([RetoursFiches:24]Domaine:6="Technique")
	COPY ARRAY:C226(PUMClassTech;PUMClassifRetour)
	$L:=Find in array:C230(PUMClassifRetour;[RetoursFiches:24]Classification:8)
	If ($L>0)
		PUMClassifRetour:=$L
	Else 
		PUMClassifRetour:=0
	End if 
	BRT:=1
End if 

If ([RetoursFiches:24]Domaine:6="Qualité")
	COPY ARRAY:C226(PUMClassQual;PUMClassifRetour)
	$L:=Find in array:C230(PUMClassifRetour;[RetoursFiches:24]Classification:8)
	If ($L>0)
		PUMClassifRetour:=$L
	Else 
		PUMClassifRetour:=0
	End if 
	BRQ:=1
End if 

If ([RetoursFiches:24]Domaine:6="Statistique")
	COPY ARRAY:C226(PUMClassStat;PUMClassifRetour)
	$L:=Find in array:C230(PUMClassifRetour;[RetoursFiches:24]Classification:8)
	If ($L>0)
		PUMClassifRetour:=$L
	Else 
		PUMClassifRetour:=0
	End if 
	BRS:=1
End if 

If ([RetoursFiches:24]Domaine:6="Administratif")
	COPY ARRAY:C226(PUMClassAdmi;PUMClassifRetour)
	$L:=Find in array:C230(PUMClassifRetour;[RetoursFiches:24]Classification:8)
	If ($L>0)
		PUMClassifRetour:=$L
	Else 
		PUMClassifRetour:=0
	End if 
	BRA:=1
End if 