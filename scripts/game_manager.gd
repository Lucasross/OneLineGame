extends Node2D

class_name GameManager

@onready var player: Player = %Player

@export var start_scene: Data.Scene
@export var start_side: Data.Side

var current_scene: Data.Scene
var current_side: Data.Side

func _ready():
	switch_to_scene(start_scene, null, start_side, null)

func switch_to_scene(scene: Data.Scene, old_scene: Node2D, target: Data.Side, callback):
	call_deferred("switch_scene", scene, old_scene, target, callback)
	
func switch_scene(scene_ref: Data.Scene, old_scene: Node2D, target: Data.Side, callback):
	player.playable = false
	var scene = load(Data.get_scene_path(scene_ref))
	var instScene: Node = scene.instantiate()
	player.position.x = instScene.get_portal(target).position.x + (30 * int(target) * -1)
	if old_scene != null:
		old_scene.queue_free()
	get_tree().root.add_child(instScene)
	get_tree().current_scene = instScene
	current_scene = scene_ref
	current_side = target
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	player.playable = true
	if callback != null:
		callback.call()

func restart_stage():
	switch_to_scene(current_scene, get_tree().current_scene, current_side, reset_player)

func reset_player():
	player.reset_player()
