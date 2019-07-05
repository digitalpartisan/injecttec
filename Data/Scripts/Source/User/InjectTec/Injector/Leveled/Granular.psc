Scriptname InjectTec:Injector:Leveled:Granular extends InjectTec:Injector:Leveled Conditional
{Attach this script in the editor to inject append the Form records from a FormList source record to a targetted LeveledItem record with granular control over which levels and quantities are used for each Form record added.
See notes on InjectTec:Core:Leveled.addFormListGranular() for specifics.}

Import InjectTec:Utility:LeveledItem
Import InjectTec:Utility:HexidecimalLogic

Group SourceSettings
	InjectTec:Plugin Property SourcePlugin = None Auto Const
	InjectTec:Injector:Leveled:Granular:FormSetting[] Property FormSettings = None Auto Const
EndGroup

GranularFormData[] sourceData = None

GranularFormData[] Function getSource()
	return sourceData
EndFunction

Bool Function canLoadSource()
	if (!FormSettings || !FormSettings.Length)
		return false
	endif
	
	GranularFormData[] loadResults = new GranularFormData[0]
	Int iCounter = 0
	GranularFormData currentData = None
	
	while (iCounter < FormSettings.Length)
		currentData = FormSettings[iCounter].getGranularFormData(SourcePlugin)
		if (!currentData)
			return false
		endif
		
		loadResults.Add(currentData)
		iCounter += 1
	endWhile
	
	sourceData = loadResults
	return true
EndFunction

Function clear()
	sourceData = None
	parent.clear()
EndFunction

Function injectBehavior()
	InjectTec:Utility:LeveledItem.addGranularFormDataArray(getTarget(), getSource())
EndFunction
