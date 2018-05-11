Scriptname InjectTec:Injector:Leveled:Custom extends InjectTec:Injector:Leveled Conditional
{A different way of going about a granular injection to a leveled list.  Can use remote forms, but note to set the isSourceLocal to false, provide a value for sourcePlugin, and set the SourceIDs on the CustomForms correctly.}

Import InjectTec:Core:Leveled

Struct CustomFormSetting
	Form SourceForm = None
	{The Form record to inject.  Set this if the Form you wish to use is immediately available to your plugin or one of its hard requirements.}
	Int SourceID = 0
	{The Base 10 ID of the form you wish to inject.  Set this if the Form you wish to use is not immediately available to your plugin or one of its hard dependencies.}
	Int Level = 1
	{The level at which the targetted LeveledItem list should spawn the Form being injected.}
	Int Amount = 1
	{The amount of the injected Form the targetted LeveledItem should spawn.}
EndStruct

Group SourceSettings
	Bool Property isSourceLocal = true Auto Const
	{True if the value of sourceForm can be set using the editor because the sourced Form record comes from either a master file on which your plugin depends or your plugin itself.  Set to false otherwise.}
	InjectTec:Plugin Property sourcePlugin = None Auto Const
	{The plugin containing forms in CustomForms.  Set this value if the value of isSourceLocal has been set to false.}
	CustomFormSetting[] Property CustomForms = None Auto Const Mandatory
	{The form, level, and amount settings to inject into the targetted leveled list.}
EndGroup

InjectionData[] aInjectionData = None

InjectionData[] Function getSource()
	return aInjectionData
EndFunction

Bool Function canLoadSource()
	InjectionData[] aLoaded = new InjectionData[0]
	
	Int iCounter = 0
	CustomFormSetting currentForm = None
	Form loadedForm = None
	
	while (iCounter < CustomForms.Length)
		currentForm = CustomForms[iCounter]
		loadedForm = InjectTec:Loader:Form.load(isSourceLocal, currentForm.SourceForm, sourcePlugin, currentForm.SourceID)
		if (None == loadedForm)
			InjectTec:Logger:Injector.couldNotLoadSource(self)
			return false
		endif
		
		aLoaded.Add(buildInjectionData(loadedForm, currentForm.Level, currentForm.Amount))
		iCounter += 1
	endwhile

	aInjectionData = aLoaded
	return true
EndFunction

Function clear()
	aInjectionData = None
	parent.clear()
EndFunction

Function injectBehavior()
	addInjectionDataBulk(getTarget(), getSource())
EndFunction
