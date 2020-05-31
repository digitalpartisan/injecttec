Scriptname InjectTec:Integrator extends Quest Conditional
{Generic logic used in scriting cross-plugin functionality.  Handles things like are the required plugins installed, event hooks for what to do when starting up, shutting down, and when the required plugins are suddenly no longer installed.}

Group MinimalRequirements
    InjectTec:Plugin[] Property Plugins Auto Const Mandatory
    Message Property About Auto Const
    Bool Property AutoFire = false Auto Const
EndGroup

InjectTec:Injector:Bulk Property Injections Auto Const

String sStateWaiting = "Waiting" Const
String sStateStopped = "Stopped" Const
String sStateUnrun = "Unrun" Const
String sStateStarted = "Started" Const

Bool bHasRun = false Conditional ; for legacy reasons to support old functionality across plugins that may need this script (but also useful for conditional system)

Bool Function hasRun()
    return false
EndFunction

Bool Function canRun()
    return false
EndFunction

InjectTec:Plugin[] Function getPlugins()
	return Plugins
EndFunction

Bool Function isPluginRequirementMet()
	return InjectTec:Plugin.isInstalledBulk(Plugins)
EndFunction

Message Function getAbout()
    return About
EndFunction

Function goToWaiting()
	GoToState(sStateWaiting)
EndFunction

Function goToStarted()
	GoToState(sStateStarted)
EndFunction

Function goToStopped()
    GoToState(sStateStopped)
EndFunction

Function goToUnrun()
    GoToState(sStateUnrun)
EndFunction

Function stateCheck()
    InjectTec:Integrator:Logger.logStateCheck(self)
EndFunction

Bool Function shouldStartLogic()
    return !hasRun() && AutoFire && isPluginRequirementMet()
EndFunction

Bool Function shouldStart()
	return false
EndFunction

Bool Function shouldUnrunLogic()
    return !isPluginRequirementMet()
EndFunction

Bool Function shouldUnrun()
	return false
EndFunction

Function forceInjections()

EndFunction

Function rerun()

EndFunction

Auto State Waiting
	Event OnBeginState(String asOldState)
	    InjectTec:Integrator:Logger.logWaiting(self)
		bHasRun = false
		Stop()
	EndEvent

	Event OnQuestInit()
		goToStarted()
	EndEvent

	Bool Function shouldStart()
		return shouldStartLogic()
	EndFunction

    Bool Function canRun()
        return isPluginRequirementMet()
    EndFunction

	Function stateCheck()
	    InjectTec:Integrator:Logger.logStateCheck(self)
		shouldStart() && Start()
	EndFunction
EndState

Function startBehavior()
    Injections && Injections.inject()
EndFunction

Function gameLoadBehavior()

EndFunction

Function gameLoad()

EndFunction

State Started
	Event OnBeginState(String asOldState)
	    InjectTec:Integrator:Logger.logStarted(self)

		if (shouldUnrun())
			goToUnrun()
			return
		endif

		bHasRun = true

        startBehavior()
	EndEvent

	Event OnQuestShutdown()
		goToStopped()
	EndEvent

	Bool Function shouldUnrun()
		return shouldUnrunLogic()
	EndFunction

	Function stateCheck()
	    InjectTec:Integrator:Logger.logStateCheck(self)
		shouldUnrun() && goToUnrun()
	EndFunction

	Function forceInjections()
	    Injections && Injections.forceInject()
	EndFunction

	Function rerun()
	    Stop()
	    Start()
	EndFunction
	
	Bool Function hasRun()
		return true
	EndFunction
	
	Function gameLoad()
		gameLoadBehavior()
	EndFunction
EndState

Function stopBehavior()
    Injections && Injections.revert()
EndFunction

State Stopped
    Event OnBeginState(String asOldState)
        InjectTec:Integrator:Logger.logStopped(self)
		bHasRun = false
        stopBehavior()
        goToWaiting()
    EndEvent
EndState

Function unrunBehavior()
    Injections && Injections.unrun()
EndFunction

State Unrun
    Event OnBeginState(String asOldState)
        InjectTec:Integrator:Logger.logUnrun(self)
		bHasRun = false
        unrunBehavior()
        goToWaiting()
    EndEvent
EndState

Function stateCheckBulk(InjectTec:Integrator[] integrators) Global
	if (!integrators || !integrators.Length)
		return
	endif

	Int iCounter = 0
	while (iCounter < integrators.Length)
		integrators[iCounter] && integrators[iCounter].stateCheck()
		iCounter += 1
	endWhile
EndFunction

Function stateCheckList(FormList integrators) Global
	stateCheckBulk(Jiffy:Utility:FormList.toArray(integrators) as InjectTec:Integrator[])
EndFunction

Function gameLoadBulk(InjectTec:Integrator[] integrators) Global
	if (!integrators || !integrators.Length)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < integrators.Length)
		integrators[iCounter] && integrators[iCounter].gameLoad()
		iCounter += 1
	endWhile
EndFunction

Function gameLoadList(FormList integrators) Global
	gameLoadBulk(Jiffy:Utility:FormList.toArray(integrators) as InjectTec:Integrator[])
EndFunction

Function stopBulk(InjectTec:Integrator[] integrators, Bool bCheck = true) Global
	if (!integrators || !integrators.Length)
		return
	endif

	Int iCounter = 0
	while (iCounter < integrators.Length)
		integrators[iCounter] && integrators[iCounter].Stop()
		iCounter += 1
	endWhile
EndFunction

Function stopList(FormList integrators) Global
	stopBulk(Jiffy:Utility:FormList.toArray(integrators) as InjectTec:Integrator[])
EndFunction
