Scriptname InjectTec:Core:NamingRules Hidden Const
{Logic related to merging InstanceNamingRules records with each other.}

Function append(InstanceNamingRules innrTarget, InstanceNamingRules innrAdditions) Global
{Trivial, except for logging.  Useful for debugging.}
	InjectTec:Logger:Injection.log(innrTarget, innrAdditions)
	innrTarget.mergeWith(innrAdditions)
EndFunction
