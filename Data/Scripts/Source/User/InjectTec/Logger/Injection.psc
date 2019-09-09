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

Bool Function log(String sMessage) Global
	return InjectTec:Logger.log(sMessage, getTags())
EndFunction

Bool Function warn(String sMessage) Global
	return InjectTec:Logger.warn(sMessage, getTags())
EndFunction

Bool Function error(String sMessage) Global
	return InjectTec:Logger.error(sMessage, getTags())
EndFunction

Bool Function logInjection(Form fTarget, Form fAddition) Global
	return log("target: " + fTarget + " adding: " + fAddition)
EndFunction

Bool Function logLeveledInjection(LeveledItem liTarget, Form fAddition, Int iLevel, Int iAmount) Global
	return log("target: " + liTarget + " adding: " + fAddition + " level: " + iLevel + " amount: " + iAmount)
EndFunction

Bool Function logArray(Form fTarget, Form[] faAdditions) Global
	return log("target: " + fTarget + " adding: " + faAdditions)
EndFunction

Bool Function leveled(LeveledItem liTarget, FormList flForms, Int iLevel, Int iAmount) Global
	return log("target: " + liTarget + " adding: " + flForms + " level: " + iLevel + " amount: " + iAmount)
EndFunction

Bool Function leveledArray(LeveledItem liTarget, Form[] faForms, Int iLevel, Int iAmount) Global
	return log("target: " + liTarget + " adding: " + faForms + " level: " + iLevel + " amount: " + iAmount)
EndFunction

Bool Function leveledGranular(LeveledItem liTarget, FormList flForms, Int[] iaLevels, Int[] iaAmounts) Global
	return log("target: " + liTarget + " adding: " + flForms + " levels: " + collapseInts(iaLevels) + " amounts: " + collapseInts(iaAmounts))
EndFunction

Bool Function leveledGranularSizeMismatch(LeveledItem liTarget, FormList flForms, Int[] iaLevels, Int[] iaAmounts) Global
	return error("target: " + liTarget + " list size: " + flForms.GetSize() + " levels size: " + iaLevels.Length + " amounts size: " + iaAmounts.Length)
EndFunction

Bool Function leveledGranularArray(LeveledItem liTarget, Form[] faForms, Int[] iaLevels, Int[] iaAmounts) Global
	return log("target: " + liTarget + " adding: " + faForms + " levels: " + collapseInts(iaLevels) + " amounts: " + collapseInts(iaAmounts))
EndFunction

Bool Function leveledGranularArraySizeMismatch(LeveledItem liTarget, Form[] faForms, Int[] iaLevels, Int[] iaAmounts) Global
	return error("target: " + liTarget + " list size: " + faForms.Length + " levels size: " + iaLevels.Length + " amounts size: " + iaAmounts.Length)
EndFunction
