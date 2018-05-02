Scriptname InjectTec:Plugin extends Quest Hidden
{Base class for scripts which represent a plugin from which forms should be loaded or a group of plugins which contain variations on forms with the same form IDs which should be loaded from one of its versions.}

Import InjectTec:HexidecimalLogic

String Function getFilename()
{Override this method based on how the filename representing this plugin should be decided.}
	InjectTec:Logger:Plugin.behaviorUndefined(self, "getFilename()")
	return ""
EndFunction

Bool Function isInstalled()
{See InjectTec:Core:Plugin.isPluginInstalled()}
	return InjectTec:Core:Plugin.isPluginInstalled(getFilename())
EndFunction

Form Function lookupForm(Int iFormID)
{See InjectTec:Core:Plugin.fetchForm()}
	return InjectTec:Core:Plugin.fetchForm(getFilename(), iFormID)
EndFunction

Form[] Function lookupForms(Int[] iaFormIDs)
{Returns an array of Form records from this particular plugin matching the IDs in iaFormIDs or None if one or more Form records cannot be located.}
	Form[] faResults = new Form[0]
	Int iCounter = 0
	Form fNew = None
	
	While (iCounter < iaFormIDs.Length)
		fNew = lookupForm(iaFormIDs[iCounter])
		if (!fNew)
			return None
		endif
		faResults.Add(fNew)
		iCounter += 1
	EndWhile
	
	return faResults
EndFunction

Form[] Function lookupFormsFromDigitSets(DigitSet[] digitSets)
	return lookupForms(getDigitSetValues(digitSets))
EndFunction

FormList Function lookupFormList(Int iFormID)
{See InjectTec:Core:Plugin.fetchFormList()}
	return InjectTec:Core:Plugin.fetchFormList(getFilename(), iFormID)
EndFunction

LeveledItem Function lookupLeveled(Int iFormID)
{See InjectTec:Core:Plugin.fetchLeveled()}
	return InjectTec:Core:Plugin.fetchLeveled(getFilename(), iFormID)
EndFunction

InstanceNamingRules Function lookupNamingRules(Int iFormID)
{See InjectTec:Core:Plugin.fetchNamingRules()}
	return InjectTec:Core:Plugin.fetchNamingRules(getFilename(), iFormID)
EndFunction
