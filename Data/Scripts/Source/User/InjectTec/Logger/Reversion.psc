Scriptname InjectTec:Logger:Reversion Hidden Const DebugOnly

String[] Function getTags() Global
	String[] tags = new String[1]
	tags[0] = "Reversion"
	return tags
EndFunction

Bool Function log(Form fTarget, Form fRemoving) Global
	return Loggout.log(InjectTec:Logger.getName(), "target: " + fTarget + " removing: " + fRemoving, getTags())
EndFunction

Bool Function warn(String sMessage) Global
	return Loggout.warn(InjectTec:Logger.getName(), sMessage, getTags())
EndFunction

Bool Function error(String sMessage) Global
	return Loggout.error(InjectTec:Logger.getName(), sMessage, getTags())
EndFunction

Bool Function leveled(Form fTarget) Global
	return Loggout.log(InjectTec:Logger.getName(), "leveled item: " + fTarget, getTags())
EndFunction

Bool Function logArray(Form fTarget, Form[] fRemovals) Global
	return Loggout.log(InjectTec:Logger.getName(), "target: " + fTarget + " removing: " + fRemovals, getTags())
EndFunction
