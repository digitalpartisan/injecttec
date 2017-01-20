Scriptname InjectTec:Injector:Leveled:FormList extends InjectTec:Injector:Leveled
{Attach this script in the editor to inject append the Form records from a FormList source record to a targettted LeveledItem record.}

Group SourceSettings
	Bool Property isSourceLocal = true Auto Const
	{True if the value of sourceFormList can be set using the editor because the sourced FormList record comes from either a master file on which your plugin depends or your plugin itself.  Set to false otherwise.}
	FormList Property sourceFormList = None Auto Const
	{The FormList record to source for injection.  Set this value if the value of isSourceLocal is true.}
	InjectTec:Plugin Property sourcePlugin = None Auto Const
	{The plugin containing the sourced FormList.  Set this value if the value of isSourceLocal has been set to false.}
	Int Property sourceID = 0 Auto Const
	{The record ID of the sourced FormList.  Set this value if the value of isSourceLocal has been set to false.}
EndGroup

Group Metadata
	Int Property Level = 1 Auto Const
	{The level at which the FormList records should be added to the LeveledItem.  This value will be used unless the LevelVariable property is populated.}
	Int Property Quantity = 1 Auto Const
	{The quantity to use when adding to the targetted LeveledItem.  This value will be used unless the QuantityVariable property is populated.}
	GlobalVariable Property LevelVariable = None Auto Const
	{Consider using this property instead of Level if you are performing many injections which should all have the same level.  This way, the level can be easily changed by editing only the GlobalVariable record and not many InjectTec:Injector objects.}
	GlobalVariable Property QuantityVariable = None Auto Const
	{Consider using this property instead of Quantity if you are performing many injections which should all have the same quantity.  This way, the quantity can be easily changed by editing only the GlobalVariable record and not many InjectTec:Injector objects.}
EndGroup

FormList flAdditions = None

FormList Function getSource()
	return flAdditions
EndFunction

Bool Function canLoadSource()
{Returns a boolean value indicating whether or not the FormList source record can be found and saves the FormList for use in injection should it load.}
	flAdditions = InjectTec:Loader:FormList.load(isSourceLocal, sourceFormList, sourcePlugin, sourceID)
	if (flAdditions == None)
		logMessage("additions not found: " + self)
		return false
	else
		return true
	endif
EndFunction

Function logMessage(String sMessage)
	parent.logMessage("[FormList]" + sMessage)
EndFunction

Function clear()
	flAdditions = None
	parent.clear()
EndFunction

Int Function getLevel()
	if (LevelVariable == None)
		return Level
	else
		return LevelVariable.getValueInt()
	endif
EndFunction

Int Function getQuantity()
	if (QuantityVariable == None)
		return Quantity
	else
		return QuantityVariable.getValueInt()
	endif
EndFunction

Function injectBehavior()
	InjectTec:Core:Leveled.addFormList(getTarget(), getSource(), getLevel(), getQuantity())
EndFunction
