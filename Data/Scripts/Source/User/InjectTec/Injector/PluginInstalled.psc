Scriptname InjectTec:Injector:PluginInstalled extends InjectTec:Injector Conditional
{Useful in situations where the only concern is whether or not a plugin is installed since that information is available to the conditionals system.
The bHasRun variable on this script will only be true if the target plugin is installed and false otherwise.}

InjectTec:Plugin Property TargetPlugin Auto Const Mandatory

Bool Function canLoadTarget()
	return true ; trivially true
EndFunction

Bool Function canLoadSource()
	return true ; trivially true
EndFunction

Function clear()
	; prevent useless debug messages
EndFunction

Function injectBehavior()
	; preventing useless debug messages
EndFunction

Bool Function canInject(Bool bForce = false)
	return TargetPlugin.isInstalled()
EndFunction

Function revertBehavior()
	; preventing useless debug messages
EndFunction

Bool Function canRevert(Bool bForce = false)
	return true ; once again, trivial, but you know the drill...
EndFunction
