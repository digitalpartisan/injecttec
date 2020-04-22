Scriptname InjectTec:Utility:HexidecimalLogic Hidden Const

Struct DigitSet
	String sFive = "0"
	String sFour = "0"
	String sThree = "0"
	String sTwo = "0"
	String sOne = "0"
	String sZero = "0"
EndStruct

Int Function getCharacterValue(String sCharacter) Global
{Returns the integer value of the character passed in.  Returns -1 if the given string isn't exactly one of the hexidecimal characters and only one of the hexidecimal characters.}
	Int iResult = -1 ; this is the default value and it indicates invalid input
	
	if ("0" == sCharacter)
		iResult = 0
	endif
	
	if ("1" == sCharacter)
		iResult = 1
	endif
	
	if ("2" == sCharacter)
		iResult = 2
	endif
	
	if ("3" == sCharacter)
		iResult = 3
	endif
	
	if ("4" == sCharacter)
		iResult = 4
	endif
	
	if ("5" == sCharacter)
		iResult = 5
	endif
	
	if ("6" == sCharacter)
		iResult = 6
	endif
	
	if ("7" == sCharacter)
		iResult = 7
	endif
	
	if ("8" == sCharacter)
		iResult = 8
	endif
	
	if ("9" == sCharacter)
		iResult = 9
	endif
	
	if ("a" == sCharacter || "A" == sCharacter)
		iResult = 10
	endif
	
	if ("b" == sCharacter || "B" == sCharacter)
		iResult = 11
	endif
	
	if ("c" == sCharacter || "C" == sCharacter)
		iResult = 12
	endif
	
	if ("d" == sCharacter || "D" == sCharacter)
		iResult = 13
	endif
	
	if ("e" == sCharacter || "E" == sCharacter)
		iResult = 14
	endif
	
	if ("f" == sCharacter || "F" == sCharacter)
		iResult = 15
	endif
	
	return iResult
EndFunction

Bool Function isDigitValid(String sDigit) Global
	return -1 != getCharacterValue(sDigit)
EndFunction

String Function digitSetToString(DigitSet digits) Global
	if (!digits)
		return "N/A - no digits provided"
	endif
	
	return digits.sFive + digits.sFour + digits.sThree + digits.sTwo + digits.sOne + digits.sZero
EndFunction

Int Function getDigitValue(String sChar, Int iPower = 0) Global
	Int iValue = getCharacterValue(sChar)
	if (-1 == iValue)
		return -1
	endif
	
	return iValue * Math.pow(16, iPower) as Int
EndFunction

Int Function getDigitSetValue(DigitSet digits) Global
	if (!digits)
		return 0
	endif

	Int iResult = 0
	
	Int iFive = getDigitValue(digits.sFive, 5)
	if (-1 == iFive)
		return -1
	endif
	iResult += iFive
	
	Int iFour = getDigitValue(digits.sFour, 4)
	if (-1 == iFour)
		return -1
	endif
	iResult += iFour
	
	Int iThree = getDigitValue(digits.sThree, 3)
	if (-1 == iThree)
		return -1
	endif
	iResult += iThree
	
	Int iTwo = getDigitValue(digits.sTwo, 2)
	if (-1 == iTwo)
		return -1
	endif
	iResult += iTwo
	
	Int iOne = getDigitValue(digits.sOne, 1)
	if (-1 == iOne)
		return -1
	endif
	iResult += iOne
	
	Int iZero = getDigitValue(digits.sZero, 0)
	if (-1 == iZero)
		return -1
	endif
	iResult += iZero
	
	;InjectTec:Logger:HexidecimalLogic.logDigitSetCompuation(digits, iResult)
	
	return iResult
EndFunction

Int[] Function getDigitSetValues(DigitSet[] aDigitSets) Global
	Int[] iaResults = new Int[0]
	Int iCounter = 0
	while (iCounter < aDigitSets.Length)
		iaResults.Add(getDigitSetValue(aDigitSets[iCounter]))
		iCounter += 1
	endWhile
	
	return iaResults
EndFunction

