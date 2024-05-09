extends Node


enum Stat { Damage = 0, Health = 1, Speed = 2, Regen = 3 }

enum Side { Left = -1 , Right = 1 }

enum Scene 
{
	forest, #1
	beach, #2-3
	cave_1, #3-4
	cave_2, #4-5
	dungeon_1, #6-7
	dungeon_2, #7-8
	swamp_1, #9-10
	rock_1, #11-12
	desert_1, #13-14
	tower_1, #14-15
	tower_2, #15-16
	snow_1, #17-18
	snow_2, #19-20 RATON_SAN 25
}

var scene_names: Dictionary = {
	Scene.forest: "forest",
	Scene.beach: "beach",
	Scene.cave_1: "cave_1",
	Scene.cave_2: "cave_2",
	Scene.dungeon_1: "dungeon_1",
	Scene.dungeon_2: "dungeon_2",
	Scene.swamp_1: "swamp_1",
}

func get_scene_path(scene: Scene) -> String :
	return "res://scenes/levels/level_"+scene_names[scene]+".tscn"
	
func get_game_manager() -> GameManager:
	return get_tree().root.get_node("/root/Game/Gameplay")
