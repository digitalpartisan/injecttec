Scriptname InjectTec:Injector:FormList:Form extends InjectTec:Injector:FormList Conditional
{Attach this script in the editor to inject a Form record into a FormList record.}

Import InjectTec:Utility:HexidecimalLogic

Group SourceSettings
	Form Property sourceForm = None Auto Const
	{The Form record to source for injection.  Set this value if the value of isSourceLocal is true.}
	InjectTec:Plugin Property sourcePlugin = None Auto Const
	{The plugin containing the sourced Form.  Set this value if the value of isSourceLocal has been set to false.}
	DigitSet Property sourceDigits = None Auto Const
	{This is an alternative option to setting the sourceID property.  If you would rather not bother with the base 16 to base 10 calculation, enter the base 16 digits here.}
EndGroup

Form fAddition = None

Form Function getSource()
{Because variables are private and child scripts can't see them.}
	return fAddition
EndFunction

Bool Function canLoadSource()
	fAddition = InjectTec:Utility:Form.load(sourceForm, sourcePlugin, sourceDigits)
	if (fAddition)
		return true
	else
		InjectTec:Injector:Logger.couldNotLoadSource(self)
		return false
	endif
EndFunction

Function clear()
	fAddition = None
	parent.clear()
EndFunction

Function injectBehavior()
	InjectTec:Utility:FormList.addForm(getTarget(), getSource())
EndFunction

Function revertBehavior()
	InjectTec:Utility:FormList.removeForm(getTarget(), getSource())
EndFunction

Bool Function verificationBehavior()
{Only called after canLoadRecords() has been called, so this is safe.}
	return InjectTec:Utility:FormList.verifyForm(getTarget(), getSource())
EndFunction
