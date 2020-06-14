//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 05/08/18, 14:59:31
  // ----------------------------------------------------
  // Paramètre aucun
  // ----------------------------------------------------
  // Méthode : ResP3bEnvoiResultats
  // Description
  // Traitement du formulaire P3' de validation des données incomplètes
C_BOOLEAN:C305(OnEscamote;OnEscamoteL)
ARRAY TEXT:C222($TbNomsP4;0)
ARRAY TEXT:C222($TbValeursP4;0)
WEB GET VARIABLES:C683($TbNomsP4;$TbValeursP4)  // lecture de la première valeur = code raema
  // récupération des valeurs du précédent écran (écran de confirmation)
UUIDParticipation:=WebTrouveValeurParNom ("hiddenField";->$TbNomsP4;->$TbValeursP4)  // mot de passe
$LigneTbGnxPart:=Find in array:C230(<>TbLotoUUIDParticipation;UUIDParticipation)
$UUIDLabo:=<>TbLotoUUIDLabo{$LigneTbGnxPart}
NumLaboActuelA:=ASAPTrouveNumeroLaboParUUID ($UUIDLabo)
  //NumLaboActuelA:=WebTrouveValeurParNom (MotDePasseActuel;-><>TbPerIdentificateur;-><>TbPerNumLaboRAEMAA)
LangueCourante:=WebTrouveValeurParNom ("langage";->$TbNomsP4;->$TbValeursP4)
NumCampagneCourante:=<>NumCampagneEnCoursSaisie
RaemaPoudre:=(String:C10(Num:C11(NumCampagneCourante))=NumCampagneCourante)  // si Vrai RAEMA traditionnel, Additionnel si Faux

  //Si (ResP3ChasseLaboFantomes )  // Le mdp caché est correct
WebLireTableauxAnterieurs   // restitution des données antérieures du labo logué
ResP3EnvoiMailAsa 
  //Fin de si 