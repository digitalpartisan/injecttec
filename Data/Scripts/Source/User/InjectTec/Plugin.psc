Scriptname InjectTec:Plugin extends Quest
{Do not attach this script in the editor.  This would be an interface in any other programming language.}

String Function getFilename()
{Override this method based on how the filename representing this plugin should be decided.}
	Debug.TraceStack("[InjectTec][Plugin] get filename logic is not implemented")
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

FormList Function lookupFormlist(Int iFormID)
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