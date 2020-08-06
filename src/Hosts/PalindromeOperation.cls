/// Custom Ensemble Business Operation for outputting the longest palindrome results
Class src.Hosts.PalindromeOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Property Adapter As EnsLib.File.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method SplitPalindrome(pRequest As Ens.StreamContainer, Output pResponse As Ens.StringResponse) As %Status
{
	
	try{
		
		set tSC = $$$OK
		
		set ^longestPalindrome = ""
		
		set tString = pRequest.Stream.Read()
		
		set filename = ..Adapter.FilePath_$HOROLOG_".txt"
		set file = ##class(%File).%New(filename)
		do file.Open("NW")
		
		for i = 1:1:$L(tString, ",")
		{
			set cString = $ZSTRIP($P(tString,",",i),"<>W")
			
			set firsthalf = $NORMALIZE($L(cString)/2, 0)
			set lasthalf = $NORMALIZE($L(cString)/2 - 1, 0)
			
			set x = $E(cString, 1, firsthalf)
			
			set y = $E(cString, *-lasthalf, *)
			
			if (x = $REVERSE(y))
			{
				do file.Write(cString_" Is A Palindrome"_$CHAR(13)_$CHAR(10))
				do file.%Save()

				if ($L(cString) > $L(^longestPalindrome))
				{
					set ^longestPalindrome = cString
				}
				
			}
			else{

				$$$TRACE("Not A Palindrome"_x_"-"_y)
				
			}
		}
		
		do file.Close()
		
		$$$TRACE(^longestPalindrome)
		
		set pResponse = ##class(Ens.StringResponse).%New()
		
		set pResponse.StringValue = "Success"
		
	}
	catch{
		if $$$ISERR(exception.AsStatus()){	
			set tSC = exception.AsStatus()
			}
		
	}

	Quit tSC
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Ens.StreamContainer"> 
		<Method>SplitPalindrome</Method>
	</MapItem>
</MapItems>
}


}
