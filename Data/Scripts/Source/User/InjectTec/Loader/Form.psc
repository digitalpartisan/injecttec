Scriptname InjectTec:Loader:Form extends InjectTec:Loader
{Generally used to fetch records for Injection, but can be attached in the editor to load records for other purposes.}

Form Function load(Bool bLocal = true, Form myForm = None, InjectTec:Plugin myPlugin = None, Int myID = 0) Global
{Syntacial sugar which enables InjectTec:Injector logic not to care how a Form record is accessed.  If the record is indicated to be true by bLocal, then myForm is returned.  Otherwise, the result of a record lookup using myPlugin and myID is returned.}
	if (bLocal)
		return myForm
	else
		return myPlugin.lookupForm(myID)
	endif
EndFunction

Form Function get()
	return load(false, None, RemotePlugin, RemoteID)
EndFunction
