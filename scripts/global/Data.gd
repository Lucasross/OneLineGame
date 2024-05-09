extends Node


enum Stat { Damage = 0, Health = 1, Speed = 2, Regen = 3 }

enum Side { Left = -1 , Right = 1 }

enum Scene 
{
	forest,
	beach,
	cave_1,
	cave_2,
	dungeon_1,
	dungeon_2,
	swamp1,
	rock1,
	desert1,
	tower1,
	tower2,
	snow1,
	snow2,
}

var scene_names: Dictionary = {
	Scene.forest: "forest",
	Scene.beach: "beach",
	Scene.cave_1: "cave_1",
}

func get_scene_path(scene: Scene) -> String :
	return "res://scenes/levels/level_"+scene_names[scene]+".tscn"
	
func get_game_manager() -> GameManager:
	return get_tree().root.get_node("/root/Game/Gameplay")
