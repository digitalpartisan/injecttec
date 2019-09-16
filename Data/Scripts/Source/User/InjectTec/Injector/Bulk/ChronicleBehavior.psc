Scriptname InjectTec:Injector:Bulk:ChronicleBehavior extends Chronicle:Package:CustomBehavior

InjectTec:Injector:Bulk Property BulkInjections Auto Const Mandatory

InjectTec:Injector:Bulk Function getInjections()
	return BulkInjections
EndFunction

Function inject(Bool bForce = false)
	BulkInjections.inject(bForce)
EndFunction

Function forceInject()
	inject(true)
EndFunction

Function revert(Bool bForce = false)
	BulkInjections.revert(bForce)
EndFunction

Function forceRevert()
	revert(true)
EndFunction

Function verify(Bool bForceInjectOnFailure = false)
	BulkInjections.verify(bForceInjectOnFailure)
EndFunction

Function forceVerify()
	verify(true)
EndFunction

Bool Function installBehavior()
	inject()
	return true
EndFunction

Bool Function postloadBehavior()
	inject()
	return true
EndFunction

Bool Function uninstallBehavior()
	revert()
	return true
EndFunction
