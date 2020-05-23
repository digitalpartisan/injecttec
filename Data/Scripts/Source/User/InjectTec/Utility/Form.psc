Scriptname InjectTec:Utility:Form extends InjectTec:Utility:Loader
{Generally used to fetch records for Injection, but can be attached in the editor to load records for other purposes.}

Import InjectTec:Utility:HexidecimalLogic

Form Function load(Form record = None, InjectTec:Plugin plugin = None, DigitSet digits = None) Global
	return InjectTec:Utility:Loader.loadHelper(record, plugin, digits) ; called this way because of compiler syntax oddities
EndFunction

Form Function getForm()
	return concreteLoad()
EndFunction
