Scriptname InjectTec:Injector:Leveled:RemoteForms extends InjectTec:Injector:Leveled
{Attach this script in the editor to inject append rmote Form records to a targetted LeveledItem record.}

Group SourceSettings
	InjectTec:Plugin Property SourcePlugin = None Auto Const Mandatory
	{The plugin containing the sourced Form IDs.}
	Int[] Property SourceIDs Auto Const Mandatory
	{The IDs of the sourced Form records.}
EndGroup

Group Metadata
	Int Property Level = 1 Auto Const
	{The level at which the SourceIDs records should be added to the LeveledItem.  This value will be used unless the LevelVariable property is populated.}
	Int Property Quantity = 1 Auto Const
	{The quantity to use when adding to the targetted LeveledItem.  This value will be used unless the QuantityVariable property is populated.}
	GlobalVariable Property LevelVariable = None Auto Const
	{Consider using this property instead of Level if you are performing many injections which should all have the same level.  This way, the level can be easily changed by editing only the GlobalVariable record and not many InjectTec:Injector objects.}
	GlobalVariable Property QuantityVariable = None Auto Const
	{Consider using this property instead of Quantity if you are performing many injections which should all have the same quantity.  This way, the quantity can be easily changed by editing only the GlobalVariable record and not many InjectTec:Injector objects.}
EndGroup

Form[] fAdditions = None

Form[] Function getSource()
	return fAdditions
EndFunction

Bool Function canLoadSource()
{Returns a boolean value indicating whether or not the sourced Form record can be found and saves the Forms for use in injection should it load.}
	fAdditions = new Form[0]
	
	Int iCounter = 0
	Form fNew = None
	While (iCounter < SourceIDs.Length)
		fNew = InjectTec:Loader:Form.load(false, None, SourcePlugin, SourceIDs[iCounter])
		if (None == fNew)
			return false
		endif
		fAdditions.Add(fNew)
		iCounter += 1
	EndWhile
	
	return true
EndFunction

Function clear()
	fAdditions = None
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
	InjectTec:Core:Leveled.addFormArray(getTarget(), getSource(), getLevel(), getQuantity())
EndFunction
