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

Bool Function logDigitSetCompuation(InjectTec:HexidecimalLogic:DigitSet digits, Int iFive, Int iFour, Int iThree, Int iTwo, Int iOne, Int iZero, Int iResult) Global
	return log(InjectTec:HexidecimalLogic.digitSetToString(digits) + " = " + iFive + " + " + iFour + " + " + iThree + " + " + iTwo + " + " + iOne + " + " + iZero + " = " + iResult)
EndFunction
