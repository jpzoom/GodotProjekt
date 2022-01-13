extends Node

signal listBuilt(controls)

var inputKontrole = {
	'move_up': KEY_UP,
	'move_down': KEY_DOWN,
	'move_left': KEY_LEFT,
	'move_right': KEY_RIGHT,
	'attack': KEY_SPACE
}

func buildKeyList():
	var controls = inputKontrole
	for actionName in controls.keys():
		changeKey(actionName, controls[actionName])
	emit_signal('listBuilt', controls)
	return controls

func changeKey(actionName, keyScancode):
	removePreviousInput(actionName)
	var newInput = InputEventKey.new()
	newInput.set_scancode(keyScancode)
	InputMap.action_add_event(actionName, newInput)

func removePreviousInput(actionName):
	var input_events = InputMap.get_action_list(actionName)
	for input in input_events:
		InputMap.action_erase_event(actionName, input)
