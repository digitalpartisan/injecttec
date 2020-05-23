Scriptname InjectTec:Plugin:Versioned extends InjectTec:Plugin
{Incredibly useful for situations which entail multiple possible plugin file names based on different versions of the plugin (example: AWKCR vs. non-AWKCR and the like.)  Takes multiple plugin file objects and uses only one of them to perform lookups.
This is only suitable if you know for a fact that the Form IDs are the same across the various versions of the mod (as in, you went as checked yourself to make sure.)  Otherwise, this doesn't help so much.}

InjectTec:Plugin:File[] Property Files Auto Const Mandatory
{The list of plugin files to search for.  Since only one is used, the first plugin found becomes the "official" filename for the plugin as far as lookups go, so order these appropriately to suit your priorities.  See getFilename() for how this is used.}

String Function getFilenameHelper()
{Ideally, this method would save the name of the file, but there's no clear point in time after which it would be cleared, so I'd rather not keep that stale data around when the information could change based on things happening outside of the script environment which cannot be detected anyway.}
	Int iCounter = 0
	InjectTec:Plugin:File currentVersion = None
	
	While (iCounter < Files.Length)
		currentVersion = Files[iCounter]
		if (currentVersion.isInstalled())
			InjectTec:Plugin:Logger.foundVersion(self, currentVersion)
			return currentVersion.getFilename()
		endif
		
		iCounter += 1
	EndWhile
	
	InjectTec:Plugin:Logger.noInstalledVersion(self)
	return ""
EndFunction
