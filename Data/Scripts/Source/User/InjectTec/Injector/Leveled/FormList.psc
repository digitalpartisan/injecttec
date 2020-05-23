Scriptname InjectTec:Injector:Leveled:FormList extends InjectTec:Injector:Leveled:Abstract Conditional
{Attach this script in the editor to inject append the Form records from a FormList source record to a targetted LeveledItem record.}

Import InjectTec:Utility:HexidecimalLogic

Group SourceSettings
	FormList Property sourceFormList = None Auto Const
	{The FormList record to source for injection.  Set this value if the value of isSourceLocal is true.}
	InjectTec:Plugin Property sourcePlugin = None Auto Const
	{The plugin containing the sourced FormList.  Set this value if the value of isSourceLocal has been set to false.}
	DigitSet Property sourceDigits = None Auto Const
	{Alternative to the sourceID property.  If you would prefer not to manually convert base 16 to base 10, enter the hexidecimal digits here.}
EndGroup

FormList flAdditions = None

FormList Function getSource()
	return flAdditions
EndFunction

Bool Function canLoadSource()
	flAdditions = InjectTec:Utility:FormList.load(sourceFormList, sourcePlugin, sourceDigits)
	if (flAdditions)
		return true
	else
		InjectTec:Injector:Logger.couldNotLoadSource(self)
		return false
	endif
EndFunction

Function clear()
	flAdditions = None
	parent.clear()
EndFunction

Function injectBehavior()
	InjectTec:Utility:LeveledItem.addFormList(getTarget(), getSource(), getLevel(), getQuantity())
EndFunction
