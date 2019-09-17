Scriptname InjectTec:Plugin:ListWrapper extends DynamicTerminal:ListWrapper:FormList:Static

Bool Function itemPassesFilter(Int iNumber)
	return (getItem(iNumber) as InjectTec:Plugin).isInstalled()
EndFunction
