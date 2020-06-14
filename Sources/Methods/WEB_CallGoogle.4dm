//%attributes = {"invisible":true}
  //  // ----------------------------------------------------
  //  // Nom utilisateur (OS) : 
  //  // Date et heure : 10/10/10, 23:34:02
  //  // ----------------------------------------------------
  //  // Méthode : WEB_CallGoogle
  //  // Description

  //  //$1 URL de l'agenda google
  //  //$2 Nom utilisateur Google
  //  //$3 MDP Google
  //  //$4 Durée Moyenne d'un RDV (si durée =0 par défaut durée est égale à 30)
  //  //$5 Nom pour ajouter un RDV (Texte)
  //  //$6 Déscription pout la création d'un RDV (Texte)
  //  //$7 Date départ
  //  //$8 Date Fin
  //  //$9 Heure Départ
  //  //$10 Heure Fin
  //  //$11 Nom du serveur SMTP en cas d'erreur pour recevoir un mail
  //  //$12 Nom de l'emetteur du Mail From
  //  //$13 Nom du destinataire du Mail To
  //  //
  //  // Paramètres
  //  // ----------------------------------------------------


  //C_TEXTE($1;$2;$3;$5)
  //C_TEXTE($6;$11;$12;$13)
  //C_TEXTE(<>CalendarCompte;<>CalendarMDP;Tx_Nom)
  //C_TEXTE(t_serveurSMTP;t_MailFrom;t_MailTo)
  //C_ENTIER LONG($4;Duree_Moyenne_RDV)
  //C_DATE($7;$8)
  //C_DATE(d_start_rdv;d_fin_rdv)
  //C_HEURE($9;$10)
  //C_HEURE(h_start_rdv;h_fin_rdv)

  //Si (Nombre de paramètres=13)
  //$URLGoogleCal:=$1
  //<>CalendarCompte:=$2  // Juste pour ne pas modifier la méthode au début
  //<>CalendarMDP:=$3  // Juste pour ne pas modifier la méthode au début
  //Duree_Moyenne_RDV:=$4
  //Tx_Nom:=$5
  //(OBJET Lire pointeur(Objet nommé;"Tx_Description"))->:=$6
  //d_start_rdv:=$7
  //d_fin_rdv:=$8
  //h_start_rdv:=$9
  //h_fin_rdv:=$10
  //t_serveurSMTP:=$11
  //t_MailFrom:=$12
  //t_MailTo:=$13

  //Si ($URLGoogleCal#"") & (<>CalendarCompte#"") & (<>CalendarMDP#"")
  //Duree_Moyenne_RDV:=(Num(Duree_Moyenne_RDV<=0)*30)+(Num(Duree_Moyenne_RDV>0)*Duree_Moyenne_RDV)
  //Si (d_start_rdv=!00/00/0000!)
  //d_start_rdv:=<>ZDateDuJour
  //Fin de si 
  //Si (d_fin_rdv=!00/00/0000!)
  //d_fin_rdv:=d_start_rdv
  //Fin de si 

  //$ok:=Créer fenêtre formulaire("GoogleCal";Form dialogue modal;Centrée horizontalement;Centrée verticalement)
  //DIALOGUE(;"Google_Cal")
  //FERMER FENÊTRE
  //Fin de si 
  //Sinon 
  //ALERTE("ERREUR : manquent des parametres")
  //Fin de si 