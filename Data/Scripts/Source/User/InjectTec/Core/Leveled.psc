Scriptname InjectTec:Core:Leveled Hidden Const
{Logic related to injecting Form records to LeveledItem records.}

Function addForm(LeveledItem liTarget, Form fItem, Int iLevel = 1, Int iAmount = 1) Global
{Trivial, except for logging.  Useful for debugging.}
	liTarget.addForm(fItem, iLevel, iAmount)
	Debug.Trace("[InjectTec][LeveledItem] target: " + liTarget + " addition: " + fItem)
EndFunction

Function addFormList(LeveledItem liTarget, FormList flForms, Int iLevel = 1, Int iAmount = 1) Global
{Adds the Form records in the flForms FormList to the LeveledItem liTarget.}
	Int iCounter = 0
	Int iSize = flForms.getSize()
	While (iCounter < iSize)
		addForm(liTarget, flForms.getAt(iCounter), iLevel, iAmount)
		iCounter += 1
	EndWhile
EndFunction

Function addFormListGranular(LeveledItem liTarget, FormList flForms, Int[] Levels, Int[] Amounts) Global
{Adds the Form records in the flForms FormList to the LeveledItem liTarget.  Note this behavior requires Int arrays with the same length as flForms which provide the level and quantity values for each Form.}
	Int iCounter = 0
	Int iSize = flForms.getSize()
	
	If ( (iSize != Levels.Length) || (iSize != Amounts.Length) )
		Debug.Trace("[InjectTec][Leveled] forms / levels / amounts data size mismatch, no insertion performed")
		return
	EndIf
	
	While (iCounter < iSize)
		addForm(liTarget, flForms.getAt(iCounter), Levels[iCounter], Amounts[iCounter])
		iCounter += 1
	EndWhile
EndFunction

Function revert(LeveledItem liTarget) Global
{Trivial, except for logging.  Especially useful for debugging because this behavior is known to be particularly destructive.}
	liTarget.revert()
	Debug.Trace("[InjectTec][Leveled] reverting " + liTarget)
EndFunction
