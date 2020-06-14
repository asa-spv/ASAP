//%attributes = {}
  //  // ----------------------------------------------------
  //  // Nom utilisateur (OS) : Patrick EMANUEL
  //  // Date et heure : 09/08/11
  //  // ----------------------------------------------------
  //  // Méthode : _Appli_GenereNSISFile
  //  // Description
  //  // Les informations concernant le fichier scriptable sont données au fur et à mesure en tant que commentaires
  //  //
  //  // Documentation
  //  // http://www.todae.fr/nsis/docs/   <--- En Français
  //  // http://nsis.sourceforge.net/Docs/Chapter4.html#4.2
  //  // http://www.klopfenstein.net/lorenz.aspx/simple-nsis-installer-with-user-execution-level
  //  // http://nsis.sourceforge.net/IShellLink_Set_RunAs_flag
  //  // http://nsis.sourceforge.net/ShellLink_plug-in
  //  // http://nsis.sourceforge.net/Uninstall_only_installed_files
  //  // http://kalanir.blogspot.com/2011/08/nsis-how-to-write-uninstaller.html
  //  // http://ontopreplica.codeplex.com/SourceControl/changeset/view/a65fdbb263dd#Installer%2fscript.nsi
  //  // http://ctlabs.blogspot.com/2009/02/nullsoft-scriptable-install-system-nsis.html
  //  // ----------------------------------------------------

  //C_HEURE($vDoc)
  //C_TEXTE($vnom;$1;$vChemin;$2;$Welcome)
  //TABLEAU TEXTE($Inst;0)

  //$Build:=Chaine(Annee de(<>zdatedujour))+Chaine(Mois de(<>zdatedujour))+Chaine(Jour de(<>zdatedujour))
  //$vNom:=<>SoftName+"_install-b"+$Build+"."
  //$CR:=Caractere(13)+Caractere(10)
  //$Guil:=<>ZGuil

  //Si (Nombre de parametres=2)  //Permet la gestion de test :-)
  //$vChemin:=$1  // Pour les besoin du test
  //$Welcome:=$2
  //Sinon 
  //$vChemin:=Dossier 4D(Dossier base)+<>SoftName+"_build"+<>ZSeparateur+"Final Application"+<>ZSeparateur+<>SoftName
  //$Welcome:="!define MUI_WELCOMEPAGE_TEXT "+$Guil+"Cet assistant va vous guider pendant l'installation de "+<>SoftName+" ${VERSION}, la nouvelle génération de gestionnaire d'Association.$\\r$\\n$\\r$\\n"\

  //$Welcome:=$Welcome+"Parce que gérer une Association demande souvent du temps, "+<>SoftName+" vous libère du temps afin que vous vous consacriez à ce qui est"+" vraiment important pour votre Association !$\\r$\\n$\\r$\\n $_CLICK"+$Guil+$CR\



  //Fin de si 

  //  //Création du jeu d'instruction
  //  // la commande Name permet de spécifier le nom du logiciel/produit installé
  //AJOUTER A TABLEAU($Inst;";--------------------------------"+$CR)
  //AJOUTER A TABLEAU($Inst;";-- Paramétrage Général"+$CR)
  //AJOUTER A TABLEAU($Inst;"BrandingText "+$Guil+"Association QualiSoft"+$Guil+$CR)
  //AJOUTER A TABLEAU($Inst;"!define VERSION "+$Guil+"V."+aaaaaaaaaafVersion +" ("+$Build+")"+$Guil+$CR)
  //AJOUTER A TABLEAU($Inst;"XPStyle on"+$CR)
  //AJOUTER A TABLEAU($Inst;"Name "+$Guil+<>SoftName+" ${VERSION}"+$Guil+$CR)
  //AJOUTER A TABLEAU($Inst;"Caption "+$Guil+"Installation de "+<>SoftName+" ${VERSION}, Association QualiSoft."+$Guil+$CR)

  //  // Fait gagner beaucoup d'octets à la compression (taille égale à environ 25-30% de la taille totale)
  //AJOUTER A TABLEAU($Inst;"SetCompressor /SOLID lzma"+$CR)

  //  // OutFile spécifie le nom du fichier exécutable (installation) généré à la fin de la compilation du script NSIS. 
  //AJOUTER A TABLEAU($Inst;"OutFile "+$Guil+$vNom+"exe"+$Guil+$CR+$CR)
  //  // ; ComponentText spécifie le texte affiché au dessus de la liste des composants (sections) à sélectionner. S'il n'est pas spécifié, 
  //  // la fenêtre de sélection des composants ne s'affichera pas, et les composants par défaut seront sélectionnés.
  //AJOUTER A TABLEAU($Inst;"ComponentText "+$Guil+"Valider les options d'installation de "+<>SoftName+$Guil+$CR)
  //  //  DirText spécifie le texte affiché au dessus du répertoire d'installation spécifié par l'utilisateur.
  //  //  S'il n'est pas spécifié, la fenêtre de sélection du répertoire ne s'affichera pas et le répertoire par défaut sera utilisé. 
  //AJOUTER A TABLEAU($Inst;"DirText "+$Guil+"Sélection du répertoire d'installation"+$Guil+$CR+$CR)
  //  // InstallDir spécifie le répertoire d'installation de l'application par défaut. 
  //AJOUTER A TABLEAU($Inst;"InstallDir "+$Guil+"$COMMONFILES\\"+<>SoftName+$Guil+$CR)
  //  // InstallDirRegKey spécifie une clé de registre ou se situe le répertoire d'installation par défaut à utiliser. Si cette clé n'est pas présente (ou ne contient pas de répertoire), le répertoire d'installation par défaut sera utilisé. 
  //AJOUTER A TABLEAU($Inst;"InstallDirRegKey HKLM "+$Guil+"Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\"+<>SoftName+$Guil+$Guil+"UninstallString"+$Guil+$CR+$CR)


  //AJOUTER A TABLEAU($Inst;";--------------------------------"+$CR)
  //AJOUTER A TABLEAU($Inst;";Header Files"+$CR)
  //AJOUTER A TABLEAU($Inst;"!include "+$Guil+"MUI2.nsh"+$Guil+$CR)
  //AJOUTER A TABLEAU($Inst;"!include "+$Guil+"Sections.nsh"+$Guil+$CR)
  //AJOUTER A TABLEAU($Inst;"!include "+$Guil+"LogicLib.nsh"+$Guil+$CR)
  //AJOUTER A TABLEAU($Inst;"!include "+$Guil+"Memento.nsh"+$Guil+$CR)
  //AJOUTER A TABLEAU($Inst;"!include "+$Guil+"WordFunc.nsh"+$Guil+$CR+$CR)

  //AJOUTER A TABLEAU($Inst;";--------------------------------"+$CR)
  //AJOUTER A TABLEAU($Inst;";Interface Settings"+$CR)
  //AJOUTER A TABLEAU($Inst;"!define MUI_ICON "+$Guil+<>SoftName+".ico"+$Guil+$CR)
  //AJOUTER A TABLEAU($Inst;"!define MUI_ABORTWARNING"+$CR+$CR)
  //AJOUTER A TABLEAU($Inst;"!define MUI_HEADERIMAGE"+$CR)
  //AJOUTER A TABLEAU($Inst;"!define MUI_HEADERIMAGE_BITMAP "+$Guil+"header.bmp"+$Guil+$CR)
  //AJOUTER A TABLEAU($Inst;"!define MUI_HEADERIMAGE_UNBITMAP "+$Guil+"header.bmp"+$Guil+$CR)
  //AJOUTER A TABLEAU($Inst;"!define MUI_LICENSEPAGE_CHECKBOX"+$CR)
  //AJOUTER A TABLEAU($Inst;"!define MUI_FINISHPAGE_LINK "+$Guil+"Visiter le site de QualiSoft pour les news, FAQs et le support"+$guil+$CR)
  //AJOUTER A TABLEAU($Inst;"!define MUI_FINISHPAGE_LINK_LOCATION "+$Guil+"http://www.association-qualisoft.eu/"+$guil+$CR)
  //AJOUTER A TABLEAU($Inst;"!define MUI_FINISHPAGE_RUN "+$Guil+"$INSTDIR\\"+<>SoftName+".exe"+$guil+$CR)
  //AJOUTER A TABLEAU($Inst;"!define MUI_FINISHPAGE_NOREBOOTSUPPORT"+$CR+$CR)

  //AJOUTER A TABLEAU($Inst;";--------------------------------"+$CR)
  //AJOUTER A TABLEAU($Inst;";Welcome"+$CR)
  //AJOUTER A TABLEAU($Inst;"!define MUI_WELCOMEFINISHPAGE_BITMAP "+$Guil+"Association Qualisoft.bmp"+$Guil+$CR)
  //AJOUTER A TABLEAU($Inst;"!define MUI_UNWELCOMEFINISHPAGE_BITMAP "+$Guil+"Association Qualisoft.bmp"+$Guil+$CR)
  //AJOUTER A TABLEAU($Inst;";Pages"+$CR)
  //AJOUTER A TABLEAU($Inst;"!define MUI_WELCOMEPAGE_TITLE_3LINES"+$CR)
  //AJOUTER A TABLEAU($Inst;"!define MUI_WELCOMEPAGE_TITLE "+$Guil+"Bienvenue dans l'assistant d'installation de "+<>SoftName+" ${VERSION}"+$Guil+$CR)
  //AJOUTER A TABLEAU($Inst;$Welcome)

  //AJOUTER A TABLEAU($Inst;";--------------------------------"+$CR)
  //AJOUTER A TABLEAU($Inst;";Page Order"+$CR)
  //AJOUTER A TABLEAU($Inst;"!insertmacro MUI_PAGE_WELCOME"+$CR+$CR)
  //AJOUTER A TABLEAU($Inst;"!insertmacro MUI_PAGE_LICENSE "+$Guil+"disclaimer.txt"+$Guil+$CR)
  //AJOUTER A TABLEAU($Inst;"!insertmacro MUI_PAGE_COMPONENTS"+$CR)
  //AJOUTER A TABLEAU($Inst;"!insertmacro MUI_PAGE_DIRECTORY"+$CR+$CR)
  //AJOUTER A TABLEAU($Inst;"!insertmacro MUI_PAGE_INSTFILES"+$CR)
  //AJOUTER A TABLEAU($Inst;"!insertmacro MUI_PAGE_FINISH"+$CR)
  //AJOUTER A TABLEAU($Inst;"!insertmacro MUI_LANGUAGE "+$Guil+"French"+$Guil+$CR+$CR)

  //AJOUTER A TABLEAU($Inst;";--------------------------------"+$CR)
  //AJOUTER A TABLEAU($Inst;";-- Paramétrage final"+$CR)
  //  // la commande InstType permet de créer un type d'installation. Il s'agit simplement de permettre le sélectionnement automatique de sections 
  //  // (ici Normal n'installe que le programme, tandis que Entiere installe les deux composants). 
  //  // Le premier type d'installation est considéré comme celui par défaut.
  //AJOUTER A TABLEAU($Inst;"InstType Complete"+$CR)

  //  // la commande Section créé une nouvelle section.
  //AJOUTER A TABLEAU($Inst;"Section "+$Guil+"Programme (Requis)"+$Guil+$CR)

  //  //  SectionIn indique a quels types d'installation la section courante appartient. Ici, elle appartient au premier et au second type. 
  //AJOUTER A TABLEAU($Inst;"SectionIn 1"+$CR)
  //  // SetOutPath place le premier paramètre comme répertoire courant, et le créé s'il n'existe pas.
  //AJOUTER A TABLEAU($Inst;"SetOutPath $INSTDIR"+$CR)
  //  // Ajout de la liste des fichiers à installer
  //  // File permet de copier un fichier dans le répertoire courant de l'utilisateur, depuis un fichier situé dans un répertoire de la personne créant l'installation
  //AJOUTER A TABLEAU($Inst;"File /r "+$Guil+$vChemin+<>ZSeparateur+"*.*"+$Guil+$CR)
  //  // SectionEnd ferme une section précedement ouverte. 
  //AJOUTER A TABLEAU($Inst;"SectionEnd"+$CR+$CR)

  //  // SECTION de création des raccourcis
  //AJOUTER A TABLEAU($Inst;";--------------------------------"+$CR)
  //AJOUTER A TABLEAU($Inst;";-- Création des raccourcis"+$CR)
  //AJOUTER A TABLEAU($Inst;"Section \"Raccourcis\""+$CR)
  //AJOUTER A TABLEAU($Inst;"SetShellVarContext all"+$CR)
  //AJOUTER A TABLEAU($Inst;"SectionIn 1"+$CR)

  //$Chaine:="SetOutPath \"$SMPROGRAMS\\"+<>SoftName+"\""+$CR
  //AJOUTER A TABLEAU($Inst;$Chaine)
  //  // CreateShortCut créé un raccourci (ici dans le menu Démarrer > programmes > <>SoftName) vers le fichier donné en paramètres. 
  //$Chaine:="CreateShortCut \"$SMPROGRAMS\\"+<>SoftName+"\\"+<>SoftName+".lnk\" \"$INSTDIR\\"+<>SoftName+".exe\""+$CR
  //AJOUTER A TABLEAU($Inst;$Chaine)
  //$Chaine:="ShellLink::SetRunAsAdministrator \"$SMPROGRAMS\\"+<>SoftName+"\\"+<>SoftName+".lnk\""+$CR
  //$Chaine:=$Chaine+"DetailPrint \"SetRunAsAdministrator: $0\""+$CR
  //AJOUTER A TABLEAU($Inst;$Chaine)

  //$Chaine:="CreateShortCut \"$SMPROGRAMS\\"+<>SoftName+"\\Désinstallation de "+<>SoftName+".lnk\""
  //$Chaine:=$Chaine+" \"$INSTDIR\\uninst-"+<>SoftName+".exe\""+$CR
  //AJOUTER A TABLEAU($Inst;$Chaine)
  //$Chaine:="ShellLink::SetRunAsAdministrator \"$SMPROGRAMS\\"+<>SoftName+"\\Désinstallation de "+<>SoftName+".lnk\""+$CR
  //$Chaine:=$Chaine+"DetailPrint \"SetRunAsAdministrator: $0\""+$CR
  //AJOUTER A TABLEAU($Inst;$Chaine)

  //AJOUTER A TABLEAU($Inst;"SectionEnd"+$CR+$CR)

  //  // La section-PostInstall est une section spéciale, appelée à la fin de l'installation, si celle-ci se termine correctement."
  //  // SECTION de création des raccourcis
  //AJOUTER A TABLEAU($Inst;";--------------------------------"+$CR+$CR)
  //AJOUTER A TABLEAU($Inst;";-- Gestion Base de Registres"+$CR)
  //AJOUTER A TABLEAU($Inst;"Section \"-PostInstall\""+$CR)

  //  // WriteRegStr permet d'accéder à la base de registre du système, et d'y ajouter une nouvelle valeur.
  //  // Ici, on ajoute une entrée dans la fenêtre système d'Ajout/Suppression de Programmes."
  //AJOUTER A TABLEAU($Inst;"!define REG_UNINSTALL \"Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\\""+$CR)

  //$Chaine:="WriteRegStr HKLM \"${REG_UNINSTALL}"+<>SoftName+"\" \"DisplayName\" \""+<>SoftName+"\""+$CR
  //AJOUTER A TABLEAU($Inst;$Chaine)
  //$Chaine:="WriteRegStr HKLM \"${REG_UNINSTALL}"+<>SoftName+"\" \"DisplayVersion\" \""+Chaine(aaaaaaaaaafVersion )+"\""+$CR
  //AJOUTER A TABLEAU($Inst;$Chaine)
  //$Chaine:="WriteRegStr HKLM \"${REG_UNINSTALL}"+<>SoftName+"\" \"Publisher\" \"Association QualiSoft\""+$CR
  //AJOUTER A TABLEAU($Inst;$Chaine)
  //$Chaine:="WriteRegStr HKLM \"${REG_UNINSTALL}"+<>SoftName+"\" \"HelpLink\" \"www.association-qualisoft.eu\""+$CR
  //AJOUTER A TABLEAU($Inst;$Chaine)
  //$Chaine:="WriteRegStr HKLM \"${REG_UNINSTALL}"+<>SoftName+"\" \"URLInfoAbout\" \"www.association-qualisoft.eu\""+$CR
  //AJOUTER A TABLEAU($Inst;$Chaine)
  //$Chaine:="WriteRegStr HKLM \"${REG_UNINSTALL}"+<>SoftName+"\" \"InstallLocation\" \"$INSTDIR\""+$CR
  //AJOUTER A TABLEAU($Inst;$Chaine)
  //$Chaine:="WriteRegStr HKLM \"${REG_UNINSTALL}"+<>SoftName+"\" \"NoModify\" \"1\""+$CR
  //AJOUTER A TABLEAU($Inst;$Chaine)
  //$Chaine:="WriteRegStr HKLM \"${REG_UNINSTALL}"+<>SoftName+"\" \"NoRepair\" \"1\""+$CR
  //AJOUTER A TABLEAU($Inst;$Chaine)
  //$Chaine:="WriteRegStr HKLM \"${REG_UNINSTALL}\" \"UninstallString\" \"$INSTDIR\\uninst-"+<>SoftName+".exe\""+$CR
  //AJOUTER A TABLEAU($Inst;$Chaine)

  //$Chaine:="WriteRegStr HKLM \"Software\\Microsoft\\Windows NT\\CurrentVersion\\AppCompatFlags\\layers\" \"$INSTDIR\\"+<>SoftName+".exe\" \"RUNASADMIN\""+$CR
  //AJOUTER A TABLEAU($Inst;$Chaine)

  //AJOUTER A TABLEAU($Inst;";--------------------------------"+$CR+$CR)

  //AJOUTER A TABLEAU($Inst;";-- Création du Désinstallateur"+$CR)
  //  //WriteUninstaller lance la génération du désinstalleur.
  //AJOUTER A TABLEAU($Inst;"WriteUninstaller \"uninst-"+<>SoftName+".exe\""+$CR)
  //AJOUTER A TABLEAU($Inst;"SectionEnd"+$CR+$CR)

  //AJOUTER A TABLEAU($Inst;"UninstallText \"Voulez-vous vraiment supprimer "+<>SoftName+" de votre système ?\""+$CR+$CR)
  //  //  La section spéciale Uninstall contient toutes les commandes appelées lors du processus de désinstallation. 
  //AJOUTER A TABLEAU($Inst;"Section \"Uninstall\""+$CR)
  //  //  ShellVarContext to all (all user's shell folder will be used). If not the default is current user's shell folder. 
  //AJOUTER A TABLEAU($Inst;"SetShellVarContext all"+$CR)
  //  // -> Suppression du répertoire d'installation & Raccourcis
  //AJOUTER A TABLEAU($Inst;"Delete \"$DESKTOP\\"+<>SoftName+".lnk\""+$CR)
  //AJOUTER A TABLEAU($Inst;"RMDir /r \"$SMPROGRAMS\\"+<>SoftName+"\""+$CR)
  //AJOUTER A TABLEAU($Inst;"RMDir /r \"$INSTDIR\""+$CR)  // Suppression du répertoire d'installation
  //  // -> Nettoyahe de la base de registre
  //AJOUTER A TABLEAU($Inst;"DeleteRegKey HKLM \"${REG_UNINSTALL}"+<>SoftName+"\""+$CR)
  //AJOUTER A TABLEAU($Inst;"DeleteRegKey HKLM \"Software\\"+<>SoftName+"\""+$CR)
  //AJOUTER A TABLEAU($Inst;"SectionEnd"+$CR+$CR)

  //  //********************************************************************************
  //  //Balançons tout dans le fichier ".NSI"
  //$vDoc:=Creer document($vnom+"nsi";"TEXT")
  //UTILISER FILTRE("ISO_8859-1";0)
  //Si (OK=1)

  //Boucle ($a;1;Taille tableau($Inst))
  //ENVOYER PAQUET($vDoc;$Inst{$a})
  //Fin de boucle 

  //FERMER DOCUMENT($vDoc)  // Fermer le document 

  //Fin de si 
  //UTILISER FILTRE(*;0)

  //  //Génération du fichier Application !
  //$Nom:=Dossier 4D(Dossier base)+$vNom+"exe"
  //Si (Tester chemin acces($Nom)=Est un document)
  //SUPPRIMER DOCUMENT($Nom)
  //Fin de si 

  //  //Si (Nombre de parametres=2)  // Permet de ne pas être bloqué lors de tests
  //Si (Vrai)
  //FIXER VARIABLE ENVIRONNEMENT("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS";"false")
  //$appli:=Dossier 4D(Dossier base)+"NSIS"+<>ZSeparateur+"makensisw.exe"
  //LANCER PROCESS EXTERNE($appli+" "+$Guil+document+$Guil)
  //FIXER VARIABLE ENVIRONNEMENT("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS";"")
  //Fin de si 