Scriptname InjectTec:integrator:Handler:STATIC extends InjectTec:integrator:Handler

InjectTec:Integrator Property MyIntegrator Auto Const Mandatory

InjectTec:Integrator Function getIntegrator()
    return MyIntegrator
EndFunction

Function setIntegrator(InjectTec:Integrator newIntegrator)
    ; do nothing - the integrator is already set
EndFunction
