Scriptname InjectTec:Integrator:ChronicleBehavior extends Chronicle:Package:CustomBehavior

FormList Property Integrators Auto Const Mandatory

FormList Function getIntegrators()
    return Integrators
EndFunction

Bool Function installBehavior()
	InjectTec:Integrator.stateCheckList(getIntegrators())
	return true
EndFunction

Bool Function postloadBehavior()
	InjectTec:Integrator.stateCheckList(getIntegrators())
	InjectTec:Integrator.gameLoadList(getIntegrators())
	return true
EndFunction

Bool Function uninstallBehavior()
	InjectTec:Integrator.stopList(getIntegrators())
	return true
EndFunction
