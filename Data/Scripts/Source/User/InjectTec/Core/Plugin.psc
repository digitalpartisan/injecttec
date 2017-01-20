Scriptname InjectTec:Core:Plugin
{Logic related to locating forms in plugin files.  Mostly trivial, except that the detail level of logging may be required to diagnose mysterious issues because the compiler can't tell you if you goofed something up.}

Function logMessage(String sLogEntry) global
	Debug.TraceStack("[InjectTec][Plugin]" + sLogEntry)
EndFunction

Function logNotInstalledFailureMessage(String sPluginName) global
	logMessage("form lookup failed, plugin file not installed: " + sPluginName)
EndFunction

Function lookupMessage(String sPluginName, Int iFormID, String sLogEntry) global
	logMessage("file: " + sPluginName + " formID: " + iFormID + " " + sLogEntry)
EndFunction

Bool Function isPluginInstalled(String sFilename) Global
{Does what it says on the tin.}
	return Game.isPluginInstalled(sFilename)
EndFunction

Form Function fetchForm(String sPluginName, Int iFormID) global
{Trivial, except for the logging.  This is the sort of thing that you have to diagnose post-runtime to find out if the plugin name / ID was correct.}
	if (!isPluginInstalled(sPluginName))
		logNotInstalledFailureMessage(sPluginName)
		return None
	endif

	Form found = Game.GetFormFromFile(iFormID, sPluginName)

	if (found == None)
		lookupMessage(sPluginName, iFormID, "form not found in plugin")
	endif

	return found
EndFunction

FormList Function fetchFormList(String sPluginName, Int iFormID) global
{Trivial, except that it guarantees a FormList return type for synatic sugar and logs any issues with the typecasting.}
	Form fetched = fetchForm(sPluginName, iFormID)
	FormList casted = fetched as FormList
	
	if (casted == None)
		lookupMessage(sPluginName, iFormID, fetched + " failed to cast to form list")
	endif
	
	return casted
EndFunction

LeveledItem Function fetchLeveled(String sPluginName, Int iFormID) global
{Trivial, except that it guarantees a LeveledItem return type for synatic sugar and logs any issues with the typecasting.}
	Form fetched = fetchForm(sPluginName, iFormID)
	LeveledItem casted = fetched as LeveledItem
	
	if (casted == None)
		lookupMessage(sPluginName, iFormID, fetched + " failed to cast to leveled item")
	endif
	
	return casted
EndFunction

InstanceNamingRules Function fetchNamingRules(String sPluginName, Int iFormID) global
{Trivial, except that it guarantees a InstanceNamingRules return type for synatic sugar and logs any issues with the typecasting.}
	Form fetched = fetchForm(sPluginName, iFormID)
	InstanceNamingRules casted = fetched as InstanceNamingRules
	
	if (casted == None)
		lookupMessage(sPluginName, iFormID, fetched + " failed to cast to instance naming rules")
	endif
	
	return casted
EndFunction
