Scriptname InjectTec:Core:Leveled Hidden Const
{Logic related to injecting Form records to LeveledItem records.}

Function addForm(LeveledItem liTarget, Form fItem, Int iLevel = 1, Int iAmount = 1) Global
{Trivial, except for logging.  Useful for debugging.}
	InjectTec:Logger:Injection.log(liTarget, fItem)
	liTarget.AddForm(fItem, iLevel, iAmount)
EndFunction

Function addFormList(LeveledItem liTarget, FormList flForms, Int iLevel = 1, Int iAmount = 1) Global
{Adds the Form records in the flForms FormList to the LeveledItem liTarget.}
	InjectTec:Logger:Injection.leveled(liTarget, flForms, iLevel, iAmount)
	Int iCounter = 0
	Int iSize = flForms.getSize()
	While (iCounter < iSize)
		liTarget.AddForm(flForms.getAt(iCounter), iLevel, iAmount)
		iCounter += 1
	EndWhile
EndFunction

Function addFormArray(LeveledItem liTarget, Form[] fForms, Int iLevel = 1, Int iAmount = 2) Global
{Adds the Form records in fForms to the LeveledItem liTarget.}
	InjectTec:Logger:Injection.logArray(liTarget, fForms)
	Int iCounter = 0
	While (iCounter < fForms.Length)
		liTarget.addForm(fForms[iCounter], iLevel, iAmount)
		iCounter += 1
	EndWhile
EndFunction

Function addFormListGranular(LeveledItem liTarget, FormList flForms, Int[] Levels, Int[] Amounts) Global
{Adds the Form records in the flForms FormList to the LeveledItem liTarget.  Note this behavior requires Int arrays with the same length as flForms which provide the level and quantity values for each Form.}
	Int iCounter = 0
	Int iSize = flForms.getSize()
	
	If ( (iSize != Levels.Length) || (iSize != Amounts.Length) )
		InjectTec:Logger:Injection.leveledGranularSizeMismatch(liTarget, flForms, Levels, Amounts)
		return
	EndIf
	
	InjectTec:Logger:Injection.leveledGranular(liTarget, flForms, Levels, Amounts)
	While (iCounter < iSize)
		liTarget.AddForm(flForms.getAt(iCounter), Levels[iCounter], Amounts[iCounter])
		iCounter += 1
	EndWhile
EndFunction

Function addFormArrayGranular(LeveledItem liTarget, Form[] fForms, Int[] Levels, Int[] Amounts) Global
{Adds the Form records in fForms to the LeveledItem liTarget.  Note this behavior requires Int arrays with the same length as fForms which provide the level and quantity values for each Form.}
	Int iCounter = 0
	
	If ( (fForms.Length != Levels.Length) || (fForms.Length != Amounts.Length) )
		InjectTec:Logger:Injection.leveledGranularArraySizeMismatch(liTarget, fForms, Levels, Amounts)
		return
	EndIf
	
	InjectTec:Logger:Injection.leveledGranularArray(liTarget, fForms, Levels, Amounts)
	While (iCounter < fForms.Length)
		liTarget.AddForm(fForms[iCounter], Levels[iCounter], Amounts[iCounter])
		iCounter += 1
	EndWhile
EndFunction

Function revert(LeveledItem liTarget) Global
{Trivial, except for logging.  Especially useful for debugging because this behavior is known to be particularly destructive.}
	InjectTec:Logger:Reversion.leveled(liTarget)
	liTarget.revert()
EndFunction
