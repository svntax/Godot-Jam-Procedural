extends Node2D

var LIVES = 3
var texture
var player
var playerCam

func _ready():
	texture = get_node("Sprite").get_texture()
	player = get_parent().find_node("Player")
	playerCam = player.find_node("Camera2D")
	for i in range(LIVES):
		var first = get_node("Sprite")
		var pos = first.get_pos()
		var life = first.duplicate()
		life.show()
		life.set_pos(Vector2(pos.x + i*texture.get_width()*2, pos.y))
		add_child(life)
	
	set_process(true)
	
func _process(delta):
	var w = get_viewport().get_rect().size.x
	var h = get_viewport().get_rect().size.y
	var x = playerCam.get_camera_pos().x - (w / 2) + texture.get_width()*3
	var y = playerCam.get_camera_pos().y - (h / 2) + texture.get_height()*2
	set_pos(Vector2(x, y))

func damage():
	if(LIVES > 0):
		get_children()[LIVES].queue_free()
		LIVES -= 1
	if(LIVES <= 0):
		print("You died!")