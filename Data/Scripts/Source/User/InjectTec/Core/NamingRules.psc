Scriptname InjectTec:Core:NamingRules
{Logic related to merging InstanceNamingRules records with each other.}

Function append(InstanceNamingRules innrTarget, InstanceNamingRules innrAdditions) global
{Trivial, except for logging.  Useful for debugging.}
	innrTarget.mergeWith(innrAdditions)
	Debug.Trace("[InjectTec][NamingRules] target: " + innrTarget + " additions: " + innrAdditions)
EndFunction
