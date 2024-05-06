extends Node

class_name PlayerDataSave

@export var experience: int = 0
@export var level: int = 1
@export var skillPoint: int = 0
@export var stats: Dictionary = {
	Data.Stat.Damage: 1,
	Data.Stat.Health: 1,
	Data.Stat.Speed: 0,
	Data.Stat.Regen: 0,
	}
	
func save():
	return {
		"experience": experience,
		"level": level,
		"skillPoint": skillPoint,
		"stats": stats,
	}

func load(save_data):
	experience = save_data["experience"]
	level = save_data["level"]
	skillPoint = save_data["skillPoint"]
	
	for i in save_data["stats"]:
		stats[int(i)] = save_data["stats"][i]
