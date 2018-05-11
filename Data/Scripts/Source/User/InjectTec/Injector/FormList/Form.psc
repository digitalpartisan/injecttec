Scriptname InjectTec:Injector:FormList:Form extends InjectTec:Injector:FormList Conditional
{Attach this script in the editor to inject a Form record into a FormList record.}

Import InjectTec:HexidecimalLogic

Group SourceSettings
	Bool Property isSourceLocal = true Auto Const
	{True if the value of sourceForm can be set using the editor because the sourced Form record comes from either a master file on which your plugin depends or your plugin itself.  Set to false otherwise.}
	Form Property sourceForm = None Auto Const
	{The Form record to source for injection.  Set this value if the value of isSourceLocal is true.}
	InjectTec:Plugin Property sourcePlugin = None Auto Const
	{The plugin containing the sourced Form.  Set this value if the value of isSourceLocal has been set to false.}
	Int Property sourceID = 0 Auto Const
	{The record ID of the sourced Form.  Set this value if the value of isSourceLocal has been set to false.}
	DigitSet Property sourceDigits = None Auto Const
	{This is an alternative option to setting the sourceID property.  If you would rather not bother with the base 16 to base 10 calculation, enter the base 16 digits here.}
EndGroup

Form fAddition = None

Form Function getSource()
{Because variables are private and child scripts can't see them.}
	return fAddition
EndFunction

Bool Function canLoadSource()
	fAddition = InjectTec:Loader:Form.load(isSourceLocal, sourceForm, sourcePlugin, sourceID, sourceDigits)
	if (fAddition)
		return true
	else
		InjectTec:Logger:Injector.couldNotLoadSource(self)
		return false
	endif
EndFunction

Function clear()
	fAddition = None
	parent.clear()
EndFunction

Function injectBehavior()
	InjectTec:Core:FormList.addForm(getTarget(), getSource())
EndFunction

Function revertBehavior()
	InjectTec:Core:FormList.removeForm(getTarget(), getSource())
EndFunction

Bool Function verificationBehavior()
{Only called after canLoadRecords() has been called, so this is safe.}
	return InjectTec:Core:FormList.verifyForm(getTarget(), getSource())
EndFunction
