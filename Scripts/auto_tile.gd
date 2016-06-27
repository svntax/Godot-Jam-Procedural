
extends StaticBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var isTiled = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)

func _fixed_process(delta):
	if(!isTiled):
		"""var amount = 4
		var up = get_parent().test_move(Vector2(0, -amount))
		var down = get_parent().test_move(Vector2(0, amount))
		var left = get_parent().test_move(Vector2(-amount, 0))
		var right = get_parent().test_move(Vector2(amount, 0))
		"""
		var space_state = get_world_2d().get_direct_space_state()
		var sprite = find_node("Sprite")
		var pos = Vector2(sprite.get_pos().x + 16, sprite.get_pos().y + 16)
		pos = get_pos()
		var exceptions = get_tree().get_nodes_in_group("enemies")
		exceptions.append(self)
		exceptions.append(get_tree().get_root().get_node("Game").get_node("Player"))
		var up = !space_state.intersect_ray( pos, Vector2(pos.x, pos.y - 32), exceptions).empty()
		var down = !space_state.intersect_ray( pos, Vector2(pos.x, pos.y + 32), exceptions).empty()
		var left = !space_state.intersect_ray( pos, Vector2(pos.x - 32, pos.y), exceptions).empty()
		var right = !space_state.intersect_ray( pos, Vector2(pos.x + 32, pos.y), exceptions).empty()

		#hard-coded for specific tileset
		if(!up && down && left && right):
			sprite.set_region_rect(Rect2(32, 0, 32, 32))
		elif(up && !down && left && right):
			sprite.set_region_rect(Rect2(64, 0, 32, 32))
		elif(up && down && !left && right):
			sprite.set_region_rect(Rect2(96, 0, 32, 32))
		elif(up && down && left && !right):
			sprite.set_region_rect(Rect2(0, 32, 32, 32))
		elif (!up && down && left && !right):
			sprite.set_region_rect(Rect2(32, 32, 32, 32))
		elif (up && !down && left && !right):
			sprite.set_region_rect(Rect2(64, 32, 32, 32))
		elif (up && !down && !left && right):
			sprite.set_region_rect(Rect2(96, 32, 32, 32))
		elif(!up && down && !left && right):
			sprite.set_region_rect(Rect2(0, 64, 32, 32))
		elif(!up && down && !left && !right):
			sprite.set_region_rect(Rect2(32, 64, 32, 32))
		elif(!up && !down && left && !right):
			sprite.set_region_rect(Rect2(64, 64, 32, 32))
		elif(up && !down && !left && !right):
			sprite.set_region_rect(Rect2(96, 64, 32, 32))
		elif(!up && !down && !left && right):
			sprite.set_region_rect(Rect2(0, 96, 32, 32))
		elif(!up && !down && left && right):
			sprite.set_region_rect(Rect2(32, 96, 32, 32))
		elif(up && down && !left && !right):
			sprite.set_region_rect(Rect2(64, 96, 32, 32))
		elif(!up && !down && !left && !right):
			sprite.set_region_rect(Rect2(96, 96, 32, 32))
		isTiled = true

