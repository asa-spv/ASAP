//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/07/18, 19:41:21
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : RaemaSchemaBlanc
  // Description
  //  remet à zéro le dialogue

  // Tableau des n° de campagne
ARRAY TEXT:C222(TbNR;0)

  // Le tableau des rangs
ARRAY LONGINT:C221(TbRR;4)
For ($Salé;1;4)
	TbRR{$Salé}:=$Salé+1
End for 

  // Les tableaux des LB
ARRAY TEXT:C222(TbNomGermeFr;0)
ARRAY TEXT:C222(TbNomGermeEn;0)
ARRAY TEXT:C222(TbNomLigneFr;0)
ARRAY TEXT:C222(TbNomLigneEn;0)
ARRAY BOOLEAN:C223(TbMultiple;0)
ARRAY BOOLEAN:C223(TbEscamotable;0)
ARRAY TEXT:C222(TbValeurFr;0)
ARRAY TEXT:C222(TbValeurEn;0)
ARRAY BOOLEAN:C223(TbPrecision;0)
ARRAY BOOLEAN:C223(TbEscamotage;0)
ARRAY LONGINT:C221(TbNumEnrGerme;0)
ARRAY LONGINT:C221(TbNumEnrLigne;0)
ARRAY LONGINT:C221(TbNumEnrValeur;0)

OBJECT SET ENTERABLE:C238(TbNomGermeFr;False:C215)
OBJECT SET ENTERABLE:C238(TbNomGermeEn;False:C215)
OBJECT SET ENTERABLE:C238(TbNomLigneFr;False:C215)
OBJECT SET ENTERABLE:C238(TbNomLigneEn;False:C215)
OBJECT SET ENTERABLE:C238(TbValeurFr;False:C215)
OBJECT SET ENTERABLE:C238(TbValeurEn;False:C215)
  // Disparition des lignes des [RAEMAGermes]
OBJECT SET VISIBLE:C603(*;"Germe@";False:C215)
  // Disparition des [RAEMAValeurs]
OBJECT SET VISIBLE:C603(*;"Valeur@";False:C215)
