Scriptname InjectTec:Injector:Leveled:Granular:FormSetting extends Quest Const
{This script is entirely superfluous except for the fact that the DigitSet property cannot be part of a struct because it is also a struct.}

Import InjectTec:Utility:HexidecimalLogic
Import InjectTec:Utility:LeveledItem

Group FormData
	Form Property LocalForm = None Auto Const
	DigitSet Property RemoteDigits = None Auto Const
EndGroup

Group QuantityData
	Int Property Quantity = 1 Auto Const
	GlobalVariable Property QuantityVariable = None Auto Const
EndGroup

Group LevelData
	Int Property Level = 1 Auto Const
	GlobalVariable Property LevelVariable = None Auto Const
EndGroup

Form Function getForm()
	return LocalForm
EndFunction

DigitSet Function getDigits()
	return RemoteDigits
EndFunction

GranularFormData Function getGranularFormData(InjectTec:Plugin plugin)
	return buildGranularFormData(InjectTec:Utility:Form.load(getForm(), plugin, getDigits()), getLevel(), getQuantity())
EndFunction

Int Function getQuantity()
	return InjectTec:Injector:Leveled.coalesceIntValue(Quantity, QuantityVariable)
EndFunction

Int Function getLevel()
	return InjectTec:Injector:Leveled.coalesceIntValue(Level, LevelVariable)
EndFunction	
