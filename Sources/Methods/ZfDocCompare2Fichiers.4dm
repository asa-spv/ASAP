//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 27/04/14, 15:41:53
  // ----------------------------------------------------
  // Méthode : FILE_Compare2Fichiers
  // Description: Determines two files are identical using the MD5 digest.
  //
  // Input:
  // $1 (text) - Path of the first file
  // $2 (text) - Path of the second file
  //
  // Output:
  // $0 (boolean)- true (files are the same) or false (files are not the same)
  // ---------------------------------------------------------------------------

C_BOOLEAN:C305($0)
C_TEXT:C284($1;$2;$file1_path_t;$file2_path_t)
C_TEXT:C284($md5_result1;$md5_result2)
C_BLOB:C604($file_blob1;$file_blob2)

If (Count parameters:C259>=2)
	$file1_path_t:=$1
	$file2_path_t:=$2
	
	If (Test path name:C476($file1_path_t)=Est un document:K24:1) & \
		(Test path name:C476($file2_path_t)=Est un document:K24:1)
		
		DOCUMENT TO BLOB:C525($file1_path_t;$file_blob1)
		DOCUMENT TO BLOB:C525($file2_path_t;$file_blob2)
		
		$md5_result1:=Generate digest:C1147($file_blob1;Digest MD5:K66:1)  // create digest key
		$md5_result2:=Generate digest:C1147($file_blob2;Digest MD5:K66:1)  // create digest key
		
		$0:=($md5_result1=$md5_result2)  // Compare if they are the same
	End if 
End if 