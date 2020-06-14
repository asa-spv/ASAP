//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 11/07/18, 19:25:03
  // ----------------------------------------------------
  // Méthode : GAFabriqueTableauMailsLabo
  // Paramètres : $1= nom de la propriété  
  // $2 à $4 booléens d'appartenance à Info, Rapport Compta 
  // Description
  // Permet de construire les tableaux des mails des laboratoires
  // ----------------------------------------------------
$Propriété:=$1
$InfoOK:=$2
$RapportOK:=$3
$ComptaOK:=$4
$Mail:=OB Get:C1224([Personnes:12]Arguments:7;$Propriété;Est un texte:K8:3)
$Pos:=Position:C15(",";$Mail)
While ($Pos>0)
	$Candidat:=Substring:C12($Mail;1;($Pos-1))
	If (Length:C16($Candidat)>0)  // un test de validité de mail serait meilleur
		$L:=Find in array:C230(TbMails;$Candidat)
		If ($L<0)
			APPEND TO ARRAY:C911(TbMails;$Candidat)
			APPEND TO ARRAY:C911(TbMailInfo;$InfoOK)
			APPEND TO ARRAY:C911(TbMailRapport;$RapportOK)
			APPEND TO ARRAY:C911(TbMailCompta;$ComptaOK)
		Else 
			If (TbMailInfo{$L}=False:C215) & ($InfoOK)
				TbMailInfo{$L}:=True:C214
				If (TbMailRapport{$L}=False:C215) & ($RapportOK)
					TbMailRapport{$L}:=True:C214
				End if 
				If (TbMailCompta{$L}=False:C215) & ($ComptaOK)
					TbMailCompta{$L}:=True:C214
				End if 
			End if 
		End if 
	End if 
	$Mail:=Substring:C12($Mail;($Pos+1))
	$Pos:=Position:C15(",";$Mail)
End while 
If (Length:C16($Mail)>0)  // un test de validité de mail serait meilleur
	
	$L:=Find in array:C230(TbMails;$Mail)
	If ($L<0)
		APPEND TO ARRAY:C911(TbMails;$Mail)
		APPEND TO ARRAY:C911(TbMailInfo;$InfoOK)
		APPEND TO ARRAY:C911(TbMailRapport;$RapportOK)
		APPEND TO ARRAY:C911(TbMailCompta;$ComptaOK)
	Else 
		If (TbMailInfo{$L}=False:C215) & ($InfoOK)
			TbMailInfo{$L}:=True:C214
		End if 
		If (TbMailRapport{$L}=False:C215) & ($RapportOK)
			TbMailRapport{$L}:=True:C214
		End if 
		If (TbMailCompta{$L}=False:C215) & ($ComptaOK)
			TbMailCompta{$L}:=True:C214
		End if 
	End if 
End if 
