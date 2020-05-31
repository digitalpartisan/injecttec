Scriptname InjectTec:Integrator:BehaviorOmnibus extends InjectTec:Integrator
{The purpose of this script is to allow many different Chronicle Behavior scripts to run at the right time as part of an InjectTec:Integrator's behavior.
Instead of attaching these behaviors to a package directly, attach them to this Integrator using this script's properties so that they are run when the behavior operating this Injector runs.}

Chronicle:Package:CustomBehavior[] Property Behaviors Auto Const

Chronicle:Package:CustomBehavior[] Function getBehaviors()
	return Behaviors
EndFunction

Function handleBehaviors(Bool bInstall = false, Bool bPostLoad = false, Bool bUninstall = false)
	Chronicle:Package:CustomBehavior[] myBehaviors = getBehaviors()
	if (!myBehaviors || !myBehaviors.Length)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < myBehaviors.Length)
		if (myBehaviors[iCounter] && !(myBehaviors[iCounter] as InjectTec:Integrator:ChronicleBehavior)) ; the behavior in question must be a valid, non-InjectTec:Integrator behavior to prevent an infinte loop via this script
			bInstall && myBehaviors[iCounter].installBehavior()
			bPostLoad && myBehaviors[iCounter].postloadBehavior()
			bUninstall && myBehaviors[iCounter].uninstallBehavior()
		endif
		
		iCounter += 1
	endWhile
EndFunction

Function installBehaviors()
	handleBehaviors(true)
EndFunction

Function postloadBehaviors()
	handleBehaviors(false, true)
EndFunction

Function uninstallBehaviors()
	handleBehaviors(false, false, true)
EndFunction

Function startBehavior()
{See InjectTec:Integrator.startBehavior()}	
	parent.startBehavior()
	installBehaviors()
EndFunction

Function gameLoadBehavior()
{See InjectTec:Integrator.gameLoadBehavior()}
	parent.gameLoadBehavior()
	postloadBehaviors()
EndFunction

Function stopBehavior()
{See InjectTec:Integrator.stopBehavior()}
    parent.stopBehavior()
	uninstallBehaviors()
EndFunction

Function unrunBehavior()
{See InjectTec:Integrator.unrunBehavior()}
    parent.unrunBehavior()
	uninstallBehaviors()
EndFunction
