extends Control

onready var _listaAkcija = get_node("Stupac/ScrollContainer/ListaAkcija")

func _ready():
	$Inputmapper.connect('listBuilt', self, 'rebuild')
	$Inputmapper.buildKeyList()

func rebuild(inputKontrole):

	for action in inputKontrole.keys():
		var line = _listaAkcija.addLine(action, inputKontrole[action], true)
		line.connect('changeButtonPressed', self, '_on_InputLine_change_button_pressed', [action, line])

func _on_InputLine_change_button_pressed(actionNaziv, line):
	set_process_input(false)
	
	$SelectButton.open()
	var key_scancode = yield($SelectButton, "key_selected")
	$Inputmapper.changeKey(actionNaziv, key_scancode)
	line.updateKey(key_scancode)
	
	set_process_input(true)

func _on_QuitButton_pressed():
	get_tree().change_scene("res://Menu/TitleScreen.tscn")
