Scriptname InjectTecTesting:Verifier extends ObjectReference

InjectTec:Injector Property Injector Auto Const

Event OnActivate(ObjectReference akActionRef)
	String sMessage = "Result: "
	if (Injector.verify())
		sMessage += "true"
	else
		sMessage += "false"
	endif
	Debug.Notification(sMessage)
EndEvent
