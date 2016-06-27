
extends Node2D

var dirt
var SPAWN_RANGE = 6
var SPAWN_CHANCE = 0.7
var MIN_DIST_AWAY = 64
var size = 16
var player

func _ready():
	dirt = find_node("Dirt")
	player = get_parent().find_node("Player")

func getOffset():
	return (SPAWN_RANGE*size) / 2
	
func spawnEarth():	
	get_node("/root/sound_effects").play("rock_explode")
	var space_state = get_world_2d().get_direct_space_state()
	for i in range(SPAWN_RANGE):
		for j in range(SPAWN_RANGE):
			randomize()
			if(randf() < SPAWN_CHANCE):
				var pos = Vector2(get_pos().x + i*size+8, get_pos().y + j*size+8)
				var dist = pos.distance_to(player.get_pos())
				var obj = space_state.intersect_ray(pos, Vector2(pos.x+16, pos.y+16))
				if(dist > MIN_DIST_AWAY && obj.empty()):
					var block = dirt.duplicate()
					block.set_pos(Vector2(i*size+8, j*size+8))
					add_child(block)
	get_children()[0].queue_free()
