Scriptname InjectTecTesting:SpawnFormList extends ObjectReference Const

ObjectReference Property FormListContainer Auto Const
FormList Property ListToSpawn Auto Const

Event OnActivate(ObjectReference akActionRef)
	Utility.Wait(0.25)

	FormListContainer.Reset()

	Int iCounter = 0
	Int iSize = ListToSpawn.GetSize()
	while (iCounter < iSize)
		ObjectReference akInstance = FormListContainer.PlaceAtMe(ListToSpawn.GetAt(iCounter))
		FormListContainer.AddItem(akInstance)
		iCounter += 1
	endwhile
EndEvent
