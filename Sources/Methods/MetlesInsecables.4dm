//%attributes = {"publishedWeb":true}
  // MetlesInsecables
  // `remplace les espaces par des espaces insécables
  // $1 = chaine à traiter

$0:=Replace string:C233($1;" ";Char:C90(160))