Scriptname InjectTec:Utility:LeveledItem extends InjectTec:Utility:Loader
{Logic related to injecting Form records to LeveledItem records.  Generally used to fetch records for Injection, but can be attached in the editor to load records for other purposes.}

Import InjectTec:Utility:HexidecimalLogic

Struct GranularFormData
	Form record = None
	{The Form record to inject.}
	Int level = 1
	{The level at which the list should generate the item indicated by fForm.}
	Int amount = 1
	{The amount of fForm to generate.}
EndStruct

GranularFormData Function buildGranularFormData(Form fForm, Int iLevel = 1, Int iAmount = 1) Global
{Returns an GranularFormData struct to be used with addGranularFormData() and addGranularFormDataArray().  Returns None if no fForm value is given.}
	if (None == fForm)
		return None
	endif
	
	GranularFormData newData = new GranularFormData
	newData.record = fForm
	newData.level = iLevel
	newData.amount = iAmount
	
	return newData
EndFunction

Function addForm(LeveledItem liTarget, Form fItem, Int iLevel = 1, Int iAmount = 1) Global
{Trivial, except for logging.  Useful for debugging.}
	InjectTec:Utility:Logger.logLeveledInjection(liTarget, fItem, iLevel, iAmount)
	liTarget.AddForm(fItem, iLevel, iAmount)
EndFunction

Function addGranularFormData(LeveledItem liTarget, GranularFormData dataSet) Global
{Uses an InjectionData value to inject forms with specific level and amount information into liTarget.}
	addForm(liTarget, dataSet.record, dataSet.level, dataSet.amount)
EndFunction

Function addGranularFormDataArray(LeveledItem liTarget, GranularFormData[] dataSets) Global
{Synactical sugar for calling addInjectionData() with an array of InjectionData values.}
	Int iCounter = 0
	
	while (iCounter < dataSets.Length)
		addGranularFormData(liTarget, dataSets[iCounter])
		iCounter += 1
	endwhile
EndFunction

Function addFormList(LeveledItem liTarget, FormList flForms, Int iLevel = 1, Int iAmount = 1) Global
{Adds the Form records in the flForms FormList to the LeveledItem liTarget.}
	InjectTec:Utility:Logger.leveled(liTarget, flForms, iLevel, iAmount)
	
	Int iCounter = 0
	Int iSize = flForms.getSize()
	
	While (iCounter < iSize)
		addForm(liTarget, flForms.getAt(iCounter), iLevel, iAmount)
		iCounter += 1
	EndWhile
EndFunction

Function addForms(LeveledItem liTarget, Form[] faForms, Int iLevel = 1, Int iAmount = 1) Global
{Adds the Form records in faForms to the LeveledItem liTarget.}
	InjectTec:Utility:Logger.leveledArray(liTarget, faForms, iLevel, iAmount)
	
	Int iCounter = 0
	
	While (iCounter < faForms.Length)
		addForm(liTarget, faForms[iCounter], iLevel, iAmount)
		iCounter += 1
	EndWhile
EndFunction

Function revert(LeveledItem liTarget) Global
{Trivial, except for logging.  Especially useful for debugging because this behavior is known to be particularly destructive.}
	InjectTec:Utility:Logger.revertingLeveled(liTarget)
	liTarget.revert()
EndFunction

LeveledItem Function load(LeveledItem record = None, InjectTec:Plugin plugin = None, DigitSet digits = None) Global
	return InjectTec:Utility:Loader.loadHelper(record, plugin, digits) as LeveledItem
EndFunction

LeveledItem Function get()
	return concreteLoad() as LeveledItem
EndFunction
