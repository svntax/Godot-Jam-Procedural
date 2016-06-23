
extends KinematicBody2D

var SPEED = 1
var THRESHOLD = 8

var anim
var frames
var velX = 0
var velY = 0

func _ready():
	anim = get_node("AnimationPlayer")
	frames = get_node("AnimatedSprite")
	set_fixed_process(true)
	
func _fixed_process(delta):
	var player = get_parent().get_node("Player")
	#face the player
	if(player.get_pos().x < get_pos().x && frames.is_flipped_h()):
		frames.set_flip_h(false)
	elif(player.get_pos().x > get_pos().x && !frames.is_flipped_h()):
		frames.set_flip_h(true)

	var px = player.get_pos().x
	var py = player.get_pos().y
	var bx = get_pos().x
	var by = get_pos().y
	if(px < bx):
		velX = -SPEED
	elif(px > bx):
		velX = SPEED
	if(abs(px - bx) <= THRESHOLD):
		velX = 0
	if(py < by):
		velY = -SPEED
	elif(py > by):
		velY = SPEED
	if(abs(py - by) <= THRESHOLD):
		velY = 0
	move(Vector2(velX, 0))
	move(Vector2(0, velY))

