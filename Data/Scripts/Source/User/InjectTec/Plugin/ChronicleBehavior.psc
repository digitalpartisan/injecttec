Scriptname InjectTec:Plugin:ChronicleBehavior extends Chronicle:Package:CustomBehavior

InjectTec:Plugin[] Property ThirdPartyPlugins Auto Const Mandatory

Bool Function checkPlugins()
	if (ThirdPartyPlugins)
		Int iCounter = 0
		while (iCounter < ThirdPartyPlugins.Length)
			if (!ThirdPartyPlugins[iCounter] || !ThirdPartyPlugins[iCounter].isInstalled())
				return false
			endif
			
			iCounter += 1
		endWhile
	endif
	
	return true
EndFunction

Bool Function meetsInstallationConditions()
	return checkPlugins()
EndFunction
