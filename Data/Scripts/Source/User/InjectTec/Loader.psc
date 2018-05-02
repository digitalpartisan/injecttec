Scriptname InjectTec:Loader extends Quest Hidden
{Children of this script are multi-tasked as libraries to assist the rest of the InjectTec codebase or as form loaders for plugins doing things other than simple injection which requires remote loading of forms.
Attach these child scripts in the editor to enable easy referencing of another plugin's records.}

Import InjectTec:HexidecimalLogic

Group RemoteSourceSettings
	InjectTec:Plugin Property RemotePlugin = None Auto Const Mandatory
	{The plugin containing the required record.}
	Int Property RemoteID = 0 Auto Const Mandatory
	{The record ID of the sourced Form.  Set this value if the value of isSourceLocal has been set to false.}
	DigitSet Property RemoteDigits= None Auto Const
	{This is an alternative option to setting the sourceID property.  If you would rather not bother with the base 16 to base 10 calculation, enter the base 16 digits here.}
EndGroup
