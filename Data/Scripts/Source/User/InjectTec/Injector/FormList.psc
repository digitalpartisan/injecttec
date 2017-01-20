Scriptname InjectTec:Injector:FormList extends InjectTec:Injector
{Do not attach this script in the editor.  Attach one of its children instead.
Logic related to injecting information into FormList records.}

Group TargetSettings
	Bool Property isTargetLocal = true Auto Const
	{True if the value of targetList can be set using the editor because the targetted FormList record comes from either a master file on which your plugin depends or your plugin itself.  Set to false otherwise.}
	FormList Property targetList = None Auto Const
	{The FormList record to target for injection.  Set this value if the value of isTargetLocal is true.}
	InjectTec:Plugin Property targetPlugin = None Auto Const
	{The plugin containing the targetted FormList.  Set this value if the value of isTargetLocal has been set to false.}
	Int Property targetID = 0 Auto Const
	{The record ID of the targetted FormList.  Set this value if the value of isTargetLocal has been set to false.}
EndGroup

FormList flTarget = None

FormList Function getTarget()
	return flTarget
EndFunction

Bool Function canLoadTarget()
{Returns a boolean value indicating whether or not the targetted FormList record can be found and saves the FormList for use in injection should it load.}
	flTarget = InjectTec:Loader:FormList.load(isTargetLocal, targetList, targetPlugin, targetID)
	if (flTarget == "None")
		logMessage("target not found: " + self)
		return false
	else
		return true
	endif
EndFunction

Function logMessage(String sMessage)
	parent.logMessage("[FormList]" + sMessage)
EndFunction

Function clear()
	flTarget = None
	parent.clear()
EndFunction
