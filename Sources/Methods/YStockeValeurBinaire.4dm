//%attributes = {"publishedWeb":true}
  //  //YSockeValeurBinaire
  //  //Fonction qui retourne l'état d'une valeur Binaire dans pour une table Données
  //  //Une valriable Entier Long est constituée de 32 bits, numéroté de 0 à 31
  //  //Le Bit 0 est peu utilisé, cela permet de numéroter 31 champs, voire 32
  //  //si l'on utilise un décalage Binaire

  //C_POINTEUR($1;$PtTable)  //Champ sur laquelle on désire travailler
  //_o_C_ALPHA(1;$2;$Opérateur)  //Opérateur "+" "-" "?"
  //C_ENTIER LONG($Mavariable;$NumTable)  //Valeur variant de 0 à 31
  //_o_C_ENTIER($0)  //0 ou 1

  //$NumTable:=Table($1)
  //$PtTable:=Table($NumTable)
  //$Champ:=Champ($1)
  //$Opérateur:=$2
  //$0:=0  //En cas d'erreur


  //Si ($Champ>31) | ($Champ<0)
  //ALERTE("Le numéro du champ doit être <32 ! ")
  //Sinon 
  //  //On recherche la fiche spécifique à $1 
  //CHERCHER(;="Bit";*)
  //CHERCHER(; & =Chaîne($NumTable))
  //LECTURE ÉCRITURE()
  //Si (Enregistrements trouvés()=0)
  //CRÉER ENREGISTREMENT()
  //:=Chaîne($NumTable)
  //:="Bit"
  //:=0  //Tous les Bits sont à 0
  //STOCKER ENREGISTREMENT()
  //Sinon 
  //ZVerrouAttendre (->)
  //$MaVariable:=  //On Charge la variable
  //Fin de si 

  //Au cas ou 
  //: ($Opérateur="+")  //Met à 1 le Bit
  //$MaVariable:=$MaVariable ?+ $Champ
  //$0:=1

  //: ($Opérateur="-")  //Met à Zéro le bit
  //$MaVariable:=$MaVariable ?- $Champ
  //$0:=0

  //: ($Opérateur="?")  //Interroge sur la valeur du bit
  //$0:=Num($MaVariable ?? $Champ)  //Vrai si =1 ; Faux si=0

  //Fin de cas 

  //:=$MaVariable
  //STOCKER ENREGISTREMENT()
  //LECTURE SEULEMENT()
  //LIBÉRER ENREGISTREMENT()
  //Fin de si 
