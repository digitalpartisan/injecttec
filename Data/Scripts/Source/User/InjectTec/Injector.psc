Scriptname InjectTec:Injector extends Quest Hidden Conditional
{Extend this script to provide easy access to the logic in the InjectTec library to objects in the Creation Kit editor.  See child scripts for specifics.}

Bool bHasRun = false Conditional; this should be based on Papyrus' script states and the like, but I didn't do that and now, save games with Injectors in them won't convert easily, so it's staying this way

Bool Function getHasRun()
	return bHasRun
EndFunction

Function setHasRun(Bool bNewValue = true)
	bHasRun = bNewValue
EndFunction

Bool Function canLoadTarget()
{Override this method to specify what the target record is and how it is accessed.}
	InjectTec:Logger:Injector.behaviorUndefined(self, "canLoadTarget()")
	return false
EndFunction

Bool Function canLoadSource()
{Overrride this method to specify what the source (that is, the source of the new data) is and how it is accessed.}
	InjectTec:Logger:Injector.behaviorUndefined(self, "canLoadSource()")
	return false
EndFunction

Function clear()
{Precaution against junk data staying around in the variables of child scripts.  See child scripts for details.}
	InjectTec:Logger:Injector.behaviorUndefined(self, "clear()")
EndFunction

Bool Function canLoadRecords()
{Returns a Bool indicating whether or not the records needed to perform the injection can be found.
This method is written in such a way that both the target and source records are loaded so that all possible
log message are generated so that all possible problems can be detected and remedied as soon as possible.}
	Bool bTarget = canLoadTarget()
	Bool bSource = canLoadSource()
	return bTarget && bSource
EndFunction

Function injectBehavior()
{Override this behavior in child scripts to implement specific injection logic on particular data types.}
	InjectTec:Logger:Injector.behaviorUndefined(self, "injectBehavior()")
EndFunction

Bool Function canInject(Bool bForce = false)
	return (canLoadRecords() && (!getHasRun() || bForce)) ; either this injector must not have run or else injection must be coerced
EndFunction

Function inject(Bool bForce = false)
{Call this method to cause the injection behavior to occur.}
	if (canInject(bForce))
		InjectTec:Logger:Injector.injecting(self, bForce)
		injectBehavior()
		setHasRun(true)
	endif
	
	clear() ; wipe out data regardless of whether or not action was taken since it's trivial to load back in and cleanliness matters
EndFunction

Function forceInject()
	inject(true)
EndFunction

Function revertBehavior()
{Override this behavior to revert the injection as needed.}
	InjectTec:Logger:Injector.behaviorUndefined(self, "revertBehavior()")
EndFunction

Bool Function canRevert(Bool bForce = false)
	return (canLoadRecords() && (getHasRun() || bForce)) ; either this injector must have been run or else reversion must be coerced
EndFunction

Function revert(Bool bForce = false)
{Call this method to cause the injection behavior to be reversed.
Warning: reverting script changes could wipe out all injections, not just yours.  Use as a last resort and investigate other options in and out of this library first.}
	if (canRevert(bForce))
		InjectTec:Logger:Injector.reverting(self, bForce)
		revertBehavior()
		setHasRun(false)
	endif
	
	clear() ; wipe out data regardless of whether or not action was taken since it's trivial to load back in
EndFunction

Function forceRevert()
	revert(true)
EndFunction

Bool Function canVerify()
{Generally, this is only true of FormList targets since no other types allow for detailed inspection.}
	return false
EndFunction

Bool Function verificationBehavior()
{Override to indicate how an injection object should verify (if at all) whether or not it has taken effect.  This function is not expected to be called (or even overridden if verification is not possible.}
	InjectTec:Logger:Injector.behaviorUndefined(self, "verificationBehavior()")
	return false
EndFunction

Bool Function verify(Bool bForceInjectOnFailure = false)
{Returns true if this injector object can successfully verify that the injection it contains has taken effect and returns false otherwise.  Optionally allows forceful injection if appropriate.}
	if (!canVerify() || !canLoadRecords())
		return false
	endif
	
	Bool bResult = verificationBehavior()
	if (!bResult && bForceInjectOnFailure)
		forceInject()
	endif
	
	clear() ; this logic required loading forms, so they're going to need to be purged again
	
	return bResult
EndFunction

Event OnQuestInit()
{Useful for initiating the injection right off the bat if it's not part of a larger logical package and/or if it's part of a mod that has an install / uninstall quest.}
	inject()
EndEvent

Event OnQuestShutdown()
{Useful for reverting the injection if it's not part of a larger logical package and/or if it's part of a mod that has an install / uninstall quest.}
	revert()
EndEvent
