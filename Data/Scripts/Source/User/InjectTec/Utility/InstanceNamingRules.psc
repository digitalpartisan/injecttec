Scriptname InjectTec:Utility:InstanceNamingRules extends InjectTec:Utility:Loader
{Logic related to merging InstanceNamingRules records with each other.  Generally used to fetch records for Injection, but can be attached in the editor to load records for other purposes.}

Import InjectTec:Utility:HexidecimalLogic

Function append(InstanceNamingRules innrTarget, InstanceNamingRules innrAdditions) Global
{Trivial, except for logging.  Useful for debugging.}
	InjectTec:Logger:Injection.logInjection(innrTarget, innrAdditions)
	innrTarget.mergeWith(innrAdditions)
EndFunction

InstanceNamingRules Function load(InstanceNamingRules record = None, InjectTec:Plugin plugin = None, Int iID = 0, DigitSet digits = None) Global
	return InjectTec:Utility:Loader.loadHelper(record, plugin, iID, digits) as InstanceNamingRules
EndFunction

InstanceNamingRules Function get()
	return concreteLoad() as InstanceNamingRules
EndFunction
