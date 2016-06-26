extends Node2D

var TILE_SIZE = 32
var TERRAIN_WIDTH = 60
var TERRAIN_HEIGHT = 38
var INITIAL_CHANCE = 0.4

var MIN_FOR_ALIVE = 3
var MIN_FOR_DEAD = 4

var terrain = []

var r_pressed = false
var g_pressed = false

var scene = load("res://Scenes/terrain_wall.scn")
var outerWallScene = load("res://Scenes/outer_wall.scn")

func _ready():
	for i in range(TERRAIN_WIDTH):
		terrain.append([])
		for j in range(TERRAIN_HEIGHT):
			terrain[i].append(0)

	generateTerrain()
	for i in range(3):
		cellularAutomata()
	spawnOuterWalls()
	spawnWalls()
	
	set_process(true)
	#set_process_input(true)

func _input(event):
	if(event.type == InputEvent.KEY):
		if(event.scancode == KEY_R && !event.is_echo()):
			if(!r_pressed):
				generateTerrain()
				for i in range(3):
					cellularAutomata()
				spawnWalls()
				update()
			r_pressed = !r_pressed

		"""if(event.scancode == KEY_G && !event.is_echo()):
			if(!g_pressed):
				cellularAutomata()
				update()
			g_pressed = !g_pressed	"""

func _draw():
	var w = TERRAIN_WIDTH * TILE_SIZE - (TILE_SIZE / 2)
	var h = TERRAIN_HEIGHT * TILE_SIZE - (TILE_SIZE / 2)
	draw_rect(Rect2(0, 0, w, h), Color(255, 255, 255))

func getWidth():
	return TERRAIN_WIDTH

func getHeight():
	return TERRAIN_HEIGHT
	
func getTileSize():
	return TILE_SIZE

func generateTerrain():
	randomize()
	for i in range(TERRAIN_WIDTH):
		for j in range(TERRAIN_HEIGHT):
			if(i == 0 || i == TERRAIN_WIDTH - 1 || j == 0 || j == TERRAIN_HEIGHT - 1):
				terrain[i][j] = 1
			elif(randf() < INITIAL_CHANCE):
				terrain[i][j] = 1
			else:
				terrain[i][j] = 0

func cellularAutomata():
	var newTerrain = []
	for i in range(TERRAIN_WIDTH):
		newTerrain.append([])
		for j in range(TERRAIN_HEIGHT):
			if(i == 0 || i == TERRAIN_WIDTH - 1 || j == 0 || j == TERRAIN_HEIGHT - 1):
				newTerrain[i].append(1)
			else:
				newTerrain[i].append(0)
	for i in range(1, TERRAIN_WIDTH - 1):
		for j in range(1, TERRAIN_HEIGHT - 1):
			var count = getNeighborsCount(terrain, i, j)
			#old method - spacious
			#if(count >= 5):
				#newTerrain[i][j] = 1
			if(terrain[i][j] == 1):
				if(count-1 < MIN_FOR_ALIVE):
					newTerrain[i][j] = 0
				else:
					newTerrain[i][j] = 1
			else:
				if(count > MIN_FOR_DEAD):
					newTerrain[i][j] = 1
				else:
					newTerrain[i][j] = 0
	terrain = newTerrain
	update()

# assume that arr[row][col] is within the middle
func getNeighborsCount(var arr, var row, var col):
	var count = 0
	for i in [-1, 0, 1]:
		for j in [-1, 0, 1]:
			count += arr[row+i][col+j]
	return count

func drawTerrain():
	for i in range(TERRAIN_WIDTH):
		for j in range(TERRAIN_HEIGHT):
			var block = Rect2(i*TILE_SIZE, j*TILE_SIZE, TILE_SIZE, TILE_SIZE)
			if(terrain[i][j] == 1):
				draw_rect(block, Color(0, 0, 0.7, 1))
				pass
			elif(terrain[i][j] == 0):
				draw_rect(block, Color(0, 0, 0, 1))

func spawnWalls():
	"""var walls = get_child(1)
	if(walls != null):
		while(get_child(1) != null):
			get_child(1).queue_free()
			remove_child(get_child(1))"""

	for i in range(TERRAIN_WIDTH):
		for j in range(TERRAIN_HEIGHT):
			if(terrain[i][j] == 1):
				var block = scene.instance()
				var shape = RectangleShape2D.new()
				shape.set_extents(Vector2(TILE_SIZE/2, TILE_SIZE/2))
				block.set_pos(Vector2(i*TILE_SIZE, j*TILE_SIZE))
				block.add_shape(shape)
				add_child(block)
			#elif(terrain[i][j] == 0):
				#draw_rect(block, Color(1, 1, 1, 1))

func spawnOuterWalls():
	var wallTop = outerWallScene.instance()
	var shapeTop = RectangleShape2D.new()
	shapeTop.set_extents(Vector2(TERRAIN_WIDTH*TILE_SIZE/2, 4))
	wallTop.set_pos(Vector2(TERRAIN_WIDTH*TILE_SIZE/2, -8))
	wallTop.add_shape(shapeTop)
	add_child(wallTop)
	
	var wallBottom = outerWallScene.instance()
	var shapeBottom = RectangleShape2D.new()
	shapeBottom.set_extents(Vector2(TERRAIN_WIDTH*TILE_SIZE/2, 4))
	wallBottom.set_pos(Vector2(TERRAIN_WIDTH*TILE_SIZE/2, TERRAIN_HEIGHT*TILE_SIZE))
	wallBottom.add_shape(shapeBottom)
	add_child(wallBottom)
	
	var wallTop = outerWallScene.instance()
	var shapeTop = RectangleShape2D.new()
	shapeTop.set_extents(Vector2(TERRAIN_WIDTH*TILE_SIZE/2, 4))
	wallTop.set_pos(Vector2(TERRAIN_WIDTH*TILE_SIZE/2, -8))
	wallTop.add_shape(shapeTop)
	add_child(wallTop)
	
	var wallLeft = outerWallScene.instance()
	var shapeLeft = RectangleShape2D.new()
	shapeLeft.set_extents(Vector2(4, TERRAIN_HEIGHT*TILE_SIZE/2))
	wallLeft.set_pos(Vector2(-8, TERRAIN_HEIGHT*TILE_SIZE/2))
	wallLeft.add_shape(shapeLeft)
	add_child(wallLeft)
	
	var wallRight = outerWallScene.instance()
	var shapeRight = RectangleShape2D.new()
	shapeRight.set_extents(Vector2(4, TERRAIN_HEIGHT*TILE_SIZE/2))
	wallRight.set_pos(Vector2(TERRAIN_WIDTH*TILE_SIZE, TERRAIN_HEIGHT*TILE_SIZE/2))
	wallRight.add_shape(shapeRight)
	add_child(wallRight)

