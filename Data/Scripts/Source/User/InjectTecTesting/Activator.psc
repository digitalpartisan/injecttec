Scriptname InjectTecTesting:Activator extends ObjectReference

InjectTec:Injector Property Injector Auto Const Mandatory

Message Property InjectTecTestingActivateLabelInject Auto Const Mandatory
Message Property InjectTecTestingActivateLabelRevert Auto Const Mandatory

InjectTecTesting:FormListContainer Property InjectTecTestingFormListContainer Auto Const
InjectTectesting:LeveledItemContainer Property InjectTecTestingLeveledItemContainer Auto Const

Function cycleContainers()
	if (InjectTecTestingFormListContainer)
		InjectTecTestingFormListContainer.process()
	endif
	
	if (InjectTecTestingLeveledItemContainer)
		InjectTecTestingLeveledItemContainer.process()
	endif
EndFunction

Auto State Inject
	Event OnBeginState(String asOldState)
		SetActivateTextOverride(InjectTecTestingActivateLabelInject)
		cycleContainers()
	EndEvent

	Event OnActivate(ObjectReference akActionRef)
		Injector.inject()
		if (Injector.getHasRun())
			GoToState("Revert")
		endif
	EndEvent
EndState

State Revert
	Event OnBeginState(String asOldState)
		SetActivateTextOverride(InjectTecTestingActivateLabelRevert)
		cycleContainers()
	EndEvent

	Event OnActivate(ObjectReference akActionRef)
		Injector.revert()
		if (!Injector.getHasRun())
			GoToState("Inject")
		endif
	EndEvent
EndState
