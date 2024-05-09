extends Node

class_name PlayerDataSave

@export var experience: int = 0
@export var level: int = 1
@export var skillPoint: int = 0
@export var potion_count: int = -1
@export var stats: Dictionary = {
	Data.Stat.Damage: 1,
	Data.Stat.Health: 1,
	Data.Stat.Speed: 0,
	Data.Stat.Regen: 0,
	}
@export var scene: Data.Scene = Data.Scene.swamp_1
@export var side: Data.Side = Data.Side.Left
	
func save():
	return {
		"experience": experience,
		"level": level,
		"skillPoint": skillPoint,
		"potion_count": potion_count,
		"stats": stats,
		"scene": scene,
		"side": side,
	}

func load(save_data):
	experience = save_data["experience"]
	level = save_data["level"]
	skillPoint = save_data["skillPoint"]
	potion_count = save_data["potion_count"]
	for i in save_data["stats"]:
		stats[int(i)] = save_data["stats"][i]
	scene = save_data["scene"]
	side = save_data["side"]
