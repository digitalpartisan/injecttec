Scriptname InjectTecTesting:Reverter extends ObjectReference

InjectTec:Injector Property Injector Auto Const

Event OnActivate(ObjectReference akActionRef)
	Injector.revert()
EndEvent
