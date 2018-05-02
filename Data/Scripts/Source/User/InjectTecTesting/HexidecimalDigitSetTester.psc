Scriptname InjectTecTesting:HexidecimalDigitSetTester extends ObjectReference

InjectTecTesting:HexidecimalDigitSet[] Property DigitSets Auto Const Mandatory

Event OnActivate(ObjectReference akActionRef)
	Int iCounter = 0
	while (iCounter < DigitSets.Length)
		DigitSets[iCounter].test()
		iCounter += 1
	endWhile
EndEvent
