Scriptname InjectTec:Core:FormList Hidden Const
{Logic related to injecting Form records into FormList records.}

Function addForm(FormList flTarget, Form fItem) Global
{Trivial, except for the logging.  Useful for debugging.}
	flTarget.addForm(fItem)
	Debug.Trace("[InjectTec][FormList] target: " + flTarget + " addition: " + fItem)
EndFunction

Function addFormList(FormList flTarget, FormList flItems) Global
{Adds the Form records in flItems to the FormList flTarget.}
	Int iCounter = 0
	Int iSize = flItems.getSize()
	While (iCounter < iSize)
		addForm(flTarget, flItems.getAt(iCounter))
		iCounter += 1
	EndWhile
EndFunction

Function removeForm(FormList flTarget, Form fRecord) Global
{Trivial, except for the logging.  Useful for debugging.}
	flTarget.RemoveAddedForm(fRecord)
	Debug.Trace("[InjectTec][FormList] removed " + fRecord + " from " + flTarget)
EndFunction

Function removeFormList(FormList flTarget, FormList flForms) Global
{Removes the Form records in the flForms FormList from the flTarget FormList.}
	Int iCounter = 0
	Int iSize = flForms.GetSize()
	while (iCounter < iSize)
		removeForm(flTarget, flForms.GetAt(iCounter))
		iCounter += 1
	endwhile
EndFunction
