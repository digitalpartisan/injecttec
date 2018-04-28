Scriptname InjectTec:Injector:Leveled:ReusableRemoteFormsGranular extends InjectTec:Injector:Leveled:GranularAbstract

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
	InjectTec:Core:Leveled.addFormsGranular(getTarget(), getSource(), Levels, Quantities)
EndFunction