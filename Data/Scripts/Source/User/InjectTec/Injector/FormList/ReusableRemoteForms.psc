Scriptname InjectTec:Injector:FormList:ReusableRemoteForms extends InjectTec:Injector:FormList
{Attach this script in the editor to inject append a reusable remote forms list to a targetted FormList record.}

Group SourceSettings
	InjectTec:ReusableRemoteForms Property RemoteForms Auto Const Mandatory
	{The set of forms to load for sourcing.}
EndGroup

Form[] faAdditions = None

Form[] Function getSource()
	return faAdditions
EndFunction

Bool Function canLoadSource()
	faAdditions = RemoteForms.loadAll()
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
