Scriptname InjectTec:Injector:NamingRules extends InjectTec:Injector Conditional
{Implementation of injection into InstanceNamingRule records.}

Import InjectTec:Utility:HexidecimalLogic

Group TargetSettings
	InstanceNamingRules Property targetRules = None Auto Const
	{The InstanceNamingRules record to target for injection.  Set this value if the value of isTargetLocal is true.}
	InjectTec:Plugin Property targetPlugin = None Auto Const
	{The plugin containing the targetted InstanceNamingRules.  Set this value if the value of isTargetLocal has been set to false.}
	DigitSet Property targetDigits = None Auto Const
	{Alternative to the targetID property.  Set this to bypass the need to convert the hexidecimal digits to an integer.}
EndGroup

Group SourceSettings
	InstanceNamingRules Property sourceRules = None Auto Const
	{The InstanceNamingRules record to source for injection.  Set this value if the value of isSourceLocal is true.}
	InjectTec:Plugin Property sourcePlugin = None Auto Const
	{The plugin containing the sourced InstanceNamingRules.  Set this value if the value of isSourceLocal has been set to false.}
	DigitSet Property sourceDigits = None Auto Const
	{Alternative to the sourceID property.  Set this to bypass the need to convert the hexidecimal digits to an integer.}
EndGroup

InstanceNamingRules innrTarget = None
InstanceNamingRules innrAdditions = None

InstanceNamingRules Function getTarget()
	return innrTarget
EndFunction

InstanceNamingRules Function getSource()
	return innrAdditions
EndFunction

Bool Function canLoadTarget()
	innrTarget = InjectTec:Utility:InstanceNamingRules.load(targetRules, targetPlugin, targetDigits)
	if (innrTarget)
		return true
	else
		InjectTec:Injector:Logger.couldNotLoadTarget(self)
		return false
	endif
EndFunction

Bool Function canLoadSource()
	innrAdditions = InjectTec:Utility:InstanceNamingRules.load(sourceRules, sourcePlugin, sourceDigits)
	if (innrAdditions)
		return true
	else
		InjectTec:Injector:Logger.couldNotLoadSource(self)
		return false
	endif
EndFunction

Function clear()
{Doesn't call parent.clear() to avoid warning in debug logs.}
	innrTarget = None
	innrAdditions = None
EndFunction

Function injectBehavior()
	InjectTec:Utility:InstanceNamingRules.append(getTarget(), getSource())
EndFunction

Function revert(Bool bForce = false)
{This method was overridden solely to put this note on it.  No such behavior is provided by the base game, so don't rely on being able to back out naming rule changes.}
	return
EndFunction
