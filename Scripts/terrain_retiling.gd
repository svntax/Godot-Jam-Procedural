
extends Area2D

var player
var retilingTerrain = false

func _ready():
	player = get_tree().get_nodes_in_group("players")[0]
	set_fixed_process(true)
	
func _fixed_process(delta):
	if(retilingTerrain):
		var others = get_overlapping_bodies()
		for obj in others:
			if(obj.is_in_group("terrain_wall_group")):
				obj.setTiled(false)
		
		retilingTerrain = false

func retileTerrain():
	retilingTerrain = true