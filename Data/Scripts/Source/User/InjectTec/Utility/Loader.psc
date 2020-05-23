Scriptname InjectTec:Utility:Loader extends Quest Hidden Const
{Children of this script are multi-tasked as libraries to assist the rest of the InjectTec codebase or as form loaders for plugins doing things other than simple injection which requires remote loading of forms.
Attach these child scripts in the editor to enable easy referencing of another plugin's records.}

Import InjectTec:Utility:HexidecimalLogic

Group RemoteSourceSettings
	InjectTec:Plugin Property RemotePlugin = None Auto Const Mandatory
	{The plugin containing the required record.}
	DigitSet Property RemoteDigits = None Auto Const
	{This is an alternative option to setting the sourceID property.  If you would rather not bother with the base 16 to base 10 calculation, enter the base 16 digits here.}
EndGroup

Form Function loadHelper(Form record = None, InjectTec:Plugin plugin = None, DigitSet digits = None) Global
{Syntacial sugar which enables InjectTec:Injector logic not to care how a Form record is accessed.
If the record is indicated to be true by bLocal, then myForm is returned.  Otherwise, the result of a record lookup using a plugin and digits is returned.}
	if (record)
		return record
	elseif (plugin)
		return plugin.lookup(digits)
	endif
	
	return None
EndFunction

Form Function concreteLoad()
	return loadHelper(None, RemotePlugin, RemoteDigits)
EndFunction
