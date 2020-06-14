  //$1 Texte URL
  //$2 Texte En-tête+Corps HTTP(dans la limite des 32 ko)
  //$3 Texte Adresse IP du navigateur
  //$4 Texte Adresse IP appelée du serveur 
  //$5 Texte Nom d’utilisateur
  //$6 Texte Mot de passe
  //$0 Booleen Vrai=requete acceptee, Faux=requete rejetee



C_TEXT:C284($1;$2;$3;$4;$5;$6)
C_BOOLEAN:C305($0)
$Pos:=Position:C15("Host";$2)+6
If ($Pos>0)
	$SC:=Substring:C12($2;$Pos)
	$Pos:=Position:C15(Char:C90(10);$SC)-1
	<>IDInternet:=Substring:C12($SC;1;$Pos)
	  //◊IDInternet:="217.128.218.16"
End if 

