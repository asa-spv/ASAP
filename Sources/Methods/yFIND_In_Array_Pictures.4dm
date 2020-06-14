//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 17/04/14, 07:39:24
  // ----------------------------------------------------
  // Méthode : FIND_In_Array_Pictures
  // Description
  // Recherche la position d'une image dans un tableau d'images
  //  $find:=FIND_In_Array_Pictures (->$TableauPicturess;$MonImage)
  // 
  // Paramètres
  // ----------------------------------------------------

C_POINTER:C301($1)
C_PICTURE:C286($2)
C_LONGINT:C283($3)
C_LONGINT:C283($0)

ASSERT:C1129(Count parameters:C259>1)
ASSERT:C1129(Not:C34(Is nil pointer:C315($1)))
ASSERT:C1129(Type:C295($1->)=Est un tableau image:K8:22)

ARRAY PICTURE:C279($images;0)
  //%W-518.1
COPY ARRAY:C226($1->;$images)  //ref-counted, no penalty here
  //%W+518.1
C_PICTURE:C286($image;$mask)
$image:=$2  //or here

C_LONGINT:C283($size;$position;$find;$start)
$size:=Size of array:C274($images)
$position:=0
$find:=-1

If (Count parameters:C259>2)
	$start:=$3
	$position:=Choose:C955($start>=0;$start;0)
	$position:=Choose:C955($position<=$size;$position;$size)
End if 

Repeat 
	$find:=Choose:C955(Equal pictures:C1196($images{$position};$image;$mask);$position;$find)
	$position:=$position+1
Until (($find#-1) | ($position=$size))

$0:=$find