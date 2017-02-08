Scriptname InjectTec:Loader:Leveled extends InjectTec:Loader
{Generally used to fetch records for Injection, but can be attached in the editor to load records for other purposes.}

LeveledItem Function load(Bool bLocal = true, LeveledItem myLeveled = None, InjectTec:Plugin myPlugin = None, Int myID = 0) Global
{Syntacial sugar which enables InjectTec:Injector logic not to care how a LeveledItem record is accessed.  If the record is indicated to be true by bLocal, then myLeveled is returned.  Otherwise, the result of a record lookup using myPlugin and myID is returned.}
	if (bLocal)
		return myLeveled
	else
		return myPlugin.lookupLeveled(myID)
	endif
EndFunction

LeveledItem Function get()
	return load(false, None, RemotePlugin, RemoteID)
EndFunction
