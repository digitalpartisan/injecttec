Scriptname InjectTec:Utility:FormList extends InjectTec:Utility:Loader
{Logic related to injecting Form records into FormList records.  Generally used to fetch records for Injection, but can be attached in the editor to load records for other purposes.}

Import InjectTec:Utility:HexidecimalLogic

Function addForm(FormList flTarget, Form fItem) Global
{Trivial, except for the logging.  Useful for debugging.}
	InjectTec:Utility:Logger.logInjection(flTarget, fItem)
	flTarget.addForm(fItem)
EndFunction

Function addFormList(FormList flTarget, FormList flItems) Global
{Adds the Form records in flItems to the FormList flTarget.}
	InjectTec:Utility:Logger.logInjection(flTarget, flItems)
	
	Int iCounter = 0
	Int iSize = flItems.getSize()
	
	While (iCounter < iSize)
		flTarget.addForm(flItems.getAt(iCounter))
		iCounter += 1
	EndWhile
EndFunction

Function addForms(FormList flTarget, Form[] faForms) Global
{Adds the Form records in faForms to the FormList flTarget.}
	InjectTec:Utility:Logger.logArray(flTarget, faForms)
	
	Int iCounter = 0
	
	While (iCounter < faForms.Length)
		flTarget.addForm(faForms[iCounter])
		iCounter += 1
	EndWhile
EndFunction

Bool Function verifyForm(FormList flTarget, Form fItem) Global
{Returns true if flTarget contains fItem and false otherwise.}
	return flTarget.HasForm(fItem)
EndFunction

Bool Function verifyFormList(FormList flTarget, FormList flAdditions) Global
{Returns true if each of the forms in flAdditions is also in flTarget and false otherwise.}
	Int iCounter = 0
	Int iSize = flAdditions.GetSize()
	
	While (iCounter < iSize)
		if (!verifyForm(flTarget, flAdditions.GetAt(iCounter)))
			return false
		endif
		
		iCounter += 1
	EndWhile
	
	return true
EndFunction

Bool Function verifyForms(FormList flTarget, Form[] faAdditions) Global
{Returns true if each of the forms in faAdditions is also in flTarget and false otherwise.}
	Int iCounter = 0
	
	While (iCounter < faAdditions.Length)
		if (!verifyForm(flTarget, faAdditions[iCounter]))
			return false
		endif
		iCounter += 1
	EndWhile
	
	return true
EndFunction

Function removeForm(FormList flTarget, Form fRecord) Global
{Trivial, except for the logging.  Useful for debugging.}
	InjectTec:Utility:Logger.reverting(flTarget, fRecord)
	flTarget.RemoveAddedForm(fRecord)
EndFunction

Function removeFormList(FormList flTarget, FormList flForms) Global
{Removes the Form records in the flForms FormList from the flTarget FormList.}
	InjectTec:Utility:Logger.reverting(flTarget, flForms)
	
	Int iCounter = 0
	Int iSize = flForms.GetSize()
	
	while (iCounter < iSize)
		flTarget.RemoveAddedForm(flForms.GetAt(iCounter))
		iCounter += 1
	endwhile
EndFunction

Function removeForms(FormList flTarget, Form[] faForms) Global
{Removes the Form records in faForms from flTarget.}
	InjectTec:Utility:Logger.logRevertingArray(flTarget, faForms)
	
	Int iCounter = 0
	
	While (iCounter < faForms.Length)
		flTarget.RemoveAddedForm(faForms[iCounter])
		iCounter += 1
	EndWhile
EndFunction

FormList Function load(FormList record = None, InjectTec:Plugin plugin = None, DigitSet digits = None) Global
	return InjectTec:Utility:Loader.loadHelper(record, plugin, digits) as FormList
EndFunction

FormList Function get()
	return concreteLoad() as FormList
EndFunction
