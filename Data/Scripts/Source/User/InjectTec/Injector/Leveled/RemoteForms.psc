Scriptname InjectTec:Injector:Leveled:RemoteForms extends InjectTec:Injector:Leveled:Abstract
{Attach this script in the editor to inject append remote Form records to a targetted LeveledItem record.}

Group SourceSettings
	InjectTec:Plugin Property SourcePlugin = None Auto Const Mandatory
	{The plugin containing the sourced Form IDs.}
	Int[] Property SourceIDs Auto Const Mandatory
	{The IDs of the sourced Form records.}
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
	InjectTec:Core:Leveled.addForms(getTarget(), getSource(), getLevel(), getQuantity())
EndFunction
