extends CanvasLayer

const gameplay_scene = preload("res://scenes/main/Gameplay.tscn")

func _on_continue_pressed():
	get_tree().root.get_node("/root/Game").add_child(gameplay_scene.instantiate())
	get_tree().root.get_node("/root/Game/Menu").queue_free()

func _on_new_pressed():
	PlayerData.reset()
	_on_continue_pressed()

func _on_quit_pressed():
	get_tree().quit()
