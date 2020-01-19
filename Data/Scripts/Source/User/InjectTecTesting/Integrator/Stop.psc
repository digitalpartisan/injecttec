Scriptname InjectTecTesting:Integrator:Stop extends InjectTecTesting:Integrator

Function actOn(InjectTec:Integrator integrator)
    integrator && integrator.Stop()
EndFunction
