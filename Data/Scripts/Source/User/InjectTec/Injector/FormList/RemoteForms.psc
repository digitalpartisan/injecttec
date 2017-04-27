Scriptname InjectTec:Injector:FormList:RemoteForms extends InjectTec:Injector:FormList
{Attach this script in the editor to inject append multiple remote Forms to a targetted FormList record.}

Group SourceSettings
	InjectTec:Plugin Property SourcePlugin = None Auto Const Mandatory
	{The plugin containing the sourced Form IDs.}
	Int[] Property SourceIDs Auto Const Mandatory
	{The record IDs of the sourced Forms.}
EndGroup

Form[] fAdditions = None

Form[] Function getSource()
	return fAdditions
EndFunction

Bool Function canLoadSource()
{Returns a boolean value indicating whether or not the sourced Form record can be found and saves the Forms for use in injection should it load.}
	fAdditions = new Form[0]
	
	Int iCounter = 0
	Form fNew = None
	While (iCounter < SourceIDs.Length)
		fNew = InjectTec:Loader:Form.load(false, None, SourcePlugin, SourceIDs[iCounter])
		if (None == fNew)
			return false
		endif
		fAdditions.Add(fNew)
		iCounter += 1
	EndWhile
	
	return true
EndFunction

Function clear()
	fAdditions = None
	parent.clear()
EndFunction

Function injectBehavior()
	InjectTec:Core:FormList.addFormArray(getTarget(), getSource())
EndFunction

Function revertBehavior()
	InjectTec:Core:FormList.removeFormArray(getTarget(), getSource())
EndFunction

Bool Function verificationBehavior()
{Only called after canLoadRecords() has been called, so this is safe.}
	Int iCounter = 0
	Form[] fAdditionsToVerify = getSource()
	While (iCounter < fAdditionsToVerify.Length)
		if (!verifyForm(fAdditionsToVerify[iCounter]))
			return false
		endif
		iCounter += 1
	EndWhile
	
	return true
EndFunction
