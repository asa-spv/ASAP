//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 17/02/18, 17:50:48
  // ----------------------------------------------------
  // Méthode : ZLBAjoutASelection
  // Description
  // Ajoute à la sélection présente
  //. le résultat de la recherche
  // ----------------------------------------------------

QUERY:C277(ZPtTable->)
CREATE SET:C116(ZPtTable->;"plus")
UNION:C120(ZNomEnsembleAvant;"plus";"ceusses maintenant")
USE SET:C118("ceusses maintenant")
CLEAR SET:C117("ceusses maintenant")
CLEAR SET:C117("plus")