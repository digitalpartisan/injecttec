Scriptname InjectTecTesting:FormListContainer extends Quest

FormList Property InjectTecTestingTargetFormList Auto Const Mandatory
ObjectReference Property ContainerRef Auto Const Mandatory

Function process()
	ContainerRef.Reset()
	
	Int iCounter = 0
	Int iSize = InjectTecTestingTargetFormList.GetSize()
	while (iCounter < iSize)
		ContainerRef.AddItem(InjectTecTestingTargetFormList.GetAt(iCounter))
		iCounter += 1
	endwhile
EndFunction
