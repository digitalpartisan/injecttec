Scriptname InjectTec:Loader extends Quest Hidden
{Children of this script are multi-tasked as libraries to assist the rest of the InjectTec codebase or as form loaders for plugins doing things other than simple injection which requires remote loading of forms.
Attach these child scripts in the editor to enable easy referencing of another plugin's records.}

Group RemoteSourceSettings
	InjectTec:Plugin Property RemotePlugin = None Auto Const
	{The plugin containing the required record.}
	Int Property RemoteID = 0 Auto Const
	{The record ID of the sourced Form.  Set this value if the value of isSourceLocal has been set to false.}
EndGroup
