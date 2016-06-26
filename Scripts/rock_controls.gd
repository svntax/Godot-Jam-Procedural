
extends KinematicBody2D

var vel = Vector2()

var gravity = 0.2
var maxSpeedY = 6.0
var player

var debrisScene = load("res://Scenes/debris_lump.scn")

func _ready():
	player = get_parent().find_node("Player")
	set_fixed_process(true)
	
func _fixed_process(delta):
	#limit falling speed
	if(vel.y > maxSpeedY):
		vel.y = maxSpeedY
	moveX()
	moveY()
	vel.y += gravity
	
	if(test_move(vel)):
		move(vel)
		var other = get_collider()
		#spawn debris if it hit something
		if(other.get_instance_ID() != player.get_instance_ID()):
			var debris = debrisScene.instance()
			var debrisX = get_pos().x - debris.getOffset()
			var debrisY = get_pos().y - debris.getOffset()
			debris.set_pos(Vector2(debrisX, debrisY))
			get_parent().add_child(debris)
			debris.spawnEarth()
			queue_free()

func setVelocity(vx, vy):
	vel.x = vx
	vel.y = vy

func moveX():
	var currentVel = Vector2(vel.x, 0)
	move(currentVel)

func moveY():
	var currentVel = Vector2(0, vel.y)
	move(currentVel)
