Scriptname InjectTec:Core:FormList Hidden Const
{Logic related to injecting Form records into FormList records.}

Function addForm(FormList flTarget, Form fItem) Global
{Trivial, except for the logging.  Useful for debugging.}
	InjectTec:Logger:Injection.log(flTarget, fItem)
	flTarget.addForm(fItem)
EndFunction

Function addFormList(FormList flTarget, FormList flItems) Global
{Adds the Form records in flItems to the FormList flTarget.}
	InjectTec:Logger:Injection.log(flTarget, flItems)
	Int iCounter = 0
	Int iSize = flItems.getSize()
	While (iCounter < iSize)
		flTarget.addForm(flItems.getAt(iCounter))
		iCounter += 1
	EndWhile
EndFunction

Function addFormArray(FormList flTarget, Form[] fForms) Global
{Adds the Form records in fForms to the FormList flTarget.}
	InjectTec:Logger:Injection.logArray(flTarget, fForms)
	Int iCounter = 0
	While (iCounter < fForms.Length)
		flTarget.addForm(fForms[iCounter])
		iCounter += 1
	EndWhile
EndFunction

Function removeForm(FormList flTarget, Form fRecord) Global
{Trivial, except for the logging.  Useful for debugging.}
	InjectTec:Logger:Reversion.log(flTarget, fRecord)
	flTarget.RemoveAddedForm(fRecord)
EndFunction

Function removeFormList(FormList flTarget, FormList flForms) Global
{Removes the Form records in the flForms FormList from the flTarget FormList.}
	InjectTec:Logger:Reversion.log(flTarget, flForms)
	Int iCounter = 0
	Int iSize = flForms.GetSize()
	while (iCounter < iSize)
		flTarget.RemoveAddedForm(flForms.GetAt(iCounter))
		iCounter += 1
	endwhile
EndFunction

Function removeFormArray(FormList flTarget, Form[] fForms) Global
	InjectTec:Logger:Reversion.logArray(flTarget, fForms)
	Int iCounter = 0
	While (iCounter < fForms.Length)
		flTarget.RemoveAddedForm(fForms[iCounter])
		iCounter += 1
	EndWhile
EndFunction
