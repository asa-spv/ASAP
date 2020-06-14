//%attributes = {"publishedWeb":true}
If (False:C215)
	  //Méthode : ZGENE_VersionLangage4D
	  //Détermine si l'on travaille avec un 4D Français ; Anglais ou Italien
	  //Crée le 14/10/98 par Vincent de Lachaux
End if 
  //
_O_C_STRING:C293(4;$0)
  //
Case of 
	: (Get indexed string:C510(42;3)="Sinon")  //Français
		$0:="_Fr"
	: (Get indexed string:C510(42;3)="Else")  //Anglais
		$0:="_US"
	: (Get indexed string:C510(42;3)="Si no")  //Italien
		$0:="_US"
	Else 
		$0:="_US"
End case 