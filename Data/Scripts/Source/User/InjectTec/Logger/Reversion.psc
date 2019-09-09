Scriptname InjectTec:Logger:Reversion Hidden Const DebugOnly

String[] Function getTags() Global
	String[] tags = new String[1]
	tags[0] = "Reversion"
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

Bool Function reverting(Form fTarget, Form fRemoving) Global
	return log("target: " + fTarget + " removing: " + fRemoving)
EndFunction

Bool Function leveled(Form fTarget) Global
	return log("leveled item: " + fTarget)
EndFunction

Bool Function logArray(Form fTarget, Form[] faRemovals) Global
	return log("target: " + fTarget + " removing: " + faRemovals)
EndFunction
