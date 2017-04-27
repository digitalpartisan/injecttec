Scriptname InjectTec:Injector:Leveled:RemoteFormsGranular extends InjectTec:Injector:Leveled
{Attach this script in the editor to inject append the remote Form to a targetted LeveledItem record with granular control over which levels and quantities are used for each Form record added.
See notes on InjectTec:Core:Leveled.addFormListGranular() for specifics.}

Group SourceSettings
	InjectTec:Plugin Property SourcePlugin Auto Const Mandatory
	{The plugin containing the sourced FormList.}
	Int[] Property SourceIDs Auto Const Mandatory
	{The record IDs of the sourced Forms.}
EndGroup

Group Metadata
	Int[] Property Levels Auto Const Mandatory
	{An Int array which has a specific (and likely, unique) level setting for each Form record in the SourceIDs property.  See InjectTec:Core:Leveled.addFormArrayGranular() for details.}
	Int[] Property Quantities Auto Const Mandatory
	{An Int array which has a specific (and likely, unique) quantity setting for each Form records in the SourceIDs property.  See InjectTec:Core:Leveled.addFormArrayGranular() for details.}
EndGroup

Form[] fAdditions = None

Form[] Function getSource()
	return fAdditions
EndFunction

Bool Function canLoadSource()
{Returns a boolean value indicating whether or not the sourced Form record can be found and saves the Forms for use in injection should it load.}
	fAdditions = new Form[0]
	
	Int iCounter = 0
	Form fNew = None
	While (iCounter < SourceIDs.Length)
		fNew = InjectTec:Loader:Form.load(false, None, SourcePlugin, SourceIDs[iCounter])
		if (None == fNew)
			return false
		endif
		fAdditions.Add(fNew)
		iCounter += 1
	EndWhile
	
	return true
EndFunction

Function clear()
	fAdditions = None
	parent.clear()
EndFunction

Function injectBehavior()
	InjectTec:Core:Leveled.addFormArrayGranular(getTarget(), getSource(), Levels, Quantities)
EndFunction
