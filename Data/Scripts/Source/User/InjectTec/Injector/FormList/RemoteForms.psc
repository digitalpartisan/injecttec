Scriptname InjectTec:Injector:FormList:RemoteForms extends InjectTec:Injector:FormList
{Attach this script in the editor to inject append multiple remote Forms to a targetted FormList record.}

Group SourceSettings
	InjectTec:Plugin Property SourcePlugin = None Auto Const Mandatory
	{The plugin containing the sourced Form IDs.}
	Int[] Property SourceIDs Auto Const Mandatory
	{The record IDs of the sourced Forms.}
EndGroup

Form[] faAdditions = None

Form[] Function getSource()
	return faAdditions
EndFunction

Bool Function canLoadSource()
	faAdditions = SourcePlugin.lookupForms(SourceIDs)
	return (None != faAdditions)
EndFunction

Function clear()
	faAdditions = None
	parent.clear()
EndFunction

Function injectBehavior()
	InjectTec:Core:FormList.addForms(getTarget(), getSource())
EndFunction

Function revertBehavior()
	InjectTec:Core:FormList.removeForms(getTarget(), getSource())
EndFunction

Bool Function verificationBehavior()
	return InjectTec:Core:FormList.verifyForms(getTarget(), getSource())
EndFunction
