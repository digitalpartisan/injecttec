Scriptname InjectTecTesting:FormListContainer:OnClose extends ObjectReference

FormList Property MyForms Auto Const Mandatory

Event OnClose(ObjectReference akActionRef)
    if (!Game.GetPlayer() == akActionRef || !MyForms || !MyForms.GetSize())
        return
    endif

    RemoveAllItems()
    Reset()

    Int iSize = MyForms.GetSize()
    Int iCounter = 0
    while (iCounter < iSize)
        AddItem(MyForms.GetAt(iCounter))
        iCounter += 1
    endWhile
EndEvent
