
extends Node

var ENEMIES_KILLED = 0
var LEVEL_REACHED = 1

func _ready():
	pass

func getEnemiesKilled():
	return ENEMIES_KILLED

func getLevelReached():
	return LEVEL_REACHED

func incrementKills():
	ENEMIES_KILLED += 1
	
func incrementLevel():
	LEVEL_REACHED += 1

func resetStats():
	ENEMIES_KILLED = 0
	LEVEL_REACHED = 1