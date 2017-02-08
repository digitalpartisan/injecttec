Scriptname InjectTec:Injector:Leveled:Granular extends InjectTec:Injector:Leveled
{Attach this script in the editor to inject append the Form records from a FormList source record to a targetted LeveledItem record with granular control over which levels and quantities are used for each Form record added.
See notes on InjectTec:Core:Leveled.addFormListGranular() for specifics.}

Group SourceSettings
	Bool Property isSourceLocal = true Auto Const
	{True if the value of sourceFormList can be set using the editor because the sourced FormList record comes from either a master file on which your plugin depends or your plugin itself.  Set to false otherwise.}
	FormList Property sourceFormList = None Auto Const
	{The FormList record to source for injection.  Set this value if the value of isSourceLocal is true.}
	InjectTec:Plugin Property sourcePlugin = None Auto Const
	{The plugin containing the sourced FormList.  Set this value if the value of isSourceLocal has been set to false.}
	Int Property sourceID = 0 Auto Const
	{The record ID of the sourced FormList.  Set this value if the value of isSourceLocal has been set to false.}
EndGroup

Group Metadata
	Int[] Property Levels Auto Const
	{An Int array which has a specific (and likely, unique) level setting for each Form record in the myAdditions Form property.  See InjectTec:Core:Leveled.addFormListGranular() for details.}
	Int[] Property Quantities Auto Const
	{An Int array which has a specific (and likely, unique) quantity setting for each Form records in the myAdditions Form property.  See InjectTec:Core:Leveled.addFormListGranular() for details.}
EndGroup

FormList flAdditions = None

FormList Function getSource()
	return flAdditions
EndFunction

Bool Function canLoadSource()
{Returns a boolean value indicating whether or not the FormList source record can be found and saves the FormList for use in injection should it load.}
	flAdditions = InjectTec:Loader:FormList.load(isSourceLocal, sourceFormList, sourcePlugin, sourceID)
	if (flAdditions == None)
		logMessage("additions not found: " + self)
		return false
	else
		return true
	endif
EndFunction

Function logMessage(String sMessage)
	parent.logMessage("[Detailed]" + sMessage)
EndFunction

Function clear()
	flAdditions = None
	parent.clear()
EndFunction

Function injectBehavior()
	InjectTec:Core:Leveled.addFormListGranular(getTarget(), getSource(), Levels, Quantities)
EndFunction
