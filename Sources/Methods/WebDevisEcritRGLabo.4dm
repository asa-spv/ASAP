//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/12/18, 16:28:59
  // ----------------------------------------------------
  // Paramètre $1= numéro du laboratoire (alpha) 
  // ----------------------------------------------------
  // Méthode : WebDevisEcritRGLabo
  // Description
  //  méthode qui écrit le HTML du programme RAEMA gel du laboratoire

C_LONGINT:C283($Salé;$FT;$Fumé;$L)
$NumLaboA:=$1
$L:=Find in array:C230(<>TbPerNumLaboRAEMAA;$NumLaboA)
$UUID:=<>TBPerUUID{$L}
$THTML:=""

  // Recherche des demandes antérieures
QUERY:C277([CampagneGelGermes:25];[Personnes:12]UUID:1=$UUID;*)
QUERY:C277([CampagneGelGermes:25]; & [CampagneGelGermes:25]NumCampagne:6="@A")
SELECTION TO ARRAY:C260([CampagneGelGermes:25]NbreColisSupAvecRapport:5;$TbCAR;[CampagneGelGermes:25]NbreColisSupSansRapport:4;$TbCSR;[CampagneGelGermes:25]NomDuGerme:3;$TbNomGerme;[CampagneGelGermes:25]NumCampagne:6;$TbNumCampagne)
$FT:=Size of array:C274($TbNumCampagne)
ARRAY TEXT:C222($TbCombine;$FT)
For ($Salé;1;$FT)
	$TbCombine{$Salé}:=$TbNumCampagne{$Salé}+$TbNomGerme{$Salé}
