Scriptname InjectTec:Core:Leveled Hidden Const
{Logic related to injecting Form records to LeveledItem records.}

Struct InjectionData
	Form fForm = None
	{The Form record to inject.}
	Int iLevel = 1
	{The level at which the list should generate the item indicated by fForm.}
	Int iAmount = 1
	{The amount of fForm to generate.}
EndStruct

InjectionData Function buildInjectionData(Form fForm, Int iLevel = 1, Int iAmount = 1) Global
{Returns an InjectionData object to be used with addInjectionData() or addInjectionDataBulk().  Returns None if no fForm value is given.}
	if (None == fForm)
		return None
	endif
	
	InjectionData newData = new InjectionData
	newData.fForm = fForm
	newData.iLevel = iLevel
	newData.iAmount = iAmount
	
	return newData
EndFunction

Function addForm(LeveledItem liTarget, Form fItem, Int iLevel = 1, Int iAmount = 1) Global
{Trivial, except for logging.  Useful for debugging.}
	InjectTec:Logger:Injection.log(liTarget, fItem)
	liTarget.AddForm(fItem, iLevel, iAmount)
EndFunction

Function addInjectionData(LeveledItem liTarget, InjectionData dataSet) Global
{Uses an InjectionData value to inject forms with specific level and amount information into liTarget.}
	addForm(liTarget, dataSet.fForm, dataSet.iLevel, dataSet.iAmount)
EndFunction

Function addInjectionDataBulk(LeveledItem liTarget, InjectionData[] dataSets) Global
{Synactical sugar for calling addInjectionData() with an array of InjectionData values.}
	Int iCounter = 0
	while (iCounter < dataSets.Length)
		addInjectionData(liTarget, dataSets[iCounter])
		iCounter += 1
	endwhile
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

Function addForms(LeveledItem liTarget, Form[] faForms, Int iLevel = 1, Int iAmount = 2) Global
{Adds the Form records in faForms to the LeveledItem liTarget.}
	InjectTec:Logger:Injection.logArray(liTarget, faForms)
	Int iCounter = 0
	While (iCounter < faForms.Length)
		liTarget.addForm(faForms[iCounter], iLevel, iAmount)
		iCounter += 1
	EndWhile
EndFunction

Function addFormListGranular(LeveledItem liTarget, FormList flForms, Int[] iaLevels, Int[] iaAmounts) Global
{Adds the Form records in the flForms FormList to the LeveledItem liTarget.  Note this behavior requires Int arrays with the same length as flForms which provide the level and quantity values for each Form.}
	Int iCounter = 0
	Int iSize = flForms.getSize()
	
	If ( (iSize != iaLevels.Length) || (iSize != iaAmounts.Length) )
		InjectTec:Logger:Injection.leveledGranularSizeMismatch(liTarget, flForms, iaLevels, iaAmounts)
		return
	EndIf
	
	InjectTec:Logger:Injection.leveledGranular(liTarget, flForms, iaLevels, iaAmounts)
	While (iCounter < iSize)
		liTarget.AddForm(flForms.getAt(iCounter), iaLevels[iCounter], iaAmounts[iCounter])
		iCounter += 1
	EndWhile
EndFunction

Function addFormsGranular(LeveledItem liTarget, Form[] faForms, Int[] iaLevels, Int[] iaAmounts) Global
{Adds the Form records in faForms to the LeveledItem liTarget.  Note this behavior requires Int arrays with the same length as faForms which provide the level and quantity values for each Form.}
	Int iCounter = 0
	
	If ( (faForms.Length != iaLevels.Length) || (faForms.Length != iaAmounts.Length) )
		InjectTec:Logger:Injection.leveledGranularArraySizeMismatch(liTarget, faForms, iaLevels, iaAmounts)
		return
	EndIf
	
	InjectTec:Logger:Injection.leveledGranularArray(liTarget, faForms, iaLevels, iaAmounts)
	While (iCounter < faForms.Length)
		liTarget.AddForm(faForms[iCounter], iaLevels[iCounter], iaAmounts[iCounter])
		iCounter += 1
	EndWhile
EndFunction

Function revert(LeveledItem liTarget) Global
{Trivial, except for logging.  Especially useful for debugging because this behavior is known to be particularly destructive.}
	InjectTec:Logger:Reversion.leveled(liTarget)
	liTarget.revert()
EndFunction
