Scriptname InjectTec:Core:Plugin Hidden Const
{Logic related to locating forms in plugin files.  Mostly trivial, except that the detail level of logging may be required to diagnose mysterious issues because the compiler can't tell you if you goofed something up.}

Bool Function isPluginInstalled(String sFilename) Global
{Does what it says on the tin.}
	return Game.isPluginInstalled(sFilename)
EndFunction

Form Function fetchForm(String sPluginName, Int iFormID) Global
{Trivial, except for the logging.  This is the sort of thing that you have to diagnose post-runtime to find out if the plugin name / ID was correct.}
	if (!isPluginInstalled(sPluginName))
		InjectTec:Logger:Plugin.notInstalled(sPluginName)
		return None
	endif

	Form found = Game.GetFormFromFile(iFormID, sPluginName) ; parameter orders seem wrong to me, but I program in PHP during the day, so it's not like I'm triggered by it or anything

	if (found == None)
		InjectTec:Logger:Plugin.lookupFailed(sPluginName, iFormID)
	endif

	return found
EndFunction

FormList Function fetchFormList(String sPluginName, Int iFormID) Global
{Trivial, except that it guarantees a FormList return type for synatic sugar and logs any issues with the typecasting.}
	Form fetched = fetchForm(sPluginName, iFormID)
	FormList casted = fetched as FormList
	
	if (casted == None)
		InjectTec:Logger:Plugin.couldNotCast(sPluginName, iFormID, "form list")
	endif
	
	return casted
EndFunction

LeveledItem Function fetchLeveled(String sPluginName, Int iFormID) Global
{Trivial, except that it guarantees a LeveledItem return type for synatic sugar and logs any issues with the typecasting.}
	Form fetched = fetchForm(sPluginName, iFormID)
	LeveledItem casted = fetched as LeveledItem
	
	if (casted == None)
		InjectTec:Logger:Plugin.couldNotCast(sPluginName, iFormID, "leveled item")
	endif
	
	return casted
EndFunction

InstanceNamingRules Function fetchNamingRules(String sPluginName, Int iFormID) Global
{Trivial, except that it guarantees a InstanceNamingRules return type for synatic sugar and logs any issues with the typecasting.}
	Form fetched = fetchForm(sPluginName, iFormID)
	InstanceNamingRules casted = fetched as InstanceNamingRules
	
	if (casted == None)
		InjectTec:Logger:Plugin.couldNotCast(sPluginName, iFormID, "naming rules")
	endif
	
	return casted
EndFunction
