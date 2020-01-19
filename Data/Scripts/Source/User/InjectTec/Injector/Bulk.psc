Scriptname InjectTec:Injector:Bulk extends Quest
{This script bulk-executes a list of InjectTec:Injector objects.  Useful for running a number of injections during a mod's initialization quest or the like.}

FormList Property Injectors Auto Const Mandatory
{The InjectTec:Injector objects to work on.  Not an array because this list has a tendency to become long and arrays are cumbersome to work with in the editor.}
InjectTec:Plugin[] Property Plugins Auto Const
{The InjectTec:Plugin objects to verify plugin existence before running injection / reversion operations.
Providing no plugin is assumed to mean always run the injections.}

Bool Function checkPlugins()
	return InjectTec:Plugin.isInstalledBulk(Plugins)
EndFunction

Function inject(Bool bForce = false)
{Performs all injections in the Injectors FormList property based on whether or not all required plugins are available.}
	checkPlugins() && InjectTec:Injector.bulkInjectList(Injectors, bForce)
EndFunction

Function forceInject()
	inject(true)
EndFunction

Function revert(Bool bForce = false)
{Performs all reversions in the Injectors FormList property based on whether or not all required plugins are available.
Please see the cautionary remark on InjectTec:Injector.revert() before doing this and consider the potential consequences.}
	checkPlugins() && InjectTec:Injector.bulkRevertList(Injectors, bForce)
EndFunction

Function forceRevert()
	revert(true)
EndFunction

Function verify(Bool bForceInjectOnFailure = false)
	checkPlugins() && InjectTec:Injector.bulkVerifyList(Injectors, bForceInjectOnFailure)
EndFunction

Function forceVerify()
	verify(true)
EndFunction

Function unrun()
    InjectTec:Injector.bulkUnrunList(Injectors)
EndFunction
