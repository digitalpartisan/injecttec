Scriptname InjectTec:Injector:FormList:FormList extends InjectTec:Injector:FormList
{Attach this script in the editor to inject append a FormList source record to a targetted FormList record.}

Group SourceSettings
	Bool Property isSourceLocal = true Auto Const
	{True if the value of sourceFormList can be set using the editor because the sourced FormList record comes from either a master file on which your plugin depends or your plugin itself.  Set to false otherwise.}
	FormList Property sourceFormList = None Auto Const
	{The FormList record to source for injection.  Set this value if the value of isSourceLocal is true.}
	InjectTec:Plugin Property sourcePlugin = None Auto Const
	{The plugin containing the sourced FormList.  Set this value if the value of isSourceLocal has been set to false.}
	Int Property sourceID = 0 Auto Const
	{The record ID of the sourced FormList.  Set this value if the value of isSourceLocal has been set to false.}
EndGroup

FormList flAdditions = None

FormList Function getSource()
	return flAdditions
EndFunction

Bool Function canLoadSource()
{Returns a boolean value indicating whether or not the FormList source record can be found and saves the FormList for use in injection should it load.}
	flAdditions = InjectTec:Loader:FormList.load(isSourceLocal, sourceFormList, sourcePlugin, sourceID)
	return (None != flAdditions)
EndFunction

Function clear()
	flAdditions = None
	parent.clear()
EndFunction

Function injectBehavior()
	InjectTec:Core:FormList.addFormList(getTarget(), getSource())
EndFunction

Function revertBehavior()
	InjectTec:Core:FormList.removeFormList(getTarget(), getSource())
EndFunction

Bool Function verificationBehavior()
{Only called after canLoadRecords() has been called, so this is safe.}
	FormList flAdditionsToVerify = getSource()
	Int iCounter = 0
	Int iSize = flAdditionsToVerify.GetSize()
	While (iCounter < iSize)
		if (!verifyForm(flAdditionsToVerify.GetAt(iCounter)))
			return false
		endif
		iCounter += 1
	EndWhile
	
	return true
EndFunction
