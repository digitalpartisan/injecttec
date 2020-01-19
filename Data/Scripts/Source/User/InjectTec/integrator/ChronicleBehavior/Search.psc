Scriptname InjectTec:Integrator:ChronicleBehavior:Search extends Chronicle:Package:CustomBehavior:BehaviorSearch

Bool Function meetsCriteria(Chronicle:Package:CustomBehavior behavior)
	return (behavior as InjectTec:Integrator:ChronicleBehavior)
EndFunction

InjectTec:Integrator:ChronicleBehavior[] Function searchIntegrators(Chronicle:Package targetPackage)
	return search(targetPackage) as InjectTec:Integrator:ChronicleBehavior[]
EndFunction

InjectTec:Integrator:ChronicleBehavior Function searchOneIntegrator(Chronicle:Package targetPackage)
	return searchOne(targetPackage) as InjectTec:Integrator:ChronicleBehavior
EndFunction
