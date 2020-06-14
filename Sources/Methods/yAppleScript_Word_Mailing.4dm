//%attributes = {}
  //  // ----------------------------------------------------
  //  // Nom utilisateur (OS) : Patrick
  //  // Date et heure : 27/01/12
  //  // ----------------------------------------------------
  //  // Méthode : AppleScript_WORD_Mailing
  //  //
  //  // Documentation
  //  // Le positionnement des valeurs à remplacer dans le document WORD
  //  // est réalisé par des signets.
  //  //
  //  // Paramètres
  //  // ----------------------------------------------------
  //  // 1 - Nécessité de connaitre le chemin du document modèle
  //  //    Variable : $1 = Nom du Modèle
  //  //    Variable : $2 = Nom du document de sortie
  //  //    Variable : $3 = Chemin où se trouve le modèle
  //  //    Variable : $4 = Chemin où enregistrer le nouveau document

  //C_TEXT($1;$2;$3;$4;$script_t;$Modele;$MailingFile;$cheminSource;$cheminSortie)


  //  // ****************** CONFIGURATION DES VARIABLES REPERTOIRES  *******************************

  //If (Count parameters=1)
  //$Modele:=$1
  //Else 
  //$Modele:="modelelettre.doc"
  //End if 

  //If (Count parameters=2)
  //$cheminSource:=$2
  //Else 
  //$cheminSource:=ZDocNomFichier (<>PathData;1)+"mailing"+<>ZSéparateur
  //End if 

  //If (Count parameters=3)
  //$cheminSortie:=$3
  //Else 
  //$cheminSortie:=ZDocNomFichier (<>PathData;1)+"mailing"+<>ZSéparateur
  //End if 

  //If (Count parameters=4)  // Nom du document de sortie
  //$MailingFile:=$4  // "test.doc" 
  //Else 
  //$MailingFile:=String(Milliseconds)+".doc"
  //End if 

  //$Source:=$cheminSource

  //  // ****************** CREATION DU SCRIPT "Apple Script"  *******************************
  //$script_t:=""
  //$script_t:=$script_t+"tell application \"Microsoft Word\"\r"
  //$script_t:=$script_t+"\r\r"

  //$script_t:=$script_t+"-- ouverture du modèle\r"
  //$script_t:=$script_t+"set myDoc to \""+$cheminSource+$Modele+"\"\r"
  //$script_t:=$script_t+"open myDoc\r"
  //$script_t:=$script_t+"\r\r"

  //$script_t:=$script_t+"-- maj des valeurs des variables dynamiques\r"

  //ARRAY TEXT($ChmpsExport;0)
  //ARRAY LONGINT($ChmpsExportID;0)
  //ARRAY TEXT($Signet;0)

  //If (BLOB size()>0)
  //$Offset:=ZBlobVersVariableOffset (->$ChmpsExportID;->$ChmpsExport;->$Signet)
  //  //$NumTable:=

  //If ($NumTable>0)

  //For ($a;1;Size of array($Signet))  // Parcourons le tableau des signets
  //If ($Signet{$a}#"")  // La ligne est-elle réellement renseignée
  //$Value:=(Field($NumTable;$ChmpsExportID{$a}))->
  //If ($Value="")
  //$Value:=" "
  //End if 
  //  // *** Pour des champs
  //$script_t:=$script_t+"set variable value of variable \""+$Signet{$a}+"\" of active document to \""+$Value+"\"\r"

  //  // *** Pour des signets
  //  //$script_t:=$script_t+"select bookmark \""+$Signet{$a}+"\" of active document\r"
  //  //$script_t:=$script_t+"set content of text object of selection to \""+$Value+"\"\r"
  //End if 
  //End for 

  //End if 
  //End if 

  //$script_t:=$script_t+"-- provoquer le raffraichissement de l'affichage des champs liés aux variables\r"
  //  // *** Pour des champs
  //$script_t:=$script_t+"set fieldsNumber to count of fields of active document\r"
  //$script_t:=$script_t+"repeat with i from 1 to fieldsNumber\r"
  //$script_t:=$script_t+"set uField to update field field i of active document\r"
  //$script_t:=$script_t+"end repeat\r"

  //$script_t:=$script_t+"\r\r"

  //$script_t:=$script_t+"-- enregistrement du doc sous un autre nom\r"
  //$script_t:=$script_t+"save as document myDoc file name \""+$cheminSource+$MailingFile+"\"\r"

  //If (ToPrintNow)
  //$script_t:=$script_t+"tell application \"Microsoft Word\" to print out the active document\r"
  //End if 

  //$script_t:=$script_t+"\r\r"
  //$script_t:=$script_t+"end tell"

  //  // *****************************************************

  //$MailingFile:=$Source+"Apple Script mailing.scpt"

  //If (Test path name($MailingFile)=Is a document)  // si document existe, on vire c'est un vieux
  //DELETE DOCUMENT($MailingFile)
  //End if 

  //$ASCode:=Create document($MailingFile)
  //CLOSE DOCUMENT($ASCode)

  //CONVERT FROM TEXT($script_t;"UTF-8";$blob)
  //  // TEXTE VERS BLOB($script_t;$blob)
  //  // SUPPRIMER DANS BLOB($blob;Taille BLOB($blob)-1;Taille BLOB($blob)) // suppression d'un caractère parasite final !
  //BLOB TO DOCUMENT($MailingFile;$blob)
  //$isOK:=yAppleScript_Exec ($MailingFile)

  //DELAY PROCESS(Current process;1)

  //  //Si (Tester chemin acces($MailingFile)=Est un document)  // Nettoyons
  //  //SUPPRIMER DOCUMENT($MailingFile)
  //  //Fin de si 