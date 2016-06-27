
extends KinematicBody2D

var SPEED = 1
var THRESHOLD = 8
var AGGRO_RANGE = 600

var anim
var frames
var player
var velX = 0
var velY = 0
var dead = false
var animTimer = 0

func _ready():
	anim = get_node("AnimationPlayer")
	frames = get_node("AnimatedSprite")
	player = get_tree().get_nodes_in_group("players")[0]
	set_fixed_process(true)
	
func _fixed_process(delta):
	if(!dead):
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
			
		if(get_pos().distance_to(player.get_pos()) <= AGGRO_RANGE):
			move(Vector2(velX, 0))
			move(Vector2(0, velY))
		
		checkCollision()
	else:
		#set_pos(Vector2(-100, -100))
		find_node("AnimatedSprite").hide()
		animTimer += delta 
		if(animTimer >= find_node("Particles2D").get_lifetime() - 0.1):
			set_pos(Vector2(-100, -100))
			get_node("Particles2D").set_emitting(false)
			get_node("/root/globals").incrementKills()
			queue_free()
	
func checkCollision():
	var pos = get_pos()
	if(test_move(Vector2(velX, velY)) && pos.distance_to(player.get_pos()) <= 60):
		move(Vector2(velX, velY))
		var other = get_collider()
		if(other.get_instance_ID() == player.get_instance_ID()):
			if(!dead):
				kill()
				get_tree().get_nodes_in_group("lives_ui")[0].damage()
				player.knockback(Vector2(velX, velY))

func kill():
	dead = true
	get_node("Particles2D").set_emitting(true)
	get_node("CollisionShape2D").set_trigger(true)
