Scriptname InjectTec:Loader:NamingRules extends InjectTec:Loader

InstanceNamingRules Function load(Bool bLocal = true, InstanceNamingRules myRules = None, InjectTec:Plugin myPlugin = None, Int myID = 0) Global
{Syntacial sugar which enables InjectTec:Injector logic not to care how an InstanceNamingRules record is accessed.  If the record is indicated to be true by bLocal, then myRules is returned.  Otherwise, the result of a record lookup using myPlugin and myID is returned.}
	if (bLocal)
		return myRules
	else
		return myPlugin.lookupNamingRules(myID)
	endif
EndFunction

InstanceNamingRules Function get()
	return load(false, None, RemotePlugin, RemoteID)
EndFunction
