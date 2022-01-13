extends Control

const INPUT_ACTIONS = [ "move_up", "move_down", "move_left", "move_right", "attack" ]
const CONFIG_FILE = "user://input.cfg"

var action
var button


func load_config():
	var config = ConfigFile.new()
	var err = config.load(CONFIG_FILE)
	if err:
		for action_name in INPUT_ACTIONS:
			var action_list = InputMap.get_action_list(action_name)
			var scancode = OS.get_scancode_string(action_list[0].scancode)
			config.set_value("input", action_name, scancode)
		config.save(CONFIG_FILE)
	else:
		for action_name in config.get_section_keys("input"):
			var scancode = OS.find_scancode_from_string(config.get_value("input", action_name))
			var event = InputEventKey.new()
			event.scancode = scancode
			for old_event in InputMap.get_action_list(action_name):
				if old_event is InputEventKey:
					InputMap.action_erase_event(action_name, old_event)
			InputMap.action_add_event(action_name, event)


func save_to_config(section, key, value):
	"""Helper function to redefine a parameter in the settings file"""
	var config = ConfigFile.new()
	var err = config.load(CONFIG_FILE)
	if err:
		print("Error code when loading config file: ", err)
	else:
		config.set_value(section, key, value)
		config.save(CONFIG_FILE)


# Input management

func wait_for_input(action_bind):
	action = action_bind
	# See note at the beginning of the script
	button = get_node("Column/ScrollContainer").get_node(action).get_node("Button")
	set_process_input(true)


func _input(event):
	# Handle the first pressed key
	if event is InputEventKey:
		# Register the event as handled and stop polling
		get_tree().set_input_as_handled()
		set_process_input(false)
		# Reinitialise the contextual help label
		if not event.is_action("ui_cancel"):
			# Display the string corresponding to the pressed key
			var scancode = OS.get_scancode_string(event.scancode)
			button.text = scancode
			# Start by removing previously key binding(s)
			for old_event in InputMap.get_action_list(action):
				InputMap.action_erase_event(action, old_event)
			# Add the new key binding
			InputMap.action_add_event(action, event)
			save_to_config("input", action, scancode)


func _ready():
	if get_tree().paused == true:
		get_tree().paused == false
	# Load config if existing, if not it will be generated with default values
	load_config()
	# Initialise each button with the default key binding from InputMap
	for action in INPUT_ACTIONS:
		# We assume that the key binding that we want is the first one (0), if there are several
		var input_event = InputMap.get_action_list(action)[0]
		# See note at the beginning of the script
		var button = get_node("Column/ScrollContainer").get_node(action).get_node("Button")
		button.text = OS.get_scancode_string(input_event.scancode)
		button.connect("pressed", self, "wait_for_input", [action])
	
	# Do not start processing input until a button is pressed
	set_process_input(false)
