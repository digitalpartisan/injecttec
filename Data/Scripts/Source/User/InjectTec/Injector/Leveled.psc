Scriptname InjectTec:Injector:Leveled extends InjectTec:Injector Hidden Conditional
{Implementation of injection into LeveledItem records.}

Import InjectTec:Utility:HexidecimalLogic

Group TargetSettings
	LeveledItem Property targetLeveled = None Auto Const
	{The LeveledItem record to target for injection.  Set this value if the value of isTargetLocal is true.}
	InjectTec:Plugin Property targetPlugin = None Auto Const
	{The plugin containing the targetted LeveledItem.  Set this value if the value of isTargetLocal has been set to false.}
	DigitSet Property targetDigits = None Auto Const
	{The hexidecimal digits of the target form to load from targetPlugin.}
EndGroup

LeveledItem liTarget = None

LeveledItem Function getTarget()
	return liTarget
EndFunction

Int Function coalesceIntValue(Int iStatic = 0, GlobalVariable variable = None) Global
	if (variable)
		return variable.GetValueInt()
	endif
	
	return iStatic
EndFunction

Bool Function canLoadTarget()
	liTarget = InjectTec:Utility:LeveledItem.load(targetLeveled, targetPlugin, targetDigits)
	if (liTarget)
		return true
	else
		InjectTec:Injector:Logger.couldNotLoadTarget(self)
		return false
	endif
EndFunction

Function clear()
{Doesn't call parent.clear() to avoid warning in debug logs.}
	liTarget = None
EndFunction

Function revertBehavior()
	InjectTec:Utility:LeveledItem.revert(getTarget())
EndFunction

Function revert(Bool bForce = false)
{Overridden just to add this warning.  Warning: this will destroy all injections, not just yours.}
	parent.revert(bForce)
EndFunction
