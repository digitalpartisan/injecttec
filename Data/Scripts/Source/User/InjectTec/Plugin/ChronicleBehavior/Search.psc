Scriptname InjectTec:Plugin:ChronicleBehavior:Search extends Chronicle:Package:CustomBehavior:BehaviorSearch
{See Chronicle:Package:CustomBehavior:BehaviorSearch}

Bool Function meetsCriteria(Chronicle:Package:CustomBehavior behavior)
	return (behavior as InjectTec:Plugin:ChronicleBehavior)
EndFunction

InjectTec:Plugin:ChronicleBehavior[] Function searchPluginRequirements(Chronicle:Package targetPackage)
	return search(targetPackage) as InjectTec:Plugin:ChronicleBehavior[]
EndFunction

InjectTec:Plugin:ChronicleBehavior Function searchOnePluginRequirement(Chronicle:Package targetPackage)
	return searchOne(targetPackage) as InjectTec:Plugin:ChronicleBehavior
EndFunction
