Scriptname InjectTec:Integrator:Handler extends DynamicTerminal:Basic Conditional

InjectTec:Integrator myIntegrator = None
Bool bIsValid = false Conditional
Bool bPluginRequirementMet = false Conditional
Bool bHasRun = false Conditional
Bool bCanRun = false Conditional

Bool Function isValid()
    return bIsValid
EndFunction

Bool Function isPluginRequirementMet()
    return bPluginRequirementMet
EndFunction

Bool Function hasRun()
    return bHasRun
EndFunction

Bool Function canRun()
    return bCanRun
EndFunction

InjectTec:Integrator Function getIntegrator()
    return myIntegrator
EndFunction

Function setIntegrator(InjectTec:Integrator newIntegrator)
    myIntegrator = newIntegrator
    bIsValid = (None != myIntegrator)
    updateState()
EndFunction

Function updateState()
    bPluginRequirementMet = false
    bHasRun = false

    if (!isValid())
        return
    endif

    InjectTec:Integrator integrator = getIntegrator()
    bPluginRequirementMet = integrator.isPluginRequirementMet()
    bHasRun = integrator.hasRun()
    bCanRun = integrator.canRun()
EndFunction

Function startup(ObjectReference akTerminalRef)
    if (isValid() && canRun())
        getIntegrator().Start()
        updateState()
        draw(akTerminalRef)
    endif
EndFunction

Function shutdown(ObjectReference akTerminalRef)
    if (isValid() && hasRun())
        getIntegrator().Stop()
        updateState()
        draw(akTerminalRef)
    endif
EndFunction

Function rerun(ObjectReference akTerminalRef)
    if (isValid() && hasRun())
        getIntegrator().rerun()
        updateState()
        draw(akTerminalRef)
    endif
EndFunction

Function tokenReplacementLogic()
	if (isValid())
	    InjectTec:Integrator integrator = getIntegrator()
		replace("IntegratorForm", integrator)
		replace("IntegratorAbout", integrator.getAbout())
	else
		replace("IntegratorForm", None)
        replace("IntegratorAbout", None)
	endif
EndFunction