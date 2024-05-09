extends Node


enum Stat { Damage = 0, Health = 1, Speed = 2, Regen = 3 }

enum Side { Left = -1 , Right = 1 }

enum Scene 
{
	forest,
	beach,
}

var scene_names: Dictionary = {
	Scene.forest: "forest",
	Scene.beach: "beach",
}

func get_scene_path(scene: Scene) -> String :
	return "res://scenes/levels/level_"+scene_names[scene]+".tscn"
	
func get_game_manager() -> GameManager:
	return get_tree().root.get_node("/root/Game/Gameplay")
