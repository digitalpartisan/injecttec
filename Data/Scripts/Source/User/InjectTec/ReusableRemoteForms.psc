Scriptname InjectTec:ReusableRemoteForms extends Quest
{Useful for repeatedly pulling large numbers of remote forms into multiple target locations.  May or may not be useful outside of very large compatability patches or other similar mods.}

Struct FormData
	Int FormID
	{The base 10 ID of the form to remote load.}
	String Name
	{Name used to lookup the FormID of a specific record.  It is best to make this unique to the list stored on a specific object or else FormData values with repeated Name attributes will not be found by findFromName().}
EndStruct

InjectTec:Plugin Property MyPlugin Auto Const Mandatory
{The plugin to reference for the forms specified by Forms.}
FormData[] Property Forms Auto Const Mandatory
{The remote IDs to load from MyPlugin.}

FormData Function getFormData(Int iIndex = 0)
{Returns the FormData at iIndex in Forms provided a valid iIndex value is given and None otherwise.}
	if (0 <= iIndex && iIndex < Forms.Length)
		return Forms[iIndex]
	else
		return None
	endif
EndFunction

Form Function loadFromData(FormData fdValue = None)
{Returns the Form record indicated by the FormID in fdValue if it can be successfully loaded and None otherwise.}
	if (None == fdValue)
		return None
	endif
	
	return InjectTec:Loader:Form.load(false, None, MyPlugin, fdValue.FormID)
EndFunction

Form Function loadFormAtIndex(Int iIndex = 0)
{Returns the Form record specified by the FormData value at iIndex in Forms provided a valid iIndex value is given and the lookup succeeds and None otherwise.}
	return loadFromData(getFormData(iIndex))
EndFunction

FormData Function findFromName(String sName = "")
{This may or may not be helpful in larger packages or situations where a plugin referncing the list this object contains needs only on or a few records indicated by Forms for a specific purpose.  Locates a FormData value in Forms using its Name attribute.  May return None if no matches are found.}
	if ("" == sName)
		return None
	endif
	
	Int iIndex = Forms.FindStruct("Name", sName)
	if (iIndex < 0)
		return None
	endif
	
	return Forms[iIndex]
EndFunction

Form Function loadFromName(String sName = "")
{Loads the Form record specified by the FormData value in Forms having the Name attribute of sName.  May return None if no FormData value is matched or if the lookup fails.}
	FormData fdValue = findFromName(sName)
	if (None == fdValue)
		return None
	endif
	
	return loadFromData(fdValue)
EndFunction

Form[] Function loadAll()
{Returns an array of Form records matching those specified by the ID attributes of the FormData values in Forms.  May return None if one or more of the lookups fails.}
	Form[] faResults = new Form[0]
	
	Int iCounter = 0
	Form fTemp = None
	while (iCounter < Forms.Length)
		fTemp = loadFormAtIndex(iCounter)
		if (!fTemp)
			return None
		endif
		faResults.Add(fTemp)
		iCounter += 1
	endwhile
	
	return faResults
EndFunction
