Scriptname InjectTec:Injector:Leveled:ReusableRemoteForms extends InjectTec:Injector:Leveled:Abstract

Group SourceSettings
	InjectTec:ReusableRemoteForms Property RemoteForms Auto Const Mandatory
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
	InjectTec:Core:Leveled.addForms(getTarget(), getSource(), getLevel(), getQuantity())
EndFunction
