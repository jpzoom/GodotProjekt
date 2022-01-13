extends Control

const linijaInputa = preload("res://Menu/Rebind/LineSelect.tscn")

func clear():
	for child in get_children():
		child.free()

func addLine(actionName, key, enabledStatus):
	var linija = linijaInputa.instance()
	linija.initializeLine(actionName, key, enabledStatus)
	add_child(linija)
	return linija