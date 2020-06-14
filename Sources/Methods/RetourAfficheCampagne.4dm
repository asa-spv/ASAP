//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 11/01/19, 08:55:54
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : RetourAfficheCampagne
  // Description
  // 


  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 01/01/17, 17:01:08
  // ----------------------------------------------------
  // Méthode : RetourAfficheCampagne
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

C_LONGINT:C283($anCourant)
ARRAY LONGINT:C221(TbAnCampagne;0)
ARRAY TEXT:C222(Colonne4;0)
ARRAY TEXT:C222(Colonne5;0)
ARRAY TEXT:C222(Colonne6;0)
ARRAY TEXT:C222(Colonne7;0)
ARRAY BOOLEAN:C223(Colonne4B;0)
ARRAY BOOLEAN:C223(Colonne5B;0)
ARRAY BOOLEAN:C223(Colonne6B;0)
ARRAY BOOLEAN:C223(Colonne7B;0)
GET TEXT KEYWORDS:C1141([RetoursFiches:24]Campagne:7;$TbMot)

If ([RetoursFiches:24]DateRetour:3#!00-00-00!)
	$anCourant:=Year of:C25(vDate)
	ARRAY LONGINT:C221(TbAnCampagne;5)
	TbAnCampagne{1}:=$anCourant+1
	TbAnCampagne{2}:=$anCourant
	TbAnCampagne{3}:=$anCourant-1
	TbAnCampagne{4}:=$anCourant-2
	TbAnCampagne{5}:=$anCourant-3
	ARRAY TEXT:C222(Colonne4;5)
	Colonne4{1}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{1};1)
	Colonne4{2}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{2};1)
	Colonne4{3}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{3};1)
	Colonne4{4}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{4};1)
	Colonne4{5}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{5};1)
	
	ARRAY BOOLEAN:C223(Colonne4B;5)
	ARRAY BOOLEAN:C223(Colonne5B;5)
	ARRAY BOOLEAN:C223(Colonne6B;5)
	ARRAY BOOLEAN:C223(Colonne7B;5)
	
	RetourCocheCampagneTb (->$TbMot;->Colonne4;->Colonne4B;1)
	RetourCocheCampagneTb (->$TbMot;->Colonne4;->Colonne4B;2)
	RetourCocheCampagneTb (->$TbMot;->Colonne4;->Colonne4B;3)
	RetourCocheCampagneTb (->$TbMot;->Colonne4;->Colonne4B;4)
	RetourCocheCampagneTb (->$TbMot;->Colonne4;->Colonne4B;5)
	
	ARRAY TEXT:C222(Colonne5;5)
	Colonne5{1}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{1};3)
	Colonne5{2}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{2};3)
	Colonne5{3}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{3};3)
	Colonne5{4}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{4};3)
	Colonne5{5}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{5};3)
	RetourCocheCampagneTb (->$TbMot;->Colonne5;->Colonne5B;1)
	RetourCocheCampagneTb (->$TbMot;->Colonne5;->Colonne5B;2)
	RetourCocheCampagneTb (->$TbMot;->Colonne5;->Colonne5B;3)
	RetourCocheCampagneTb (->$TbMot;->Colonne5;->Colonne5B;4)
	RetourCocheCampagneTb (->$TbMot;->Colonne5;->Colonne5B;5)
	
	ARRAY TEXT:C222(Colonne6;5)
	Colonne6{1}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{1};2)
	Colonne6{2}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{2};2)
	Colonne6{3}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{3};2)
	Colonne6{4}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{4};2)
	Colonne6{5}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{5};2)
	RetourCocheCampagneTb (->$TbMot;->Colonne6;->Colonne6B;1)
	RetourCocheCampagneTb (->$TbMot;->Colonne6;->Colonne6B;2)
	RetourCocheCampagneTb (->$TbMot;->Colonne6;->Colonne6B;3)
	RetourCocheCampagneTb (->$TbMot;->Colonne6;->Colonne6B;4)
	RetourCocheCampagneTb (->$TbMot;->Colonne6;->Colonne6B;5)
	
	ARRAY TEXT:C222(Colonne7;5)
	Colonne7{1}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{1};4)
	Colonne7{2}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{2};4)
	Colonne7{3}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{3};4)
	Colonne7{4}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{4};4)
	Colonne7{5}:=RaemaTrouveNumCampagneParAn (TbAnCampagne{5};4)
	RetourCocheCampagneTb (->$TbMot;->Colonne7;->Colonne7B;1)
	RetourCocheCampagneTb (->$TbMot;->Colonne7;->Colonne7B;2)
	RetourCocheCampagneTb (->$TbMot;->Colonne7;->Colonne7B;3)
	RetourCocheCampagneTb (->$TbMot;->Colonne7;->Colonne7B;4)
	RetourCocheCampagneTb (->$TbMot;->Colonne7;->Colonne7B;5)
End if 
