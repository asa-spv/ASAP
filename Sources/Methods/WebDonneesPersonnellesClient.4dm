//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 20/10/19, 07:50:07
  // ----------------------------------------------------
  // Méthode : WebDonneesPersonnellesClient
  // Description
  // 
  //
  // Paramètre $1 = message du Web  type "DonneesPersonnelles123"
  //           $2 = langue choisie par l'utilisateur
  //           $3 = UUID du laboratoire
  //           $4 = Ligne dans les tableaux généraux des personnes
  // ----------------------------------------------------

$Mess:=$1
$Langue:=$2
$UUID:=$3
$LigneTbGnxA:=$4

$LigneTbGnx:=Num:C11($LigneTbGnxA)
  // les variables utilisés dans les données personnelles
VarNomPersonneContact:=<>TbPANomContact{$LigneTbGnx}
VarAdresseLivraison:="<br  />"+<>TbPerAdrLivAd1{$LigneTbGnx}\
+(Num:C11(<>TbPerAdrLivAd2{$LigneTbGnx}#"")*("<br  />"+<>TbPerAdrLivAd2{$LigneTbGnx}))\
+(Num:C11(<>TbPerAdrLivAd3{$LigneTbGnx}#"")*("<br  />"+<>TbPerAdrLivAd3{$LigneTbGnx}))\
+(Num:C11(Length:C16(<>TbPerAdrLivCP{$LigneTbGnx}+<>TbPerAdrLivVille{$LigneTbGnx})>0)*("<br  />"+<>TbPerAdrLivCP{$LigneTbGnx}+"-"+<>TbPerAdrLivVille{$LigneTbGnx}))\
+(Num:C11(<>TbPerAdrLivPays{$LigneTbGnx}#"")*("<br  />"+<>TbPerAdrLivPays{$LigneTbGnx}))
VarPhoneContact:=<>TbPAPhonePro{$LigneTbGnx}
VarFaxContact:=<>TbPAFaxPro{$LigneTbGnx}
VarNomPersonneFacturation:=<>TbPANomContact{$LigneTbGnx}
VarAdresseFacturation:="<br  />"+<>TbPerAdrFacAd1{$LigneTbGnx}\
+(Num:C11(<>TbPerAdrFacAd2{$LigneTbGnx}#"")*("<br  />"+<>TbPerAdrFacAd2{$LigneTbGnx}))\
+(Num:C11(<>TbPerAdrFacAd3{$LigneTbGnx}#"")*("<br  />"+<>TbPerAdrFacAd3{$LigneTbGnx}))\
+(Num:C11(Length:C16(<>TbPerAdrFacCP{$LigneTbGnx}+<>TbPerAdrFacVille{$LigneTbGnx})>0)*("<br  />"+<>TbPerAdrFacCP{$LigneTbGnx}+"-"+<>TbPerAdrFacVille{$LigneTbGnx}))\
+(Num:C11(<>TbPerAdrFacPays{$LigneTbGnx}#"")*("<br  />"+<>TbPerAdrFacPays{$LigneTbGnx}))
VarPhoneFacturation:=<>TbPAPhonePro{$LigneTbGnx}
VarFaxFacturation:=<>TbPAFaxPro{$LigneTbGnx}
VarMailPersonneFacturation:=<>TbPANomContact{$LigneTbGnx}  // Voir avec CGM adresse facturation
VarMailPersonneRapport:=<>TbPAEmailRAEMA{$LigneTbGnx}
VarMailPersonneCommunication:=<>TbPAEMail{$LigneTbGnx}
$THTML:=WebEspaceHTMLDonneesPerso ($Langue;$UUID)
WEB SEND TEXT:C677($THTML)