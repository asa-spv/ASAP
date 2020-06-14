//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 01/07/13, 15:16:41
  // ----------------------------------------------------
  // Méthode : RapAffichePb
  // Description
  // Permet d'afficher un écran d'erreur en actualisant le contenu
  //  grace aux 5 Paramètres explicites
  // ----------------------------------------------------

TitreErreur:=$1  // titre de la page Web
TypeErreur:=$2  // Annonce principale centrée rouge 
MotifErreur1:=$3  // $3 à $5 Détail du pb en 3 lignes
MotifErreur2:=$4
MotifErreur3:=$5
WEB SEND FILE:C619("RapRaemaKO.shtml")  // envoi du dialogue
