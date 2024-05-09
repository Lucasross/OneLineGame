extends Node2D

class_name GameManager

@onready var player: Player = %Player

var current_scene: Data.Scene
var current_side: Data.Side
var inst_scene: Node2D

func _ready():
	switch_to_scene(PlayerData.scene, null, PlayerData.side, null)
	player.animated_sprite.flip_h = PlayerData.side == Data.Side.Right

func switch_to_scene(scene: Data.Scene, old_scene: Node2D, target: Data.Side, callback):
	call_deferred("switch_scene", scene, old_scene, target, callback)
	
func switch_scene(scene_ref: Data.Scene, old_scene: Node2D, target: Data.Side, callback):
	player.playable = false
	var scene = load(Data.get_scene_path(scene_ref))
	var instScene: Node = scene.instantiate()
	player.position.x = instScene.get_portal(target).position.x + (30 * int(target) * -1)
	player.position.y = instScene.get_portal(target).position.y + 16.5
	if old_scene != null:
		old_scene.queue_free()
	get_tree().root.get_node("/root/Game/Gameplay").add_child(instScene)
	PlayerData.scene = scene_ref
	PlayerData.side = target
	inst_scene = instScene
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	player.playable = true
	if callback != null:
		callback.call()

func restart_stage():
	switch_to_scene(PlayerData.scene, inst_scene, PlayerData.side, reset_player)

func reset_player():
	player.reset_player()
