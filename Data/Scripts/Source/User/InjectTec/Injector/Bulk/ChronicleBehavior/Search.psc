Scriptname InjectTec:Injector:Bulk:ChronicleBehavior:Search extends Chronicle:Package:CustomBehavior:BehaviorSearch
{See Chronicle:Package:CustomBehavior:BehaviorSearch}

Bool Function meetsCriteria(Chronicle:Package:CustomBehavior behavior)
	return (behavior as InjectTec:Injector:Bulk:ChronicleBehavior)
EndFunction

InjectTec:Injector:Bulk:ChronicleBehavior[] Function searchBulkInjectors(Chronicle:Package targetPackage)
	return search(targetPackage) as InjectTec:Injector:Bulk:ChronicleBehavior[]
EndFunction

InjectTec:Injector:Bulk:ChronicleBehavior Function searchOneBulkInjector(Chronicle:Package targetPackage)
	return searchOne(targetPackage) as InjectTec:Injector:Bulk:ChronicleBehavior
EndFunction
