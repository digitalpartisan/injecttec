Scriptname InjectTec:Injector:Leveled:RemoteFormsGranular extends InjectTec:Injector:Leveled:GranularAbstract
{Attach this script in the editor to inject append the remote Form to a targetted LeveledItem record with granular control over which levels and quantities are used for each Form record added.
See notes on InjectTec:Core:Leveled.addFormListGranular() for specifics.}

Group SourceSettings
	InjectTec:Plugin Property SourcePlugin Auto Const Mandatory
	{The plugin containing the sourced FormList.}
	Int[] Property SourceIDs Auto Const Mandatory
	{The record IDs of the sourced Forms.}
EndGroup

Form[] faAdditions = None

Form[] Function getSource()
	return faAdditions
EndFunction

Bool Function canLoadSource()
	faAdditions = InjectTec:Loader:Form.loadArray(SourcePlugin, SourceIDs)
	return (None != faAdditions)
EndFunction

Function clear()
	faAdditions = None
	parent.clear()
EndFunction

Function injectBehavior()
	InjectTec:Core:Leveled.addFormsGranular(getTarget(), getSource(), Levels, Quantities)
EndFunction
