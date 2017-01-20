Scriptname InjectTecTesting:ContainerReset extends ObjectReference Const

ObjectReference Property LeveledItemContainer Auto Const

Event OnActivate(ObjectReference akActionRef)
	LeveledItemContainer.Reset()
EndEvent