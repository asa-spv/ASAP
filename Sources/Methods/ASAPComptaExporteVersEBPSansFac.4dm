//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 29/05/13, 07:05:32
  // ----------------------------------------------------
  // Méthode : GA13Exporte4DVersComptaSansFac
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

  //$Doc:=$1
  //$FT:=Enregistrements trouvés([Ventes])
  //NumLigne:=1

  //$permmille:=Chaîne(Année de(Date du jour))
  //$Guil:=Caractère(Guillemets)
  //Boucle ($Salé;1;$FT)
  //CHERCHER([Factures];[Factures]NumFacture=[Ventes]NumFacture)
  //$Date:=Remplacer chaîne(Chaîne([Ventes]DateVente;Interne date court);"/";"")+","
  // chercher([Personnes];[Personnes]UUID=
  //CHERCHER([Adhérents];[Adhérents]NumAdhérent=[Ventes]CodeBénéficiaire)
  // $Or:=ASAPComptaDetermineOrigine
  //$Code400:=(Num($Or="F")*"412")+(Num($Or="D")*"413")+(Num($Or="E")*"414")
  //Au cas ou 
  //: ([Ventes]Intitulé="@cotisation@")
  //Si ([Ventes]NumFacture="@RT@")  // Raema tradition
  //$DebLigne:=Chaîne(NumLigne)+","+$Date+"VE"+","
  //NumLigne:=NumLigne+1
  //$Envoi:=$DebLigne+$Code400+",LA,"+$Guil+[Factures]NumFacture+" "+[Adhérents]IdentitéAdhérent+$Guil+","\
+$Guil+[Factures]NumFacture+$Guil+","+Remplacer chaîne(Chaîne([Factures]TotalTTC;"########0,00");",";".")+",D,3112"+$permmille+Caractère(Retour chariot)
  //ENVOYER PAQUET($Doc;$Envoi)


  //$DebLigne:=Chaîne(NumLigne)+","+$Date+"VE"+","
  //NumLigne:=NumLigne+1
  //$Envoi:=$DebLigne+"706109"+",LA,"+$Guil+[Factures]NumFacture+" cotisation "+$permmille+" "+[Adhérents]IdentitéAdhérent+$Guil+","\
+$Guil+[Factures]NumFacture+$Guil+","+Remplacer chaîne(Chaîne([Ventes]PrixTTC;"########0,00");",";".")+",C,3112"+$permmille+Caractère(Retour chariot)
  //ENVOYER PAQUET($Doc;$Envoi)

  //Sinon   // Cotisation individuelle
  //$Civil:=(Num([Adhérents]Civilités="Mad@")*"Mme")+(Num([Adhérents]Civilités="Mon@")*"Mr")
  //$Desc:="Cotis "+$permmille+" "+$Civil+" "+[Adhérents]IdentitéAdhérent+" "+[Adhérents]Prénom
  //Si (Longueur($Desc)>38)
  //$desc:=Sous chaîne($Desc;1;38)
  //Fin de si 
  //$DebLigne:=Chaîne(NumLigne)+","+$Date+"VE"+","
  //NumLigne:=NumLigne+1
  //$Envoi:=$DebLigne+"410"+",LA,"+$Guil+$Desc+$Guil+","\
+$Guil+[Factures]NumFacture+$Guil+","+Remplacer chaîne(Chaîne([Ventes]PrixTTC;"########0,00");",";".")+",D,3112"+$permmille+Caractère(Retour chariot)
  //ENVOYER PAQUET($Doc;$Envoi)

  //$DebLigne:=Chaîne(NumLigne)+","+$Date+"VE"+","
  //NumLigne:=NumLigne+1
  //$Envoi:=$DebLigne+"7061"+",LA,"+$Guil+$Desc+$Guil+","\
+$Guil+""+$Guil+","+Remplacer chaîne(Chaîne([Ventes]PrixTTC;"########0,00");",";".")+",C,3112"+$permmille+Caractère(Retour chariot)
  //ENVOYER PAQUET($Doc;$Envoi)

  //Fin de si 


  //: ([Ventes]Intitulé="@abonnement@") | ([Ventes]Intitulé="@colis sup@")
  //$Code700:=(Num($Or="F")*"706019")+(Num($Or="D")*"706021")+(Num($Or="E")*"706029")
  //Si ([Ventes]NumFacture="@RT@")  // Raema tradition
  //CHERCHER([Factures];[Factures]NumFacture=[Ventes]NumFacture)
  //CHERCHER([Adhérents];[Adhérents]NumAdhérent=[Factures]CodeBénéficiaire)
  //$DebLigne:=Chaîne(NumLigne)+","+$Date+"VE"+","
  //NumLigne:=NumLigne+1
  //$Envoi:=$DebLigne+$Code700+",LA,"+$Guil+[Factures]NumFacture+" "+[Adhérents]IdentitéAdhérent+$Guil+","\
+$Guil+[Factures]NumFacture+$Guil+","+Remplacer chaîne(Chaîne([Ventes]PrixTHT;"########0,00");",";".")+",C,3112"+$permmille+Caractère(Retour chariot)
  //ENVOYER PAQUET($Doc;$Envoi)
  //$TVA:=[Ventes]PrixTTC-[Ventes]PrixTHT
  //Si ($TVA>0) & ($Or="F")
  //$DebLigne:=Chaîne(NumLigne)+","+$Date+"VE"+","
  //NumLigne:=NumLigne+1
  //$Envoi:=$DebLigne+"44573"+",LA,"+$Guil+[Factures]NumFacture+" "+[Adhérents]IdentitéAdhérent+$Guil+","\
+$Guil+[Factures]NumFacture+$Guil+","+Remplacer chaîne(Chaîne($TVA;"########0,00");",";".")+",C,3112"+$permmille+Caractère(Retour chariot)
  //ENVOYER PAQUET($Doc;$Envoi)
  //Fin de si 

  //Fin de si 

  //Sinon 

  //VarManque:=VarManque+"Vente du "+Chaîne([Ventes]DateVente;Interne date court)\
+" n° de facture "+[Ventes]NumFacture+" à "+[Adhérents]IdentitéAdhérent\
+" pour un montant de  "+Chaîne([Ventes]PrixTHT;"### ### ##0,00")+"€ HT"+Caractère(Retour chariot)
  //Fin de cas 



  //ENREGISTREMENT SUIVANT([Ventes])
  //Fin de boucle 
