Scriptname InjectTec:Plugin extends Quest Hidden
{Base class for scripts which represent a plugin from which forms should be loaded or a group of plugins which contain variations on forms with the same form IDs which should be loaded from one of its versions.}

Import InjectTec:Utility:HexidecimalLogic

Bool Function isPluginInstalled(String sFilename) Global
	return Game.isPluginInstalled(sFilename)
EndFunction

String Function getFilenameHelper()
{Override this method based on how the filename representing this plugin should be decided.}
	InjectTec:Logger:Plugin.behaviorUndefined(self, "getFilenameHelper()")
	return ""
EndFunction

String Function getFilename()
	String sFilename = getFilenameHelper()
	if ("" == sFilename)
		InjectTec:Logger:Plugin.noFilename(self)
	endif
	
	return sFilename
EndFunction

Bool Function isInstalled()
	return isPluginInstalled(getFilename())
EndFunction

Form Function fetch(String sPluginName, Int iFormID) Global
{Trivial, except for the logging.  This is the sort of thing that you have to diagnose post-runtime to find out if the plugin name / ID was correct.}
	if (!isPluginInstalled(sPluginName))
		InjectTec:Logger:Plugin.notInstalled(sPluginName)
		return None
	endif
	
	Form found = Game.GetFormFromFile(iFormID, sPluginName) ; parameter orders seem wrong to me, but I program in PHP during the day, so it's not like I'm triggered by it or anything
	if (!found)
		InjectTec:Logger:Plugin.lookupFailed(sPluginName, iFormID)
	endif
	
	return found
EndFunction

Form Function lookup(Int iFormID)
	return fetch(getFilename(), iFormID)
EndFunction

Form Function fetchFromDigits(String sPluginName, DigitSet digits) Global
	if (!isPluginInstalled(sPluginName))
		InjectTec:Logger:Plugin.notInstalled(sPluginName)
		return None
	endif
	
	Form found = Game.GetFormFromFile(getDigitSetValue(digits), sPluginName)
	if (!found)
		InjectTec:Logger:Plugin.digitLookupFailed(sPluginName, digits)
	endif
	
	return found
EndFunction

Form Function lookupWithDigits(DigitSet digits)
	return fetchFromDigits(getFilename(), digits)
EndFunction

Form Function fetchFromCoalescedID(String sPluginName, Int iID = 0, DigitSet digits = None) Global
	if (iID)
		return fetch(sPluginName, iID)
	elseif (digits)
		return fetchFromDigits(sPluginName, digits)
	endif
	
	return None
EndFunction

Form Function lookupWithCoalescedID(Int iID = 0, DigitSet digits = None)
	return fetchFromCoalescedID(getFilename(), iID, digits)
EndFunction

Form[] Function fetchArray(String sPluginName, Int[] iaFormIDs) Global
{Returns an array of Form records from this particular plugin matching the IDs in iaFormIDs or None if one or more Form records cannot be located or invalid values are provided.}
	if (!isPluginInstalled(sPluginName))
		InjectTec:Logger:Plugin.notInstalled(sPluginName)
		return None
	endif
	
	if (!iaFormIDs)
		return None
	endif
	
	Form[] results = new Form[0]
	
	Int iCurrentID = 0
	Int iCounter = 0
	Form fCurrentForm = None
	
	while (iCounter < iaFormIDs.Length)
		iCurrentID = iaFormIDs[iCounter]
		fCurrentForm = Game.GetFormFromFile(iCurrentID, sPluginName)
		
		if (!fCurrentForm)
			InjectTec:Logger:Plugin.lookupFailed(sPluginName, iCurrentID)
			return None
		endif
		
		results.Add(fCurrentForm)
		
		iCounter += 1
	endWhile
	
	return results
EndFunction

Form[] Function lookupArray(Int[] iaFormIDs)
	return fetchArray(getFilename(), iaFormIDs)
EndFunction

Form[] Function fetchArrayFromDigitSets(String sPluginName, DigitSet[] aDigitSets) Global
{Returns an array of Form records from this particular plugin matching the IDs in iaDigitSets or None if one or more Form records cannot be located or invalid values are provided.}
	if (!isPluginInstalled(sPluginName))
		InjectTec:Logger:Plugin.notInstalled(sPluginName)
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
			InjectTec:Logger:Plugin.digitLookupFailed(sPluginName, currentDigits)
			return None
		endif
		
		results.Add(fCurrentForm)
		
		iCounter += 1
	endWhile
	
	return results
EndFunction

Form[] Function lookupArrayWithDigitSets(DigitSet[] aDigitSets)
	return fetchArrayFromDigitSets(getFilename(), aDigitSets)
EndFunction

Form[] Function fetchArrayFromCoalescedIDs(String sPluginName, Int[] iaIDs = None, DigitSet[] aDigitSets = None) Global
	if (iaIDs && iaIDs.Length)
		return fetchArray(sPluginName, iaIDs)
	elseif (aDigitSets && aDigitSets.Length)
		return fetchArrayFromDigitSets(sPluginName, aDigitSets)
	endif
	
	return None
EndFunction

Form[] Function lookupArrayWithCoalescedIDs(Int[] aiIDs = None, DigitSet[] aDigitSets = None)
	return fetchArrayFromCoalescedIDs(getFilename(), aiIDs, aDigitSets)
EndFunction
