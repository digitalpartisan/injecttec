Scriptname InjectTec:Logger:Injection Hidden Const DebugOnly

String[] Function getTags() Global
	String[] tags = new String[1]
	tags[0] = "Injection"
	return tags
EndFunction

String Function collapseInts(Int[] iaValues) Global
	if (0 == iaValues.Length)
		return ""
	endif
	
	String sResult = ""
	Int iCounter = 0
	While (iCounter < iaValues.Length)
		if (iCounter > 0)
			sResult += "-"
		endif
		sResult += iaValues[iCounter]
		iCounter += 1
	EndWhile
	
	return sResult
EndFunction

Bool Function log(Form fTarget, Form fAddition) Global
	return Loggout.log(InjectTec:Logger.getName(), "target: " + fTarget + " adding: " + fAddition, getTags())
EndFunction

Bool Function warn(String sMessage) Global
	return Loggout.warn(InjectTec:Logger.getName(), sMessage, getTags())
EndFunction

Bool Function error(String sMessage) Global
	return Loggout.error(InjectTec:Logger.getName(), sMessage, getTags())
EndFunction

Bool Function logArray(Form fTarget, Form[] faAdditions) Global
	return Loggout.log(InjectTec:Logger.getName(), "target: " + fTarget + " adding: " + faAdditions, getTags())
EndFunction

Bool Function leveled(LeveledItem liTarget, FormList flForms, Int iLevel, Int iAmount) Global
	return Loggout.log(InjectTec:Logger.getName(), "target: " + liTarget + " adding: " + flForms + " level: " + iLevel + " amount: " + iAmount, getTags())
EndFunction

Bool Function leveledGranular(LeveledItem liTarget, FormList flForms, Int[] iaLevels, Int[] iaAmounts) Global
	return Loggout.log(InjectTec:Logger.getName(), "target: " + liTarget + " adding: " + flForms + " levels: " + collapseInts(iaLevels) + " amounts: " + collapseInts(iaAmounts), getTags())
EndFunction

Bool Function leveledGranularSizeMismatch(LeveledItem liTarget, FormList flForms, Int[] iaLevels, Int[] iaAmounts) Global
	return error("target: " + liTarget + " list size: " + flForms.GetSize() + " levels size: " + iaLevels.Length + " amounts size: " + iaAmounts.Length)
EndFunction

Bool Function leveledGranularArray(LeveledItem liTarget, Form[] faForms, Int[] iaLevels, Int[] iaAmounts) Global
	return Loggout.log(InjectTec:Logger.getName(), "target: " + liTarget + " adding: " + faForms + " levels: " + collapseInts(iaLevels) + " amounts: " + collapseInts(iaAmounts), getTags())
EndFunction

Bool Function leveledGranularArraySizeMismatch(LeveledItem liTarget, Form[] faForms, Int[] iaLevels, Int[] iaAmounts) Global
	return error("target: " + liTarget + " list size: " + faForms.Length + " levels size: " + iaLevels.Length + " amounts size: " + iaAmounts.Length)
EndFunction
