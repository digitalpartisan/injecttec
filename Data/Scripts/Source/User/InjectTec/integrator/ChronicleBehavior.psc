Scriptname InjectTec:Integrator:ChronicleBehavior extends Chronicle:Package:CustomBehavior

InjectTec:Integrator[] Property Integrators Auto Const Mandatory

InjectTec:Integrator[] Function getIntegrators()
    return Integrators
EndFunction

Bool Function installBehavior()
	InjectTec:Integrator.stateCheckBulk(getIntegrators())
	return true
EndFunction

Bool Function postloadBehavior()
	InjectTec:Integrator.stateCheckBulk(getIntegrators())
	return true
EndFunction

Bool Function uninstallBehavior()
	InjectTec:Integrator.stopBulk(getIntegrators())
	return true
EndFunction
