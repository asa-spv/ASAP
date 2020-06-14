//%attributes = {"invisible":true}
C_TEXT:C284($Text;$subText)  //Text containers
C_POINTER:C301($Col_p)  //points to the ListBox columns
C_LONGINT:C283($cr_position_i;$delimiter_position_i;$col_num_i;$counter_i)
  //C_BOOLEAN($flag)


Case of 
	: (Form event code:C388=Sur déposer:K2:12)
		$Text:=Get text from pasteboard:C524
		$col_num_i:=0
		Repeat   //loop for rows
			$cr_position_i:=Position:C15(Char:C90(Retour chariot:K15:38);$Text)  //find the position of the carriage return
			  //To make the method MAC compatible
			If ($cr_position_i>0)
				$subText:=Substring:C12($Text;1;$cr_position_i-1)  //take the first row
				  //$flag:=True
			Else 
				$subText:=$Text
				  //$flag:=False
			End if 
			
			
			$col_num_i:=$col_num_i+1
			$counter_i:=1  //reset the counter for array elements
			Repeat   //loop for columns
				$delimiter_position_i:=Position:C15(Char:C90(9);$subText)  //find the position of Tab delimeter
				$Col_p:=Get pointer:C304("TbCol"+String:C10($counter_i))
				If ($delimiter_position_i>0)  //check for delimetere because of the last element
					APPEND TO ARRAY:C911($Col_p->;Substring:C12($subText;1;$delimiter_position_i-1))
					
				Else 
					APPEND TO ARRAY:C911($Col_p->;$subText)  //append the last element
				End if 
				$subText:=Delete string:C232($subText;1;Length:C16($Col_p->{$col_num_i})+1)  //delete the element + delimeter
				$counter_i:=$counter_i+1
			Until ($delimiter_position_i=0)
			$Text:=Delete string:C232($Text;1;$cr_position_i)  //delete the firs row
		Until ($cr_position_i=0)
		  //Until ($flag=False)
End case 