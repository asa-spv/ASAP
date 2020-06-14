//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 17/04/14, 07:38:18
  // ----------------------------------------------------
  // Méthode : FIND_In_Array_BLOB
  // Description
  // Recherche la position d'un Blob dans un tableau de blobs
  //  $find:=FIND_In_Array_BLOB (->$TableauBLOBs;$MonBlob)
  // 
  // Paramètres
  // ----------------------------------------------------

C_POINTER:C301($1)
C_BLOB:C604($2)
C_LONGINT:C283($3)
C_LONGINT:C283($0)

ASSERT:C1129(Count parameters:C259>1)
ASSERT:C1129(Not:C34(Is nil pointer:C315($1)))
ASSERT:C1129(Type:C295($1->)=Est un tableau blob:K8:30)

C_LONGINT:C283($size;$position;$find;$start)
$size:=Size of array:C274($1->)
$position:=0
$find:=-1

If (Count parameters:C259>2)
	$start:=$3
	$position:=Choose:C955($start>=0;$start;0)
	$position:=Choose:C955($position<=$size;$position;$size)
End if 

$hash:=Generate digest:C1147($2;Digest SHA1:K66:2)
Repeat 
	$find:=Choose:C955(Generate digest:C1147($1->{$position};Digest SHA1:K66:2)=$hash;$position;$find)
	$position:=$position+1
Until (($find#-1) | ($position=$size))

$0:=$find