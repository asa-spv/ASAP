//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 12/08/18, 11:21:57
  // ----------------------------------------------------
  // Paramètre aucun
  // ----------------------------------------------------
  // Méthode : RaemaLotoMFSurChargement
  // Description
  // Initialise les variables du dialogue du Loto

C_LONGINT:C283($Salé;$Fumé;$FT;$NumMax;$Sec)

  // Recherche des derniers RAEMA
QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2>="62")  // Les Campagnes depuis 62 
  // création du menu local PUMNRFLP des n° de RAEMA
SELECTION TO ARRAY:C260([RAEMACampagnes:20]NumCampagne:2;PUMNRFLP)
SORT ARRAY:C229(PUMNRFLP;<)
PUMNRFLP:=Find in array:C230(PUMNRFLP;<>NumCampagneEnCoursSaisie)

  // Remplissage des données du loto 

RaemaLotoFabriquePage 

