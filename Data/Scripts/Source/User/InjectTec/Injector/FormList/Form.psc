Scriptname InjectTec:Injector:FormList:Form extends InjectTec:Injector:FormList
{Attach this script in the editor to inject a Form record into a FormList record.}

Group SourceSettings
	Bool Property isSourceLocal = true Auto Const
	{True if the value of sourceForm can be set using the editor because the sourced Form record comes from either a master file on which your plugin depends or your plugin itself.  Set to false otherwise.}
	Form Property sourceForm = None Auto Const
	{The Form record to source for injection.  Set this value if the value of isSourceLocal is true.}
	InjectTec:Plugin Property sourcePlugin = None Auto Const
	{The plugin containing the sourced Form.  Set this value if the value of isSourceLocal has been set to false.}
	Int Property sourceID = 0 Auto Const
	{The record ID of the sourced Form.  Set this value if the value of isSourceLocal has been set to false.}
EndGroup

Form fAddition = None

Form Function getSource()
	return fAddition
EndFunction

Bool Function canLoadSource()
{Returns a boolean value indicating whether or not the Form source record can be found and saves the Form for use in injection should it load.}
	fAddition = InjectTec:Loader:Form.load(isSourceLocal, sourceForm, sourcePlugin, sourceID)
	return (None != fAddition)
EndFunction

Function clear()
	fAddition = None
	parent.clear()
EndFunction

Function injectBehavior()
	InjectTec:Core:FormList.addForm(getTarget(), getSource())
EndFunction

Function revertBehavior()
	InjectTec:Core:FormList.removeForm(getTarget(), getSource())
EndFunction

Bool Function verificationBehavior()
{Only called after canLoadRecords() has been called, so this is safe.}
	return verifyForm(getSource())
EndFunction
