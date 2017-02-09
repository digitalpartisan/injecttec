Scriptname InjectTec:Logger:Injection Hidden Const DebugOnly

String[] Function getTags() Global
	String[] tags = new String[1]
	tags[0] = "Injection"
	return tags
EndFunction

String Function collapseInts(Int[] values) Global
	if (0 == values.Length)
		return ""
	endif
	
	String sResult = ""
	Int iCounter = 0
	While (iCounter < values.Length)
		if (iCounter > 0)
			sResult += "-"
		endif
		sResult += values[iCounter]
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

Bool Function leveled(LeveledItem liTarget, Formlist flForms, Int iLevel, Int iAmount) Global
	return Loggout.log(InjectTec:Logger.getName(), "target: " + liTarget + " adding: " + flForms + " level: " + iLevel + " amount: " + iAmount, getTags())
EndFunction

Bool Function leveledGranular(LeveledItem liTarget, Formlist flForms, Int[] Levels, Int[] Amounts) Global
	return Loggout.log(InjectTec:Logger.getName(), "target: " + liTarget + " adding: " + flForms + " levels: " + collapseInts(Levels) + " amounts: " + collapseInts(Amounts), getTags())
EndFunction

Bool Function leveledGranularSizeMismatch(LeveledItem liTarget, Formlist flForms, Int[] Levels, Int[] Amounts) Global
	return error("target: " + liTarget + " list size: " + flForms.GetSize() + " levels size: " + Levels.Length + " amounts size: " + Amounts.Length)
EndFunction
