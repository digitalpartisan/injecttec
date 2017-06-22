Scriptname InjectTec:Injector:Leveled:Abstract extends InjectTec:Injector:Leveled Hidden
{This is an abstraction for all fixed level and quantity leveled list injectors.  Note that this was written multipe versions after release and it's not reaonsable to expect mod authors to re-create large batches of injections.  Scripts extending this one are not named in the expected way.}

Group Metadata
	Int Property Level = 1 Auto Const
	{The level at which the Form should be added to the LeveledItem.  This value will be used unless the LevelVariable property is populated.}
	Int Property Quantity = 1 Auto Const
	{The number of myAddition to add to the targetted LeveledItem.  This value will be used unless the QuantityVariable property is populated.}
	GlobalVariable Property LevelVariable = None Auto Const
	{Consider using this property instead of Level if you are performing many injections which should all have the same level.  This way, the level can be easily changed by editing only the GlobalVariable record and not many InjectTec:Injector objects.}
	GlobalVariable Property QuantityVariable = None Auto Const
	{Consider using this property instead of Quantity if you are performing many injections which should all have the same quantity.  This way, the quantity can be easily changed by editing only the GlobalVariable record and not many InjectTec:Injector objects.}
EndGroup

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
