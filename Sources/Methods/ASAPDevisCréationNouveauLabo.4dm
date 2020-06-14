//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 15/07/19, 06:32:04
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPDevisCréationNouveauLabo
  // Description
  // TABLEAU ENTIER LONG($TbNumPersonne;0)
COPY ARRAY:C226(<>TbPerNumPersonne;$TbNumPersonne)
SORT ARRAY:C229($TbNumPersonne;<)
VarNumAdhérent:=$TbNumPersonne{1}+1

ARRAY LONGINT:C221($TbNumRAEMA;0)
COPY ARRAY:C226(<>TbPerNumLaboRAEMA;$TbNumRAEMA)
SORT ARRAY:C229($TbNumRAEMA;<)
VarNumLaboRAEMA:=$TbNumRAEMA{1}+1
CREATE RECORD:C68([Personnes:12])
[Personnes:12]NomLong:2:=VarNom
[Personnes:12]TypePersonne:5:="Laboratoire"
[Personnes:12]Identificateur:4:=GAInitIdentificateurPersonne 
OB SET:C1220([Personnes:12]Arguments:7;"Association";"ASA")
OB SET:C1220([Personnes:12]Arguments:7;"EmailRAEMA";VarMail)
$Remarque:="Adhésion par le Web le "+String:C10([XData:1]XDate:4;3)+" à "+String:C10([XData:1]XHeure:5)
OB SET:C1220([Personnes:12]Arguments:7;"Remarques";$Remarque)
SAVE RECORD:C53([Personnes:12])
CREATE RECORD:C68([PersonnesAdresses:11])
[PersonnesAdresses:11]UUIDPersonne:2:=[Personnes:12]UUID:1
[PersonnesAdresses:11]LigneAdresse1:3:=VarNom
$FT:=Length:C16(VarAdresse)
Case of 
	: ($FT<36)
		$Ad2:=VarAdresse
		$Ad3:=""
		
	: (VarAdresse[[36]]="")
		$Ad2:=Substring:C12(VarAdresse;1;35)
		$Ad3:=Substring:C12(VarAdresse;37)
		
	Else 
		For ($Salé;1;$FT)
			$Rang:=36-$Salé
			If (VarAdresse[[$rang]]=" ")
				$Ad2:=Substring:C12(VarAdresse;1;$Rang)
				$Ad3:=Substring:C12(VarAdresse;$Rang+2)
				$Salé:=$FT
			End if 
		End for 
End case 
[PersonnesAdresses:11]LigneAdresse2:4:=$Ad2
[PersonnesAdresses:11]LigneAdresse3:5:=$Ad3
[PersonnesAdresses:11]CodePostal:6:=VarCP
[PersonnesAdresses:11]Ville:7:=VarVille
[PersonnesAdresses:11]Pays:8:=VarPays
[PersonnesAdresses:11]TypeAdresse:9:="Livraison"
SAVE RECORD:C53([PersonnesAdresses:11])
DUPLICATE RECORD:C225([PersonnesAdresses:11])
[PersonnesAdresses:11]TypeAdresse:9:="Facturation"
SAVE RECORD:C53([PersonnesAdresses:11])

