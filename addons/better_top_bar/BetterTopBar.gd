@tool
extends EditorPlugin

var EditInterface
var WorkspaceTabs
var Spacer1
var Spacer2
var Renderer
var Build
var Run
var RunChild
var TwoDButton
var ThreeDDButton
var ScriptButton
var AssetlibButton
var TopControl

var is_hidden = false  # To keep track of the hidden status

func _enter_tree():
	# Initialization of the plugin goes here.
	EditInterface = get_editor_interface()
	WorkspaceTabs = EditInterface.get_base_control().get_child(0).get_child(0).get_child(2)
	Spacer1 = EditInterface.get_base_control().get_child(0).get_child(0).get_child(3)
	Spacer2 = EditInterface.get_base_control().get_child(0).get_child(0).get_child(1)
	Run = EditInterface.get_base_control().get_child(0).get_child(0).get_child(4)
	Renderer = EditInterface.get_base_control().get_child(0).get_child(0).get_child(5)
	Build = EditInterface.get_base_control().get_child(0).get_child(0).get_child(6)
	TopControl = EditInterface.get_base_control().get_child(0).get_child(0)

	TwoDButton = WorkspaceTabs.get_child(0)
	ThreeDDButton = WorkspaceTabs.get_child(1)
	ScriptButton = WorkspaceTabs.get_child(2)
	AssetlibButton = WorkspaceTabs.get_child(3)
	

	RunChild = Run.get_child(0).get_child(0)

	# Add a menu item to the Tools menu.
	add_tool_menu_item("Toggle Workspace UI Elements",Callable(self, "_on_toggle_elements"))

	_on_toggle_elements()

func _exit_tree():
	# Remove the menu item when the plugin is disabled
	remove_tool_menu_item("Toggle Workspace UI Elements")
	# Clean-up of the plugin goes here.
	if WorkspaceTabs and Spacer1 and Spacer2:
		WorkspaceTabs.visible = true
		Spacer1.visible = true
		Spacer2.visible = true

func _on_toggle_elements():

	#print("The name of WorkspaceTabs is: ", WorkspaceTabs.get_name())#4747
	#print("The name of Run is: ", Run.get_name())#4828
	#print("The name of ScriptButton is: ", ScriptButton.get_name())#4828

	is_hidden = !is_hidden  # Toggle the hidden status
	if WorkspaceTabs and Spacer1 and Spacer2:
		#WorkspaceTabs.visible = !is_hidden
		WorkspaceTabs.visible = true
		if is_hidden:				
			Run.size_flags_horizontal = 3
			RunChild.size_flags_horizontal = 4
			TwoDButton.text ="";
			ThreeDDButton.text ="";
			AssetlibButton.text ="";
			ScriptButton.text ="";
			TopControl.move_child(WorkspaceTabs, 4)

		else:		

			Run.size_flags_horizontal = 1
			RunChild.size_flags_horizontal = 1
			TwoDButton.text ="2D";
			ThreeDDButton.text ="3D";
			AssetlibButton.text ="AssetLib";
			ScriptButton.text ="Script";
			TopControl.move_child(WorkspaceTabs, 1)

		Spacer1.visible = !is_hidden
		Spacer2.visible = !is_hidden	
		Build.visible = !is_hidden	
		


