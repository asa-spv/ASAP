//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 05/12/16, 10:09:22
  // ----------------------------------------------------
  // Méthode : RaemaGenereNumEchantillons
  // Description
  // Permet de créer les n° des échantillons d'un RAEMA poudre
  //  en tenant compte du rang décidé pour la campagne
  // Paramètre : rang de la campagne
  // ----------------------------------------------------
  //$H1:=Nombre de millisecondes
If (Size of array:C274(TbNumEchRaema)>0)
	ALERT:C41("Désolé, le tableau des numéros d'échantillons est déjà généré...")
Else 
	
	$Rang:=$1
	ARRAY TEXT:C222(TbNumEchRaema;0)
	CompteurHesitation:=0
	For ($Salé;1;5)
		RaemaGenereNumSerie ($Salé;$Rang)  // Les Séries 1
	End for 
	  // remplissons les tableaux par série
	RaemaEchFabriqueTbSeries 
	OBJECT SET VISIBLE:C603(BouImporteNumEch;(Size of array:C274(TbNumEchRaema)=0))
	
	  //$h2:=Nombre de millisecondes
	  //ALERTE(Chaine($H2-$H1))
	  //
	  //ALERTE("Le nombre de numéros de série refusés pour cause de doublon est "+Chaine(CompteurHesitation))
	TexteSup:=ZTableauVersTexte (->TbNumEchRaema)
End if 