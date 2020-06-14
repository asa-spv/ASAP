//%attributes = {}
  // YSaisieAssiste appelée en apres frappe clavier
  // MP permettant de faciliter la saisie de valeurs préétablies
  // $1 = pt sur tableau texte des valeurs préétablies
  // $2 = méthode de saisie 0
  // $3 = Vrai si la recherche se fait sur contient et Faux si sur le début de mot
  // {$4} = nbre de caractère de déclenchement sinon 2
  // $0 = valeur envoyée

C_TEXT:C284($0;$T;$Test)
C_POINTER:C301($1)
C_LONGINT:C283($2;$4;$LongMin;$L)
C_BOOLEAN:C305($3)

$PtTbValeur:=$1
$T:=Get edited text:C655
$0:=$T
If (Count parameters:C259=4)
	$LongMin:=$4
Else 
	$LongMin:=2
End if 
If (Length:C16($T)>=$LongMin)
	$Test:=(Num:C11($3)*"@")+$T+"@"
	$L:=Find in array:C230($PtTbValeur->;$Test)
	
	If ($L>=0)
		
		Case of 
			: ($2=0)  // mise des valeurs dans un tableau
				ARRAY TEXT:C222(TbChoixSaisieAssiste;0)
				Repeat 
					APPEND TO ARRAY:C911(TbChoixSaisieAssiste;$PtTbValeur->{$L})
					$L:=Find in array:C230($PtTbValeur->;$Test;($L+1))
				Until ($L<0)
				
				
			: ($2=1)  // mise des valeurs dans menu local sans ligne de saisie additionnelle
				ARRAY TEXT:C222(TbChoixSaisieAssiste;0)
				MenuLocalPages:=""
				Repeat 
					APPEND TO ARRAY:C911(TbChoixSaisieAssiste;$PtTbValeur->{$L})
					MenuLocalPages:=MenuLocalPages+";"+$PtTbValeur->{$L}
					$L:=Find in array:C230($PtTbValeur->;$Test;($L+1))
				Until ($L<0)
				MenuLocalPages:=Substring:C12(MenuLocalPages;2)
				$0:=TbChoixSaisieAssiste{Pop up menu:C542(MenuLocalPages;1)}
				
				
			: ($2=2)  // mise des valeurs dans menu local avec ligne de saisie additionnelle
				ARRAY TEXT:C222(TbChoixSaisieAssiste;0)
				MenuLocalPages:=""
				$Compteur:=1
				Repeat 
					APPEND TO ARRAY:C911(TbChoixSaisieAssiste;$PtTbValeur->{$L})
					MenuLocalPages:=MenuLocalPages+";"+$PtTbValeur->{$L}
					$L:=Find in array:C230($PtTbValeur->;$Test;($L+1))
					$Compteur:=$Compteur+1
				Until ($L<0)
				MenuLocalPages:=MenuLocalPages+";-;Nouvelle valeur"
				MenuLocalPages:=Substring:C12(MenuLocalPages;2)
				$L:=Pop up menu:C542(MenuLocalPages;1)
				Case of 
					: ($L=($Compteur+1))  // il veut entrer une nouvelle valeur
						$Dem:=Request:C163("Et quelle valeur, SVP ?")
						If (OK=1) & ($Dem#"")
							$0:=$Dem
							APPEND TO ARRAY:C911($PtTbValeur->;$Dem)
							SORT ARRAY:C229($PtTbValeur->;>)
						End if 
					Else 
						$0:=TbChoixSaisieAssiste{$L}
				End case 
				
				
			: ($2=3)  // mise de la première valeur dans $0 en sélectionnant les lettres restant à taper
				$L:=Find in array:C230($PtTbValeur->;$Test)
				If ($L>0)
					$0:=$PtTbValeur->{$L}
					HIGHLIGHT TEXT:C210(*;OBJECT Get name:C1087(Objet courant:K67:2);(Length:C16($T)+1);1000)
				End if 
				
				
			: ($2=4)  // mise de la première valeur dans $0 en sélectionnant les lettres restant à taper
				ARRAY TEXT:C222(TbChoixSaisieAssiste;0)
				Repeat 
					APPEND TO ARRAY:C911(TbChoixSaisieAssiste;$PtTbValeur->{$L})
					$L:=Find in array:C230($PtTbValeur->;$Test;($L+1))
				Until ($L<0)
				ZFenetreModaleAuCentre (400;350)
				AjoutDansListe:=False:C215
				DIALOG:C40("DlgChoixListBox")
				CLOSE WINDOW:C154
				If (BouAnnuleChoixStrd=0)
					$0:=TbChoixSaisieAssiste{TbChoixSaisieAssiste}
				End if 
				
				
			: ($2=5)  // mise de la première valeur dans $0 en sélectionnant les lettres restant à taper
				ARRAY TEXT:C222(TbChoixSaisieAssiste;0)
				Repeat 
					APPEND TO ARRAY:C911(TbChoixSaisieAssiste;$PtTbValeur->{$L})
					$L:=Find in array:C230($PtTbValeur->;$Test;($L+1))
				Until ($L<0)
				ZFenetreModaleAuCentre (400;350)
				AjoutDansListe:=True:C214
				DIALOG:C40("DlgChoixListBox")
				CLOSE WINDOW:C154
				If (BouAnnuleChoixStrd=0) | (BouStrdAjout=1)
					$0:=TbChoixSaisieAssiste{TbChoixSaisieAssiste}
				End if 
				
		End case 
	End if 
End if 
