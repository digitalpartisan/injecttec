Scriptname InjectTec:Loader:Form extends InjectTec:Loader
{Generally used to fetch records for Injection, but can be attached in the editor to load records for other purposes.}

Import InjectTec:HexidecimalLogic

Form Function load(Bool bLocal = true, Form myForm = None, InjectTec:Plugin myPlugin = None, Int myID = 0, DigitSet digits = None) Global
{Syntacial sugar which enables InjectTec:Injector logic not to care how a Form record is accessed.  If the record is indicated to be true by bLocal, then myForm is returned.  Otherwise, the result of a record lookup using myPlugin and myID is returned.}
	if (bLocal)
		return myForm
	else
		if (digits)
			return myPlugin.lookupForm(getDigitSetValue(digits))
		else
			return myPlugin.lookupForm(myID)
		endif
	endif
EndFunction

Form[] Function loadArray(InjectTec:Plugin myPlugin = None, Int[] iaMyIDs = None, DigitSet[] aDigitSets = None) Global
{Returns an array of From records if the forms having IDs in iaMyIDs can be found in plugin myPlugin and None otherwise.}
	if (!myPlugin)
		return None
	endif
	
	if (aDigitSets && aDigitSets.Length > 0)
		return myPlugin.lookupForms(getDigitSetValues(aDigitSets))
	elseif (iaMyIDs && iaMyIDs.Length > 0)
		return myPlugin.lookupForms(iaMyIDs)
	else
		return None
	endif
EndFunction	

Form Function get()
	return load(false, None, RemotePlugin, RemoteID, RemoteDigits)
EndFunction
