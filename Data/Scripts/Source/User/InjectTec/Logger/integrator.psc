Scriptname InjectTec:Logger:Integrator Hidden Const DebugOnly

String[] Function getTags() Global
    String[] tags = new String[1]
    tags[0] = "Integrator"
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

Bool Function logWaiting(InjectTec:Integrator integrator) Global
    return log(integrator + " is waiting")
EndFunction

Bool Function logStarted(InjectTec:Integrator integrator) Global
    return log(integrator + " has started")
EndFunction

Bool Function logUnrun(InjectTec:Integrator integrator) Global
    return log(integrator + " is unrunning")
EndFunction

Bool Function logStopped(InjectTec:Integrator integrator) Global
    return log(integrator + " has stopped")
EndFunction

Bool Function logStateCheck(InjectTec:Integrator integrator) Global
    return log(integrator + " is state checking in " + integrator.GetState())
EndFunction
