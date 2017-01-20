Scriptname InjectTecTesting:Activator extends ObjectReference

InjectTec:Injector Property Injector Auto Const

Event OnActivate(ObjectReference akActionRef)
	Injector.inject()
EndEvent