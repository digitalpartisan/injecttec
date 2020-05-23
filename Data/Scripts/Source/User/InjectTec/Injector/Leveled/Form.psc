Scriptname InjectTec:Injector:Leveled:Form extends InjectTec:Injector:Leveled:Abstract Conditional
{Attach this script in the editor to inject append a Form source record to a targetted LeveledItem record.}

Import InjectTec:Utility:HexidecimalLogic

Group SourceSettings
	Form Property sourceForm = None Auto Const
	{The Form record to source for injection.  Set this value if the value of isSourceLocal is true.}
	InjectTec:Plugin Property sourcePlugin = None Auto Const
	{The plugin containing the sourced Form.  Set this value if the value of isSourceLocal has been set to false.}
	DigitSet Property sourceDigits = None Auto Const
	{Alternative to sourceID.  If you would rather skip the base 16 to base 10 conversion, enter the hexidecimal digits here.}
EndGroup

Form fAddition = None

Form Function getSource()
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
	InjectTec:Utility:LeveledItem.addForm(getTarget(), getSource(), getLevel(), getQuantity())
EndFunction
