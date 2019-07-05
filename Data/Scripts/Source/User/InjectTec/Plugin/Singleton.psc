Scriptname InjectTec:Plugin:Singleton extends InjectTec:Plugin
{The most likely plugin implementation you're going to use since this assumes you're pulling from a single file which does not have alterate versions floating around in the mod universe.}

InjectTec:Plugin:File Property myFile Auto Const Mandatory
{Associates InjectTec plugin functionality with a particular plugin file.}

String Function getFilenameHelper()
	if (!myFile) ; prevent noisy debug logs over trivially-avoided warnings
		return ""
	endif
	
	return myFile.getFilename()
EndFunction
