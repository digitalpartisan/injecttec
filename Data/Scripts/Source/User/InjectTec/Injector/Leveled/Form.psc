Scriptname InjectTec:Injector:Leveled:Form extends InjectTec:Injector:Leveled:Abstract
{Attach this script in the editor to inject append a Form source record to a targetted LeveledItem record.}

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
	fAddition = InjectTec:Loader:Form.load(isSourceLocal, sourceForm, sourcePlugin, sourceID)
	return (None != fAddition)
EndFunction

Function clear()
	fAddition = None
	parent.clear()
EndFunction

Function injectBehavior()
	InjectTec:Core:Leveled.addForm(getTarget(), getSource(), getLevel(), getQuantity())
EndFunction
