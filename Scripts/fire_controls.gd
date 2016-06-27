
extends KinematicBody2D

var vel = Vector2()

var gravity = 0.2
var maxSpeedY = 6.0
var player

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
		#kill enemy and destroy terrain
		if(other.get_instance_ID() != player.get_instance_ID()):
			if(other.is_in_group("enemies")):
				other.kill()
			get_node("Area2D").destroyTerrain()
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
