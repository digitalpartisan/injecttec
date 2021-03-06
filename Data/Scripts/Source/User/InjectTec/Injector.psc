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
	InjectTec:Injector:Logger.behaviorUndefined(self, "canLoadTarget()")
	return false
EndFunction

Bool Function canLoadSource()
{Overrride this method to specify what the source (that is, the source of the new data) is and how it is accessed.}
	InjectTec:Injector:Logger.behaviorUndefined(self, "canLoadSource()")
	return false
EndFunction

Function clear()
{Precaution against junk data staying around in the variables of child scripts.  See child scripts for details.}
	InjectTec:Injector:Logger.behaviorUndefined(self, "clear()")
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
	InjectTec:Injector:Logger.behaviorUndefined(self, "injectBehavior()")
EndFunction

Bool Function canInject(Bool bForce = false)
	return (canLoadRecords() && (!getHasRun() || bForce)) ; either this injector must not have run or else injection must be coerced
EndFunction

Function inject(Bool bForce = false)
{Call this method to cause the injection behavior to occur.}
	if (canInject(bForce))
		InjectTec:Injector:Logger.injecting(self, bForce)
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
	InjectTec:Injector:Logger.behaviorUndefined(self, "revertBehavior()")
EndFunction

Bool Function canRevert(Bool bForce = false)
	return (canLoadRecords() && (getHasRun() || bForce)) ; either this injector must have been run or else reversion must be coerced
EndFunction

Function revert(Bool bForce = false)
{Call this method to cause the injection behavior to be reversed.
Warning: reverting script changes could wipe out all injections, not just yours.  Use as a last resort and investigate other options in and out of this library first.}
	if (canRevert(bForce))
		InjectTec:Injector:Logger.reverting(self, bForce)
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
	InjectTec:Injector:Logger.behaviorUndefined(self, "verificationBehavior()")
	return false
EndFunction

Bool Function verify(Bool bForceInjectOnFailure = false)
{Returns true if this injector object can successfully verify that the injection it contains has taken effect and returns false otherwise.  Optionally allows forceful injection if appropriate.}
	if (!canVerify() || !canLoadRecords())
		return false
	endif
	
	Bool bResult = verificationBehavior()
	!bResult && bForceInjectOnFailure && forceInject()
	clear() ; this logic required loading forms, so they're going to need to be purged again
	
	return bResult
EndFunction

Bool Function forceVerify()
	return verify(true)
EndFunction

Event OnQuestInit()
{Useful for initiating the injection right off the bat if it's not part of a larger logical package and/or if it's part of a mod that has an install / uninstall quest.}
	inject()
EndEvent

Event OnQuestShutdown()
{Useful for reverting the injection if it's not part of a larger logical package and/or if it's part of a mod that has an install / uninstall quest.}
	revert()
EndEvent

Function bulkInjectList(FormList injectionList, Bool bForce = false) Global
	if (!injectionList)
		return
	endif
	
	Int iSize = injectionList.GetSize()
	if (!iSize)
		return
	endif
	
	InjectTec:Injector injector = None
	Int iCounter = 0
	while (iCounter < iSize)
		injector = injectionList.GetAt(iCounter) as InjectTec:Injector
		injector && injector.inject(bForce)
		iCounter += 1
	endWhile
EndFunction

Function bulkForceInjectList(FormList injectionList) Global
	bulkInjectList(injectionList, true)
EndFunction

Function bulkRevertList(FormList injectionList, Bool bForce = false) Global
	if (!injectionList)
		return
	endif
	
	Int iSize = injectionList.GetSize()
	if (!iSize)
		return
	endif
	
	InjectTec:Injector injector = None
	Int iCounter = 0
	while (iCounter < iSize)
		injector = injectionList.GetAt(iCounter) as InjectTec:Injector
		injector && injector.revert(bForce)
		iCounter += 1
	endWhile
EndFunction

Function bulkForceRevertList(FormList injectionList) Global
	bulkRevertList(injectionList, true)
EndFunction

Function bulkVerifyList(FormList injectionList, Bool bForceInjectOnFailure = false) Global
	if (!injectionList)
		return
	endif
	
	Int iSize = injectionList.GetSize()
	if (!iSize)
		return
	endif
	
	InjectTec:Injector injector = None
	Int iCounter = 0
	while (iCounter < iSize)
		injector = injectionList.GetAt(iCounter) as InjectTec:Injector
		injector && injector.verify(bForceInjectOnFailure)
		iCounter += 1
	endWhile
EndFunction

Function bulkForceVerifyList(FormList injectionList) Global
	bulkVerifyList(injectionList, true)
EndFunction

Bool Function shouldUnrun()
    return getHasRun() && !canRevert()
EndFunction

Function unrunBehavior()
    clear()
    setHasRun(false)
EndFunction

Function unrun()
    shouldUnrun() && unrunBehavior()
EndFunction

Function bulkUnrunList(FormList injectionList) Global
    if (!injectionList)
        return
    endif

    Int iSize = injectionList.GetSize()
    if (!iSize)
        return
    endif

    InjectTec:Injector injector = None
    Int iCounter = 0
    while (iCounter < iSize)
        injector = injectionList.GetAt(iCounter) as InjectTec:Injector
        injector && injector.unrun()
        iCounter += 1
    endWhile
EndFunction
