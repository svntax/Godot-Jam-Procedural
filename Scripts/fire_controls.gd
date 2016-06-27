
extends KinematicBody2D

var vel = Vector2()

var gravity = 0.2
var maxSpeedY = 6.0
var player
var canCollide = false
var collisionTimer = 0
var maxCollisionTimer = 0.05

func _ready():
	set_collision_mask(2)
	player = get_parent().find_node("Player")
	set_fixed_process(true)
	
func _fixed_process(delta):
	#rough fix for spawning inside terrain
	if(!canCollide):
		collisionTimer += delta
		if(collisionTimer >= maxCollisionTimer):
			collisionTimer = 0
			canCollide = true
			set_collision_mask(1)
	
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
		#if(other.get_instance_ID() != player.get_instance_ID()):
		if(other.is_in_group("enemies")):
			other.kill()
		get_node("Area2D").set_pos(get_pos())
		get_node("RetileArea").set_pos(get_pos())
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
