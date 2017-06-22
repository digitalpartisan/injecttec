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

	Int iCounter = 0
	while (iCounter < Injectors.GetSize())
		(Injectors.GetAt(iCounter) as InjectTec:Injector).inject(bForce)
		iCounter += 1
	endwhile
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
	
	Int iCounter = 0
	while (iCounter < Injectors.GetSize())
		(Injectors.GetAt(iCounter) as InjectTec:Injector).revert(bForce)
		iCounter += 1
	endwhile
EndFunction

Function forceRevert()
	revert(true)
EndFunction

Event OnQuestInit()
{Useful for initiating injections right off the bat if they're not part of a larger logical package and/or if they're part of a mod that has an install / uninstall quest.}
	inject()
EndEvent

Event OnQuestShutdown()
{Useful for reverting the injections if they're not part of a larger logical package and/or if they're part of a mod that has an install / uninstall quest.}
	revert()
EndEvent
