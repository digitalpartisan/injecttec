Scriptname InjectTec:Injector:Leveled:ReusableRemoteFormsGranular extends InjectTec:Injector:Leveled:GranularAbstract Conditional

Group SourceSettings
	InjectTec:ReusableRemoteForms Property RemoteForms Auto Const Mandatory
EndGroup

Form[] faAdditions = None

Form[] Function getSource()
	return faAdditions
EndFunction

Bool Function canLoadSource()
	faAdditions = RemoteForms.loadAll()
	if (faAdditions)
		return true
	else
		InjectTec:Logger:Injector.couldNotLoadSource(self)
		return false
	endif
EndFunction

Function clear()
	faAdditions = None
	parent.clear()
EndFunction

Function injectBehavior()
	InjectTec:Core:Leveled.addFormsGranular(getTarget(), getSource(), Levels, Quantities)
EndFunction
