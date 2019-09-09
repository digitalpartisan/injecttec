Scriptname InjectTec:Logger:HexidecimalLogic

String[] Function getTags() Global
	String[] tags = new String[1]
	tags[0] = "Hexidecimal"
	return tags
EndFunction

Bool Function log(String sMessage) Global
	return InjectTec:Logger.log(sMessage, getTags())
EndFunction

Bool Function warn(String sMessage) Global
	return InjectTec:Logger.warn(sMessage, getTags())
EndFunction

Bool Function error(String sMessage) Global
	return InjectTec:Logger.error(sMessage, getTags())
EndFunction

Bool Function logDigitSetCompuation(InjectTec:Utility:HexidecimalLogic:DigitSet digits, Int iResult) Global
	return log(InjectTec:Utility:HexidecimalLogic.digitSetToString(digits) + " = " + iResult)
EndFunction
