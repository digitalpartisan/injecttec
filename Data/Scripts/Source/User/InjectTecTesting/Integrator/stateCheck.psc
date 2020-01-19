Scriptname InjectTecTesting:Integrator:StateCheck extends InjectTecTesting:Integrator

Function actOn(InjectTec:Integrator integrator)
    integrator && integrator.stateCheck()
EndFunction
