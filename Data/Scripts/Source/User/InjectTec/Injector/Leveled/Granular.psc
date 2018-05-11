Scriptname InjectTec:Injector:Leveled:Granular extends InjectTec:Injector:Leveled:GranularAbstract Conditional
{Attach this script in the editor to inject append the Form records from a FormList source record to a targetted LeveledItem record with granular control over which levels and quantities are used for each Form record added.
See notes on InjectTec:Core:Leveled.addFormListGranular() for specifics.}

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
	{Alternative to the SourceID property.  To bypass converting base 16 to base 10, enter the hexidecimal digits here.}
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
	InjectTec:Core:Leveled.addFormListGranular(getTarget(), getSource(), Levels, Quantities)
EndFunction
