
extends VBoxContainer

func _ready():
	pass

func _on_StartButton_pressed():
	var musicHandler = get_node("/root/music_handler")
	if(!musicHandler.is_playing()):
		musicHandler.set_volume(2)
		musicHandler.play()
	get_tree().change_scene("res://test_scene.scn")

func _on_QuitButton_pressed():
	get_tree().quit()
