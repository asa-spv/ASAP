//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 05/05/18, 15:51:38
  // ----------------------------------------------------
  // Paramètres
  // $1 = Texte à écrire dans le fichier de Log personnalisé
  // ----------------------------------------------------
  // Méthode : LOG_AjoutTrace
  // récupéré et adapté de Pole Contact de Mimosa
  // paramètres
  // ----------------------------------------------------
  // LOG_CreateLine  ("texte à écrire") -> "chemin d'accès au document"
  // gère un journal texte sur le disque dur pour tracer ce qu'on désire
  // emplacement du journal (un par jour) dans un dossier "Trace" créé si nécessaire
  // elle ajoute le texte au log en cours avec marque de l'heure, elle génère elle même les saut de lignes entre les trace
  // ex : LOG_CreateLine("toto va à la plage")
  // --> ajoute "12:26:12 : toto va à la plage" au journal

  // ***************
  // READY TO USE
  // ***************

C_TEXT:C284($1;$LigneLog)  // texte de trace à rajouter
C_TEXT:C284($CheminAcces)
C_TEXT:C284($TitreLogFichierJournalier)
C_TIME:C306($FileRef)

If (<>ZMouchard)
	
	If (Count parameters:C259>=1)
		$LigneLog:=$1
	Else 
		$LigneLog:="..."
	End if 
	
	$CheminAcces:=Get 4D folder:C485(Dossier base:K5:14;*)+Replace string:C233("Logs_base/";"/";Séparateur dossier:K24:12)
	
	If (Test path name:C476($CheminAcces)#Est un dossier:K24:2)
		CREATE FOLDER:C475($CheminAcces;*)  // création du dossier de trace si absent
	End if 
	
	$TitreLogFichierJournalier:=ZDateConvertirEnTexte (Current date:C33(*);"-")
	$TitreLogFichierJournalier:=$TitreLogFichierJournalier+".txt"
	
	If (Test path name:C476($CheminAcces+$TitreLogFichierJournalier)=Est un document:K24:1)
		$FileRef:=Append document:C265($CheminAcces+$TitreLogFichierJournalier)  // si le document existe déjà, on écrit à la suite
	Else 
		$FileRef:=Create document:C266($CheminAcces+$TitreLogFichierJournalier;Document texte:K4:1)  // sinon, on le crée (un fichier par jour)
	End if 
	
	If (OK=1)  // fichier ouvert
		
		$LigneLog:=String:C10(Current time:C178;h mn:K7:2)+": "+$LigneLog+"\n"
		
		SEND PACKET:C103($FileRef;$LigneLog)
		CLOSE DOCUMENT:C267($FileRef)
		USE CHARACTER SET:C205(*;0)
		
	End if 
	
End if 
