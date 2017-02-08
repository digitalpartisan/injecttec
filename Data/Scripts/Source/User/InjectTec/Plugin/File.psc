Scriptname InjectTec:Plugin:File extends Quest
{While potentially irritating, one only record for each plugin file you wish to interact with needs to exist in your mod.  Doing this this way prevents repeatedly entering a filename for each mod which means typos or mod name changes are easily dealt with.}

String Property Filename = "" Auto Const
{The name of the plugin file from which forms are to be loaded.}
