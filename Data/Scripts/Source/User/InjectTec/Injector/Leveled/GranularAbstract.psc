Scriptname InjectTec:Injector:Leveled:GranularAbstract extends InjectTec:Injector:Leveled Hidden Conditional
{This is an abstraction for all granular level and amount leveled list injectors.  Note that this was written multipe versions after release and it's not reaonsable to expect mod authors to re-create large batches of injections.  Scripts extending this one are not named in the expected way.}

Group Metadata
	Int[] Property Levels Auto Const Mandatory
	{An Int array which has a specific (and likely, unique) level setting for each Form record in the myAdditions Form property.  See InjectTec:Core:Leveled.addFormListGranular() for details.}
	Int[] Property Quantities Auto Const Mandatory
	{An Int array which has a specific (and likely, unique) quantity setting for each Form records in the myAdditions Form property.  See InjectTec:Core:Leveled.addFormListGranular() for details.}
EndGroup
