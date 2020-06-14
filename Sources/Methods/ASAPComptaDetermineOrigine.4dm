//%attributes = {}
  //  // GA13DetermineOrigine
  //  // Premet de savoir où (France métro, DOM-TOM ou étranger) est le client de la dépense

  //Si ([Adhérents]FacturationPays#"")
  //$0:=(Num([Adhérents]FacturationPays="E@")*"E")+(Num([Adhérents]FacturationPays="O@")*"D")+(Num([Adhérents]FacturationPays="F@")*"F")
  //Sinon 
  //Au cas ou 
  //: (([Adhérents]Pays="france") | ([Adhérents]Pays="")) & ([Adhérents]CodePostalProfessionnel<"97000")
  //$0:="F"

  //: ([Adhérents]CodePostalProfessionnel<"97000")
  //$0:="D"
  //Sinon 

  //$0:="E"
  //Fin de cas 
  //Fin de si 
