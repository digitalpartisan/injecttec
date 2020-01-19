Scriptname InjectTec:Integrator:Paginator extends dynamicterminal:paginator Conditional

InjectTec:Integrator:Handler Property Handler Auto Const Mandatory

Function itemActivation(Int iItem, ObjectReference akTerminalRef)
	Handler.setIntegrator(getItem(iItem) as InjectTec:Integrator)
	Handler.draw(akTerminalRef)
EndFunction
