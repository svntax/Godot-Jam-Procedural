
extends Area2D

var player
var terrain
var destroyingTerrain = false

func _ready():
	player = get_tree().get_nodes_in_group("players")[0]
	terrain = get_tree().get_nodes_in_group("terrain_group")[0]
	set_fixed_process(true)
	
func _fixed_process(delta):
	if(destroyingTerrain):
		var others = get_overlapping_bodies()
		for obj in others:
			if(obj.is_in_group("dirt_group")):
				obj.queue_free()
			if(obj.is_in_group("terrain_wall_group")):
				var objX = obj.get_pos().x
				var objY = obj.get_pos().y
				var size = terrain.getTileSize()
				var terrainPos = terrain.get_pos()
				if(objX > terrainPos.x + (size*2) 
				&& objX < terrainPos.x + terrain.getWidth()*size - (size*2)
				&& objY > terrainPos.y + (size*2)
				&& objY < terrainPos.y + terrain.getHeight()*size - (size*2)):
					obj.queue_free()
				
		destroyingTerrain = false
		get_parent().get_node("RetileArea").retileTerrain()

func destroyTerrain():
	get_node("/root/sound_effects").play("fire_explode")
	destroyingTerrain = true