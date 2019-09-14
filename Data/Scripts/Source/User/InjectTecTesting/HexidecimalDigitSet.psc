Scriptname InjectTecTesting:HexidecimalDigitSet extends Quest

InjectTec:Utility:HexidecimalLogic:DigitSet Property Digits Auto Const Mandatory
Int Property DecimalValue Auto Const Mandatory

Function test()
	InjectTec:Logger.log("Digit set expected " + DecimalValue + " and calculated " + InjectTec:Utility:HexidecimalLogic.getDigitSetValue(Digits))
EndFunction
