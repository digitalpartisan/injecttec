Scriptname InjectTecTesting:ContainerReset extends ObjectReference Const

ObjectReference Property LeveledItemContainer Auto Const

Event OnActivate(ObjectReference akActionRef)
	Utility.Wait(0.25)
	LeveledItemContainer.Reset()
EndEvent
