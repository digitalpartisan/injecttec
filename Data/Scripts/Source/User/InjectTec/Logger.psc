Scriptname InjectTec:Logger Hidden Const DebugOnly

String Function getName() Global
	return "InjectTec"
EndFunction

Bool Function log(String sMessage, String[] tags = None) Global
	return Jiffy:Loggout.log(getName(), sMessage, tags)
EndFunction

Bool Function warn(String sMessage, String[] tags = None) Global
	return Jiffy:Loggout.warn(getName(), sMessage, tags)
EndFunction

Bool Function error(String sMessage, String[] tags = None) Global
	return Jiffy:Loggout.error(getName(), sMessage, tags)
EndFunction
