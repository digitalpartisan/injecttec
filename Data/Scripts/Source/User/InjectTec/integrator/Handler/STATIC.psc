Scriptname InjectTec:Integrator:Handler:STATIC extends InjectTec:Integrator:Handler Conditional

InjectTec:Integrator Property MyIntegrator Auto Const Mandatory

InjectTec:Integrator Function getIntegrator()
    return MyIntegrator
EndFunction

Function setIntegrator(InjectTec:Integrator newIntegrator)
    ; do nothing - the integrator is already set
EndFunction
