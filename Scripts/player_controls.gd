
extends KinematicBody2D

var vel = Vector2()

var gravity = 0.3
var moveSpeed = 3.0
var jumpSpeed = 7.0
var maxSpeedX = 6.0
var maxSpeedY = 6.0
var frictionX = 0.6
var knockbackX = 8
var knockbackY = 3
var onGround = false

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	#vel.x = 0
	
	if(test_move(Vector2(0, 1))):
		onGround = true
	else:
		onGround = false
	
	#jump
	if(Input.is_key_pressed(KEY_SPACE) && onGround):
		vel.y = -jumpSpeed
		
	if(Input.is_key_pressed(KEY_A)):
		vel.x = -moveSpeed
	if(Input.is_key_pressed(KEY_D)):
		vel.x = moveSpeed
	
	#limit falling speed
	if(vel.y > maxSpeedY):
		vel.y = maxSpeedY
	if(abs(vel.x) > maxSpeedX):
		vel.x = sign(vel.x) * abs(vel.x)
		
	frictionX()
	moveX()
	moveY()
	
	#gravity
	vel.y += gravity
	
func moveX():
	var currentVel = Vector2(vel.x, 0)
	move(currentVel)

func moveY():
	var currentVel = Vector2(0, vel.y)
	move(currentVel)

func frictionX():
	if(vel.x > 0):
		vel.x -= frictionX
		if(vel.x < 0):
			vel.x = 0

	if(vel.x < 0):
		vel.x += frictionX
		if(vel.x > 0):
			vel.x = 0

func knockback(dir):
	var mx
	var my
	if(dir.x < 0):
		mx = -knockbackX
	elif(dir.x >= 0):
		mx = knockbackX
	if(dir.y > 0):
		my = knockbackY
	elif(dir.y <= 0):
		my = -knockbackY
	vel.x = mx
	vel.y = my
