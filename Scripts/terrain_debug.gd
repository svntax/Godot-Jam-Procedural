extends Node2D

var r_pressed = false
var g_pressed = false

var scene = load("res://Scenes/terrain.scn") 

var terrainNode

func _ready():
	terrainNode = scene.instance()
	add_child(terrainNode)
	#set_process_input(true)

func _input(event):
	if(event.type == InputEvent.KEY):
		if(event.scancode == KEY_R && !event.is_echo()):
			if(!r_pressed):
				terrainNode.queue_free()
				remove_child(terrainNode)
				for enemy in get_tree().get_nodes_in_group("enemies"):
					enemy.queue_free()
				terrainNode = scene.instance()
				add_child(terrainNode)
			r_pressed = !r_pressed


