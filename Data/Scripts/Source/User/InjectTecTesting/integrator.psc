Scriptname InjectTecTesting:Integrator extends ObjectReference Hidden

InjectTec:Integrator Property MyIntegrator Auto Const Mandatory

Function actOn(InjectTec:Integrator integrator)

EndFunction

Event OnActivate(ObjectReference akActionRef)
    Game.GetPlayer() == akActionRef && MyIntegrator && actOn(MyIntegrator)
EndEvent
