Scriptname InjectTec:Loader:NamingRules extends InjectTec:Loader
{Generally used to fetch records for Injection, but can be attached in the editor to load records for other purposes.}

Import InjectTec:HexidecimalLogic

InstanceNamingRules Function load(Bool bLocal = true, InstanceNamingRules myRules = None, InjectTec:Plugin myPlugin = None, Int myID = 0, DigitSet digits = None) Global
{Syntacial sugar which enables InjectTec:Injector logic not to care how an InstanceNamingRules record is accessed.  If the record is indicated to be true by bLocal, then myRules is returned.  Otherwise, the result of a record lookup using myPlugin and myID is returned.}
	if (bLocal)
		return myRules
	endif
	
	if (digits)
		return myPlugin.lookupNamingRules(getDigitSetValue(digits))
	else
		return myPlugin.lookupNamingRules(myID)
	endif
EndFunction

InstanceNamingRules Function get()
	return load(false, None, RemotePlugin, RemoteID, RemoteDigits)
EndFunction
