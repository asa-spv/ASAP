//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 08/11/11
  // ----------------------------------------------------
  // Méthode : Appli_Manifest
  // Description
  // 
  // Création d'un fichier "Manifest" à positionner à côter de l'exécutable
  // pour passer outre la demande d'autorisation de lancement
  // http://msdn.microsoft.com/en-us/library/bb756929.aspx - Values descriptions
  // http://msdn.microsoft.com/en-us/library/ms766454.aspx - Another example
  // http://www.microsoft.com/download/en/details.aspx?displaylang=en&id=8442 -- SDK Download
  // http://www.fryan0911.com/2009/09/how-to-add-windows-7-application.html
  // http://www.fryan0911.com/2009/09/how-to-add-windows-7-application.html
  // Critical Parameters
  // ----------------------------------------------------
  // level
  // asInvoker : The application runs with the same access token as the parent process.
  // highestAvailable : The application runs with the highest privileges the current user can obtain.
  // requireAdministrator : The application runs only for administrators and requires that the 
  //                        application be launched with the full access token of an administrator.
  // uiAccess
  // False : The application does not need to drive input to the user interface of another window on
  //         the desktop. Applications that are not providing accessibility should set this flag to false.
  //         Applications that are required to drive input to other windows on the desktop 
  //         (on-screen keyboard, for example) should set this value to true.
  // True : The application is allowed to bypass user interface control levels to drive input to higher
  //        privilege windows on the desktop. This setting should only be used for user interface 
  //        Assistive Technology applications.


C_TEXT:C284($XMLFile)
C_TIME:C306($Manifest)

  // Entête du Fichier ManiFest
$XMLFile:=""
$XMLFile:=$XMLFile+"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\r"
$XMLFile:=$XMLFile+"<assembly xmlns=\"urn:schemas-microsoft-com:asm.v1\" manifestVersion=\"1.0\">\r"
$XMLFile:=$XMLFile+"<assemblyIdentity version=\""+String:C10(afVersion )+"\"\r"
$XMLFile:=$XMLFile+"processorArchitecture=\"X86\"\r"
$XMLFile:=$XMLFile+"name=\""+<>SoftName+"\"\r"
$XMLFile:=$XMLFile+"type=\"win32\"/>\r"

  // Descriptio, du Fichier ManiFest
$XMLFile:=$XMLFile+"<description>"+<>SoftName+"</description>\r"
$XMLFile:=$XMLFile+"<!-- Identify the application security requirements. -->\r"
$XMLFile:=$XMLFile+"<trustInfo xmlns=\"urn:schemas-microsoft-com:asm.v2\">\r"
$XMLFile:=$XMLFile+"<security>\"\r"
$XMLFile:=$XMLFile+"   <requestedPrivileges>\r"
$XMLFile:=$XMLFile+"    <requestedExecutionLevel\r"
  // $XMLFile:=$XMLFile+"    level=\"asInvoker\"\r"  // asInvoker|highestAvailable|requireAdministrator
  // $XMLFile:=$XMLFile+"    level=\"highestAvailable\"\r"  // asInvoker|highestAvailable|requireAdministrator
$XMLFile:=$XMLFile+"    level=\"requireAdministrator\"\r"  // asInvoker|highestAvailable|requireAdministrator
$XMLFile:=$XMLFile+"      uiAccess=\"False\"/>\r"
$XMLFile:=$XMLFile+"   </requestedPrivileges>\r"
$XMLFile:=$XMLFile+"</security>\r"
$XMLFile:=$XMLFile+"</trustInfo>\r"
$XMLFile:=$XMLFile+"</assembly>"


  // Ecriture du fichier 
$vNom:=<>SoftName+"_install."

$Manifest:=XML_Creer_Document (<>SoftName+".exe.manifest")
USE CHARACTER SET:C205("ISO_8859-1";0)
If (OK=1)
	
	SEND PACKET:C103($Manifest;$XMLFile)
	CLOSE DOCUMENT:C267($Manifest)  // Fermer le document 
	
End if 
USE CHARACTER SET:C205(*;0)
