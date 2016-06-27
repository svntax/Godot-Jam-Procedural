
extends Area2D

var player

func _ready():
	player = get_tree().get_nodes_in_group("players")[0]
	set_fixed_process(true)
	
func _fixed_process(delta):
	if(overlaps_body(player)):
		print("Exit found!")

