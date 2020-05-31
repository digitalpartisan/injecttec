Scriptname InjectTec:Integrator:Paginator extends DynamicTerminal:Paginator Conditional
{Used to pass an InjectTec:Integrator selected during Dynamic Terminal pagination into an InjectTec:Integrator:Handler object so that it can be manipulated after having been selected.
See DynamicTerminal:Paginator.}

InjectTec:Integrator:Handler Property Handler Auto Const Mandatory

Function itemActivation(Int iItem, ObjectReference akTerminalRef)
	Handler.setIntegrator(getItem(iItem) as InjectTec:Integrator)
	Handler.draw(akTerminalRef)
EndFunction
