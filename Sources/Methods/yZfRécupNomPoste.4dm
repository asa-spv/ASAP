//%attributes = {"publishedWeb":true}
  //  // ZfRécupNomPoste  V11 du 14/08/2010
  //  //  fonction qui renvoie le nom du poste en 4D serveur et "" en Nom

  //  // Voir BLOB 4D

  //C_ENTIER LONG($ProcessNo)
  //TOUT SÉLECTIONNER()
  //VERROUILLÉ PAR(;$ProcessNo\
;$Utilisateur\
;$PosteClient\
;$NomProcess\
)
  //$0:="Poste "+$PosteClient\

  //LECTURE SEULEMENT()

  //LIBÉRER ENREGISTREMENT()  //Rend seulement l'enregistrement disponible pour les autres
  //RÉDUIRE SÉLECTION(;0\
)  //Fait gagner de la mémoire à l'utilisateur car aucune fiche chargée
