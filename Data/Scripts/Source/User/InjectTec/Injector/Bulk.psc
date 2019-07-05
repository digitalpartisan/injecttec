Scriptname InjectTec:Injector:Bulk extends Quest
{This script bulk-executes a list of InjectTec:Injector objects.  Useful for running a number of injections during a mod's initialization quest or the like.}

FormList Property Injectors Auto Const Mandatory
{The InjectTec:Injector objects to work on.  Not an array because this list has a tendency to become long and arrays are cumbersome to work with in the editor.}
InjectTec:Plugin Property Plugin = None Auto Const
{The InjectTec:Plugin objects to verify plugin existence before running injection / reversion operations.
Providing no plugin is assumed to mean always run the injections.}

Bool Function checkPlugin()
{Verifies all plugins are installed.}
	if (None == Plugin)
		return true
	endif

	return Plugin.isInstalled()
EndFunction

Function inject(Bool bForce = false)
{Performs all injections in the Injectors FormList property based on whether or not all required plugins are available.}
	if (!checkPlugin())
		return
	endif

	InjectTec:Injector.bulkInjectList(Injectors, bForce)
EndFunction

Function forceInject()
	inject(true)
EndFunction

Function revert(Bool bForce = false)
{Performs all reversions in the Injectors FormList property based on whether or not all required plugins are available.
Please see the cautionary remark on InjectTec:Injector.revert() before doing this and consider the potential consequences.}
	if (!checkPlugin())
		return
	endif
	
	InjectTec:Injector.bulkRevertList(Injectors, bForce)
EndFunction

Function forceRevert()
	revert(true)
EndFunction

Function verify(Bool bForceInjectOnFailure = false)
	if (!checkPlugin())
		return
	endif
	
	InjectTec:Injector.bulkVerifyList(Injectors, bForceInjectOnFailure)
EndFunction

Function forceVerify()
	verify(true)
EndFunction

Event OnQuestInit()
{Useful for initiating injections right off the bat if they're not part of a larger logical package and/or if they're part of a mod that has an install / uninstall quest.}
	inject()
EndEvent

Event OnQuestShutdown()
{Useful for reverting the injections if they're not part of a larger logical package and/or if they're part of a mod that has an install / uninstall quest.}
	revert()
EndEvent

Function bulkInject(InjectTec:Injector:Bulk[] bulkInjectors, Bool bForce = false) Global
	if (!bulkInjectors || !bulkInjectors.Length)
		return
	endif
	
	Int iCounter = 0
	InjectTec:Injector:Bulk bulkInjector = None
	while (iCounter < bulkInjectors.Length)
		bulkInjector = bulkInjectors[iCounter] as InjectTec:Injector:Bulk
		if (bulkInjector)
			bulkInjector.inject(bForce)
		endif
		
		iCounter += 1
	endWhile
EndFunction

Function bulkForceInject(InjectTec:Injector:Bulk[] bulkInjectors) Global
	bulkInject(bulkInjectors, true)
EndFunction

Function bulkInjectList(FormList bulkInjectors, Bool bForce = false) Global
	if (!bulkInjectors)
		return
	endif
	
	Int iSize = bulkInjectors.GetSize()
	if (!iSize)
		return
	endif
	
	InjectTec:Injector:Bulk injector = None
	Int iCounter = 0
	while (iCounter < iSize)
		injector = bulkInjectors.GetAt(iCounter) as InjectTec:Injector:Bulk
		if (injector)
			injector.inject(bForce)
		endif
		
		iCounter += 1
	endWhile
EndFunction

Function bulkForceInjectList(FormList bulkInjectors) Global
	bulkInjectList(bulkInjectors, true)
EndFunction

Function bulkRevert(InjectTec:Injector:Bulk[] bulkInjectors, Bool bForce = false) Global
	if (!bulkInjectors || !bulkInjectors.Length)
		return
	endif
	
	Int iCounter = 0
	InjectTec:Injector:Bulk bulkInjector = None
	while (iCounter < bulkInjectors.Length)
		bulkInjector = bulkInjectors[iCounter] as InjectTec:Injector:Bulk
		if (bulkInjector)
			bulkInjector.revert(bForce)
		endif
		
		iCounter += 1
	endWhile
EndFunction

Function bulkForceRevert(InjectTec:Injector:Bulk[] bulkInjectors) Global
	bulkRevert(bulkInjectors, true)
EndFunction

Function bulkRevertList(FormList bulkInjectors, Bool bForce = false) Global
	if (!bulkInjectors)
		return
	endif
	
	Int iSize = bulkInjectors.GetSize()
	if (!iSize)
		return
	endif
	
	InjectTec:Injector:Bulk injector = None
	Int iCounter = 0
	while (iCounter < iSize)
		injector = bulkInjectors.GetAt(iCounter) as InjectTec:Injector:Bulk
		if (injector)
			injector.revert(bForce)
		endif
		
		iCounter += 1
	endWhile
EndFunction

Function bulkForceRevertList(FormList bulkInjectors) Global
	bulkRevertList(bulkInjectors, true)
EndFunction

Function bulkVerify(InjectTec:Injector:Bulk[] bulkInjectors, Bool bForceInjectOnFailure = false) Global
	if (!bulkInjectors || !bulkInjectors.Length)
		return
	endif
	
	Int iCounter = 0
	InjectTec:Injector:Bulk bulkInjector = None
	while (iCounter < bulkInjectors.Length)
		bulkInjector = bulkInjectors[iCounter] as InjectTec:Injector:Bulk
		if (bulkInjector)
			bulkInjector.verify(bForceInjectOnFailure)
		endif
		
		iCounter += 1
	endWhile
EndFunction

Function bulkForceVerify(InjectTec:Injector:Bulk[] bulkInjectors) Global
	bulkVerify(bulkInjectors, true)
EndFunction

Function bulkVerifyList(FormList bulkInjectors, Bool bForceInjectOnFailure = false) Global
	if (!bulkInjectors)
		return
	endif
	
	Int iSize = bulkInjectors.GetSize()
	if (!iSize)
		return
	endif
	
	InjectTec:Injector:Bulk injector = None
	Int iCounter = 0
	while (iCounter < iSize)
		injector = bulkInjectors.GetAt(iCounter) as InjectTec:Injector:Bulk
		if (injector)
			injector.verify(bForceInjectOnFailure)
		endif
		
		iCounter += 1
	endWhile
EndFunction

Function bulkForceVerifyList(FormList bulkInjectors) Global
	bulkVerifyList(bulkInjectors, true)
EndFunction
