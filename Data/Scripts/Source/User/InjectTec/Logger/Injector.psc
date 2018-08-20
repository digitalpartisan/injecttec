Scriptname InjectTec:Logger:Injector Hidden Const DebugOnly

String[] Function getTags() Global
	String[] tags = new String[1]
	tags[0] = "Injector"
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

Bool Function behaviorUndefined(InjectTec:Injector injectorObject, String sBehavior) Global
	return warn(injectorObject + " " + sBehavior + " behavior is not defined")
EndFunction

Bool Function couldNotLoadTarget(InjectTec:Injector injectorRef) Global
	return error(injectorRef + " could not load its target")
EndFunction

Bool Function couldNotLoadSource(InjectTec:Injector injectorRef) Global
	return error(injectorRef + " could not load its source")
EndFunction

Bool Function injecting(InjectTec:Injector injectorObject, Bool bForce) Global
	return log(Loggout.buildMessage(injectorObject + " injecting", bForce, "", " (forced)"))
EndFunction

Bool Function reverting(InjectTec:Injector injectorObject, Bool bForce) Global
	return log(Loggout.buildMessage(injectorObject + " reverting", bForce, "", " (forced)"))
EndFunction
