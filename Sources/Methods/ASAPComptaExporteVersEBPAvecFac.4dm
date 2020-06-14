//%attributes = {}

  //  // ----------------------------------------------------
  //  // Nom utilisateur (OS) : ASA
  //  // Date et heure : 29/05/13, 07:07:21
  //  // ----------------------------------------------------
  //  // Méthode : GA13Exporte4DVersComptaAvecFac
  //  // Description
  //  // 
  //  //
  //  // Paramètres
  //  // ----------------------------------------------------
  //$Doc:=$1
  //$FT:=Enregistrements trouvés([Ventes])
  //$Guil:=Caractère(Guillemets)
  //$AnA:="20"+<>ZPermMille
  //$DerjourAn:="3112"+$AnA
  //TRIER([Ventes];[Ventes]NumFacture;>)
  //TABLEAU TEXTE($TbManques;0)
  //TABLEAU ENTIER LONG($TbOcc;0)
  //Tant que (Non(Fin de sélection([Ventes])))
  //$NumFac:=[Ventes]NumFacture
  //CHERCHER([Factures];[Factures]NumFacture=[Ventes]NumFacture)
  //CHERCHER([Adhérents];[Adhérents]NumAdhérent=[Ventes]CodeBénéficiaire)
  // $Or:=ASAPComptaDetermineOrigine
  //$Code400:=(Num($Or="F")*"412")+(Num($Or="D")*"414")+(Num($Or="E")*"413")
  //$Code700:=(Num($Or="F")*"706019")+(Num($Or="D")*"706029")+(Num($Or="E")*"706021")
  //$TTC:=0
  //$Trouve:=Vrai
  //Tant que (Non(Fin de sélection([Ventes])) & ($NumFac=[Ventes]NumFacture))
  //$Date:=Remplacer chaîne(Chaîne([Factures]Datefacture;Interne date court);"/";"")+","
  //Si ([Ventes]PrixTHT#0) & ([Ventes]NumFacture#"@D") & ([Ventes]NumFacture#"") & ([Factures]Devis=Faux) & ([Factures]Datefacture#!00/00/0000!)
  //Au cas ou 
  //: ([Ventes]Intitulé="@cotisation@") & ([Ventes]NumFacture="@R@")  // Cotisation liée au Raema tradition
  //$DebLigne:=Chaîne(NumLigne)+","+$Date+"VE"+","
  //NumLigne:=NumLigne+1
  //$Desc:=[Ventes]NumFacture+" Cotis labo "+$AnA+" "+[Adhérents]IdentitéAdhérent
  //Si (Longueur($Desc)>38)
  //$desc:=Sous chaîne($Desc;1;38)
  //Fin de si 
  //$Envoi:=$DebLigne+"706109"+",LA,"+$Guil+$desc+$Guil+","+$Guil+[Factures]NumFacture+$Guil+","\
+Remplacer chaîne(Chaîne([Ventes]PrixTTC;"########0,00");",";".")+",C,"+$DerjourAn+Caractère(Retour chariot)
  //ENVOYER PAQUET($Doc;$Envoi)

  //: ([Ventes]Intitulé="@cotisation@") & ([Ventes]NumFacture#"@R@")  // Cotisation individuelle
  //$Civil:=(Num([Adhérents]Civilités="Mad@")*"Mme")+(Num([Adhérents]Civilités="Mon@")*"Mr")
  //$Desc:="Cotis "+$AnA+" "+[Ventes]NumFacture+" "+$Civil+" "+[Adhérents]IdentitéAdhérent+" "+[Adhérents]Prénom
  //Si (Longueur($Desc)>38)
  //$desc:=Sous chaîne($Desc;1;38)
  //Fin de si 
  //$DebLigne:=Chaîne(NumLigne)+","+$Date+"VE"+","
  //NumLigne:=NumLigne+1
  //$Envoi:=$DebLigne+"7061"+",LA,"+$Guil+$Desc+$Guil+","\
