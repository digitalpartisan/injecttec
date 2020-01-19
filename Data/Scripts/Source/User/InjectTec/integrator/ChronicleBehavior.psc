Scriptname InjectTec:Integrator:ChronicleBehavior extends Chronicle:Package:CustomBehavior

InjectTec:Integrator[] Property Integrators Auto Const Mandatory

Bool Function installBehavior()
	InjectTec:Integrator.stateCheckBulk(Integrators)
	return true
EndFunction

Bool Function postloadBehavior()
	InjectTec:Integrator.stateCheckBulk(Integrators)
	return true
EndFunction

Bool Function uninstallBehavior()
	InjectTec:Integrator.stopBulk(Integrators)
	return true
EndFunction
