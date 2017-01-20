Scriptname InjectTec:Loader:FormList extends InjectTec:Loader

FormList Function load(Bool bLocal = true, FormList myFormList = None, InjectTec:Plugin myPlugin = None, Int myID = 0) Global
{Syntacial sugar which enables InjectTec:Injector logic not to care how a FormList record is accessed.  If the record is indicated to be true by bLocal, then myFormList is returned.  Otherwise, the result of a record lookup using myPlugin and myID is returned.}
	if (bLocal)
		return myFormList
	else
		return myPlugin.lookupFormList(myID)
	endif
EndFunction

FormList Function get()
	return load(false, None, RemotePlugin, RemoteID)
EndFunction