+$Guil+[Factures]NumFacture+$Guil+","+Remplacer chaîne(Chaîne([Ventes]PrixTHT;"########0,00");",";".")+",C,"+$DerjourAn+Caractère(Retour chariot)
  //ENVOYER PAQUET($Doc;$Envoi)

  //: (([Ventes]Intitulé="@abonnement@") | ([Ventes]Intitulé="@colis@") | ([Ventes]Intitulé="@frais@") | ([Ventes]Intitulé="@port@") | ([Ventes]Intitulé="@chanti@") | ([Ventes]Intitulé="@analyse@") | ([Ventes]Intitulé="@boite@") | ([Ventes]Intitulé="@pot@") | ([Ventes]Intitulé="@gel@"))  // Raema tradition et gel
  //$DebLigne:=Chaîne(NumLigne)+","+$Date+"VE"+","
  //NumLigne:=NumLigne+1
  //$CodePrest:=(Num([Ventes]NumFacture="@R@")*$Code700)+(Num([Ventes]NumFacture#"@R@")*"7064")  // distinction des prestation dans et hors RAEMA
  //$Envoi:=$DebLigne+$CodePrest+",LA,"+$Guil+[Factures]NumFacture+" "+[Adhérents]IdentitéAdhérent+$Guil+","\
+$Guil+[Factures]NumFacture+$Guil+","+Remplacer chaîne(Chaîne([Ventes]PrixTHT;"########0,00");",";".")+",C,"+$DerjourAn+Caractère(Retour chariot)
  //ENVOYER PAQUET($Doc;$Envoi)
  //$TVA:=[Ventes]PrixTTC-[Ventes]PrixTHT
  //Si ($TVA#0)  // & ($Or="F")
  //$DebLigne:=Chaîne(NumLigne)+","+$Date+"VE"+","
  //NumLigne:=NumLigne+1
  //$Envoi:=$DebLigne+"44573"+",LA,"+$Guil+[Factures]NumFacture+" "+[Adhérents]IdentitéAdhérent+$Guil+","\
+$Guil+[Factures]NumFacture+$Guil+","+Remplacer chaîne(Chaîne($TVA;"########0,00");",";".")+",C,"+$DerjourAn+Caractère(Retour chariot)
  //ENVOYER PAQUET($Doc;$Envoi)
  //Fin de si 

  //: ([Ventes]Intitulé="@asadia@")
  //$DebLigne:=Chaîne(NumLigne)+","+$Date+"VE"+","
  //NumLigne:=NumLigne+1
  //$Envoi:=$DebLigne+"706016"+",LA,"+$Guil+[Factures]NumFacture+" "+[Adhérents]IdentitéAdhérent+$Guil+","\
+$Guil+[Factures]NumFacture+$Guil+","+Remplacer chaîne(Chaîne([Ventes]PrixTHT;"########0,00");",";".")+",C,"+$DerjourAn+Caractère(Retour chariot)
  //ENVOYER PAQUET($Doc;$Envoi)
  //$TVA:=[Ventes]PrixTTC-[Ventes]PrixTHT
  //Si ($TVA#0)  // & ($Or="F")
  //$DebLigne:=Chaîne(NumLigne)+","+$Date+"VE"+","
  //NumLigne:=NumLigne+1
  //$Envoi:=$DebLigne+"44573"+",LA,"+$Guil+[Factures]NumFacture+" "+[Adhérents]IdentitéAdhérent+$Guil+","\
+$Guil+[Factures]NumFacture+$Guil+","+Remplacer chaîne(Chaîne($TVA;"########0,00");",";".")+",C,"+$DerjourAn+Caractère(Retour chariot)
  //ENVOYER PAQUET($Doc;$Envoi)
  //Fin de si 

  //Sinon 
  //VarManque:=VarManque+"Vente intitulé "+[Ventes]Intitulé+" du "+Chaîne([Ventes]DateVente;Interne date court)\
+" n° de facture "+[Ventes]NumFacture+" à "+[Adhérents]IdentitéAdhérent\
+" pour un montant de  "+Chaîne([Ventes]PrixTHT;"### ### ##0,00")+"€ HT"+Caractère(Retour chariot)
  //NumLigne:=NumLigne-1
  //$Trouve:=Faux
  //Fin de cas 
  //$TTC:=$TTC+(Num($Trouve)*Arrondi([Ventes]PrixTTC;2))
  //Fin de si 
  //ENREGISTREMENT SUIVANT([Ventes])
  //Fin tant que 
  //Si ($Trouve) & ($TTC#0)
  //$DebLigne:=Chaîne(NumLigne)+","+$Date+"VE"+","
  //NumLigne:=NumLigne+1
  //$Envoi:=$DebLigne+$Code400+",LA,"+$Guil+[Factures]NumFacture+" "+[Adhérents]IdentitéAdhérent+$Guil+","\
+$Guil+[Factures]NumFacture+$Guil+","+Remplacer chaîne(Chaîne($TTC;"########0,00");",";".")+",D,"+$DerjourAn+Caractère(Retour chariot)
  //ENVOYER PAQUET($Doc;$Envoi)
  //Fin de si 

  //Fin tant que 