End for 
SORT ARRAY:C229($TbCombine;$TbNumCampagne;$TbNomGerme;$TbCSR;$TbCAR;<)
$DerMai:=""
$DerDec:=""
For ($Salé;1;$FT)
	If ($DerMai#"") & ($DerDec#"")
		$Salé:=$FT
	Else 
		If (Num:C11($TbNumCampagne{$Salé})%2=0)  // Pair donc mois de mai
			$DerMai:=$TbNumCampagne{$Salé}
		End if 
		If (Num:C11($TbNumCampagne{$Salé})%2=1)  // Impair donc mois de décembre
			$DerDec:=$TbNumCampagne{$Salé}
		End if 
	End if 
End for 

For ($Fumé;1;2)
	If ($Fumé=1)
		$DateduJour:=Current date:C33
		$Année:=String:C10((Year of:C25(Current date:C33)))
		$Pivot:=Date:C102("15/12/"+$Année)
		If ($DateduJour>$Pivot)
			$AnnéeProchaine:=Num:C11($Année)+1
			$NumCampagne:=RaemaTrouveNumCampagneParAn ($AnnéeProchaine;2)
		Else 
			$NumCampagne:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);2)
		End if 
		QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$NumCampagne)
		$Mois:=String:C10([RAEMACampagnes:20]DateEnvoiColis:3;3)
		RELATE MANY:C262([RAEMACampagnes:20]UUID:1)
		SELECTION TO ARRAY:C260([RAEMAGermes:21]NomFr:4;$TbGermes;[RAEMAGermes:21]Identifiant:3;$TbOrdreGermes;[RAEMAGermes:21]Arguments:6;$TbArguments)
		$FT:=Size of array:C274($TbGermes)
		ARRAY BOOLEAN:C223($GermeExpérimental;$FT)
		ARRAY BOOLEAN:C223($GermeCofrac;$FT)
		For ($Salé;1;$FT)
			$GermeExpérimental{$Salé}:=OB Get:C1224($TbArguments{$Salé};"Experimental";Est un booléen:K8:9)
			$GermeCofrac{$Salé}:=OB Get:C1224($TbArguments{$Salé};"COFRAC";Est un booléen:K8:9)
		End for 
		SORT ARRAY:C229($TbOrdreGermes;$TbGermes;$GermeExpérimental;$GermeCofrac;>)
		DELETE FROM ARRAY:C228($TbOrdreGermes;1;1)
		DELETE FROM ARRAY:C228($TbGermes;1;1)
		DELETE FROM ARRAY:C228($GermeExpérimental;1;1)
		DELETE FROM ARRAY:C228($GermeCofrac;1;1)
		$CourtMois:="mai"
		  // $PtTbNomGerme:=-><>TbNomGermeMai
		  // $PtTbExperimental:=-><>TbExperimentalGermeMai
		  // $PtTbCofrac:=-><>TbCofracGermeMai
		  // $PtOrdre:=-><>TbOrdreGelMai
		$DerCampagneCourante:=$DerMai
	Else 
		If ($DateduJour>$Pivot)
			$AnnéeProchaine:=Num:C11($Année)+1
			$NumCampagne:=RaemaTrouveNumCampagneParAn ($AnnéeProchaine;4)
		Else 
			$NumCampagne:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);4)
		End if 
		$CourtMois:="dec"
		  //$PtTbNomGerme:=-><>TbNomGermeDec
		  //$PtExperimental:=-><>TbExperimentalGermeDec
		  //$PtTbCofrac:=-><>TbCofracGermeDec
		  //$PtOrdre:=-><>TbOrdreGelDec
		QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$NumCampagne)
		$Mois:=String:C10([RAEMACampagnes:20]DateEnvoiColis:3;3)
		RELATE MANY:C262([RAEMACampagnes:20]UUID:1)
		SELECTION TO ARRAY:C260([RAEMAGermes:21]NomFr:4;$TbGermes;[RAEMAGermes:21]Identifiant:3;$TbOrdreGermes;[RAEMAGermes:21]Arguments:6;$TbArguments)
		$FT:=Size of array:C274($TbGermes)
		ARRAY BOOLEAN:C223($GermeExpérimental;$FT)
		ARRAY BOOLEAN:C223($GermeCofrac;$FT)
		For ($Salé;1;$FT)
			$GermeExpérimental{$Salé}:=OB Get:C1224($TbArguments{$Salé};"Experimental";Est un booléen:K8:9)
			$GermeCofrac{$Salé}:=OB Get:C1224($TbArguments{$Salé};"COFRAC";Est un booléen:K8:9)
		End for 
		SORT ARRAY:C229($TbOrdreGermes;$TbGermes;$GermeExpérimental;$GermeCofrac;>)
		DELETE FROM ARRAY:C228($TbOrdreGermes;1;1)
		DELETE FROM ARRAY:C228($TbGermes;1;1)
		DELETE FROM ARRAY:C228($GermeExpérimental;1;1)
		DELETE FROM ARRAY:C228($GermeCofrac;1;1)
		$DerCampagneCourante:=$DerDec
	End if 
	  //Si ([RAEMACampagnes]DateEnvoiColis>Date du jour)
	  //$THTML:=$THTML+"     <br /><br />"+<>ZCR
	$THTML:=$THTML+"     <p class="+<>ZGuil+"grandhautpage"+<>ZGuil+">Campagne "+$NumCampagne+" du "+$Mois+"</p>"+<>ZCR
	If (([RAEMACampagnes:20]DateLimiteReponse:4<Current date:C33))
		  // Texte expliquant pourquoi c'est en gris
		$THTML:=$THTML+"    <p class="+<>ZGuil+"rougecentre"+<>ZGuil+">Cette campagne étant terminée, il vous est impossible de modifier cette partie du devis</p>"+<>ZCR
	End if 
	$THTML:=$THTML+"     <table class="+<>ZGuil+"tbdeviscentre"+<>ZGuil+">"+<>ZCR
	  // ET des colonnes 
	$THTML:=$THTML+"       <tr >"+<>ZCR
	$THTML:=$THTML+"              <td class="+<>ZGuil+"ettbdevis"+<>ZGuil+" width="+<>ZGuil+"40%"+<>ZGuil+"></td>"+<>ZCR
	$THTML:=$THTML+"              <td class="+<>ZGuil+"ettbdevis"+<>ZGuil+" width="+<>ZGuil+"20%"+<>ZGuil+">Envoi principal avec édition d'un rapport</td>"+<>ZCR
	$THTML:=$THTML+"              <td class="+<>ZGuil+"ettbdevis"+<>ZGuil+" width="+<>ZGuil+"20%"+<>ZGuil+">Pots <br />supplémentaires <b>AVEC</b> rapport</td>"+<>ZCR
	$THTML:=$THTML+"              <td class="+<>ZGuil+"ettbdevis"+<>ZGuil+" width="+<>ZGuil+"20%"+<>ZGuil+">Pots <br />supplémentaires <b>SANS</b> rapport</td>"+<>ZCR
	$THTML:=$THTML+"       </tr>"+<>ZCR
	
	  // $FT:=Taille tableau($PtTbNomGerme->)
	$FT:=Size of array:C274($TbGermes)
	
	If (([RAEMACampagnes:20]DateLimiteReponse:4<Current date:C33))
		For ($Salé;1;$FT)
			If ($GermeExpérimental{$Salé}=False:C215)
				$Cofrac:=Num:C11($GermeCofrac{$Salé})*"*"
				$Pyjama:=Num:C11($Salé%2=1)*"im"
				$THTML:=$THTML+"       <tr class="+<>ZGuil+"ligne"+$Pyjama+"pairegrise"+<>ZGuil+">"+<>ZCR
				$THTML:=$THTML+"              <td class="+<>ZGuil+"litbdevis"+<>ZGuil+">"+$TbGermes{$Salé}+$Cofrac+"</td>"+<>ZCR
				$L:=Find in array:C230(<>TbNomGermeSchémaGEL;$TbGermes{$Salé})
				$NomGermeCampagne:=<>TbNomGermeCampagneGEL{$L}
				$Identifiant:=<>TbPetitNomGermeWeb{$L}
				$Test:=$DerCampagneCourante+$NomGermeCampagne
				$L:=Find in array:C230($TbCombine;$Test)
				$Checked:=(Num:C11($L<0)*"")+(Num:C11($L>0)*" checked")
				If ($L>0)
					$Valuear:=String:C10($TbCAR{$L})
					$Valuesr:=String:C10($TbCSR{$L})
				Else 
					$Valuear:=""
					$Valuesr:=""
				End if 
				$THTML:=$THTML+"              <td class="+<>ZGuil+"litbdevis"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" onClick="+<>ZGuil+"return false;"+<>ZGuil+" name="+<>ZGuil+"cb"+$CourtMois+$Identifiant+<>ZGuil+$Checked+"></td>"+<>ZCR
				$THTML:=$THTML+"              <td class="+<>ZGuil+"litbdevis"+<>ZGuil+" ><input class="+<>ZGuil+"tbdeviscellule"+<>ZGuil+" readonly="+<>ZGuil+"readonly"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" size="+<>ZGuil+"1"+<>ZGuil+" name="+<>ZGuil+"nbpotsupar"+$CourtMois+$Identifiant+<>ZGuil+$Valuear+"></td>"+<>ZCR
				$THTML:=$THTML+"              <td class="+<>ZGuil+"litbdevis"+<>ZGuil+" ><input  class="+<>ZGuil+"tbdeviscellule"+<>ZGuil+" readonly="+<>ZGuil+"readonly"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" size="+<>ZGuil+"1"+<>ZGuil+" name="+<>ZGuil+"nbpotsupsr"+$CourtMois+$Identifiant+<>ZGuil+$Valuesr+"></td>"+<>ZCR
				$THTML:=$THTML+"       </tr>"+<>ZCR
			End if 
		End for 
	Else 
		For ($Salé;1;$FT)
			If ($GermeExpérimental{$Salé}=False:C215)
				$Cofrac:=Num:C11($GermeCofrac{$Salé})*"*"
				$Pyjama:=Num:C11($Salé%2=1)*"im"
				$THTML:=$THTML+"       <tr class="+<>ZGuil+"ligne"+$Pyjama+"paire"+<>ZGuil+">"+<>ZCR
				$THTML:=$THTML+"              <td class="+<>ZGuil+"litbdevis"+<>ZGuil+">"+$TbGermes{$Salé}+$Cofrac+"</td>"+<>ZCR
				$L:=Find in array:C230(<>TbNomGermeSchémaGEL;$TbGermes{$Salé})
				$NomGermeCampagne:=<>TbNomGermeCampagneGEL{$L}
				$Identifiant:=<>TbPetitNomGermeWeb{$L}
				$Test:=$DerCampagneCourante+$NomGermeCampagne
				$L:=Find in array:C230($TbCombine;$Test)
				$Checked:=(Num:C11($L<0)*"")+(Num:C11($L>0)*" checked")
				If ($L>0)
					$Valuear:=" value="+<>ZGuil+String:C10($TbCAR{$L})+<>ZGuil+" "
					$Valuesr:=" value="+<>ZGuil+String:C10($TbCSR{$L})+<>ZGuil+" "
				Else 
					$Valuear:=""
					$Valuesr:=""
				End if 
				$THTML:=$THTML+"              <td class="+<>ZGuil+"litbdevis"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" name="+<>ZGuil+"cb"+$CourtMois+$Identifiant+<>ZGuil+$Checked+"></td>"+<>ZCR
				$THTML:=$THTML+"              <td class="+<>ZGuil+"litbdevis"+<>ZGuil+" ><input class="+<>ZGuil+"tbdeviscellule"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" size="+<>ZGuil+"1"+<>ZGuil+" name="+<>ZGuil+"nbpotsupar"+$CourtMois+$Identifiant+<>ZGuil+$Valuear+"></td>"+<>ZCR
				$THTML:=$THTML+"              <td class="+<>ZGuil+"litbdevis"+<>ZGuil+" ><input  class="+<>ZGuil+"tbdeviscellule"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" size="+<>ZGuil+"1"+<>ZGuil+" name="+<>ZGuil+"nbpotsupsr"+$CourtMois+$Identifiant+<>ZGuil+$Valuesr+"></td>"+<>ZCR
				$THTML:=$THTML+"       </tr>"+<>ZCR
			End if 
		End for 
	End if 
	$THTML:=$THTML+"     </table>"+<>ZCR
	$THTML:=$THTML+"     <span class="+<>ZGuil+"petittextevert"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"            * sous accréditation Cofrac (Accréditation N° 1-1836,"+<>ZCR
	$THTML:=$THTML+"       <a target="+<>ZGuil+"_blank"+<>ZGuil+" href="+<>ZGuil+"http://www.cofrac.fr/fr/organismes/fiche.php?entite_id=12085864"+<>ZGuil+"><i><u>portée disponible sur le site du Cofrac</u></i></a>)"+<>ZCR
	$THTML:=$THTML+"     </span>"+<>ZCR
	$THTML:=$THTML+"       <br /><br />"+<>ZCR
	  //Fin de si 
	
End for 
$THTML:=$THTML+"     <p id="+<>ZGuil+"totalht1"+<>ZGuil+" class="+<>ZGuil+"grandtitrepage"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"       ici bientôt le prix HT"+<>ZCR
  //Fin de si 
$THTML:=$THTML+"     </p>"+<>ZCR2

$THTML:=$THTML+"       <br /><br />"+<>ZCR
$THTML:=$THTML+"     <p class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"envoyer"+<>ZGuil+" value="+<>ZGuil+"Envoyer la demande de devis"+<>ZGuil+" class="+<>ZGuil+"paragraphe"+<>ZGuil+" />"
$THTML:=$THTML+"     </p>"+<>ZCR
$THTML:=$THTML+"       <br /><br />"+<>ZCR

  // FIXER TEXTE DANS CONTENEUR($THTML)
$0:=$THTML