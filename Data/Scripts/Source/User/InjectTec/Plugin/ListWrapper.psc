Scriptname InjectTec:Plugin:ListWrapper extends DynamicTerminal:ListWrapper:FormList:Static
{Allows for dynamic terminal pagination over a FormList where the items in the list are InjectTec:Plugin objects.  The filter criteria is that the plugin is installed.}

Bool Function itemPassesFilter(Int iNumber)
	return (getItem(iNumber) as InjectTec:Plugin).isInstalled()
EndFunction
