Scriptname InjectTec:Injector:Leveled extends InjectTec:Injector Hidden
{Implementation of injection into LeveledItem records.}

Group TargetSettings
	Bool Property isTargetLocal = true Auto Const
	{True if the value of targetLeveled can be set using the editor because the targetted LeveledItem record comes from either a master file on which your plugin depends or your plugin itself.  Set to false otherwise.}
	LeveledItem Property targetLeveled = None Auto Const
	{The LeveledItem record to target for injection.  Set this value if the value of isTargetLocal is true.}
	InjectTec:Plugin Property targetPlugin = None Auto Const
	{The plugin containing the targetted LeveledItem.  Set this value if the value of isTargetLocal has been set to false.}
	Int Property targetID = 0 Auto Const
	{The record ID of the targetted LeveledItem.  Set this value if the value of isTargetLocal has been set to false.}
EndGroup

LeveledItem liTarget = None

LeveledItem Function getTarget()
	return liTarget
EndFunction

Bool Function canLoadTarget()
{Returns a boolean value indicating whether or not the targetted LeveledItem record can be found and saves the LeveledItem for use in injection should it load.}
	liTarget = InjectTec:Loader:Leveled.load(isTargetLocal, targetLeveled, targetPlugin, targetID)
	if (liTarget == "None")
		logMessage("target not found: " + self)
		return false
	else
		return true
	endif
EndFunction

Function logMessage(String sMessage)
	parent.logMessage("[Leveled]" + sMessage)
EndFunction

Function clear()
	liTarget = None
	parent.clear()
EndFunction

Function revertBehavior()
	getTarget().revert()
EndFunction

Function revert(Bool bForce = false)
{Overridden just to add this warning.  Warning: this will destroy all injections, not just yours.}
	parent.revert(bForce)
EndFunction
