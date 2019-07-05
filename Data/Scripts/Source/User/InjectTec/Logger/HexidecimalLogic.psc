Scriptname InjectTec:Logger:HexidecimalLogic

String[] Function getTags() Global
	String[] tags = new String[1]
	tags[0] = "Hexidecimal"
	return tags
EndFunction

Bool Function log(String sMessage) Global
	return Loggout.log(InjectTec:Logger.getName(), sMessage, getTags())
EndFunction

Bool Function warn(String sMessage) Global
	return Loggout.warn(InjectTec:Logger.getName(), sMessage, getTags())
EndFunction

Bool Function error(String sMessage) Global
	return Loggout.error(InjectTec:Logger.getName(), sMessage, getTags())
EndFunction

Bool Function logDigitSetCompuation(InjectTec:Utility:HexidecimalLogic:DigitSet digits, Int iResult) Global
	return log(InjectTec:Utility:HexidecimalLogic.digitSetToString(digits) + " = " + iResult)
EndFunction
