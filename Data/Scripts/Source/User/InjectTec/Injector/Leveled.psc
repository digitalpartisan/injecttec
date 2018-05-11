Scriptname InjectTec:Injector:Leveled extends InjectTec:Injector Hidden Conditional
{Implementation of injection into LeveledItem records.}

Import InjectTec:HexidecimalLogic

Group TargetSettings
	Bool Property isTargetLocal = true Auto Const
	{True if the value of targetLeveled can be set using the editor because the targetted LeveledItem record comes from either a master file on which your plugin depends or your plugin itself.  Set to false otherwise.}
	LeveledItem Property targetLeveled = None Auto Const
	{The LeveledItem record to target for injection.  Set this value if the value of isTargetLocal is true.}
	InjectTec:Plugin Property targetPlugin = None Auto Const
	{The plugin containing the targetted LeveledItem.  Set this value if the value of isTargetLocal has been set to false.}
	Int Property targetID = 0 Auto Const
	{The record ID of the targetted LeveledItem.  Set this value if the value of isTargetLocal has been set to false.}
	DigitSet Property targetDigits = None Auto Const
	{Alternative to the targetID property.  If you would rather avoid the base 16 to base 10 conversion, set the hexidecimal digits here.}
EndGroup

LeveledItem liTarget = None

LeveledItem Function getTarget()
	return liTarget
EndFunction

Bool Function canLoadTarget()
	liTarget = InjectTec:Loader:Leveled.load(isTargetLocal, targetLeveled, targetPlugin, targetID, targetDigits)
	if (liTarget)
		return true
	else
		InjectTec:Logger:Injector.couldNotLoadTarget(self)
		return false
	endif
EndFunction

Function clear()
{Doesn't call parent.clear() to avoid warning in debug logs.}
	liTarget = None
EndFunction

Function revertBehavior()
	InjectTec:Core:Leveled.revert(getTarget())
EndFunction

Function revert(Bool bForce = false)
{Overridden just to add this warning.  Warning: this will destroy all injections, not just yours.}
	parent.revert(bForce)
EndFunction
