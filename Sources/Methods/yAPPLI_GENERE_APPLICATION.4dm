//%attributes = {}
  //  // ----------------------------------------------------
  //  // Nom utilisateur (OS) : Patrick EMANUEL
  //  // Date et heure : 07/06/11
  //  // ----------------------------------------------------
  //  // Méthode : APPLI_Genere_Application
  //  // Description
  //  // Génération automatisée de l'application basée sur le fichier XML projet de 4D
  //  //
  //  // Paramètres
  //  // ----------------------------------------------------
  //  // Icone de l'application : mainscreen.ico ou mainscreen.icns
  //  // RuntimeVLCopyright & CommonCopyright : Changer le nom

  //ZBaseNotification ("Compilation";"Démarrage de la compilation")

  //$chemin:=Dossier 4D(Dossier base)+"preferences"+<>ZSeparateur+"BuildApp"+<>ZSeparateur+<>SoftName+".xml"
  //$chemin2:=Dossier 4D(Dossier base)+<>SoftName+"_build"+<>ZSeparateur  //Test du répertoire de destination"

  //Si (Tester chemin acces($chemin2)#Est un dossier)
  //CRÉER DOSSIER($chemin2)
  //Fin de si 

  //Si (Tester chemin acces($chemin)=Est un document)
  //  // un fichier XML existe de même nom existe déjà, supprimons-le
  //SUPPRIMER DOCUMENT($chemin)
  //Fin de si 

  //$Source:=Dossier 4D(Dossier base)+"preferences"+<>ZSeparateur+"BuildApp"+<>ZSeparateur+"BuildApp.xml"
  //  //Copie le fichier <>SoftName.xml
  //COPIER DOCUMENT($Source;$Chemin;*)

  //  //  ***************************************************
  //  //  **** Personnalisation du fichier XML 
  //  //  ***************************************************
  //$XML:=DOM Analyser source XML($chemin)  //Ouverture du fichier XML et génére la référence au fichier !

  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/BuildApplicationName";<>SoftName)  //On force le nom, au cas où
  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/Versioning/Common/CommonVersion";Chaîne(afVersion ))
  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/Versioning/Common/CommonCopyright";"QualiSoft")
  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/Versioning/Common/CommonComment";<>SubSoftName)
  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/Versioning/Common/CommonCompanyName";"Association QualiSoft")
  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/Versioning/Common/CommonFileDescription";<>SubSoftName)
  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/Versioning/Common/CommonInternalName";<>SoftName)
  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/Versioning/RuntimeVL/RuntimeVLVersion";Chaîne(afVersion ))
  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/Versioning/RuntimeVL/RuntimeVLCopyright";"QualiSoft")

  //  //  ***************************************************
  //  //  *** Section des Plug-In et des Composants
  //  //  *** Nettoyage du fichier XML
  //  //  ***************************************************
  //XML_Element_Delete ($XML;"/Preferences4D/BuildApp/ArrayExcludedPluginName")
  //XML_Element_Delete ($XML;"/Preferences4D/BuildApp/ArrayExcludedPluginID")
  //XML_Element_Delete ($XML;"/Preferences4D/BuildApp/ArrayExcludedComponentName")

  //  // ***************************************************
  //  // *** Section des Plug-In 
  //  // ***************************************************
  //TABLEAU ENTIER LONG($TbPlugId;0)
  //TABLEAU TEXTE($TbPlugName;0)

  //TABLEAU ENTIER LONG($XMLPlugId;0)
  //TABLEAU TEXTE($XMLPlugName;0)
  //LISTE PLUGINS($TbPlugId;$TbPlugName)

  //$Max:=Taille tableau($TbPlugId)
  //Boucle ($a;1;$Max)
  //$OnSupprime:=Faux

  //  // ***************************************************
  //  // *** LISTE A PERSONNALISER POUR CHAQUE APPLICATION !
  //  // ***************************************************
  //Au cas ou   // Liste de ce que l'on conserve
  //: ($TbPlugName{$a}="Shell Execute")  //  Keisuke MIYAKO -- Lancement et impression de documents
  //: ($TbPlugName{$a}="4D MDI")  //  Keisuke MIYAKO -- Gestion des titres de l'application
  //: ($TbPlugName{$a}="Growl II")  //  Keisuke MIYAKO -- Système de notification sur Mac
  //: ($TbPlugName{$a}="API Pack")
  //: ($TbPlugName{$a}="4D Internet Commands")
  //: ($TbPlugName{$a}="4D_Pack")

  //Sinon 
  //$OnSupprime:=Vrai
  //Fin de cas 

  //Si ($OnSupprime)
  //AJOUTER À TABLEAU($XMLPlugId;$TbPlugId{$a})
  //AJOUTER À TABLEAU($XMLPlugName;$TbPlugName{$a})
  //Fin de si 
  //Fin de boucle 

  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/ArrayExcludedPluginName/ItemsCount";Chaîne(Taille tableau($XMLPlugName)))
  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/ArrayExcludedPluginId/ItemsCount";Chaîne(Taille tableau($XMLPlugId)))

  //Boucle ($a;1;Taille tableau($XMLPlugId))
  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/ArrayExcludedPluginName/Item"+Chaîne($a);$XMLPlugName{$a})



  //  // ******************************************
  //  // Suppression de 4D View et 4D Write : ne fonctionne pas --> ACI0076438
  //  //    A NE CONSERVER QUE SI 4DWRITE OU 4DVIEW N'EST PAS UTILISÉ
  //  // ******************************************

  //Au cas ou 
  //: ($XMLPlugName{$a}="4D View")
  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/ArrayExcludedPluginID/Item"+Chaîne($a);"13000")
  //: ($XMLPlugName{$a}="4D Write")
  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/ArrayExcludedPluginID/Item"+Chaîne($a);"12000")

  //Sinon 
  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/ArrayExcludedPluginID/Item"+Chaîne($a);Chaîne($XMLPlugId{$a}))
  //Fin de cas 
  //Fin de boucle 

  //  // ***************************************************
  //  // *** Section des Composants
  //  // ***************************************************
  //TABLEAU TEXTE($TbCompName;0)
  //TABLEAU TEXTE($XMLCompName;0)
  //LISTE COMPOSANTS($TbCompName)
  //Boucle ($a;1;Taille tableau($TbCompName))
  //$OnSupprime:=Faux

  //  // ***************************************************
  //  // *** LISTE A PERSONNALISER POUR CHAQUE APPLICATION !
  //  // ***************************************************
  //Au cas ou   // Liste de ce que l'on conserve
  //: ($TbCompName{$a}="4D SVG")
  //: ($TbCompName{$a}="Dynamic Listbox")  //Keisuke MIYAKO -- Graphic en SVG sur la base de donnnées
  //: ($TbCompName{$a}="Lecteur de Musique")  //Keisuke MIYAKO -- Pilotage Biblio Itunes (Customisé par PE)

  //Sinon 
  //$OnSupprime:=Vrai
  //Fin de cas 

  //Si ($OnSupprime)
  //AJOUTER À TABLEAU($XMLCompName;$TbCompName{$a})
  //Fin de si 
  //Fin de boucle 

  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/ArrayExcludedComponentName/ItemsCount";Chaîne(Taille tableau($XMLCompName)))
  //Boucle ($a;1;Taille tableau($XMLCompName))
  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/ArrayExcludedComponentName/Item"+Chaîne($a);$XMLCompName{$a})
  //Fin de boucle 

  //  // ***************************************************
  //  //  *** Paramètres spécifique selon la plate-forme
  //  // ***************************************************
  //$OnContinue:=Faux

  //Si (<>ZPC)
  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/BuildWinDestFolder";$Chemin2)
  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/SourcesFiles/RuntimeVL/RuntimeVLIconWinPath";Dossier 4D(Dossier base)+"mainscreen.ico")

  //$CheminEngine:=XML_Element_Read ($XML;"/Preferences4D/BuildApp/SourcesFiles/RuntimeVL/RuntimeVLWinFolder")
  //Si (Tester chemin acces($CheminEngine)=Est un dossier)
  //$OnContinue:=Vrai
  //Fin de si 

  //Sinon 
  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/BuildMacDestFolder";$Chemin2)
  //XML_Element_Update ($XML;"/Preferences4D/BuildApp/SourcesFiles/RuntimeVL/RuntimeVLIconMacPath";Dossier 4D(Dossier base)+"mainscreen.icns")

  //$CheminEngine:=XML_Element_Read ($XML;"/Preferences4D/BuildApp/SourcesFiles/RuntimeVL/RuntimeVLMacFolder")
  //Si (Tester chemin acces($CheminEngine)=Est un dossier)
  //$OnContinue:=Vrai
  //Fin de si 

  //Fin de si 

  //  // ***************************************************
  //  // *** Fin de la personnalisation. Enregistrement des modifications
  //  // ***************************************************

  //DOM EXPORTER VERS FICHIER($XML;$chemin)
  //DOM FERMER XML($XML)  //Ferme le fichier

  //  // ***************************************************
  //  // **** Génération de l'application sur la base du fichier XML créé.
  //  // ***************************************************

  //Si ($OnContinue)

  //GÉNÉRER APPLICATION($chemin)

  //Si (OK=1)

  //ZBaseNotification ("Compilation";"Compilation Réussie. Ajout des fichiers annexes.")

  //  // ***************************************************
  //  // **** Définition des fichiers / Dossier à supprimer
  //  // Suite à ACI0076438 : Write et View sont quand même ajoutés à la compilation !
  //  // ***************************************************
  //TABLEAU TEXTE($Dossier;0)
  //Si (<>ZPC)
  //$FolderToDelete:=$chemin2+"Final Application"+<>ZSeparateur+<>SoftName+<>ZSeparateur+"Plugins"+<>ZSeparateur
  //Sinon 
  //$FolderToDelete:=$chemin2+"Final Application"+<>ZSeparateur+<>SoftName+".app"+<>ZSeparateur+"Contents"+<>ZSeparateur+"Plugins"+<>ZSeparateur
  //Fin de si 
  //AJOUTER À TABLEAU($Dossier;$FolderToDelete+"4D Write.bundle"+<>ZSeparateur)
  //AJOUTER À TABLEAU($Dossier;$FolderToDelete+"4D View.bundle"+<>ZSeparateur)

  //Boucle ($a;1;Taille tableau($Dossier))
  //yDOSSIER_Supprime_Dossier ($Dossier{$a};Vrai)
  //Fin de boucle 


  //  // ***************************************************
  //  // **** Définition des fichiers à ajouter à côté de la structure
  //  // ***************************************************
  //TABLEAU TEXTE($Doc;0)
  //TABLEAU TEXTE($Doc2;0)
  //AJOUTER À TABLEAU($Doc;"pmx.qls")
  //AJOUTER À TABLEAU($Doc;"Liste enfant - DOB - adresse.4QR")
  //AJOUTER À TABLEAU($Doc;"recherche Vaccin et Assurance manquante.4DF")
  //AJOUTER À TABLEAU($Doc;"Rappel facture.4QR")
  //AJOUTER À TABLEAU($Doc;"etiquette petite.4LB")
  //AJOUTER À TABLEAU($Doc;"etiquette grande.4LB")
  //AJOUTER À TABLEAU($Doc;"Recommandations.4QR")
  //AJOUTER À TABLEAU($Doc;"Simply Asso.pdf")
  //AJOUTER À TABLEAU($Doc;"simply Asso - Ecran principal.png")

  //Si (<>ZPC)  // uniquement si on compile sur PC
  //  // Création du fichier Manifest
  //yAppli_Manifest 
  //  // AJOUTER A TABLEAU($Doc2;"Simply Asso.exe.manifest")
  //Fin de si 

  //AJOUTER À TABLEAU($Doc2;"header.bmp")
  //AJOUTER À TABLEAU($Doc2;"Association Qualisoft.bmp")
  //AJOUTER À TABLEAU($Doc2;"disclaimer.txt")
  //AJOUTER À TABLEAU($Doc2;"wizard.bmp")
  //AJOUTER À TABLEAU($Doc2;"wizardsmall.bmp")
  //AJOUTER À TABLEAU($Doc2;<>SoftName+".ico")

  //  // ***************************************************
  //  // **** Fin de la définition des fichiers à ajouter à côté de la structure
  //  // ***************************************************



  //  // ***************************************************
  //  // **** Action(s)à faire après création des fichiers compilés
  //  // ***************************************************

  //  // ***************************************************
  //  //  Copie des fichiers à côté de l'application
  //  // ***************************************************
  //$Pmxs:=Dossier 4D(Dossier base)
  //$PMXd:=$Pmxs+<>SoftName+"_build"+<>ZSeparateur+"Final Application"+<>ZSeparateur+<>SoftName

  //Si (<>ZPC)
  //$PMXDesint:=$PMXd+<>ZSeparateur
  //$PMXd:=$PMXd+<>ZSeparateur+"Database"+<>ZSeparateur
  //Sinon 
  //$PMXd:=$PMXd+".app"+<>ZSeparateur+"Contents"+<>ZSeparateur+"Database"+<>ZSeparateur
  //$PMXDesint:=$PMXd
  //Fin de si 

  //Boucle ($a;1;Taille tableau($Doc))
  //Si (Tester chemin acces($Pmxs+$Doc{$a})=Est un document)
  //COPIER DOCUMENT($Pmxs+$Doc{$a};$Pmxd+$Doc{$a};*)
  //Fin de si 
  //Fin de boucle 

  //Boucle ($a;1;Taille tableau($Doc2))
  //Si (Tester chemin acces($Pmxs+$Doc2{$a})=Est un document)
  //COPIER DOCUMENT($Pmxs+$Doc2{$a};$PMXDesint+$Doc2{$a};*)
  //Fin de si 
  //Fin de boucle 
  //ZBaseNotification ("Compilation";"Copie des fichiers terminés.")

  //  // ***************************************************
  //  //  Création d'un fichier compressé
  //  // ***************************************************
  //  //AFFICHER NOTIFICATION("Compilation";"Démarrage de la compression du dossier Final Application")
  //  //$source_path_t:=$Pmxs+<>SoftName+"_build"+<>ZSeparateur+"Final Application"+<>ZSeparateur+<>SoftName
  //  //Si (<>ZPC)
  //  //$source_path_t:=$source_path_t+<>ZSeparateur
  //  //Sinon 
  //  //$source_path_t:=$source_path_t+".app"+<>ZSeparateur
  //  //Fin de si 
  //  //
  //  //  //  Définition du nom de l'archive !
  //  //$archive_target_path_t:=$Pmxs+<>SoftName+"_build"+<>ZSeparateur+"Final Application"+<>ZSeparateur+<>SoftName
  //  //
  //  //Si (<>ZPC)
  //  //  // // Désactiver suite à la création des 2 exécutables d'installation
  //  //
  //  //$Message:="Erreur lors de la compression !"
  //  //$archive_target_path_t:=$archive_target_path_t+".zip"
  //  //$success_b:=z7_Archive ($source_path_t;$archive_target_path_t)
  //  //$Message:=Choisir($success_b;$Message;$Message+<>ZCR+<>SoftName+".zip")
  //  //
  //  //Sinon   // Uniquement sur Mac
  //  //$archive_target_path_t:=$archive_target_path_t+".7z"
  //  //$success_b:=z7_Archive ($source_path_t;$archive_target_path_t)
  //  //Fin de si 

  //  // ***************************************************
  //  // Création du fichier d'installation
  //  // Note : les lignes en commentaires sont liées aux lignes de codes désactivées 
  //  // correspondant à la création d'un fichier compressé
  //  // ***************************************************

  //ZBaseNotification ("Compilation";"Création du fichier d'installation.")
  //ENDORMIR PROCESS(Numéro du process courant;30)

  //  // *** Création du fichier d'installation
  //Si (<>ZPC)
  //$Chaine:="!define MUI_WELCOMEPAGE_TEXT "+<>ZGuil+"Cet assistant va vous guider pendant l'installation de "+<>SoftName+" ${VERSION}, la nouvelle génération de gestionnaire d'Association.$\\r$\\n$\\r$\\n"
  //$Chaine:=$Chaine+"Parce que gérer une Association demande souvent du temps, "+<>SoftName+" vous libère du temps afin que vous vous consacriez à ce qui est vraiment important pour votre"+" Association !$\\r$\\n$\\r$\\n $_CLICK"+<>ZGuil+Caractère(13)+Caractère(10)

  //$Chemin:=$Pmxs+<>SoftName+"_build"+<>ZSeparateur+"Final Application"+<>ZSeparateur+<>SoftName

  //yAppli_GenereNSISFile ($Chemin;$chaine)

  //  // Appli_GenereInnoSetupFile   // Autre outil de génération de fichier d'installation

  //Sinon   // On est sur Mac

  //  //  *******************************
  //  //  **** Les SimplyAsso dans Appli_GenereDMG correspondent à la Licence et au Layout créés préalablement dans DropDMG
  //  //  *******************************
  //yAppli_GenereDMG 

  //Fin de si 

  //MONTRER SUR DISQUE($chemin2)
  //ZBaseNotification ("Compilation";"Compilation & Compression terminés avec Succès !")

  //  // ***************************************************
  //  // ****Fin de(s)l'action(s)à faire après création des fichiers compilés
  //  // ***************************************************

  //Sinon 
  //ALERTE("Un problème s'est produit lors de la génération de l'application "+<>SoftName)
  //Fin de si 

  //Sinon   // GENERER APPLICATION($chemin) FAILED !

  //ALERTE("Le chemin vers 4D Desktop est erroné !\r"+$CheminEngine)
  //Fin de si 