extends HBoxContainer

signal changeButtonPressed

func initializeLine(actionName, key, enabled):
	enabled = false
	$Akcija.text = actionName.capitalize()
	$Tipka.text = OS.get_scancode_string(key)
	$Izmjena.disabled = enabled

func updateKey(scancode):
	$Tipka.text = OS.get_scancode_string(scancode)

func _on_TextureButton_pressed():
	emit_signal("changeButtonPressed")
