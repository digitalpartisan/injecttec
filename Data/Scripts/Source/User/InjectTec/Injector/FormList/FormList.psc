Scriptname InjectTec:Injector:FormList:FormList extends InjectTec:Injector:FormList Conditional
{Attach this script in the editor to inject append a FormList source record to a targetted FormList record.}

Import InjectTec:HexidecimalLogic

Group SourceSettings
	Bool Property isSourceLocal = true Auto Const
	{True if the value of sourceFormList can be set using the editor because the sourced FormList record comes from either a master file on which your plugin depends or your plugin itself.  Set to false otherwise.}
	FormList Property sourceFormList = None Auto Const
	{The FormList record to source for injection.  Set this value if the value of isSourceLocal is true.}
	InjectTec:Plugin Property sourcePlugin = None Auto Const
	{The plugin containing the sourced FormList.  Set this value if the value of isSourceLocal has been set to false.}
	Int Property sourceID = 0 Auto Const
	{The record ID of the sourced FormList.  Set this value if the value of isSourceLocal has been set to false.}
	DigitSet Property sourceDigits = None Auto Const
	{Alternative to setting sourceID.  If you woudl rather skip the base 16 to base 10 conversion, set the hexidecimal digits here.}
EndGroup

FormList flAdditions = None

FormList Function getSource()
	return flAdditions
EndFunction

Bool Function canLoadSource()
	flAdditions = InjectTec:Loader:FormList.load(isSourceLocal, sourceFormList, sourcePlugin, sourceID, sourceDigits)
	if (flAdditions)
		return true
	else
		InjectTec:Logger:Injector.couldNotLoadSource(self)
		return false
	endif
EndFunction

Function clear()
	flAdditions = None
	parent.clear()
EndFunction

Function injectBehavior()
	InjectTec:Core:FormList.addFormList(getTarget(), getSource())
EndFunction

Function revertBehavior()
	InjectTec:Core:FormList.removeFormList(getTarget(), getSource())
EndFunction

Bool Function verificationBehavior()
	return InjectTec:Core:FormList.verifyFormList(getTarget(), getSource())
EndFunction
