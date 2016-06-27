
extends VBoxContainer

func _ready():
	pass
	
func _draw():
	draw_rect(Rect2(-2, -2, get_size().x+4, get_size().y+4), Color(255, 255, 255))
	draw_rect(Rect2(-1, -1, get_size().x+2, get_size().y+2), Color(0, 0, 0))

func toggle():
	if(get_index() != get_parent().get_child_count() - 1):
		get_parent().move_child(self, get_parent().get_child_count() - 1)
	show()
	var w = get_viewport().get_rect().size.x
	var h = get_viewport().get_rect().size.y
	var player = get_tree().get_nodes_in_group("players")[0]
	#var playerCam = get_parent().find_node("Player").find_node("Camera2D")
	var playerCam = player.find_node("Camera2D")
	var x = playerCam.get_camera_pos().x - (w / 4)
	var y = playerCam.get_camera_pos().y - (h / 4)
	set_pos(Vector2(x, y + 40))

func _on_YesButton_pressed():
	get_tree().set_pause(false)
	get_tree().change_scene("res://Scenes/main_menu.scn")
	hide()

func _on_NoButton_pressed():
	get_tree().set_pause(false)
	hide()
