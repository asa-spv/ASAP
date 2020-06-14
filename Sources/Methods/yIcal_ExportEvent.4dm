//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 24/05/12
  // ----------------------------------------------------
  // Méthode : Ical_ExportEvent
  // Description
  // http://abcdrfc.free.fr/rfc-vf/rfc2445.html
  // Format date : 20120522T170000 = 22 mai 2012, 17H00,00
  // Format date : 20120522 = 22 mai 2012
  //
  // Paramètres
  // ----------------------------------------------------
  //Les propriétés classiques d'un composant VEVENT sont :
  //2 = DTSTART: Date de début de l'événement
  //3 = DTEND: Date de fin de l'événement
  //1 = SUMMARY: Titre de l'événement
  //LOCATION: Lieu de l'événement
  //        "" par défauf. 
  //CATEGORIES: Catégorie de l'événement(ex: Conférence, Fête, ...)
  //        "" par défauf. 
  //STATUS: Statut de l'événement(TENTATIVE, CONFIRMED, CANCELLED).
  //        CONFIRMED par défauf. 
  //4 = DESCRIPTION: Description de l'événement
  //TRANSP: Définit si la ressource affectée à l'évenement est rendu indisponible(OPAQUE, TRANSPARENT)
  //        TRANSPARENT par défauf. 
  //    CATEGORIES =  "ANNIVERSARY", "APPOINTMENT", "BUSINESS", "EDUCATION", "HOLIDAY", "MEETING", "MISCELLANEOUS", "NON-WORKING HOURS",
  //  "NOT IN OFFICE", "PERSONAL", "PHONE CALL", "SICK DAY", "SPECIAL OCCASION", "TRAVEL", "VACATION"

C_POINTER:C301($1;$Pt)
C_TEXT:C284($ICS;$ICSDocument)

$Pt:=$1  // Tableau contenant les informations de création d'une fiche ICS
$CR:=Char:C90(13)+Char:C90(10)

$ICS:="BEGIN:VCALENDAR"+$CR
$ICS:=$ICS+"VERSION:2.0"+$CR
$ICS:=$ICS+"CALSCALE:GREGORIAN"+$CR
$ICS:=$ICS+"X-WR-CALNAME:"+<>ParamNom+$CR  // Nom du calendrier (Si absent, alors le système demande dans lequel)
$ICS:=$ICS+"BEGIN:VEVENT"+$CR
$ICS:=$ICS+"ORGANIZER;CN=DDPAX:MAILTO:"+<>EmailCompte+$CR  // Email de l'organisateur - Optionnel
If ($Pt->{1}#"")
	$ICS:=$ICS+"SUMMARY:"+$Pt->{1}+$CR
Else 
	$ICS:=$ICS+"SUMMARY:"+<>ParamNom+$CR
End if 
$ICS:=$ICS+"METHOD:PUBLISH"+$CR
$ICS:=$ICS+"DTSTART:"+$Pt->{2}+$CR  //    Date de début
$ICS:=$ICS+"DTEND:"+$Pt->{3}+$CR  //      Date de fin
$ICS:=$ICS+"X-APPLE-SCHEDULETAG:"+$CR  // Aucune idée, mais optionnel
$ICS:=$ICS+"TRANSP:TRANSPARENT"+$CR  // permet d'être vu lors d'une recherche dans le calendrier
$ICS:=$ICS+"CATEGORIES:"+$CR  // Permet de mettre une catégorie
$ICS:=$ICS+"LOCATION:"+$CR  // Lieu de RDV, réunion, ...
$ICS:=$ICS+"DESCRIPTION:"+$Pt->{4}+$CR  // texte
$ICS:=$ICS+"STATUS:CONFIRMED"+$CR  // Statut de la réunion
$ICS:=$ICS+"END:VEVENT"+$CR
$ICS:=$ICS+"END:VCALENDAR"

  // Export de l'évènement
$ICSDocument:=Temporary folder:C486+$Pt->{2}+".ics"  // nom du fichier, mais peut être différent

If (Test path name:C476($ICSDocument)=Est un document:K24:1)  // si document existe, on vire c'est un vieux
	DELETE DOCUMENT:C159($ICSDocument)
End if 

$Ref:=Create document:C266($ICSDocument)
If (OK=1)
	SEND PACKET:C103($Ref;$ICS)
End if 
CLOSE DOCUMENT:C267($Ref)

Repeat   // Temps d'attente pour être sur de la disponibilité du document
	DELAY PROCESS:C323(Current process:C322;10)
Until (Test path name:C476($ICSDocument)=Est un document:K24:1)

  // Intégration de l'évènement dans le calendrier
  // zDOC_OpenDocument($ICSDocument)
