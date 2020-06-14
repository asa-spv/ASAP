//%attributes = {"invisible":true}
  //  // ----------------------------------------------------
  //  // Nom utilisateur (OS) : Patrick EMANUEL
  //  // Date et heure : 29/10/12, 18:57:49
  //  // ----------------------------------------------------
  //  // Méthode : BASE_GenereCleBLOB
  //  // Description
  //  // 
  //  //
  //  // Paramètres
  //  // ----------------------------------------------------


  //C_BLOB(<>ClePublique;<>ClePrivee)

  //CHERCHER(;="ClePrivee")

  //Si (Enregistrements trouvés()=0)  //La clé n'existe pas.
  //GÉNÉRER CLÉS CRYPTAGE(<>ClePrivee;<>ClePublique)
  //CRÉER ENREGISTREMENT()
  //:="ClePrivee"
  //:=<>ClePrivee
  //STOCKER ENREGISTREMENT()

  //Sinon 
  //<>ClePrivee:=
  //Fin de si 

  //CHERCHER(;="ClePublique")
  //Si (Enregistrements trouvés()=0)
  //CRÉER ENREGISTREMENT()
  //:="ClePublique"
  //:=<>ClePublique
  //STOCKER ENREGISTREMENT()
  //Sinon 
  //<>ClePublique:=
  //Fin de si 

  //ZAmnistiePartielle (->)