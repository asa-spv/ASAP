//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 26/01/19, 07:15:01
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPCourrielsAfficheCT
  // Description
  // Séléectionne et Affiche les [CourrielsTypes]existants

If (Count parameters:C259=0)
	ALL RECORDS:C47([CourrielsTypes:28])
End if 
SELECTION TO ARRAY:C260([CourrielsTypes:28]NomLettre:2;ZZonelettre)
LONGINT ARRAY FROM SELECTION:C647([CourrielsTypes:28];TbNumEnrLT)
SORT ARRAY:C229(ZZonelettre;TbNumEnrLT;>)
ZEntêteLettre:=""