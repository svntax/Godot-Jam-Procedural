
extends KinematicBody2D

var vel = Vector2()

var onGround = false
var affectedByGravity = false
var gravity = 0.3
var maxSpeedY = 6.0

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	if(test_move(Vector2(0, 1))):
		onGround = true
	else:
		onGround = false
	
	#limit falling speed
	if(vel.y > maxSpeedY):
		vel.y = maxSpeedY
		
	if(affectedByGravity):
		moveY()
		vel.y += gravity

func moveY():
	var currentVel = Vector2(0, vel.y)
	move(currentVel)
