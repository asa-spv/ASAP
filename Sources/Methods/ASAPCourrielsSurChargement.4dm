//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 15/01/19, 07:35:34
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPCourrielsSurChargement
  // Description
  // Méthode sur chargement de [CourrielsTypes];"Entrée"


  // déversement du contenu de [CourrielsTypes]TexteP2_ dans l'objet nommé RTA_Text
$PtrRichTextArea:=OBJECT Get pointer:C1124(Objet nommé:K67:5;"RTA_Text")
  //Si ([CourrielsTypes]TexteType="")
  //$PtrRichTextArea->:=Lire texte dans conteneur
  //Sinon 
$PtrRichTextArea->:=[CourrielsTypes:28]TexteType:5
  //Fin de si 

If ([CourrielsTypes:28]ContexteLettre:4=0)
	[CourrielsTypes:28]ContexteLettre:4:=21  // RAEMA sans facturation par défaut
End if 
RadAdh:=Num:C11(([CourrielsTypes:28]ContexteLettre:4=11) | ([CourrielsTypes:28]ContexteLettre:4=12))
RadRaema:=Num:C11(([CourrielsTypes:28]ContexteLettre:4=21) | ([CourrielsTypes:28]ContexteLettre:4=22))
RadDeux:=Num:C11(([CourrielsTypes:28]ContexteLettre:4=31) | ([CourrielsTypes:28]ContexteLettre:4=32))
RadFac:=Num:C11([CourrielsTypes:28]ContexteLettre:4%2=0)

  // Personnalisation du courrier
ARRAY TEXT:C222(TbValeursCourrielChamp;0)
ARRAY TEXT:C222(TbTableCourriel;0)
ARRAY TEXT:C222(TbContexteCourriel;0)
ARRAY TEXT:C222(TbExpressionsCourriel;0)

QUERY:C277([XData:1];[XData:1]XNom:2="Champs pour Courriels-types";*)
QUERY:C277([XData:1]; & [XData:1]XType:3="ChampsCourrielsTypes")
OB GET ARRAY:C1229([XData:1]XObjet:18;"Intitulé";TbValeursCourrielChamp)
OB GET ARRAY:C1229([XData:1]XObjet:18;"Table";TbTableCourriel)
OB GET ARRAY:C1229([XData:1]XObjet:18;"Contexte";TbContexteCourriel)
OB GET ARRAY:C1229([XData:1]XObjet:18;"Expression";TbExpressionsCourriel)

  // ASAPCourrielsGereContexte 

