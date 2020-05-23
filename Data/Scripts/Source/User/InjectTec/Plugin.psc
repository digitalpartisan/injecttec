Scriptname InjectTec:Plugin extends Quest Hidden
{Base class for scripts which represent a plugin from which forms should be loaded or a group of plugins which contain variations on forms with the same form IDs which should be loaded from one of its versions.}

Import InjectTec:Utility:HexidecimalLogic

Bool Function isPluginInstalled(String sFilename) Global
	return Game.isPluginInstalled(sFilename)
EndFunction

String Function getFilenameHelper()
{Override this method based on how the filename representing this plugin should be decided.}
	InjectTec:Plugin:Logger.behaviorUndefined(self, "getFilenameHelper()")
	return ""
EndFunction

String Function getFilename()
	String sFilename = getFilenameHelper()
	if ("" == sFilename)
		InjectTec:Plugin:Logger.noFilename(self)
	endif
	
	return sFilename
EndFunction

Bool Function isInstalled()
	return isPluginInstalled(getFilename())
EndFunction

Bool Function isInstalledBulk(InjectTec:Plugin[] plugins) Global
	if (!plugins || !plugins.Length)
		return true ; because none of them are not installed, technically
	endif
	
	Int iCounter = 0
	while (iCounter < plugins.Length)
		if (!plugins[iCounter])
			return false ; because something is very broken
		endif
		
		if (!plugins[iCounter].isInstalled())
			return false
		endif
		
		iCounter += 1
	endWhile
	
	return true ; every plugin is installed
EndFunction

Form Function fetchInt(String sPluginName, Int formID) Global
	if (!isPluginInstalled(sPluginName))
		InjectTec:Plugin:Logger.notInstalled(sPluginName)
		return None
	endif
	
	Form found = Game.GetFormFromFile(formID, sPluginName)
	if (!found)
		InjectTec:Plugin:Logger.lookupFailed(sPluginName, formID)
	endif
	
	return found
EndFunction

Form Function lookupInt(Int formID)
	return fetchInt(getFilename(), formID)
EndFunction

Form Function fetch(String sPluginName, DigitSet digits) Global
	return fetchInt(sPluginName, getDigitSetValue(digits))
EndFunction

Form Function lookup(DigitSet digits)
	return fetch(getFilename(), digits)
EndFunction

Form[] Function fetchArray(String sPluginName, DigitSet[] aDigitSets) Global
{Returns an array of Form records from this particular plugin matching the IDs in iaDigitSets or None if one or more Form records cannot be located or invalid values are provided.}
	if (!isPluginInstalled(sPluginName))
		InjectTec:Plugin:Logger.notInstalled(sPluginName)
		return None
	endif
	
	if (!aDigitSets)
		return None
	endif
	
	Form[] results = new Form[0]
	
	DigitSet currentDigits = None
	Int iCounter = 0
	Form fCurrentForm = None
	
	while (iCounter < aDigitSets.Length)
		currentDigits = aDigitSets[iCounter]
		fCurrentForm = Game.GetFormFromFile(getDigitSetValue(currentDigits), sPluginName)
		
		if (!fCurrentForm)
			InjectTec:Plugin:Logger.digitLookupFailed(sPluginName, currentDigits)
			return None
		endif
		
		results.Add(fCurrentForm)
		
		iCounter += 1
	endWhile
	
	return results
EndFunction

Form[] Function lookupArray(DigitSet[] aDigitSets)
	return fetchArray(getFilename(), aDigitSets)
EndFunction
