Scriptname InjectTecTesting:Verifier extends ObjectReference

InjectTec:Injector Property Injector Auto Const Mandatory
Message Property InjectTecTestingValidationMessageFalse Auto Const Mandatory
Message Property InjectTecTestingValidationMessageTrue Auto Const Mandatory

Event OnActivate(ObjectReference akActionRef)
	if (Injector.verify())
		InjectTecTestingValidationMessageTrue.Show()
	else
		InjectTecTestingValidationMessageFalse.Show()
	endif
EndEvent
