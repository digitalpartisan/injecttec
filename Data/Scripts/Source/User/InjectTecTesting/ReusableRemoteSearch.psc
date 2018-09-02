Scriptname InjectTecTesting:ReusableRemoteSearch extends ObjectReference

InjectTec:ReusableRemoteForms Property RemoteForms Auto Const Mandatory
String Property SearchTerm Auto Const Mandatory

Event OnActivate(ObjectReference akActionRef)
	Game.GetPlayer().AddItem(RemoteForms.loadFromName(SearchTerm))
EndEvent
