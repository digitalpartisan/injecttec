Scriptname InjectTec:Logger:Plugin Hidden Const DebugOnly

String[] Function getTags() Global
	String[] tags = new String[1]
	tags[0] = "Plugin"
	return tags
EndFunction

String Function buildLookupReference(String sFilename, Int iFormID) Global
	return "(" + sFilename + "," + iFormID + ")"
EndFunction

Bool Function log(String sMessage) Global
	;return Loggout.log(InjectTec:Logger.getName(), "target: " + fTarget + " adding: " + fAddition, getTags())
	return Loggout.log(InjectTec:Logger.getName(), sMessage, getTags())
EndFunction

Bool Function warn(String sMessage) Global
	return Loggout.warn(InjectTec:Logger.getName(), sMessage, getTags())
EndFunction

Bool Function error(String sMessage) Global
	return Loggout.error(InjectTec:Logger.getName(), sMessage, getTags())
EndFunction

Bool Function notInstalled(String sFilename) Global
	return error("file not found: " + sFilename) ; not always an error, but it is in almost every case
EndFunction

Bool Function lookupFailed(String sFilename, Int iFormID) Global
	return error("lookup failed: " + buildLookupReference(sFilename, iFormID))
EndFunction

Bool Function couldNotCast(String sFilename, Int iFormID, String sType) Global
	return error("could not cast lookup " + buildLookupReference(sFilename, iFormID) + " to " + sType)
EndFunction

Bool Function behaviorUndefined(InjectTec:Plugin pluginObject, String sBehavior) Global
	return warn(pluginObject + " " + sBehavior + " behavior is not defined")
EndFunction

Bool Function foundVersion(InjectTec:Plugin pluginObject, String sFilename) Global
	return log(pluginObject + " found installed version " + sFilename)
EndFunction

Bool Function noInstalledVersion(InjectTec:Plugin pluginObject) Global
	return log(pluginObject + " found no installed versions")
EndFunction
