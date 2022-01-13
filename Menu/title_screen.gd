extends Control

var scenePathToLoad

func _ready():
	$Menu/CenterRow/Buttons/NewGameButton.grab_focus() # daje fokus na prvi gumb, new game
	for button in $Menu/CenterRow/Buttons.get_children(): # za sve gumbe u čvoru Buttons spoji signal iz varijable guma na scenu za load
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	if get_tree().paused == true:
		get_tree().paused = not get_tree().paused
		
func _on_Button_pressed(scene_to_load): # služi za pojave tranzicije
	scenePathToLoad = scene_to_load # globalna varijabla poprima vrijednost iz varijable gumba
	$FadeIn.show()
	$FadeIn.fade_in() # metoda fade_in() iz skripte vezane za fade_in
	
func _on_FadeIn_fade_finished():
#warning-ignore:return_value_discarded
	get_tree().change_scene(scenePathToLoad)
	