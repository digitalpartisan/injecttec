Scriptname InjectTec:Injector:FormList extends InjectTec:Injector Hidden
{Implementation of injection into FormList records.  See child scripts for details.}

Import InjectTec:HexidecimalLogic

Group TargetSettings
	Bool Property isTargetLocal = true Auto Const
	{True if the value of targetList can be set using the editor because the targetted FormList record comes from either a master file on which your plugin depends or your plugin itself.  Set to false otherwise.}
	FormList Property targetList = None Auto Const
	{The FormList record to target for injection.  Set this value if the value of isTargetLocal is true.}
	InjectTec:Plugin Property targetPlugin = None Auto Const
	{The plugin containing the targetted FormList.  Set this value if the value of isTargetLocal has been set to false.}
	Int Property targetID = 0 Auto Const
	{The record ID of the targetted FormList.  Set this value if the value of isTargetLocal has been set to false.}
	DigitSet Property targetDigits = None Auto Const
	{Alternative to setting the targetID property.}
EndGroup

FormList flTarget = None

FormList Function getTarget()
	return flTarget
EndFunction

Bool Function canLoadTarget()
	flTarget = InjectTec:Loader:FormList.load(isTargetLocal, targetList, targetPlugin, targetID, targetDigits)
	if (flTarget)
		return true
	else
		InjectTec:Logger:Injector.couldNotLoadTarget(self)
		return false
	endif
EndFunction

Function clear()
{Doesn't call parent.clear() to avoid warning in debug logs.}
	flTarget = None
EndFunction

Bool Function canVerify()
	return true
EndFunction
