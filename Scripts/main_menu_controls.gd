
extends VBoxContainer

func _ready():
	pass

func _on_StartButton_pressed():
	get_tree().change_scene("res://test_scene.scn")

func _on_QuitButton_pressed():
	get_tree().quit()
