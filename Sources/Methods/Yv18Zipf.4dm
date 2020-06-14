//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 23/05/20, 17:46:01
  // ----------------------------------------------------
  // Méthode : Yv18Zipf
  // Description
  // Méthode qui zippe un fichier
  //   avec ZIP Créer archive
  // Paramètres : $1=chemin du fichier source  
  // $2=chemin du fichier destination  
  // $3 = mot de passe 
  // $4 = barre de progression si taille du fichier > 10Mo
  // ----------------------------------------------------
C_OBJECT:C1216($ObjSource;$ObjDestination;$status)
C_COLLECTION:C1488($CollObjFiles)
C_TEXT:C284($CheminSource;$1;$CheminDestination;$2;$MdP;$3)
C_BOOLEAN:C305($4)

$CheminSource:=$1
$CheminDestination:=$2
$MdP:=$3
  // Suppression d'un fichier cible existant
If (File:C1566($CheminDestination;fk chemin plateforme:K87:2).exists)
	DELETE DOCUMENT:C159($CheminDestination)
End if 

  // L'objet source
$ObjSource:=File:C1566($CheminSource;fk chemin plateforme:K87:2)
  // Condition d'apparition de la barre de progression
$Progression:=(Count parameters:C259=4) & ($ObjSource.size>10000000)

  // L'objet destination
$ObjDestination:=File:C1566($CheminDestination;fk chemin plateforme:K87:2)

If ($Progression) | ($MdP#"")  // Compression avec progression ou avec mot de passe
	$ObjZip:=New object:C1471
	$CollObjFiles:=New collection:C1472($ObjSource)
	$ObjZip.files:=$CollObjFiles
	$ObjZip.password:=$MdP
	If ($Progression)
		$ObjZip.callback:=Formula:C1597(YProgressZip ($1))
		progressID:=Progress New 
	End if 
	$status:=ZIP Create archive:C1640($ObjZip;$ObjDestination)
	If ($Progression)
		Progress QUIT (progressID)
	End if 
	
Else   // Compression sans mot de passe et sans compression
	$status:=ZIP Create archive:C1640($ObjSource;$ObjDestination)
End if 

$0:=$status.success  // Vrai ou faux selon la réalité de la compression
