Scriptname InjectTec:Injector extends Quest Hidden
{Extend this script to provide easy access to the logic in the InjectTec library to objects in the Creation Kit editor.  See child scripts for specifics.}

Bool bHasRun = false ; this should be based on Papyrus' script states and the like, but I didn't do that and now, save games with Injectors in them won't convert easily, so it's staying this way

Bool Function getHasRun()
	return bHasRun
EndFunction

Function setHasRun(Bool bNewValue = true)
	bHasRun = bNewValue
EndFunction

Function logMessage(String sMessage)
	Debug.Trace("[InjectTec][Injector]" + sMessage)
EndFunction

Bool Function canLoadTarget()
{Override this method to specify what the target record is and how it is accessed.}
EndFunction

Bool Function canLoadSource()
{Overrride this method to specify what the source (that is, the source of the new data) is and how it is accessed.}
EndFunction

Function clear()
{Precaution against junk data staying around in the variables of child scripts.  See child scripts for details.}
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
	logMessage("injection behavior not overridden, no injection will occur: " + self)
EndFunction

Bool Function canInject(Bool bForce = false)
	if (!canLoadRecords())
		logMessage("cannot inject " + self + " because records won't load")
		return false
	endif
	
	if (getHasRun() && !bForce)
		logMessage("cannot inject " + self + " because injection has run and force is not applied")
		return false
	endif
	
	return true
EndFunction

Function inject(Bool bForce = false)
{Call this method to cause the injection behavior to occur.}
	if (canInject(bForce))
		logMessage("injecting " + self)
		injectBehavior()
		setHasRun(true)
	endif
	clear() ; wipe out data regardless of whether or not action was taken since it's trivial to load back in
EndFunction

Function forceInject()
	inject(true)
EndFunction

Function revertBehavior()
{Override this behavior to revert the injection as needed.}
	logMessage("reversion behavior not overridden, no reversion will occur: " + self)
EndFunction

Bool Function canRevert(Bool bForce = false)
	if (!canLoadRecords())
		logMessage("cannot revert " + self + " because records won't load")
		return false
	endif
	
	if (!getHasRun() && !bForce)
		logMessage("cannot revert " + self + " because injection has not run and force is not applied")
		return false
	endif
	
	return true
EndFunction

Function revert(Bool bForce = false)
{Call this method to cause the injection behavior to be reversed.
Warning: reverting script changes could wipe out all injections, not just yours.  Use as a last resort and investigate other options in and out of this library first.}
	if (canRevert(bForce))
		logMessage("reverting " + self)
		revertBehavior()
		setHasRun(false)
	endif
	clear() ; wipe out data regardless of whether or not action was taken since it's trivial to load back in
EndFunction

Function forceRevert()
	revert(true)
EndFunction
