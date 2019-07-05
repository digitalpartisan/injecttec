Scriptname InjectTec:Injector:FormList:RemoteForms extends InjectTec:Injector:FormList Conditional
{Attach this script in the editor to inject append multiple remote Forms to a targetted FormList record.}

Import InjectTec:Utility:HexidecimalLogic

Group SourceSettings
	InjectTec:Plugin Property SourcePlugin = None Auto Const Mandatory
	{The plugin containing the sourced Form IDs.}
	Int[] Property SourceIDs = None Auto Const
	{The record IDs of the sourced Forms.}
	DigitSet[] Property SourceDigitSets = None Auto Const
	{Alternative to the SourceIDs property.  If you would rather not bother with the base 16 to base 10 conversions, set the hexidecimal digits here.}
EndGroup

Form[] faAdditions = None

Form[] Function getSource()
	return faAdditions
EndFunction

Bool Function canLoadSource()
	if (!SourcePlugin)
		return false
	endif
	
	faAdditions = SourcePlugin.lookupArrayWithCoalescedIDs(SourceIDs, SourceDigitSets)
	if (!faAdditions)
		InjectTec:Logger:Injector.couldNotLoadSource(self)
		return false
	endif
	
	return true
EndFunction

Function clear()
	faAdditions = None
	parent.clear()
EndFunction

Function injectBehavior()
	InjectTec:Utility:FormList.addForms(getTarget(), getSource())
EndFunction

Function revertBehavior()
	InjectTec:Utility:FormList.removeForms(getTarget(), getSource())
EndFunction

Bool Function verificationBehavior()
	return InjectTec:Utility:FormList.verifyForms(getTarget(), getSource())
EndFunction
